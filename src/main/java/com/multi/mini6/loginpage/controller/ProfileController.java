package com.multi.mini6.loginpage.controller;

import com.multi.mini6.loginpage.service.MemberService;
import com.multi.mini6.loginpage.service.ProfileService;
import com.multi.mini6.loginpage.vo.CustomUser;
import com.multi.mini6.loginpage.vo.MemberVO;
import com.multi.mini6.reviewboard.vo.ReviewVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/profilepage")
@RequiredArgsConstructor
public class ProfileController {

    private final MemberService memberService;
    private final ProfileService profileService;

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @GetMapping("/mypage")
    public void mypage(Model model) {
        log.info("mypage");

        //info 정보 가져오기
        //info 정보를 model에 담아서 view로 전달
        CustomUser email = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        log.info("email = " + email);
        MemberVO member = memberService.getMember(email.getUsername());
        log.info("member = " + member);

        model.addAttribute("member", member); // 뷰에 사용자 정보 전달
    }

    //회원 본인 게시글 가져오기
    //TODO : 회원 본인 게시글 가져오기 작업
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @GetMapping("/myboard")
    @ResponseBody
    public void myboard() {
        log.info("myboard");
    }

    //로그인한 id 값에 맞는 review 리스트 가져오기
    @GetMapping("/review-list-by-id")
    @ResponseBody
    public ResponseEntity<List<ReviewVO>> reviewListById() {
        CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        int memberId = customUser.getMemberId();
        // member_id를 사용하여 리뷰 목록 가져오기
        List<ReviewVO> reviews = profileService.getReviewListById(memberId);
        return ResponseEntity.ok(reviews);
    }
}
