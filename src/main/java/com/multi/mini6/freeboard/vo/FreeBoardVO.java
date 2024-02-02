package com.multi.mini6.freeboard.vo;

import java.util.Date;
import java.util.List;

public class FreeBoardVO {
  private int board_id;
  private int member_id;
  private Date board_createdAt;
  private Date board_updatedAt;
  private String board_writer;
  private int board_views;
  private String board_title;
  private String board_content;
  private int free_board_no;
  private String nickname;

  private List<FreeBoardAttachVO> attachList;


  public int getBoard_id() {
    return board_id;
  }
  public void setBoard_id(int board_id) {
    this.board_id = board_id;
  }
  public int getMember_id() {
    return member_id;
  }
  public void setMember_id(int member_id) {
    this.member_id = member_id;
  }
  public Date getBoard_createdAt() {
    return board_createdAt;
  }
  public void setBoard_createdAt(Date board_createdAt) {
    this.board_createdAt = board_createdAt;
  }
  public Date getBoard_updatedAt() {
    return board_updatedAt;
  }
  public void setBoard_updatedAt(Date board_updatedAt) {
    this.board_updatedAt = board_updatedAt;
  }
  public String getBoard_writer() {
    return board_writer;
  }
  public void setBoard_writer(String board_writer) {
    this.board_writer = board_writer;
  }
  public int getBoard_views() {
    return board_views;
  }
  public void setBoard_views(int board_views) {
    this.board_views = board_views;
  }
  public String getBoard_title() {
    return board_title;
  }
  public void setBoard_title(String board_title) {
    this.board_title = board_title;
  }
  public String getBoard_content() {
    return board_content;
  }
  public void setBoard_content(String board_content) {
    this.board_content = board_content;
  }

  public int getFree_board_no() {
    return free_board_no;
  }

  public void setFree_board_no(int free_board_no) {
    this.free_board_no = free_board_no;
  }

  public String getNickname() {
    return nickname;
  }

  public void setNickname(String nickname) {
    this.nickname = nickname;
  }

  public List<FreeBoardAttachVO> getAttachList() {
    return attachList;
  }

  public void setAttachList(List<FreeBoardAttachVO> attachList) {
    this.attachList = attachList;
  }

  @Override
  public String toString() {
    return "FreeBoardVO{" +
            "board_id=" + board_id +
            ", member_id=" + member_id +
            ", board_createdAt=" + board_createdAt +
            ", board_updatedAt=" + board_updatedAt +
            ", board_writer='" + board_writer + '\'' +
            ", board_views=" + board_views +
            ", board_title='" + board_title + '\'' +
            ", board_content='" + board_content + '\'' +
            ", free_board_no=" + free_board_no +
            ", nickname='" + nickname + '\'' +
            '}';
  }
}
