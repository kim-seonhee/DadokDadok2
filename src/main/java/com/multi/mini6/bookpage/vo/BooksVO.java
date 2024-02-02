package com.multi.mini6.bookpage.vo;

import lombok.Data;

@Data
public class BooksVO {
    private int id;
    private String title;
    private String author;
    private String publisher;
    private String year_of_publication;
    private String isbn;
    private String set_isbn;
    private String additional_symbol;
    private String volume;
    private String subject_classification_number;
}