package com.multi.mini6.loginpage.controller;

import com.multi.mini6.bookpage.vo.PageVO;
import com.multi.mini6.loginpage.service.GuestBookService;
import com.multi.mini6.loginpage.vo.CustomUser;
import com.multi.mini6.loginpage.vo.GuestBookVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Log4j2
@RequestMapping("/profilepage/GuestBookPage")
@RequiredArgsConstructor
public class GuestBookController {

    final private GuestBookService guestBookService;

    // 방명록 페이지
    @PreAuthorize("permitAll()")
    @GetMapping("/guestbookDetail")
    public void getMyGuestBookAllEntries() {
        log.info("getMyGuestBookAllEntries() invoked.");
    }

    // 현재 로그인한 사용자의 이메일을 반환하는 메소드
    @GetMapping("/currentUserEmail")
    @ResponseBody
    public String getCurrentUserEmail(Authentication authentication) {
        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        return customUser.getUsername(); // 현재 로그인한 사용자의 이메일 반환
    }

    // 방명록 작성 기능
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
    @PostMapping("/addGuestBook")
    @ResponseBody
    public ResponseEntity<?> addGuestBook(@RequestBody GuestBookVO guestBookVO, Authentication authentication) {
        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        String email = customUser.getUsername(); // 현재 로그인한 사용자의 이메일
        String nickname = customUser.getNickname(); // 현재 로그인한 사용자의 닉네임

        // 작성자 이메일과 닉네임 설정
        guestBookVO.setAuthor_email(email);
        guestBookVO.setAuthor_nickname(nickname);

        // 수신자 이메일이 설정되지 않은 경우, 작성자 이메일을 수신자 이메일로 설정
        if (guestBookVO.getRecipient_email() == null) {
            guestBookVO.setRecipient_email(email);
            guestBookVO.setRecipient_nickname(nickname); // 수신자 닉네임도 작성자 닉네임으로 설정
        }

        // 나머지 수신자 닉네임 설정 로직 추가 (예를 들어, 수신자 닉네임을 받아와서 설정하는 등)

        log.info("Adding guest book entry: {}", guestBookVO);
        guestBookService.addGuestBook(guestBookVO); // 서비스를 통해 방명록 정보 저장

        // 메시지 내용이 비어 있는지 확인
        if (guestBookVO.getMessage() == null || guestBookVO.getMessage().trim().isEmpty()) {
            return new ResponseEntity<>("Message content cannot be empty", HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>("Guest book entry added successfully.", HttpStatus.CREATED); // 생성된 상태 코드 반환
    }


    // 방명록 5개 반환기능
    @GetMapping("/myGuestBookEntries")
    @ResponseBody
    public ResponseEntity<List<GuestBookVO>> getMyGuestBookEntries() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = ((CustomUser) authentication.getPrincipal()).getUsername(); // CustomUser의 getUsername 메서드 사용

        List<GuestBookVO> myGuestBookEntries = guestBookService.getGuestBookEntriesByEmail(email);
        if (myGuestBookEntries.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT); // 내용이 없으면 204 No Content 상태 코드 반환
        }
        return new ResponseEntity<>(myGuestBookEntries, HttpStatus.OK); // 방명록 목록과 200 OK 상태 코드 반환
    }


    // 방명록 전체 반환기능
    @GetMapping("/guestbookDetailAPI")
    @ResponseBody
    public ResponseEntity<?> getAllMyGuestBookEntries(@RequestParam(defaultValue = "1") int page,
                                                      @RequestParam(defaultValue = "10") int pageSize) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = ((CustomUser) authentication.getPrincipal()).getUsername();

        int totalItemCount = guestBookService.countGuestBookEntriesByEmail(email);
        PageVO pageVO = new PageVO(page, pageSize, totalItemCount);

        List<GuestBookVO> myGuestBookEntries = guestBookService.getAllGuestBookEntriesByEmail(email, pageVO.getPageSize(), pageVO.getOffset());
        if (myGuestBookEntries == null || myGuestBookEntries.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        Map<String, Object> response = new HashMap<>();
        response.put("guestBookEntries", myGuestBookEntries);
        response.put("pageInfo", pageVO);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }


    // 방명록 대댓글 반환기능
    @GetMapping("/guestbookDetailAPI/{parent_id}")
    @ResponseBody
    public ResponseEntity<List<GuestBookVO>> getChildGuestBookEntries(@PathVariable int parent_id) {
        List<GuestBookVO> childGuestBookEntries = guestBookService.getChildGuestBookEntries(parent_id);
        if (childGuestBookEntries == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND); // 방명록 정보가 없으면 404 Not Found 상태 코드 반환
        }
        return new ResponseEntity<>(childGuestBookEntries, HttpStatus.OK); // 방명록 정보와 200 OK 상태 코드 반환
    }


    //방명록 삭제
    @DeleteMapping("/deleteGuestBook/{id}")
    @ResponseBody
    public ResponseEntity<?> deleteGuestBook(@PathVariable int id) {
        guestBookService.deleteGuestBook(id);
        return ResponseEntity.ok("Guest book entry deleted successfully.");
    }
    //방명록 부모댓글 삭제를 위해 대댓글 삭제후 부모댓글 삭제
    @DeleteMapping("/deleteAllGuestBook/{id}")
    @ResponseBody
    public ResponseEntity<?> deleteGuestBookComment(@PathVariable int id) {
        guestBookService.deleteAllGuestBook(id);
        return ResponseEntity.ok("Guest book entry deleted successfully.");
    }
    //방명록 수정, 삭제를 위해 아이디로 검색
    @GetMapping("/guestbookDetail/{id}")
    @ResponseBody
    public ResponseEntity<GuestBookVO> getGuestBookDetail(@PathVariable int id) {
        GuestBookVO guestBook = guestBookService.getGuestBookCommnetById(id);
        return ResponseEntity.ok(guestBook);
    }

    //방명록 수정
    @PutMapping("/updateGuestBook")
    @ResponseBody
    public ResponseEntity<?> updateGuestBook(@RequestBody GuestBookVO guestBookVO) {
        guestBookService.updateGuestBook(guestBookVO);
        return ResponseEntity.ok("Guest book entry updated successfully.");
    }


    //방명록 대댓글 작성 기능
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
    @PostMapping("/addGuestBookComment/{parent_id}")
    @ResponseBody
    public ResponseEntity<?> addGuestBookComment(@RequestBody GuestBookVO guestBookVO, @PathVariable int parent_id, Authentication authentication) {
        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        String email = customUser.getUsername(); // 현재 로그인한 사용자의 이메일
        String nickname = customUser.getNickname(); // 현재 로그인한 사용자의 닉네임

        // 작성자 이메일과 닉네임 설정
        guestBookVO.setAuthor_email(email);
        guestBookVO.setAuthor_nickname(nickname);
        guestBookVO.setParent_id(parent_id);

        // 수신자 이메일이 설정되지 않은 경우, 작성자 이메일을 수신자 이메일로 설정
        if (guestBookVO.getRecipient_email() == null) {
            guestBookVO.setRecipient_email(email);
            guestBookVO.setRecipient_nickname(nickname); // 수신자 닉네임도 작성자 닉네임으로 설정
        }

        // 나머지 수신자 닉네임 설정 로직 추가 (예를 들어, 수신자 닉네임을 받아와서 설정하는 등)

        log.info("Adding guest book entry: {}", guestBookVO);
        guestBookService.addGuestBookComment(guestBookVO); // 서비스를 통해 방명록 정보 저장

        // 메시지 내용이 비어 있는지 확인
        if (guestBookVO.getMessage() == null || guestBookVO.getMessage().trim().isEmpty()) {
            return new ResponseEntity<>("Message content cannot be empty", HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>("Guest book entry added successfully.", HttpStatus.CREATED); // 생성된 상태 코드 반환
    }


}
