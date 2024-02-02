package com.multi.mini6.loginpage.security;

import com.multi.mini6.loginpage.service.MemberService;
import com.multi.mini6.loginpage.vo.CustomUser;
import com.multi.mini6.loginpage.vo.MemberVO;
import com.multi.mini6.loginpage.dao.MemberDAO;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Log4j2
@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private MemberService memberService;
    
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        log.debug("Attempting to load user by email: " + email);


        MemberVO vo = memberService.getMember(email);
        log.info("User found: " + vo);

        if (vo == null) {
            log.warn("No user found with email: " + email);
            throw new UsernameNotFoundException("No user found with email: " + email);
        }

        log.info("User found with email: " + email);
        return new CustomUser(vo);
    }
}
