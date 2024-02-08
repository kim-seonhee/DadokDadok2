package com.multi.mini6.reviewboard.controller;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.multi.mini6.freeboard.vo.FreeBoardPageVO;
import com.multi.mini6.reviewboard.service.ReviewBoardService;
import com.multi.mini6.reviewboard.vo.ReviewBoardAttachVO;
import com.multi.mini6.reviewboard.vo.ReviewBoardCommentVO;
import com.multi.mini6.reviewboard.vo.ReviewBoardVO;

import java.io.*;
import java.net.*;
import java.security.Principal;
import java.util.*;
import com.amazonaws.HttpMethod;

import com.multi.mini6.loginpage.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
@RequestMapping("/reviewboard")
@Slf4j
public class ReviewBoardController {

    @Autowired
    private ReviewBoardService reviewBoardService;

    @Autowired
    private AmazonS3 s3Client;

    @Value("${bucketName}")
    private String bucketName;

    //후기게시판 글 작성페이지로이동
    @GetMapping("/review_insert")
    public void getInsert() {
    }

    // 후기게시판 게시글 등록 + 첨부파일 등록(s3)
    @PostMapping("/review_insert")
    @ResponseBody
    @Transactional
    public ResponseEntity<?> reviewBoardInsertS3(@RequestParam("file") MultipartFile[] files,
                                               @ModelAttribute ReviewBoardVO reviewBoardVO,
                                               ReviewBoardAttachVO reviewBoardAttachVO) {

        //  게시글 등록
        reviewBoardService.reviewBoardInsert(reviewBoardVO);
        int review_id = reviewBoardVO.getReview_id();
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
                String res = reviewBoardService.reviewBoardInsertS3(file, review_id, reviewBoardAttachVO);

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

    //후기게시판 글 리스트
    @GetMapping("/review_list")
    public String reviewBoardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                  @RequestParam(value = "searchType", defaultValue = "") String searchType,
                                  @RequestParam(value = "keyword", defaultValue = "") String keyword,
                                  Model model, FreeBoardPageVO freeBoardPageVo, HttpSession session) {

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
        freeBoardPageVo.setSearchType(searchType);
        freeBoardPageVo.setKeyword(keyword);

        // 전체 게시물 수
        int count = reviewBoardService.boardCount(freeBoardPageVo);

        // 현재 페이지 설정
        freeBoardPageVo.setPage(page);

        //한 페이지에서 보여줄 게시글 수(10개)
        int pageSize = freeBoardPageVo.getPageSize();

        // 시작, 마지막 페이지 수 가져오기
        freeBoardPageVo.setStartEnd();
        // 현재페이지에서 보여줄 글 목록
        List<ReviewBoardVO> reviewList = reviewBoardService.reviewBoardList(freeBoardPageVo);
        log.info("reviewList {}", reviewList);

        // totalPage = (전체 게시물 수 + 한 페이지에서 보여줄 게시글 수 - 1)  / 한 페이지에서 보여줄 게시글 수
        // 정수 나눗셈 결과: 정수 반환, 소수부분 버림
        //   --> count / pageSize 결과값이 나머지가 있을 경우를 대비해  pageSize  - 1 해줌
        int totalPage = (count + pageSize - 1) / pageSize;

        // 게시글 제목 옆에 댓글 개수 표시
        Map<Integer, Integer> commentCountMap = new HashMap<>();
        // 게시글 제목 옆에 첨부파일 여부 확인
        List<Integer> attachList = new ArrayList<>();
        for (ReviewBoardVO review : reviewList) {
            // 댓글 개수
            int countComment = reviewBoardService.getCommentCountByReviewId(review.getReview_id());
            commentCountMap.put(review.getReview_id(), countComment);
            // 첨부파일 여부
            if (!reviewBoardService.reviewBoardAttachCheck(review.getReview_id()).isEmpty()) {
                attachList.add(review.getReview_id());
            }
            log.info("attachList {}", attachList );
        }


        model.addAttribute("reviewList", reviewList); // 페이지에서 보여줄 글 목록
        model.addAttribute("totalPage", totalPage); // 전체 페이지 수
        model.addAttribute("page", page); // 현재 페이지 번호
        model.addAttribute("count", count); // 전체 게시물 수
        model.addAttribute("searchType", searchType); // 검색 타입
        model.addAttribute("keyword", keyword); // 검색어
        model.addAttribute("countComment", commentCountMap); // 댓글 개수
        model.addAttribute("attachList", attachList); // 첨부파일 여부

        return "/reviewboard/review_list";
    }

    // 후기게시판 글 상세보기
    @RequestMapping("/review_one")
    public String one(ReviewBoardVO reviewBoardVO, FreeBoardPageVO freeBoardPageVo, Model model,
                      @RequestParam(value = "page", defaultValue = "1") int page,
                      @RequestParam(value = "searchType", defaultValue = "") String searchType,
                      @RequestParam(value = "keyword", defaultValue = "") String keyword, Principal principal, Authentication authentication
    ) throws Exception {

        // 새로고침시로그인 풀리는 경우 로그인페이지로 이동
        if (principal == null) {
            return "redirect:/loginpage/customLogin";
        }

        // 현재 페이지 설정
        freeBoardPageVo.setPage(page);

        // 현재 로그인한 member_id
        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        int userId = customUser.getMember().getMember_id();
        reviewBoardVO.setMember_id(userId);

        // 게시글 정보
        ReviewBoardVO result = reviewBoardService.reviewboardOne(reviewBoardVO.getReview_id());

        // 현재 로그인한 사용자가 게시글 작성자가 아닌 경우에만 조회수 증가
        if (userId != result.getMember_id()) {
            reviewBoardService.viewsCount(reviewBoardVO);
        }

        // s3 파일 정보 가져오기
        List<String> s3FileUrlList = reviewBoardService.getS3FileList(reviewBoardVO.getReview_id());
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
        ReviewBoardVO previousPost = reviewBoardService.reviewBoardGetPreviousPost(reviewBoardVO.getReview_id());
        ReviewBoardVO nextPost = reviewBoardService.reviewBoardGetNextPost(reviewBoardVO.getReview_id());

        // 게시글 내용 엔터 처리
        String contentEnter = result.getReview_content().replace("\r\n", "<br>");
        result.setReview_content(contentEnter);

        // 해당 게시글의 댓글 목록 가져오기
        Map<Integer, List<ReviewBoardCommentVO>> groupedComments = reviewBoardService.findList(reviewBoardVO.getReview_id());

        // 해당 게시글의 댓글 개수 가져오기
        int commentCount = reviewBoardService.getCommentCountByReviewId(reviewBoardVO.getReview_id());

        model.addAttribute("result", result);
        model.addAttribute("previousPost", previousPost);
        model.addAttribute("nextPost", nextPost);
        model.addAttribute("page", page); // 모델에 페이지 번호 추가
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchType", searchType);
        model.addAttribute("groupedComments", groupedComments); // 댓글 리스트
        model.addAttribute("s3FileUrlList", s3FileUrlList); // 파일첨부 url
        model.addAttribute("s3FileNames", s3FileNames); // 파일 이름
        model.addAttribute("s3FileTypes", s3FileTypes); // 파일 타입
        model.addAttribute("commentCount", commentCount); // 댓글 개수

        return "/reviewboard/review_one";
    }

    // 후기게시판 수정페이지로 이동
    @GetMapping("/review_update")
    public String reviewboardUpdate(@RequestParam("review_id") int review_id, Model model, ReviewBoardAttachVO reviewboardAttachVO) {
        // 게시글 정보 조회
        ReviewBoardVO reviewBoardVO = reviewBoardService.reviewboardOne(review_id);

        // 첨부파일 정보 조회
        List<ReviewBoardAttachVO> FileList = reviewBoardService.reviewboardFileList(review_id);

        // 파일이름을 _ 이후의 문자열로 변경
        List<String> modifiedNames = new ArrayList<>();
        for (ReviewBoardAttachVO file : FileList) {
            String fileName = file.getReview_file_name();
            int index = fileName.indexOf("_");
            if (index > -1) {
                modifiedNames.add(fileName.substring(index + 1));
            } else {
                modifiedNames.add(fileName);
            }
        }
        model.addAttribute("reviewBoardVO", reviewBoardVO);
        model.addAttribute("FileList", FileList);
        model.addAttribute("modifiedNames", modifiedNames);

        return "reviewboard/review_update";
    }

    // 후기게시판 게시글 수정
    @PostMapping("/review_update")
    @ResponseBody
    public ResponseEntity<Integer>  reviewboardUpdate(@RequestParam("review_id") int review_id,
                                                    @RequestParam("review_title") String review_title,
                                                    @RequestParam("review_content") String review_content,
                                                    @RequestParam(value = "file", required = false) MultipartFile[] files, ReviewBoardAttachVO reviewboardAttachVO) {

        // 게시글 정보 조회
        ReviewBoardVO reviewBoardVO = reviewBoardService.reviewboardOne(review_id);

        // 게시글 정보 갱신
        reviewBoardVO.setReview_title(review_title);
        reviewBoardVO.setReview_content(review_content);
        reviewBoardService.reviewboardUpdate(reviewBoardVO);

        // 새 첨부파일이 있을 경우에만 기존 첨부파일 삭제 및 파일 관련 처리 수행
        if (files != null && files.length > 0 && !files[0].isEmpty()) {
            // 기존 첨부파일 삭제
            List<ReviewBoardAttachVO> s3FileList = reviewBoardService.reviewboardFileList(review_id);
            if (!s3FileList.isEmpty()) {
                for (ReviewBoardAttachVO s3FileUrl : s3FileList) {
                    // S3에서 파일 삭제
                    reviewBoardService.reviewboardDeleteS3(s3FileUrl.getReview_file_name());
                }
                // DB에서 파일 정보 삭제
                reviewBoardService.reviewboardFileDelete(review_id);
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
                    String s3FileName = reviewBoardService.reviewBoardInsertS3(file, review_id, reviewboardAttachVO);
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
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(reviewBoardVO.getReview_id());

    }


    // 후기게시판 댓글 입력
    @PostMapping("/comment_insert")
    public @ResponseBody Map<Integer, List<ReviewBoardCommentVO>> commentInsert(@RequestBody ReviewBoardCommentVO reviewboardCommentVO) {
        // 댓글 등록
        reviewBoardService.commentInsert(reviewboardCommentVO);

        // 해당 게시글의 댓글 목록 가져오기
        Map<Integer, List<ReviewBoardCommentVO>> groupedComments = reviewBoardService.findList(reviewboardCommentVO.getReview_id());

        // Jackson 라이브러리가 자동으로 Map의 Integer 키를 JSON 객체의 문자열 키로 변환
        return groupedComments;
    }

    // 후기게시판 댓글수정
    @PutMapping("/comment_update")
    public ResponseEntity<String> commentUpdate(@RequestBody ReviewBoardCommentVO reviewboardCommentVO) {
        reviewBoardService.commentUpdate(reviewboardCommentVO);
        return new ResponseEntity<>("댓글 수정 성공", HttpStatus.OK);

    }

    // 후기게시판 댓글삭제
    @PostMapping("/comment_delete")
    @ResponseBody
    public ResponseEntity<String> commentDelete(@RequestParam("review_id") int review_id, @RequestParam("cm_group") int cm_group) {
        try {
            reviewBoardService.commentDelete(review_id, cm_group);
            return new ResponseEntity<>("댓글 삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("댓글 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 후기게시판 대댓글삭제
    @PostMapping("/comment_child_delete")
    @ResponseBody
    public ResponseEntity<String> commentDelete(@RequestParam("review_cm_id") int review_cm_id) {
        try {
            reviewBoardService.commentChildDelete(review_cm_id);
            return new ResponseEntity<>("대댓글 삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("대댓글 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 후기게시판 대댓글 입력
    @PostMapping("/comment_reply")
    public ResponseEntity<String> commentReply(@RequestBody ReviewBoardCommentVO reviewBoardCommentVO) {
        try {
            reviewBoardService.commentReply(reviewBoardCommentVO);
            return new ResponseEntity<>("대댓글 입력 성공", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("대댓글 입력 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }


    //후기게시판 게시글 삭제 + s3 파일 삭제
    @Transactional
    @PostMapping("/review_delete")
    @ResponseBody
    public Map<String, Object> reviewBoardDelete(int review_id) {

        Map<String, Object> result = new HashMap<>();

        // 댓글 목록 가져오기
        Map<Integer, List<ReviewBoardCommentVO>> commentListMap = reviewBoardService.findList(review_id);
        // 댓글 삭제 (댓글 목록이 있는 경우)
        for (Integer key : commentListMap.keySet()) {
            List<ReviewBoardCommentVO> commentList = commentListMap.get(key);
            for (ReviewBoardCommentVO comment : commentList) {
                reviewBoardService.commentDelete(comment.getReview_id(), comment.getCm_group()); // 댓글 삭제
            }
        }

        try {
            // db에 저장된 파일 리스트 가져오기
            List<ReviewBoardAttachVO> s3FileList = reviewBoardService.reviewboardFileList(review_id);

            log.info("s3FileList {}", s3FileList);
            // 파일이 있는 경우 s3파일 + DB삭제
            if (!s3FileList.isEmpty()) {
                for (ReviewBoardAttachVO s3FileUrl : s3FileList) {
                    // s3삭제
                    reviewBoardService.reviewboardDeleteS3(s3FileUrl.getReview_file_name());
                    log.info("s3FileUrl {}", s3FileUrl);
                }
                // db삭제
                reviewBoardService.reviewboardFileDelete(review_id);
            }

            // 게시글 삭제
            reviewBoardService.reviewboardDelete(review_id);

            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
        }
        return result;
    }

    // 후기게시판 상세 페이지에서 첨부파일 다운로드
    @PostMapping("/generatePresignedUrl")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> generatePresignedUrl(@RequestBody Map<String, String> payload) {
        String fileName = payload.get("fileName");

        // review_id를 사용하여 DB에서 파일 정보 가져오기
        List<ReviewBoardAttachVO> fileNames = reviewBoardService.findByFileName(fileName);
        log.info("fileNames {}", fileNames);

        // 파일 정보가 없는 경우 처리
        if (fileNames.isEmpty()) {
            // 오류 처리 등을 수행하거나 다른 처리를 합니다.
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

        // 파일 정보가 있는 경우 presigned URL 생성
        List<String> presignedUrls = new ArrayList<>();
        for (ReviewBoardAttachVO attachVO  : fileNames) {
            // 파일이 있는 폴더 경로를 포함하여 CopySource 값 생성
            String copySource = "reviewboard/" + attachVO.getReview_file_name();

            Date expiration = new Date();
            long expTimeMillis = expiration.getTime();
            expTimeMillis += 1000 * 60 * 20; // 20분 후 만료
            expiration.setTime(expTimeMillis);

            // presigned URL 생성
            GeneratePresignedUrlRequest generatePresignedUrlRequest =
                    new GeneratePresignedUrlRequest(bucketName, copySource)
                            .withMethod(HttpMethod.GET)
                            .withExpiration(expiration);

            URL url = s3Client.generatePresignedUrl(generatePresignedUrlRequest);
            presignedUrls.add(url.toString());
        }

        // JSON 형식으로 응답 생성
        Map<String, Object> response = new HashMap<>();
        response.put("urls", presignedUrls);

        return ResponseEntity.ok().body(response);
    }


}
