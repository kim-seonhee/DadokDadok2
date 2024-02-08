package com.multi.mini6.mainpage.controller;

import com.multi.mini6.bookpage.service.BookService;
import com.multi.mini6.bookpage.vo.BooksVO;
import com.multi.mini6.freeboard.vo.FreeBoardVO;
import com.multi.mini6.mainpage.service.MainPageService;
import com.multi.mini6.noticeboard.vo.NoticeBoardVO;
import com.multi.mini6.reviewboard.service.ReviewBoardService;
import com.multi.mini6.reviewboard.vo.ReviewBoardVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/mainpage")
@RequiredArgsConstructor
public class MainPageController {

    @Autowired
    private MainPageService mainPageService;
    private final BookService bookService;
    private final ReviewBoardService reviewService;

    @GetMapping("/index")
    public String home(Model model, FreeBoardVO freeBoardVO, NoticeBoardVO noticeBoardVO) {

        // 자유게시판에서 글 최신순 5개 가져오기
        List<FreeBoardVO> freeBoardList = (List<FreeBoardVO>) mainPageService.getFreeBoardList(freeBoardVO);

        model.addAttribute("freeBoardList", freeBoardList); // 자유게시판

        // 공지사항에서 글 최신순 5개 가져오기
        List<NoticeBoardVO> noticeBoardList = (List<NoticeBoardVO>) mainPageService.getNoticeBoardList(noticeBoardVO);

        model.addAttribute("noticeBoardList", noticeBoardList); // 공지사항
        return "mainpage/index";
    }

    //도서 검색 기능
    //Rest API
    @GetMapping("/book-search")
    @ResponseBody
    public ResponseEntity<List<BooksVO>> bookSearch(@RequestParam("searchKeyword") String searchKeyword) {
        return ResponseEntity.ok(bookService.bookSearch(searchKeyword));
    }

    //후기 리스트 가져오기
    @GetMapping("/review-list")
    @ResponseBody
    public ResponseEntity<List<ReviewBoardVO>> reviewList(ReviewBoardVO reviewBoardVO) {
        return ResponseEntity.ok(mainPageService.getReviewList(reviewBoardVO));
    }


}
