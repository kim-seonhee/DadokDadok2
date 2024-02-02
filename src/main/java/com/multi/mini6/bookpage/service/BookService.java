package com.multi.mini6.bookpage.service;

import com.multi.mini6.bookpage.dao.BookDAO;
import com.multi.mini6.bookpage.vo.BooksVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;


@Service
@RequiredArgsConstructor
@Log4j2
public class BookService {

    private final RestTemplate restTemplate;
    private final BookDAO bookDAO;


    //도서 검색 기능
    public List<BooksVO> bookSearch(String searchKeyword) {
        return bookDAO.bookSearch(searchKeyword);
    }

    //도서 정보 가져오기
    public BooksVO getBookInfo(String isbn) {
        return bookDAO.getBookInfo(isbn);
    }

}
