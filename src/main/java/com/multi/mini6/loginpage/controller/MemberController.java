package com.multi.mini6.loginpage.controller;

import com.multi.mini6.loginpage.service.MemberService;
import com.multi.mini6.loginpage.vo.AuthorityVO;
import com.multi.mini6.loginpage.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
@RequestMapping("/loginpage")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final PasswordEncoder passwordEncoder;


    @GetMapping("/all")
    public void doAll() {
        log.info("do all can access everybody.");
    }

    @PreAuthorize("hasAnyRole('ROLE_MEMBER')")
    @GetMapping("/member")
    public void doMember() {
        log.info("logined member");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @GetMapping("/admin")
    public void doAdmin() {
        log.info("admin only");
    }

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @GetMapping("/memberlist")
    public void getMemberList(Model model) {
        model.addAttribute("list", memberService.getMemberList());

    }


    @PreAuthorize("permitAll")
    @GetMapping("/login")
    public String loginPage() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication instanceof AnonymousAuthenticationToken){
            return "/loginpage/customLogin";
        }else{
            // TODO :  이미 로그인이 되어있는 상태면 마이페이지로 이동하게 수정
            return "redirect:/mainpage/index";
        }
    }


    @PreAuthorize("permitAll")
    @GetMapping("/signup") //회원 가입 페이지
    public String signupPage() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication instanceof AnonymousAuthenticationToken)
            return "/loginpage/signupPage";

        return "redirect:/mainpage/index";
    }
    @PreAuthorize("permitAll")
    @PostMapping("/signup") //회원가입
    public String signup(MemberVO memberVO) {
        log.info("사용자가 가입 시 받는 데이터들 : " + memberVO);

        String rawPassword = memberVO.getPassword();
        log.info("암호화 전에 받은 pw" + rawPassword);
        memberVO.setPassword(passwordEncoder.encode(rawPassword));
        log.info("암호화 후 : " + memberVO.getPassword());

        // null 상태인 authList에 빈 ArrayList를 먼저 배정
        memberVO.setAuthList(new ArrayList<AuthorityVO>());

        AuthorityVO authorityVO = new AuthorityVO();
        authorityVO.setAuthority_name("ROLE_MEMBER");
        authorityVO.setEmail(memberVO.getEmail());
        memberVO.setAuthList(new ArrayList<>(Arrays.asList(authorityVO)));

        log.info(memberVO.getAuthList().toString());
        memberService.insertMember(memberVO);

        return "redirect:/mainpage/index";
    }


    //이메일 중복확인 rest api
    @PostMapping("/check-email")
    @ResponseBody
    public Map<String, Boolean> checkEmail(@RequestParam String email) {
        boolean exists = memberService.checkEmail(email);
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return response;
    }
}