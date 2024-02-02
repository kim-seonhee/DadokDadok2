package com.multi.mini6.reviewboard.vo;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

public class ReviewVO {

    private int review_id;
    private int member_id;

    private String book_isbn;

    private String review_title;
    private String review_content;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date review_createdAt;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date review_updatedAt;
    private int review_views;

    private String keyword;

    private int searchCount;

    private String search;
    private int start;
    private int end;
    private int page;

    private ReviewAttachVO review_attach;

    private List<ReviewAttachVO> attachList;
    public void setStartEnd() {
        start = 1 + (page -1 ) * 10;

        // 1+ (1-1) * 10 = 1
        // 1 + (2-1) * 10 = 11
        // 1+ (3-1) * 10 = 21

        end = page * 10;
        // 1페이지 * 10 = 10
        // 2페이지 * 10 = 20
    }
    private String nickname;
    public String getNickname() {
        return nickname;
    }

    // Setter 메서드
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    public int getReview_id() {
        return review_id;
    }
    public void setReview_id(int review_id) {
        this.review_id = review_id;
    }
    public int getMember_id() {
        return member_id;
    }
    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }
    public String getBook_isbn() {
        return book_isbn;
    }
    public void setBook_isbn(String book_isbn) {
        this.book_isbn = book_isbn;
    }
    public String getReview_title() {
        return review_title;
    }
    public void setReview_title(String review_title) {
        this.review_title = review_title;
    }
    public String getReview_content() {
        return review_content;
    }
    public void setReview_content(String review_content) {
        this.review_content = review_content;
    }
    public Date getReview_createdAt() {
        return review_createdAt;
    }
    public void setReview_createdAt(Date review_createdAt) {
        this.review_createdAt = review_createdAt;
    }
    public Date getReview_updatedAt() {
        return review_updatedAt;
    }
    public void setReview_updatedAt(Date review_updatedAt) {
        this.review_updatedAt = review_updatedAt;
    }
    public int getReview_views() {
        return review_views;
    }
    public void setReview_views(int review_views) {
        this.review_views = review_views;
    }
    public String getKeyword() {
        return keyword;
    }
    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
    public int getSearchCount() {
        return searchCount;
    }
    public void setSearchCount(int searchCount) {
        this.searchCount = searchCount;
    }
    public String getSearch() {
        return search;
    }
    public void setSearch(String search) {
        this.search = search;
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
    public ReviewAttachVO getReview_attach() {
        return review_attach;
    }

    public void setReview_attach(ReviewAttachVO review_attach) {
        this.review_attach = review_attach;
    }

    public List<ReviewAttachVO> getAttachList() {
        return attachList;
    }
    public void setAttachList(List<ReviewAttachVO> attachList) {
        this.attachList = attachList;
    }
    @Override
    public String toString() {
        return "ReviewVO{" +
                "review_id=" + review_id +
                ", member_id=" + member_id +
                ", book_isbn=" + book_isbn +
                ", review_title='" + review_title + '\'' +
                ", review_content='" + review_content + '\'' +
                ", review_createdAt=" + review_createdAt +
                ", review_updatedAt=" + review_updatedAt +
                ", review_views=" + review_views +
                ", keyword='" + keyword + '\'' +
                ", searchCount=" + searchCount +
                ", search='" + search + '\'' +
                ", start=" + start +
                ", end=" + end +
                ", page=" + page +
                ", review_attach=" + review_attach +
                ", attachList=" + attachList +
                ", nickname=" + nickname +
                '}';
    }
}
