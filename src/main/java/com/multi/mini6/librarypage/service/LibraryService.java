package com.multi.mini6.librarypage.service;

import com.multi.mini6.librarypage.vo.LibraryVO;
import com.multi.mini6.librarypage.dao.LibraryDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class LibraryService {

    @Autowired
    LibraryDAO libraryDAO;

    @Autowired
    private LibraryAPI libraryAPI;
    
    // 도서관 상세 보기
    public LibraryVO library_one(LibraryVO libraryVO) throws Exception {
        return libraryDAO.one(libraryVO);
    }

    // 도서관 API -> DB 삽입
    public void library_insert() {
        LibraryAPI libraryAPI = new LibraryAPI();
        ArrayList<LibraryVO> library_list = libraryAPI.parse();
        for (LibraryVO libraryVO : library_list){
            libraryDAO.library_insert(libraryVO);
        }
    }

}
