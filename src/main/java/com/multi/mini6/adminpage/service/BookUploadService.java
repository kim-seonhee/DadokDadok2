package com.multi.mini6.adminpage.service;

import com.multi.mini6.adminpage.dao.BookUploadDAO;
import com.multi.mini6.bookpage.vo.BooksHistoryVO;
import com.multi.mini6.bookpage.vo.BooksLibrariesVO;
import com.multi.mini6.bookpage.vo.BooksVO;
import com.multi.mini6.bookpage.vo.LibrariesVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Log4j2
public class BookUploadService {

    final private SqlSessionFactory sqlSessionFactory;
    final private BookUploadDAO bookUploadDAO;


    HashSet<String> isbnSetForDuplicationCheck = new HashSet<>();
    List<BooksVO> uniqueBooksList = new ArrayList<>();
    HashSet<String> uniqueIsbnLibCode = new HashSet<>();

    //첨부파일 데이터를 위해 도서관 정보 가져오기
    public List<LibrariesVO> searchLibrary(String searchKeyword) {
        return bookUploadDAO.searchLibrary(searchKeyword);
    }

    //북 히스토리 가져오기
    public List<BooksHistoryVO> selectAllBooksHistory() {
        return bookUploadDAO.selectAllBooksHistory();
    }

    //개수 가져오기
    @Transactional
    public Map<String, Integer> getBooksAndBooksLibrariesCount() {
        int booksCount = bookUploadDAO.getBooksCount();
        int booksLibrariesCount = bookUploadDAO.getBooksLibrariesCount();
        Map<String, Integer> counts = new HashMap<>();
        counts.put("booksCount", booksCount);
        counts.put("booksLibrariesCount", booksLibrariesCount);
        return counts;
    }

    public void batchInsertOrUpdateBooksLibraries(List<BooksLibrariesVO> booksLibraryToSave, int libCode) {
        // 배치 처리 준비
        try (SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH)) {
            for (BooksLibrariesVO booksLibrary : booksLibraryToSave) {
                String isbnLibCodeKey = booksLibrary.getIsbn() + "-" + libCode;

                // 새로운 데이터인 경우 삽입, 기존 데이터인 경우 업데이트
                if (bookUploadDAO.existsByIsbnAndLibCode(booksLibrary.getIsbn(), libCode) == 0) {
                    sqlSession.insert("insertBooksLibraries", booksLibrary);
                } else {
                    sqlSession.update("updateBooksLibraries", booksLibrary);
                }
            }
            sqlSession.commit();
        } catch (Exception e) {
            // 예외 처리 로직
            e.printStackTrace();
        }

    }

    @Transactional
    public void importBooksFromCSV(MultipartFile file, int libCode) {
        long startTime = System.nanoTime();

        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("업로드된 파일이 없습니다.");
        }

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream(), "EUC-KR"))) {
            String line;
            reader.readLine(); // 첫 번째 줄은 헤더이므로 건너뜁니다.
            List<BooksVO> booksToSave = new ArrayList<>();
            List<BooksLibrariesVO> booksLibraryToSave = new ArrayList<>();
            while ((line = reader.readLine()) != null) {
                String[] values = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1);
                // CSV 데이터 처리 로직
                BooksVO booksVO = new BooksVO();
                booksVO.setTitle(removeQuotes(values[1]));
                booksVO.setPublisher(removeQuotes(values[3]));
                booksVO.setYear_of_publication(removeQuotes(values[4]));
                booksVO.setIsbn(removeQuotes(values[5]));
                booksVO.setSet_isbn(removeQuotes(values[6]));
                booksVO.setAdditional_symbol(removeQuotes(values[7]));
                booksVO.setVolume(removeQuotes(values[8]));
                booksVO.setSubject_classification_number(removeQuotes(values[9]));
                booksToSave.add(booksVO);

                //isbn
                String isbn = removeQuotes(values[5]);
                //numberOfCopies
                String numberOfCopies = removeQuotes(values[10]);
                //numberOfLoans
                String numberOfLoans = removeQuotes(values[11]);

                String isbnLibCodeKey = isbn + "-" + libCode;
                // 중복되지 않은 ISBN과 도서관 코드 조합만 리스트에 추가
                // 변동성이 있는데이터는 BooksLibrary 테이블에 저장하고 업데이트 하도록 처리
                // BooksLibraryVO 객체 생성
                if (!uniqueIsbnLibCode.contains(isbnLibCodeKey)) {
                    uniqueIsbnLibCode.add(isbnLibCodeKey);

                    BooksLibrariesVO booksLibrariesVO = new BooksLibrariesVO();
                    booksLibrariesVO.setLib_code(libCode);
                    booksLibrariesVO.setIsbn(isbn);
                    booksLibrariesVO.setNumberOfCopies(numberOfCopies);
                    booksLibrariesVO.setNumberOfLoans(numberOfLoans);

                    booksLibraryToSave.add(booksLibrariesVO);
                }

            }

            /*
             모든 줄을 읽은 후에 확인 :
             메모리에 저장한 후 db에 삽입 전 확인하면 많은 양의 데이터 처리 가능 , 데이터베이스 호출을 줄일 수 있다.
             성능과 리소스 사용면에서 csv를 읽는 도중에 확인하는것보다 효율적
             하지만  많은 양의 데이터를 메모리에 유지해야댐
             */


            for (BooksVO book : booksToSave) {
                // 이미 isbnSetForDuplicationCheck에 존재하는 경우, 중복으로 간주
                if (!isbnSetForDuplicationCheck.add(book.getIsbn())) {
                    // 중복된 ISBN 처리 로직
                    // 중복된 데이터를 무시합니다.
                    continue;
                }
                uniqueBooksList.add(book);
            }

            // 데이터베이스에 존재하는 ISBN 조회
            List<String> existingIsbnsInDb = bookUploadDAO.findExistingIsbns(new ArrayList<>(isbnSetForDuplicationCheck));
            // 데이터베이스에 존재하는 ISBN을 HashSet에서 제거
            isbnSetForDuplicationCheck.removeAll(existingIsbnsInDb);


            // HashSet에 남아 있는 ISBN들은 데이터베이스에 없는 새로운 ISBN입니다.
            List<BooksVO> newBooks = uniqueBooksList.stream()
                    .filter(book -> isbnSetForDuplicationCheck.contains(book.getIsbn()))
                    .collect(Collectors.toList());


            // 벌크 인서트를 사용하여 새로운 책 데이터를 데이터베이스에 삽입
            if (!newBooks.isEmpty()) {
                bookUploadDAO.bulkInsertBooks(newBooks);
            }
            // 배치 처리 준비
            batchInsertOrUpdateBooksLibraries(booksLibraryToSave, libCode);


        } catch (IOException e) {
            System.out.println("예외 발생: " + e);
            throw new RuntimeException("CSV 파일 처리 중 오류가 발생했습니다.", e);
        }

        //파일 히스토리 저장
        BooksHistoryVO booksHistoryVO = new BooksHistoryVO();
        booksHistoryVO.setFile_name(file.getOriginalFilename());
        booksHistoryVO.setFileSizeFormatted(file);
        booksHistoryVO.setFile_type(file.getContentType());
        bookUploadDAO.insertUploadHistory(booksHistoryVO);

        // 출력 시간 계산
        long endTime = System.nanoTime();
        System.out.println("-------------실행 시간---------------: " + (endTime - startTime) / 1000000000.0 + "초");
    }

    private String removeQuotes(String value) {
        return value.replace("\"", "").trim();
    }

    @Transactional
    public void importBooksFromExcel(MultipartFile file, int libCode) {
        long startTime = System.nanoTime();

        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("업로드된 파일이 없습니다.");
        }

        try {
            XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());
            // 워크북의 첫 번째 시트를 가져옵니다.
            XSSFSheet sheet = workbook.getSheetAt(0);
            // 저장할 도서 목록을 위한 리스트를 생성합니다.
            List<BooksVO> booksToSave = new ArrayList<>();
            List<BooksLibrariesVO> booksLibraryToSave = new ArrayList<>();

            // 시트의 모든 행에 대하여 반복합니다.
            for (Row row : sheet) {
                // 첫 번째 행은 헤더이므로 건너뛰기
                if (row.getRowNum() == 0) {
                    continue;
                }

                // 각 행에서 ISBN을 추출합니다.
                String isbn = row.getCell(5).getStringCellValue();

                // ISBN이 이미 존재하는지 확인합니다.
                // 각 셀에서 필요한 정보를 추출하여 변수에 할당합니다.
                String title = row.getCell(1).getStringCellValue();
                String author = row.getCell(2).getStringCellValue();
                String publisher = row.getCell(3).getStringCellValue();
                String yearOfPublication = row.getCell(4).getStringCellValue();
                String setIsbn = row.getCell(6).getStringCellValue();
                String additionalSymbol = row.getCell(7).getStringCellValue();
                String volume = row.getCell(8).getStringCellValue();
                String subjectClassificationNumber = row.getCell(9).getStringCellValue();
                String numberOfCopies = row.getCell(10).getStringCellValue();
                String numberOfLoans = row.getCell(11).getStringCellValue();
                String registrationDate = row.getCell(12).getStringCellValue();


                // 추출한 정보를 바탕으로 BooksVO 객체를 생성합니다.
                BooksVO booksVO = new BooksVO();
                booksVO.setTitle(title);
                booksVO.setAuthor(author);
                booksVO.setPublisher(publisher);
                booksVO.setYear_of_publication(yearOfPublication);
                booksVO.setIsbn(isbn);
                booksVO.setSet_isbn(setIsbn);
                booksVO.setAdditional_symbol(additionalSymbol);
                booksVO.setVolume(volume);
                booksVO.setSubject_classification_number(subjectClassificationNumber);




                String isbnLibCodeKey = isbn + "-" + libCode;
                // 중복되지 않은 ISBN과 도서관 코드 조합만 리스트에 추가
                if (!uniqueIsbnLibCode.contains(isbnLibCodeKey)) {
                    uniqueIsbnLibCode.add(isbnLibCodeKey);

                    BooksLibrariesVO booksLibrariesVO = new BooksLibrariesVO();
                    booksLibrariesVO.setLib_code(libCode);
                    booksLibrariesVO.setIsbn(isbn);
                    booksLibrariesVO.setNumberOfCopies(numberOfCopies);
                    booksLibrariesVO.setNumberOfLoans(numberOfLoans);

                    booksLibraryToSave.add(booksLibrariesVO);
                }

                // 생성한 BooksVO 객체를 저장할 목록에 추가합니다.
                booksToSave.add(booksVO);

            }



            for (BooksVO book : booksToSave) {
                // 이미 isbnSetForDuplicationCheck에 존재하는 경우, 중복으로 간주
                if (!isbnSetForDuplicationCheck.add(book.getIsbn())) {
                    // 중복된 ISBN 처리 로직
                    // 중복된 데이터를 무시합니다.
                    continue;
                }
                uniqueBooksList.add(book);
            }

            // 데이터베이스에 존재하는 ISBN 조회
            List<String> existingIsbnsInDb = bookUploadDAO.findExistingIsbns(new ArrayList<>(isbnSetForDuplicationCheck));
            // 데이터베이스에 존재하는 ISBN을 HashSet에서 제거
            isbnSetForDuplicationCheck.removeAll(existingIsbnsInDb);


            // HashSet에 남아 있는 ISBN들은 데이터베이스에 없는 새로운 ISBN입니다.
            List<BooksVO> newBooks = uniqueBooksList.stream()
                    .filter(book -> isbnSetForDuplicationCheck.contains(book.getIsbn()))
                    .collect(Collectors.toList());


            // 벌크 인서트를 사용하여 새로운 책 데이터를 데이터베이스에 삽입
            if (!newBooks.isEmpty()) {
                bookUploadDAO.bulkInsertBooks(newBooks);
            }
            // 배치 처리 준비
            batchInsertOrUpdateBooksLibraries(booksLibraryToSave, libCode);

            workbook.close();

        } catch (IOException e) {
            throw new RuntimeException("엑셀 파일 처리 중 오류가 발생했습니다.", e);
        }

        BooksHistoryVO booksHistoryVO = new BooksHistoryVO();
        booksHistoryVO.setFile_name(file.getOriginalFilename());
        booksHistoryVO.setFileSizeFormatted(file);
        booksHistoryVO.setFile_type("excel");
        //파일 히스토리 저장
        bookUploadDAO.insertUploadHistory(booksHistoryVO);

        // 출력 시간 계산
        long endTime = System.nanoTime();
        System.out.println("-------------실행 시간---------------: " + (endTime - startTime) / 1000000000.0 + "초");
    }
}