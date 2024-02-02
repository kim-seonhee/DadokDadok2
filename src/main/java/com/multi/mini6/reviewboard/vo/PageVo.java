package com.multi.mini6.reviewboard.vo;

public class PageVo {
    private int start;
    private int end;
    private int page;

    public void setStartEnd() {
        start = 1 + (page -1 ) * 10;

        // 1+ (1-1) * 10 = 1
        // 1 + (2-1) * 10 = 11
        // 1+ (3-1) * 10 = 21

        end = page * 10;
        // 1페이지 * 10 = 10
        // 2페이지 * 10 = 20
    }
    private String keyword;

    public void setPage(int page) {
        this.page = page;
    }
    public int getPage() {
        return page;
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
    @Override
    public String toString() {
        return "PageVO2 [start=" + start + ", end=" + end + "]";
    }
    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
}
