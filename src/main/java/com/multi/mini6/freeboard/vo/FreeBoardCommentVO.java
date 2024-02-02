package com.multi.mini6.freeboard.vo;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class FreeBoardCommentVO {
  private int bocm_id; // 댓글번호
  private int board_id; // 게시글 번호
  private String cm_content; // 댓글내용
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private Date cm_createdAt; // 댓글등록일
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private Date cm_modifiedAt; // 댓글수정일
  private String nickname; // 닉네임
  private int cm_class; // 계층 - 원댓글(부모):0, 대댓글(자식): 1
  private int cm_group; // 그룹
  private int member_id; // 회원번호

  public int getBocm_id() {
    return bocm_id;
  }

  public void setBocm_id(int bocm_id) {
    this.bocm_id = bocm_id;
  }

  public int getBoard_id() {
    return board_id;
  }

  public void setBoard_id(int board_id) {
    this.board_id = board_id;
  }

  public String getCm_content() {
    return cm_content;
  }

  public void setCm_content(String cm_content) {
    this.cm_content = cm_content;
  }

  public Date getCm_createdAt() {
    return cm_createdAt;
  }

  public void setCm_createdAt(Date cm_createdAt) {
    this.cm_createdAt = cm_createdAt;
  }

  public Date getCm_modifiedAt() {
    return cm_modifiedAt;
  }

  public void setCm_modifiedAt(Date cm_modifiedAt) {
    this.cm_modifiedAt = cm_modifiedAt;
  }

  public String getNickname() {
    return nickname;
  }

  public void setNickname(String nickname) {
    this.nickname = nickname;
  }

  public int getCm_class() {
    return cm_class;
  }

  public void setCm_class(int cm_class) {
    this.cm_class = cm_class;
  }

  public int getCm_group() {
    return cm_group;
  }

  public void setCm_group(int cm_group) {
    this.cm_group = cm_group;
  }

  public int getMember_id() {
    return member_id;
  }

  public void setMember_id(int member_id) {
    this.member_id = member_id;
  }

  @Override
  public String toString() {
    return "FreeBoardCommentVO{" +
            "bocm_id=" + bocm_id +
            ", board_id=" + board_id +
            ", cm_content='" + cm_content + '\'' +
            ", cm_createdAt=" + cm_createdAt +
            ", cm_modifiedAt=" + cm_modifiedAt +
            ", nickname='" + nickname + '\'' +
            ", cm_class=" + cm_class +
            ", cm_group=" + cm_group +
            ", member_id=" + member_id +
            '}';
  }
}
