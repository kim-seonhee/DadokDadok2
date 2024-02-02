package com.multi.mini6.bookpage.dao;

import com.multi.mini6.bookpage.vo.BooksVO;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class BookDAO {

    @Autowired
    SqlSessionTemplate sqlSession;

    //도서 검색 기능
    public List<BooksVO> bookSearch(@Param("searchKeyword") String searchKeyword) {
        return sqlSession.selectList("bookSearch", searchKeyword);
    }

    //도서 정보 가져오기
    public BooksVO getBookInfo(String isbn) {
        return sqlSession.selectOne("getBookInfo", isbn);
    }
}
