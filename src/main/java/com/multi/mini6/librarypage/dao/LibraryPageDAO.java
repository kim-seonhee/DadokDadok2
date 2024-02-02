package com.multi.mini6.librarypage.dao;

import com.multi.mini6.librarypage.vo.LibraryVO;
import com.multi.mini6.librarypage.vo.LibraryPageVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LibraryPageDAO {
    @Autowired
    SqlSessionTemplate my;
    
    // 전체 데이터 개수
    public int count() {
        return my.selectOne("library.count");
    }

    // 전체 리스트 조회
    public List<LibraryVO> list3(LibraryPageVO libraryPageVO) {
        return my.selectList("library.list3", libraryPageVO);
    }
    

    // 도서관 이름 검색
    public List<LibraryVO> search_name(LibraryPageVO libraryPageVO){
        return my.selectList("library.search_name", libraryPageVO);
    }

    // 도서관 지역 검색
    public List<LibraryVO> search_address(LibraryPageVO libraryPageVO){
        //System.out.println("libraypageVO>>>>  " + libraryPageVO);
        return my.selectList("library.search_address", libraryPageVO);
    }

    // 검색했을 때의 게시물 수 (mapper - count1로 연결되어있음)
    public int search_count(LibraryPageVO libraryPageVO) {
        return my.selectOne("library.count1", libraryPageVO);
    }


}