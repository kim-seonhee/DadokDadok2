package com.multi.mini6.loginpage.vo;

import lombok.Data;

import java.util.Date;

@Data
public class GuestBookVO {
    private int id;
    private String author_email;
    private String author_nickname;
    private String recipient_email;
    private String recipient_nickname;
    private String message;
    private Date modifiedAt;
    private Date createdAt;
    private int parent_id;
}
