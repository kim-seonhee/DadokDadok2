package com.multi.mini6.loginpage.vo;

import lombok.Data;

@Data
public class PasswordChangeDTO {
    private String email;
    private String currentPassword;
    private String newPassword;
    private String confirmNewPassword;
}
