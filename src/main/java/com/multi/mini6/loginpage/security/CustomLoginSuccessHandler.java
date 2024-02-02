package com.multi.mini6.loginpage.security;


import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Log4j2
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// 로그인 성공 시 어떤 권한인지 체크하기 위해
		// 부여받은 권한들을 불러와야 합니다.
		// ROLE_ADMIN 의 경우는 ROLE_MEMBER가 함꼐 부여되기 떄문에 경우에 따라 권한이 여럿일 수 있습니다.
	
		log.warn("로그인 성공");
		List<String> roleList = new ArrayList<>();
		
		// 향상된 for문으로 여러 개의 권한을 get
		for (GrantedAuthority role : authentication.getAuthorities()) {
			roleList.add(role.getAuthority());
		}
		
		log.warn("부여받은 권한들 디버깅 : " + roleList);
		// 이후 roleList에 포함된 권한을 통해 로그인 계정의 권한에 따라 처리
		// 각각 if문 처리하지 않으면 리다이렉트가 중복호출됩니다 *주의*
		if(roleList.contains("ROLE_ADMIN")) {
			response.sendRedirect("/adminpage/BookUploadPage");
			
			// 리다이렉트가 또 실행되지 않도록 리턴해주세요
			return;
		}
		
		if(roleList.contains("ROLE_MEMBER")) {
			response.sendRedirect("/mainpage/index");
			return;
		}
		
		response.sendRedirect("/mainpage/index");
		
		
	}

}
