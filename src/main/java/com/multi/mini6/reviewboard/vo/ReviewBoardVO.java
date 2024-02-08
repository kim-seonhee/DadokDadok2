package com.multi.mini6.reviewboard.vo;

import java.util.Date;
import java.util.List;

public class ReviewBoardVO {
    private int review_id;
    private int member_id;
    private Date review_createdAt;
    private Date review_updatedAt;
    private String review_writer;
    private int review_views;
    private String review_title;
    private String review_content;
    private int review_board_no;
    private String nickname;

    private List<ReviewBoardAttachVO> attachList;


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

    public String getReview_writer() {
        return review_writer;
    }

    public void setReview_writer(String review_writer) {
        this.review_writer = review_writer;
    }

    public int getReview_views() {
        return review_views;
    }

    public void setReview_views(int review_views) {
        this.review_views = review_views;
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

    public int getReview_board_no() {
        return review_board_no;
    }

    public void setReview_board_no(int review_board_no) {
        this.review_board_no = review_board_no;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public List<ReviewBoardAttachVO> getAttachList() {
        return attachList;
    }

    public void setAttachList(List<ReviewBoardAttachVO> attachList) {
        this.attachList = attachList;
    }

    @Override
    public String toString() {
        return "ReviewBoardVO{" +
                "review_id=" + review_id +
                ", member_id=" + member_id +
                ", review_createdAt=" + review_createdAt +
                ", review_updatedAt=" + review_updatedAt +
                ", review_writer='" + review_writer + '\'' +
                ", review_views=" + review_views +
                ", review_title='" + review_title + '\'' +
                ", review_content='" + review_content + '\'' +
                ", review_board_no=" + review_board_no +
                ", nickname='" + nickname + '\'' +
                ", attachList=" + attachList +
                '}';
    }
}
