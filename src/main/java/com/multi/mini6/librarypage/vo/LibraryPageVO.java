package com.multi.mini6.librarypage.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 매개변수로 받는 생성자 자동 생성
public class LibraryPageVO {
    private int start; //시작 번호
    private int end; // 마지막 번호
    private int total; //전체 게시물 수
    private int page; // 현재 페이지
    private int pageSize = 10; // 한 페이지에서 보여줄 게시글 수
    private String keyword; // 검색 키워드
    private String regionSelect; //지역
    private String categorySelect; //시군구

    // 이전에 사용하던 것
    public void setStartEnd() {

        start = 1 + (page - 1) * pageSize;
        // 1page : 1 + (1-1) *10 = start 1
        // 2page : 1 + (2-1) * 10 = start 11
        end = page * pageSize;
        // 1page : 1*10 = end 10
        // 2page : 2*10 = end 20

        // page에 잘못된 값이 전달되었을 때 - 제대로 안됨
        this.page = (page<1)? 1:page;
        this.page = (page>total)? total:page;

    }

}
