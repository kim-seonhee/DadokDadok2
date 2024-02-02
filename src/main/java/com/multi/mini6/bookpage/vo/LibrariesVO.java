package com.multi.mini6.bookpage.vo;

import lombok.Data;

@Data
public class LibrariesVO {

    private String lib_name;
    private String 주소;
    private String 전화번호;
    private String 팩스번호;
    private double 위도;
    private double 경도;
    private String 홈페이지;
    private String 운영시간;
    private String 휴관일;
    private int lib_code;

}

