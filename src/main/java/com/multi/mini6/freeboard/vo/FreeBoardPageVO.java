package com.multi.mini6.freeboard.vo;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class FreeBoardPageVO {
  private int start; // 페이지 시작번호
  private int end; // 페이지 끝번호
  private int page; // 현재 페이지번호
  private int pageSize = 10; // 한 페이지에서 보여줄 게시글 수
  private int maxPage; // 총 페이지 갯수

  private String searchType; // 검색 타입
  private String keyword; // 검색 키워드

  public void setStartEnd() {
    start = 1 + (page - 1) * pageSize;
    end = page * pageSize;
    //start = 1
    //end = 1 * 10
  }

  public int getStart() {
    return start;
  }

  public void setStart(int start) {
    this.start = start;
  }

  public int getEnd() {
    return end;
  }

  public void setEnd(int end) {
    this.end = end;
  }

  public int getPage() {
    return page;
  }

  public void setPage(int page) {
    this.page = page;
  }

  public int getPageSize() {
    return pageSize;
  }

  public void setPageSize(int pageSize) {
    this.pageSize = pageSize;
  }

  public int getMaxPage() {
    return maxPage;
  }

  public void setMaxPage(int maxPage) {
    this.maxPage = maxPage;
  }

  public String getSearchType() {
    return searchType;
  }

  public void setSearchType(String searchType) {
    this.searchType = searchType;
   // log.info("setSearchType) : {}", searchType);
  }

  public String getKeyword() {
    return keyword;
  }

  public void setKeyword(String keyword) {
    this.keyword = keyword;
   // log.info("setKeyword) : {}", keyword);
  }

  @Override
  public String toString() {
    return "FreeBoardPageVO{" +
            "start=" + start +
            ", end=" + end +
            ", page=" + page +
            ", pageSize=" + pageSize +
            ", maxPage=" + maxPage +
            ", searchType='" + searchType + '\'' +
            ", keyword='" + keyword + '\'' +
            '}';
  }
}
