package com.multi.mini6.reviewboard.vo;



public class ReviewBoardAttachVO {
    private int review_attach_id; // 첨부파일번호
    private int review_id; // 자유게시판 번호
    private String review_uuid; // uuid
    private String review_file_name; // 파일이름
    private String review_file_type; // 파일타입

    public int getReview_attach_id() {
        return review_attach_id;
    }

    public void setReview_attach_id(int review_attach_id) {
        this.review_attach_id = review_attach_id;
    }

    public int getReview_id() {
        return review_id;
    }

    public void setReview_id(int review_id) {
        this.review_id = review_id;
    }

    public String getReview_uuid() {
        return review_uuid;
    }

    public void setReview_uuid(String review_uuid) {
        this.review_uuid = review_uuid;
    }

    public String getReview_file_name() {
        return review_file_name;
    }

    public void setReview_file_name(String review_file_name) {
        this.review_file_name = review_file_name;
    }

    public String getReview_file_type() {
        return review_file_type;
    }

    public void setReview_file_type(String review_file_type) {
        this.review_file_type = review_file_type;
    }

    @Override
    public String toString() {
        return "reviewboardAttachVO{" +
                "review_attach_id=" + review_attach_id +
                ", review_id=" + review_id +
                ", review_uuid='" + review_uuid + '\'' +
                ", review_file_name='" + review_file_name + '\'' +
                ", review_file_type='" + review_file_type + '\'' +
                '}';
    }
}
