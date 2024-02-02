package com.multi.mini6.loginpage.vo;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Data
public class MemberVO {

    private int member_id;

    private String email;
    private String password;

    private String name;
    private String phoneNum;

    private String zipcode;
    private String address;
    private String detail_address;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createdAt;
    private String nickname;
    private String info;
    private String userImg;

    private List<AuthorityVO> authList;

}
