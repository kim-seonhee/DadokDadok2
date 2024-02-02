package com.multi.mini6.bookpage.vo;

import lombok.Data;

@Data
public class BooksLibrariesVO {

    private int id;
    private String isbn;
    private int lib_code;
    private String numberOfCopies;
    private String numberOfLoans;
    private String updatedAt;
}
