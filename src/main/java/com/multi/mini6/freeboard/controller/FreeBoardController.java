package com.multi.mini6.freeboard.controller;

import com.multi.mini6.freeboard.vo.FreeBoardAttachVO;
import com.multi.mini6.freeboard.vo.FreeBoardCommentVO;
import com.multi.mini6.freeboard.vo.FreeBoardPageVO;
import com.multi.mini6.freeboard.vo.FreeBoardVO;
import com.multi.mini6.freeboard.service.FreeBoardService;

import java.io.*;
import java.net.URLDecoder;
import java.security.Principal;
import java.util.*;

import com.multi.mini6.loginpage.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/freeboard")
@Slf4j
public class FreeBoardController {

    @Autowired
    private FreeBoardService freeBoardService;

    //자유게시판 글 작성페이지로이동
    @GetMapping("/board_insert")
    public void getInsert() {
    }

    // 자유게시판 게시글 등록 + 첨부파일 등록(s3)
    @PostMapping("/board_insert")
    @ResponseBody
    public ResponseEntity<?> freeBoardInsertS3(@RequestParam("file") MultipartFile[] files,
                                               @ModelAttribute FreeBoardVO freeBoardVO,
                                               FreeBoardAttachVO freeBoardAttachVO) {

        //  게시글 등록
        freeBoardService.freeBoardInsert(freeBoardVO);
        int board_id = freeBoardVO.getBoard_id();
        List<String> uploadedFiles = new ArrayList<>();
        boolean isUploadFailed = false;

        for (MultipartFile file : files) {
            // 파일 크기가 5MB를 초과하는지 확인
            final long maxFileSize = 5 * 1024 * 1024; // 5MB
            if (file.getSize() > maxFileSize) {
                isUploadFailed = true;
                break;
            }

            try {
                // 파일 업로드
                String res = freeBoardService.freeBoardInsertS3(file, board_id, freeBoardAttachVO);

                if (res == null || res.isEmpty()) {
                    isUploadFailed = true;
                    break;
                }

                uploadedFiles.add(res);
            } catch (IOException e) {
                isUploadFailed = true;
                break;
            }
        }

        if (isUploadFailed) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 업로드 중 오류가 발생했습니다.");
        } else {
            return ResponseEntity.ok().body("파일 업로드 성공: " + String.join(", ", uploadedFiles));
        }

    }

    //자유게시판 글 리스트
    @GetMapping("/board_list")
    public String freeBoardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                @RequestParam(value = "searchType", defaultValue = "") String searchType,
                                @RequestParam(value = "keyword", defaultValue = "") String keyword,
                                Model model, FreeBoardPageVO freeboardPageVO, HttpSession session) {

        // 검색어가 비어있지 않고 , 세션에 저장된 이전검색어와 다른 경우 page를 1로 설정
        // 이렇게 설정하지 않으면 첫번째 검색결과의 3페이지에서 재검색 결과가 3페이지 미만인경우 페이지 이동하지 않으면 보이지 않음
        if (!keyword.isEmpty() && !keyword.equals(session.getAttribute("keyword"))) {
            page = 1;
        }

        // 검색 타입과 검색어 초기 설정
        if (keyword != null && !keyword.isEmpty()) {
            session.setAttribute("searchType", searchType);
            session.setAttribute("keyword", keyword);
        } else {

            session.removeAttribute("searchType");
            session.removeAttribute("keyword");

            searchType = "";
            keyword = "";
        }

        // 검색 타입과 검색어 설정
        freeboardPageVO.setSearchType(searchType);
        freeboardPageVO.setKeyword(keyword);

        // 전체 게시물 수
        int count = freeBoardService.boardCount(freeboardPageVO);

        // 현재 페이지 설정
        freeboardPageVO.setPage(page);

        //한 페이지에서 보여줄 게시글 수(10개)
        int pageSize = freeboardPageVO.getPageSize();

        // 시작, 마지막 페이지 수 가져오기
        freeboardPageVO.setStartEnd();
        // 현재페이지에서 보여줄 글 목록
        List<FreeBoardVO> list = freeBoardService.freeBoardList(freeboardPageVO);

        // totalPage = (전체 게시물 수 + 한 페이지에서 보여줄 게시글 수 - 1)  / 한 페이지에서 보여줄 게시글 수
        // 정수 나눗셈 결과: 정수 반환, 소수부분 버림
        //   --> count / pageSize 결과값이 나머지가 있을 경우를 대비해  pageSize  - 1 해줌
        int totalPage = (count + pageSize - 1) / pageSize;

        model.addAttribute("boardList", list); // 페이지에서 보여줄 글 목록
        model.addAttribute("totalPage", totalPage); // 전체 페이지 수
        model.addAttribute("page", page); // 현재 페이지 번호
        model.addAttribute("count", count); // 전체 게시물 수
        model.addAttribute("searchType", searchType); // 검색 타입
        model.addAttribute("keyword", keyword); // 검색어

        return "/freeboard/board_list";
    }

    // 자유게시판 글 상세보기
    @RequestMapping("/board_one")
    public String one(FreeBoardVO freeBoardVO, FreeBoardPageVO freeboardPageVO, Model model,
                      @RequestParam(value = "page", defaultValue = "1") int page,
                      @RequestParam(value = "searchType", defaultValue = "") String searchType,
                      @RequestParam(value = "keyword", defaultValue = "") String keyword, Principal principal, Authentication authentication
    ) throws Exception {

        // 새로고침시로그인 풀리는 경우 로그인페이지로 이동
        if (principal == null) {
            return "redirect:/loginpage/customLogin";
        }

        // 현재 페이지 설정
        freeboardPageVO.setPage(page);

        // 현재 로그인한 member_id
        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        int userId = customUser.getMember().getMember_id();
        freeBoardVO.setMember_id(userId);

        // 게시글 정보
        FreeBoardVO result = freeBoardService.freeBoardOne(freeBoardVO.getBoard_id());

        // 현재 로그인한 사용자가 게시글 작성자가 아닌 경우에만 조회수 증가
        if (userId != result.getMember_id()) {
            freeBoardService.viewsCount(freeBoardVO);
        }

        // s3 파일 정보 가져오기
        List<String> s3FileUrlList = freeBoardService.getS3FileList(freeBoardVO.getBoard_id());
        List<String> s3FileNames = new ArrayList<>();
        List<String> s3FileTypes = new ArrayList<>();
        log.info("s3FileUrlList {}", s3FileUrlList);

        for (String url : s3FileUrlList) {
            String encodedFileName = url.substring(url.lastIndexOf("_") + 1, url.lastIndexOf("."));
            String s3FileType = url.substring(url.lastIndexOf(".") + 1);

            // URL 인코딩된 파일 이름을 디코딩
            String s3FileName = URLDecoder.decode(encodedFileName, "UTF-8");

            s3FileNames.add(s3FileName);
            s3FileTypes.add(s3FileType);
            log.info("s3FileNames {}", s3FileNames);
            log.info("s3FileTypes {}", s3FileTypes);
        }

        // 이전글, 다음글
        FreeBoardVO previousPost = freeBoardService.getPreviousPost(freeBoardVO.getBoard_id());
        FreeBoardVO nextPost = freeBoardService.getNextPost(freeBoardVO.getBoard_id());

        // 게시글 내용 엔터처리
        String contentEnter = result.getBoard_content().replace("\r\n", "<br>");
        result.setBoard_content(contentEnter);

        // 해당 게시글의 댓글 목록 가져오기
        Map<Integer, List<FreeBoardCommentVO>> groupedComments = freeBoardService.findList(freeBoardVO.getBoard_id());

        model.addAttribute("result", result);
        model.addAttribute("previousPost", previousPost);
        model.addAttribute("nextPost", nextPost);
        model.addAttribute("page", page); // 모델에 페이지 번호 추가
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchType", searchType);
        model.addAttribute("groupedComments", groupedComments); // 댓글리스트
        model.addAttribute("s3FileUrlList", s3FileUrlList); // 파일첨부 url
        model.addAttribute("s3FileNames", s3FileNames); // 파일이름
        model.addAttribute("s3FileTypes", s3FileTypes); // 파일타입

        return "/freeboard/board_one";
    }

    // 자유게시판 수정페이지로 이동
    @GetMapping("/board_update")
    public String freeBoardUpdate(@RequestParam("board_id") int board_id, Model model, FreeBoardAttachVO freeBoardAttachVO) {
        // 게시글 정보 조회
        FreeBoardVO freeBoardVO = freeBoardService.freeBoardOne(board_id);

        // 첨부파일 정보 조회
        List<FreeBoardAttachVO> FileList = freeBoardService.freeBoardFileList(board_id);

        // 파일이름을 _ 이후의 문자열로 변경
        List<String> modifiedNames = new ArrayList<>();
        for (FreeBoardAttachVO file : FileList) {
            String fileName = file.getBoard_file_name();
            int index = fileName.indexOf("_");
            if (index > -1) {
                modifiedNames.add(fileName.substring(index + 1));
            } else {
                modifiedNames.add(fileName);
            }
        }
        model.addAttribute("freeBoardVO", freeBoardVO);
        model.addAttribute("FileList", FileList);
        model.addAttribute("modifiedNames", modifiedNames);

        return "freeboard/board_update";
    }

    // 자유게시판 게시글 수정
    @PostMapping("/board_update")
    @ResponseBody
    public ResponseEntity<Integer>  freeBoardUpdate(@RequestParam("board_id") int board_id,
                                  @RequestParam("board_title") String board_title,
                                  @RequestParam("board_content") String board_content,
                                  @RequestParam(value = "file", required = false) MultipartFile[] files, FreeBoardAttachVO freeBoardAttachVO) {

        // 게시글 정보 조회
        FreeBoardVO freeBoardVO = freeBoardService.freeBoardOne(board_id);

        // 게시글 정보 갱신
        freeBoardVO.setBoard_title(board_title);
        freeBoardVO.setBoard_content(board_content);
        freeBoardService.freeBoardUpdate(freeBoardVO);

        // 새 첨부파일이 있을 경우에만 기존 첨부파일 삭제 및 파일 관련 처리 수행
        if (files != null && files.length > 0 && !files[0].isEmpty()) {
            // 기존 첨부파일 삭제
            List<FreeBoardAttachVO> s3FileList = freeBoardService.freeBoardFileList(board_id);
            if (!s3FileList.isEmpty()) {
                for (FreeBoardAttachVO s3FileUrl : s3FileList) {
                    // S3에서 파일 삭제
                    freeBoardService.freeBoardDeleteS3(s3FileUrl.getBoard_file_name());
                }
                // DB에서 파일 정보 삭제
                freeBoardService.freeBoardFileDelete(board_id);
            }

            // 새 첨부파일 업로드
            boolean isUploadFailed = false;
            List<String> uploadedFiles = new ArrayList<>();
            for (MultipartFile file : files) {
                // 파일 크기가 5MB를 초과하는지 확인
                final long maxFileSize = 5 * 1024 * 1024; // 5MB
                if (file.getSize() > maxFileSize) {
                    isUploadFailed = true;
                    break;
                }

                try {
                    // 파일 업로드
                    String s3FileName = freeBoardService.freeBoardInsertS3(file, board_id, freeBoardAttachVO);
                    if (s3FileName == null || s3FileName.isEmpty()) {
                        isUploadFailed = true;
                        break;
                    }

                    uploadedFiles.add(s3FileName);
                } catch (IOException e) {
                    isUploadFailed = true;
                    break;
                }
            }
        }
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(freeBoardVO.getBoard_id());

    }


    // 자유게시판 댓글 입력
    @PostMapping("/comment_insert")
    public @ResponseBody Map<Integer, List<FreeBoardCommentVO>> commentInsert(@RequestBody FreeBoardCommentVO freeBoardCommentVO) {
        // 댓글 등록
        freeBoardService.commentInsert(freeBoardCommentVO);

        // 해당 게시글의 댓글 목록 가져오기
        Map<Integer, List<FreeBoardCommentVO>> groupedComments = freeBoardService.findList(freeBoardCommentVO.getBoard_id());

        // Jackson 라이브러리가 자동으로 Map의 Integer 키를 JSON 객체의 문자열 키로 변환
        return groupedComments;
    }

    // 자유게시판 댓글수정
    @PutMapping("/comment_update")
    public ResponseEntity<String> commentUpdate(@RequestBody FreeBoardCommentVO freeBoardCommentVO) {
        freeBoardService.commentUpdate(freeBoardCommentVO);
        return new ResponseEntity<>("댓글 수정 성공", HttpStatus.OK);

    }

    // 자유게시판 댓글삭제
    @PostMapping("/comment_delete")
    @ResponseBody
    public ResponseEntity<String> commentDelete(@RequestParam("board_id") int board_id, @RequestParam("cm_group") int cm_group) {
        try {
            freeBoardService.commentDelete(board_id, cm_group);
            return new ResponseEntity<>("댓글 삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("댓글 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 자유게시판 대댓글삭제
    @PostMapping("/comment_child_delete")
    @ResponseBody
    public ResponseEntity<String> commentDelete(@RequestParam("bocm_id") int bocm_id) {
        try {
            freeBoardService.commentChildDelete(bocm_id);
            return new ResponseEntity<>("대댓글 삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("대댓글 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 자유게시판 대댓글 입력
    @PostMapping("/comment_reply")
    public ResponseEntity<String> commentReply(@RequestBody FreeBoardCommentVO freeBoardCommentVO) {
        try {
            freeBoardService.commentReply(freeBoardCommentVO);
            return new ResponseEntity<>("대댓글 입력 성공", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("대댓글 입력 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }


    //자유게시판 게시글 삭제 + s3 파일 삭제
    @Transactional
    @PostMapping("/board_delete")
    @ResponseBody
    public Map<String, Object> freeBoardDelete(int board_id) {

        Map<String, Object> result = new HashMap<>();

        // 댓글 목록 가져오기
        Map<Integer, List<FreeBoardCommentVO>> commentListMap = freeBoardService.findList(board_id);
        // 댓글 삭제 (댓글 목록이 있는 경우)
        for (Integer key : commentListMap.keySet()) {
            List<FreeBoardCommentVO> commentList = commentListMap.get(key);
            for (FreeBoardCommentVO comment : commentList) {
                freeBoardService.commentDelete(comment.getBoard_id(), comment.getCm_group()); // 댓글 삭제
            }
        }

        try {
            // db에 저장된 파일 리스트 가져오기
            List<FreeBoardAttachVO> s3FileList = freeBoardService.freeBoardFileList(board_id);

            log.info("s3FileList {}", s3FileList);
            // 파일이 있는 경우 s3파일 + DB삭제
            if (!s3FileList.isEmpty()) {
                for (FreeBoardAttachVO s3FileUrl : s3FileList) {
                    // s3삭제
                    freeBoardService.freeBoardDeleteS3(s3FileUrl.getBoard_file_name());
                    log.info("s3FileUrl {}", s3FileUrl);
                }
                // db삭제
                freeBoardService.freeBoardFileDelete(board_id);
            }

            // 게시글 삭제
            freeBoardService.freeBoardDelete(board_id);

            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
        }
        return result;
    }


}
