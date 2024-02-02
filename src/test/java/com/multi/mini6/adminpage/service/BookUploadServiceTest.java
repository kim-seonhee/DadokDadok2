package com.multi.mini6.adminpage.service;

import com.multi.mini6.adminpage.dao.BookUploadDAO;
import com.multi.mini6.bookpage.vo.BooksVO;
import lombok.extern.log4j.Log4j2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;

import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
@Log4j2
public class BookUploadServiceTest {

    @Mock
    private BookUploadDAO bookUploadDAO;

    @InjectMocks
    private BookUploadService bookFileUploadService;

    @Test
    public void testImportBooksFromCSV() {
        // CSV 데이터 예시
        String csvData =
                "1,\"투쟁의 장으로서의 고대사:동아시아사의 행방\",\"이성시 지음;박경희 옮김\",\"삼인\",\"2019\",\"9788964361658\",\"\",\"9\",\"\",\"910.2\",\"1\",\"0\",\"2023-12-28\"\n" +
                        "2,\"나는 잘하는 게 하나도 없어요\",\"구스노키 시게노리 글;후루쇼 요코 그림;김영희 옮김\",\"베틀북\",\"2015\",\"9788984887909\",\"\",\"7\",\"\",\"833.8\",\"1\",\"3\",\"2023-12-23\"\n" +
                        "3,\"투쟁의 장으로서의 고대사:동아시아사의 행방\",\"이성시 지음;박경희 옮김\",\"삼인\",\"2019\",\"9788964361658\",\"\",\"9\",\"\",\"910.2\",\"1\",\"0\",\"2023-12-28\"\n" +
                        "4,\"나는 잘하는 게 하나도 없어요\",\"구스노키 시게노리 글;후루쇼 요코 그림;김영희 옮김\",\"베틀북\",\"2015\",\"9788984887909\",\"\",\"7\",\"\",\"833.8\",\"1\",\"0\",\"2023-12-23\"\n";

        // Mock MultipartFile 생성
        MultipartFile mockFile = new MockMultipartFile("2.28도서관 장서 대출목록 (2023년 12월)", "filename.csv", "text/plain", csvData.getBytes());
        int lib_code = 1;
        // Mock 객체 동작 설정
        when(bookUploadDAO.findDuplicatedIsbns(anyList())).thenReturn(new ArrayList<>());
        doNothing().when(bookUploadDAO).insertBooks(any(BooksVO.class));

        // 메소드 실행
        bookFileUploadService.importBooksFromCSV(mockFile, lib_code);

        // 결과 검증
        verify(bookUploadDAO, times(1)).findDuplicatedIsbns(anyList());
        log.info("findDuplicatedIsbns() 메소드가 1번 호출되었습니다.");
        verify(bookUploadDAO, atLeastOnce()).insertBooks(any(BooksVO.class));
        log.info("insertBooks() 메소드가 최소 1번 호출되었습니다.");
    }
}
