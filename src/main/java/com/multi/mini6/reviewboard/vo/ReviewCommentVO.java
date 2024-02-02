package com.multi.mini6.reviewboard.vo;

import lombok.Data;

import java.util.Date;

@Data
public class ReviewCommentVO {
    private int cm_id;
    private int review_id;
    private int member_id;
    private int book_id;
    private String cm_content;
    private Date cm_createAt;
    private Date cm_modiefiedAt;

    private String nickname;

//    public int getCm_id() {
//        return cm_id;
//    }
//    public void setCm_id(int cm_id) {
//        this.cm_id = cm_id;
//    }
//    public int getReview_id() {
//        return review_id;
//    }
//    public void setReview_id(int review_id) {
//        this.review_id = review_id;
//    }
//    public int getMember_id() {
//        return member_id;
//    }
//    public void setMember_id(int member_id) {
//        this.member_id = member_id;
//    }
//    public int getBook_id() {
//        return book_id;
//    }
//    public void setBook_id(int book_id) {
//        this.book_id = book_id;
//    }
//    public String getCm_content() {
//        return cm_content;
//    }
//    public void setCm_content(String cm_content) {
//        this.cm_content = cm_content;
//    }
//    public Date getCm_createAt() {
//        return cm_createAt;
//    }
//    public void setCm_createAt(Date cm_createAt) {
//        this.cm_createAt = cm_createAt;
//    }
//    public Date getCm_modiefiedAt() {
//        return cm_modiefiedAt;
//    }
//    public void setCm_modiefiedAt(Date cm_modiefiedAt) {
//        this.cm_modiefiedAt = cm_modiefiedAt;
//    }
//
//    public int auth;
//    public String getNickname() {
//        return nickname;
//    }
//
//    // Setter 메서드
//    public void setNickname(String nickname) {
//        this.nickname = nickname;
//    }
//    public int getAuth() {
//        return this.auth;
//    }
//
//    // setter
//    public void setAuth(int auth) {
//        this.auth = auth;
//    }
//    public String toString() {
//        return "ReviewVO [cm_id=" + cm_id + ", review_id=" + review_id + ", member_id=" + member_id + ", book_id="
//                + book_id + ", cm_content=" + cm_content + ", cm_createAt=" + cm_createAt + ", cm_modiefiedAt="
//                + cm_modiefiedAt + ", nickname=" + nickname + ", auth=" + auth + "]";
//    }
//

}
