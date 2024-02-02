package com.multi.mini6.loginpage.security;

import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// AccessDeniedHandler 는 로그인 및 권한을 사용자가 커스터마이징 할 수 있도록
// 스프링 시큐리티 내부에 미리 구현되어 있는 일종의 템플릿입니다.
@Log4j2
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response,
                       AccessDeniedException accessDeniedException) throws IOException, ServletException {
        log.error("커스텀 접근 거부 핸들러 실행");
        log.error("/accessError 페이지로 리다이렉트");

        // 결과 페이지로 넘어가기 전에 어떻게 처리할 지를 커스텀
        response.sendRedirect("/loginpage/accessError");

    }
}