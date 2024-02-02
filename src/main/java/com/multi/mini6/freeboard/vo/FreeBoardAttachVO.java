package com.multi.mini6.freeboard.vo;

public class FreeBoardAttachVO {
  private int board_attach_id; // 첨부파일번호
  private int board_id; // 자유게시판 번호
  private String board_uuid; // uuid
  private String board_file_name; // 파일이름
  private String board_file_type; // 파일타입


  public int getBoard_attach_id() {
    return board_attach_id;
  }

  public void setBoard_attach_id(int board_attach_id) {
    this.board_attach_id = board_attach_id;
  }

  public int getBoard_id() {
    return board_id;
  }

  public void setBoard_id(int board_id) {
    this.board_id = board_id;
  }

  public String getBoard_uuid() {
    return board_uuid;
  }

  public void setBoard_uuid(String board_uuid) {
    this.board_uuid = board_uuid;
  }

  public String getBoard_file_name() {
    return board_file_name;
  }

  public void setBoard_file_name(String board_file_name) {
    this.board_file_name = board_file_name;
  }

  public String getBoard_file_type() {
    return board_file_type;
  }

  public void setBoard_file_type(String board_file_type) {
    this.board_file_type = board_file_type;
  }

  @Override
  public String toString() {
    return "FreeBoardAttachVO{" +
            "board_attach_id=" + board_attach_id +
            ", board_id=" + board_id +
            ", board_uuid='" + board_uuid + '\'' +
            ", board_file_name='" + board_file_name + '\'' +
            ", board_file_type='" + board_file_type + '\'' +
            '}';
  }
}
