package com.multi.mini6.librarypage.controller;

import com.multi.mini6.librarypage.vo.LibraryVO;
import com.multi.mini6.librarypage.service.LibraryService;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j2
@RequestMapping("librarypage")
public class LibraryController {
    @Autowired
    LibraryService libraryService;

    // 도서관 정보 상세보기
    @RequestMapping("/library_one")
    public void one(LibraryVO libraryVO, Model model) throws Exception {
        //System.out.println(libraryVO);
        LibraryVO bag = libraryService.library_one(libraryVO);
        log.info("one bag 출력 >> " + bag);
        model.addAttribute("bag", bag);
    }

    // 도서관 API -> DB 저장
    @RequestMapping("/library_insert")
    public void library_insert(){
        libraryService.library_insert();
    }

    // 관리자 계정인 경우에만 관리자 페이지로 이동 가능
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @RequestMapping("/library_admin")
    public void library_admin(){
        log.info("admin only");
    }


}
