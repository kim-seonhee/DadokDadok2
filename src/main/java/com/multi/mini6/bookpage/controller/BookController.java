package com.multi.mini6.bookpage.controller;


import com.multi.mini6.bookpage.service.BookService;
import com.multi.mini6.bookpage.vo.BooksVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/bookpage")
public class BookController {

    private final BookService bookService;
//    private final BookAPIService bookAPIService;

    @GetMapping("/bookmain")
    public void book() { // JSP 뷰 이름 반환
    }

    @GetMapping("/booklist")
    public void bookListAfterSearch() {
    }

    @GetMapping("/bookdetail/{isbn}")
    public String bookDetail(@PathVariable("isbn") String isbn, Model model) {
        BooksVO booksVO = bookService.getBookInfo(isbn);
        model.addAttribute("booksVO", booksVO);
        return "/bookpage/bookdetail";
    }


    //도서 검색 기능
    //Rest API
    @GetMapping("/book-search")
    @ResponseBody
    public ResponseEntity<List<BooksVO>> bookSearch(@RequestParam("searchKeyword") String searchKeyword) {
        return ResponseEntity.ok(bookService.bookSearch(searchKeyword));
    }

    //후기 작성하러가기 버튼
    //후기 작성 페이지로 이동하게 한다
    @PreAuthorize("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')")
    @GetMapping("/bookreview/{isbn}")
    public String bookReview(@PathVariable("isbn") String isbn, Model model) {
        BooksVO booksVO = bookService.getBookInfo(isbn);
        model.addAttribute("booksVO", booksVO);
        return "/bookpage/bookreview";
    }
}
