package com.multi.mini6.loginpage.controller;

import com.multi.mini6.loginpage.service.MemberService;
import com.multi.mini6.loginpage.vo.CustomUser;
import com.multi.mini6.loginpage.vo.MemberVO;
import com.multi.mini6.loginpage.vo.PasswordChangeDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.Optional;

@Controller
@Slf4j
@RequestMapping("/settingpage")
@RequiredArgsConstructor
public class SettingController {

    private final MemberService memberService;

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @GetMapping("/settingpage")
    public void setting(Model model) {
        CustomUser email = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        MemberVO member = memberService.getMember(email.getUsername());

        model.addAttribute("member", member); // 뷰에 사용자 정보 전달
    }

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @PostMapping("/update-profile")
    public String updateProfile(@RequestParam("userImg") MultipartFile userImg,
                                Principal principal) throws IOException {
        if(!userImg.isEmpty()) {
            CustomUser customUser = (CustomUser) ((Authentication) principal).getPrincipal();
            String email = customUser.getUsername();

            memberService.saveProfileImage(userImg, email);
        }

        return "redirect:/settingpage/settingpage";
    }

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @PostMapping("/update")
    public String edit(@ModelAttribute MemberVO memberVO,
                       Principal principal,
                       MultipartFile profileImg) {
        // Principal로부터 현재 로그인한 사용자의 정보를 얻고
        // memberVO에 정보 업데이트를 적용
        CustomUser customUser = (CustomUser) ((Authentication) principal).getPrincipal();

        MemberVO existingMember = memberService.getMember(memberVO.getEmail());
        memberVO.setPassword(existingMember.getPassword());

        memberVO.setMember_id(customUser.getMember().getMember_id());

        memberService.updateMember(memberVO);

        return "redirect:/mainpage/index";
    }


    @PostMapping("/delete") //회원 탈퇴
    public String deleteMember(Principal principal,
                               @RequestParam("feedback") Optional<String> feedback)
    {
        CustomUser customUser = (CustomUser) ((Authentication) principal).getPrincipal();
        int id = customUser.getMember().getMember_id();
        String email = customUser.getMember().getEmail();

        if (id != 0) {
            memberService.deleteMember(id, email, feedback);
        }
        SecurityContextHolder.clearContext();

        return "redirect:/mainpage/index";
    }

    @PostMapping("/change-password")
    @ResponseBody
    public ResponseEntity<?> changePassword(Principal principal,
                                            @RequestBody PasswordChangeDTO dto) {
        String email = principal.getName(); // Get email from the currently logged-in user
        boolean success = memberService.changePassword(email, dto);

        if (success) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.badRequest().body("Password change failed.");
        }

    }
}
