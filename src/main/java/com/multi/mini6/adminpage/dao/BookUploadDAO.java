package com.multi.mini6.adminpage.dao;

import com.multi.mini6.bookpage.vo.BooksHistoryVO;
import com.multi.mini6.bookpage.vo.BooksLibrariesVO;
import com.multi.mini6.bookpage.vo.BooksVO;
import com.multi.mini6.bookpage.vo.LibrariesVO;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BookUploadDAO {

    @Autowired
    private SqlSessionTemplate sqlSession;

    //중복된 ISBN을 찾는 메소드
    public List<String> findDuplicatedIsbns(List<String> isbns) {
        return sqlSession.selectList("findDuplicatedIsbns", isbns);
    }
    //특정 ISBN을 가진 책을 찾는 메소드
    public BooksVO findByIsbn(String isbn) {
        return sqlSession.selectOne("findBookByIsbn", isbn);
    }
    //책 정보를 업데이트하는 메소드
    public void updateBook(@Param("isbn") String isbn, @Param("updatedFields") Map<String, Object> updatedFields) {
        updatedFields.put("isbn", isbn);
        sqlSession.update("updateBook", updatedFields);
    }
    //책 정보 저장
    public void insertBooks(BooksVO booksVO) {
        sqlSession.insert("insertBooks", booksVO);
    }




    public List<String> findExistingIsbns(List<String> isbns) {
        return sqlSession.selectList("findExistingIsbns", isbns);
    }
    //책 정보 벌크 인서트
    public void bulkInsertBooks(List<BooksVO> booksList) {
        sqlSession.insert("bulkInsertBooks", booksList);
    }

    //책과도서관 정보 업데이트
    public void updateBooksLibraries(BooksLibrariesVO booksLibrariesVO) {
        sqlSession.update("updateBooksLibraries", booksLibrariesVO);
    }
    //책과도서관 정보 저장
    public void insertBooksLibraries(BooksLibrariesVO booksLibrariesVO) {
        sqlSession.insert("insertBooksLibraries", booksLibrariesVO);
    }

    //books 테이블이랑 booksLibraries 테이블 개수 가져오기
    public int getBooksCount() {
        return sqlSession.selectOne("getBooksCount");
    }
    public int getBooksLibrariesCount() {
        return sqlSession.selectOne("getBooksLibrariesCount");
    }

    //중복되는 책 있는지 확인
    public int existsByIsbn(String isbn) {
       return sqlSession.selectOne("existsByIsbn", isbn);
    }
    //중복되는 isbn이랑 lib_code가 있는지 확인
    public int existsByIsbnAndLibCode(@Param("isbn") String isbn, @Param("lib_code") int lib_code) {
        Map<String, Object> params = new HashMap<>();
        params.put("isbn", isbn);
        params.put("lib_code", lib_code);
        return sqlSession.selectOne("existsByIsbnAndLibCode", params);
    }

    public List<LibrariesVO> searchLibrary(String searchKeyword) {
        return sqlSession.selectList("searchLibrary", searchKeyword);
    }


    //업로드 기록 저장
    public void insertUploadHistory(BooksHistoryVO booksHistoryVO) {
        sqlSession.insert("insertUploadHistory", booksHistoryVO);
    }

    //업로드 기록 불러오기
    public List<BooksHistoryVO> selectAllBooksHistory() {
        return sqlSession.selectList("selectAllBooksHistory");
    }

}
