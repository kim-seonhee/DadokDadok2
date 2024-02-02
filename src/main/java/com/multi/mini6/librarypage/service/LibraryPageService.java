package com.multi.mini6.librarypage.service;

import com.multi.mini6.librarypage.dao.LibraryPageDAO;
import com.multi.mini6.librarypage.vo.LibraryPageVO;
import com.multi.mini6.librarypage.vo.LibraryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LibraryPageService {
    @Autowired
    LibraryPageDAO libraryPageDAO;

    // 전체 데이터 개수
    public int count() {
        return libraryPageDAO.count();
    }

    // 전체 리스트 조회
    public List<LibraryVO> list3(LibraryPageVO libraryPageVO) {
        return libraryPageDAO.list3(libraryPageVO);
    }

    // 이름으로 검색
    public List<LibraryVO> search_name(LibraryPageVO libraryPageVO) {
        return libraryPageDAO.search_name(libraryPageVO);
    }

    // 지역으로 검색
    public List<LibraryVO> search_address(LibraryPageVO libraryPageVO) {
        return libraryPageDAO.search_address(libraryPageVO);
    }

    // 검색시 결과 개수
    public int search_count(LibraryPageVO libraryPageVO) {
        return libraryPageDAO.search_count(libraryPageVO);
    }
}

