package com.multi.mini6.loginpage.vo;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.security.Timestamp;
import java.util.Date;
import java.util.List;

@Data
public class MemberDeleteReasonVO {

    private String deleteEmail;
    private String memberDeleteReason;

}
