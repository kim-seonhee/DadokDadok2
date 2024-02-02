package com.multi.mini6.librarypage.controller;


import com.multi.mini6.librarypage.vo.LibraryPageVO;
import com.multi.mini6.librarypage.vo.LibraryVO;
import com.multi.mini6.librarypage.service.LibraryPageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("librarypage")
public class LibraryPageController {

    @Autowired
    LibraryPageService libraryPageService;

    //ajax 비동기식
    @RequestMapping("/library_list3")
    public void list3(Model model, LibraryPageVO libraryPageVO, @RequestParam(value = "page", required = false, defaultValue = "1") int page) { // start, end
        // 현재 페이지 설정
        libraryPageVO.setPage(page);
        // 시작, 마지막 페이지수 가져오기
        libraryPageVO.setStartEnd();
        System.out.println(libraryPageVO);
        // 현재 페이지에서 보여줄 글 목록
        List<LibraryVO> list = libraryPageService.list3(libraryPageVO);

        // 전체 페이지 수 구하기
        int count = libraryPageService.count();

        System.out.println("전체 게시물 수>> " + count);
        // 한 페이지에서 보여줄 게시글 수(10개)
        int pageSize = libraryPageVO.getPageSize();

        // totalPage = (전체 게시물 수 + 한 페이지에서 보여줄 게시글 수 - 1)  / 한 페이지에서 보여줄 게시글 수
        // 정수 나눗셈 결과: 정수 반환, 소수부분 버림
        //   --> count / pageSize 결과값이 나머지가 있을 경우를 대비해  pageSize  - 1 해줌
        int totalPage = (count + pageSize - 1) / pageSize;
        // 마지막 페이지 번호
//        int pages = count / pageSize;
//        if (count % pageSize != 0) {
//            pages = count / pageSize + 1;
//        }
//        System.out.println("마지막 페이지 번호 >> " + pages);

        //모델로  views까지 페이지수를 넘겨야 페이지수 버튼을 만들 수 있음
        System.out.println("1 페이지당 가지고 온 게시물수>> " +list.size());


        //views로 전달
        model.addAttribute("list", list); // 페이지에서 보여줄 글 목록
        model.addAttribute("totalPage", totalPage); // 전체 페이지 수

        model.addAttribute("page", page); // 현재 페이지 번호
        model.addAttribute("count", count); // 전체 게시물 수


    }

    @RequestMapping("/library_list4")
    public void list4(LibraryPageVO libraryPageVO, Model model, @RequestParam("page") int page) { // start, end
        libraryPageVO.setStartEnd(); // start, end 계산해주는 메서드

        List<LibraryVO> list = libraryPageService.list3(libraryPageVO);
        //전체 페이지 수 구하기
        //모델로  views까지 페이지수를 넘겨야 페이지수 버튼을 만들 수 있음
        System.out.println("페이지당 가지고 온 게시물수>> " +list.size());
        //views로 전달
        model.addAttribute("list", list);
        model.addAttribute("page", page); // 현재 페이지 번호
        System.out.println(list.get(0));
    }


    @RequestMapping("/library_search_name")
    public void search_name(Model model, LibraryPageVO libraryPageVO, @RequestParam(value = "page", required = false, defaultValue = "1") int page){ // start, end
        int count = 0;
        int search_count = 0;
        String result = "";
        System.out.println("page : " + libraryPageVO.getPage());
        System.out.println("keyword : " + libraryPageVO.getKeyword());

        // 현재 페이지 설정
        libraryPageVO.setPage(page);
        // 시작, 마지막 페이지수 가져오기
        libraryPageVO.setStartEnd();
        System.out.println(libraryPageVO);

        System.out.println("전체 게시물 수>> " + count);

        // 한 페이지에서 보여줄 게시글 수(10개)
        int pageSize = libraryPageVO.getPageSize();



        List<LibraryVO> list = null;


        if (libraryPageVO.getKeyword() != null && !libraryPageVO.getKeyword().isEmpty()){
            list = libraryPageService.search_name(libraryPageVO);
            //count = libraryPageService.count(); 동적 쿼리
            //count = libraryPageService.search_count(libraryPageVO);
        }
        else{
            list = libraryPageService.list3(libraryPageVO);
            //count = libraryPageService.count();
            //search_count = libraryPageService.search_count(libraryPageVO);
        }

        count = libraryPageService.search_count(libraryPageVO);

        // totalPage = (전체 게시물 수 + 한 페이지에서 보여줄 게시글 수 - 1)  / 한 페이지에서 보여줄 게시글 수
        // 정수 나눗셈 결과: 정수 반환, 소수부분 버림
        //   --> count / pageSize 결과값이 나머지가 있을 경우를 대비해  pageSize  - 1 해줌
        int totalPage = (count + pageSize - 1) / pageSize;

        //모델로  views까지 페이지수를 넘겨야 페이지수 버튼을 만들 수 있음
        System.out.println("1 페이지당 가지고 온 게시물수>> " +list.size());

        //views로 전달
        model.addAttribute("list", list); // 페이지에서 보여줄 글 목록
        model.addAttribute("totalPage", totalPage); // 전체 페이지 수
        model.addAttribute("page", page); // 현재 페이지 번호
        model.addAttribute("count", count); // 전체 게시물 수
        model.addAttribute("keyword", libraryPageVO.getKeyword()); // 검색어
    }

    @RequestMapping("/library_search_name2")
    public void search_name2(LibraryPageVO libraryPageVO, Model model, @RequestParam("page") int page){ // start, end
        int count = 0;
        String result = "";
        System.out.println("page2 : " + libraryPageVO.getPage());
        System.out.println("keyword2 : " + libraryPageVO.getKeyword());

        // 시작, 마지막 페이지수 가져오기
        libraryPageVO.setStartEnd();
        System.out.println(libraryPageVO);

        System.out.println("전체 게시물 수2>> " + count);

        List<LibraryVO> list = null;

        if (libraryPageVO.getKeyword() != null && !libraryPageVO.getKeyword().isEmpty()){
            list = libraryPageService.search_name(libraryPageVO);
            count = libraryPageService.count();
        }
        else{
            list = libraryPageService.list3(libraryPageVO);
            count = libraryPageService.count();
        }

        //모델로  views까지 페이지수를 넘겨야 페이지수 버튼을 만들 수 있음
        System.out.println("1 페이지당 가지고 온 게시물수2>> " +list.size());

        //views로 전달
        model.addAttribute("list", list); // 페이지에서 보여줄 글 목록
        model.addAttribute("page", page); // 현재 페이지 번호
        model.addAttribute("keyword", libraryPageVO.getKeyword()); // 검색어
    }

    @RequestMapping("/library_search_address")
    public void search_address(Model model, LibraryPageVO libraryPageVO, @RequestParam(value = "page", required = false, defaultValue = "1") int page){ // start, end
        int count = 0;
        int search_count = 0;
        String result = "";
        System.out.println("page : " + libraryPageVO.getPage());
        System.out.println("regionSelect : " + libraryPageVO.getRegionSelect());
        System.out.println("categorySelect : " + libraryPageVO.getCategorySelect());

        // 현재 페이지 설정
        libraryPageVO.setPage(page);
        // 시작, 마지막 페이지수 가져오기
        libraryPageVO.setStartEnd();
        System.out.println(libraryPageVO);

        System.out.println("전체 게시물 수>> " + count);

        // 한 페이지에서 보여줄 게시글 수(10개)
        int pageSize = libraryPageVO.getPageSize();



        List<LibraryVO> list = null;


        if (libraryPageVO.getRegionSelect() != null && libraryPageVO.getCategorySelect() != null){
            list = libraryPageService.search_address(libraryPageVO);
            //count = libraryPageService.count(); 동적 쿼리
            //count = libraryPageService.search_count(libraryPageVO);
        }
        else{
            list = libraryPageService.list3(libraryPageVO);
            //count = libraryPageService.count();
            //search_count = libraryPageService.search_count(libraryPageVO);
        }

        System.out.println("search_count : " + libraryPageVO);
        //libraryPageVO.setRegionSelect("서울특별시");
        //libraryPageVO.setCategorySelect("용산구");
        count = libraryPageService.search_count(libraryPageVO);
        System.out.println("count : " + count);

        // totalPage = (전체 게시물 수 + 한 페이지에서 보여줄 게시글 수 - 1)  / 한 페이지에서 보여줄 게시글 수
        // 정수 나눗셈 결과: 정수 반환, 소수부분 버림
        //   --> count / pageSize 결과값이 나머지가 있을 경우를 대비해  pageSize  - 1 해줌
        int totalPage = (count + pageSize - 1) / pageSize;

        //모델로  views까지 페이지수를 넘겨야 페이지수 버튼을 만들 수 있음
        System.out.println("1 페이지당 가지고 온 게시물수>> " +list.size());

        //views로 전달
        model.addAttribute("list", list); // 페이지에서 보여줄 글 목록
        model.addAttribute("totalPage", totalPage); // 전체 페이지 수
        model.addAttribute("page", page); // 현재 페이지 번호
        model.addAttribute("count", count); // 전체 게시물 수
        model.addAttribute("regionSelect", libraryPageVO.getRegionSelect()); // 지역
        model.addAttribute("categorySelect", libraryPageVO.getCategorySelect()); // 시군구
    }

    @RequestMapping("/library_search_address2")
    public void search_address2(LibraryPageVO libraryPageVO, Model model){ // start, end
        int count = 0;
        String result = "";
        System.out.println("page2 : " + libraryPageVO.getPage());
        System.out.println("regionSelect2 : " + libraryPageVO.getRegionSelect());
        System.out.println("categorySelect2 : " + libraryPageVO.getCategorySelect());

        // 시작, 마지막 페이지수 가져오기
        libraryPageVO.setStartEnd();
        System.out.println(libraryPageVO);

        System.out.println("전체 게시물 수2>> " + count);

        List<LibraryVO> list = null;
        System.out.println("libraypageVO>>>>  " + libraryPageVO);
        if (libraryPageVO.getRegionSelect() != null && libraryPageVO.getCategorySelect() != null){
            list = libraryPageService.search_address(libraryPageVO);
            count = libraryPageService.count();
        }
        else{
            list = libraryPageService.list3(libraryPageVO);
            count = libraryPageService.count();
        }

        //모델로  views까지 페이지수를 넘겨야 페이지수 버튼을 만들 수 있음
        System.out.println("1 페이지당 가지고 온 게시물수2>> " +list.size());

        //views로 전달
        model.addAttribute("list", list); // 페이지에서 보여줄 글 목록
        model.addAttribute("page", libraryPageVO.getPage()); // 현재 페이지 번호
        model.addAttribute("regionSelect", libraryPageVO.getRegionSelect()); // 지역
        model.addAttribute("categorySelect", libraryPageVO.getCategorySelect()); // 시군구
    }

}