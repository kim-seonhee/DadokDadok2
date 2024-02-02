package com.multi.mini6.librarypage.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 매개변수로 받는 생성자 자동 생성
public class LibraryVO extends LibraryPageVO {

    private int lib_code; //111287
    private String lib_name; //가슴따뜻한작은도서관
    private String lib_address; //서울특별시 서대문구 응암로1길 10
    private String lib_tel; //02-330-8652
    private String lib_fax; //053-257-2284
    private double lib_latitude; //37.5814481
    private double lib_longitude; //126.9111617
    private String lib_homepage; //http://lib.sdm.or.kr
    private String lib_closed; //휴관중 (2023.1.1.~ 현재) / 2025년 재개관 예정
    private String lib_operating_time; //화~금 09:00~18:00 / 토일 09:00~17:00
    private String lib_bookcount; //6495

}
