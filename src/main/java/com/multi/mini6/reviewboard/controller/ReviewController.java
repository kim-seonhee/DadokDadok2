package com.multi.mini6.reviewboard.controller;


import com.multi.mini6.loginpage.vo.CustomUser;
import net.coobird.thumbnailator.Thumbnailator;
import com.multi.mini6.reviewboard.vo.PageVo;
import com.multi.mini6.reviewboard.vo.ReviewAttachVO;
import com.multi.mini6.reviewboard.vo.ReviewCommentVO;
import com.multi.mini6.reviewboard.vo.ReviewVO;
import com.multi.mini6.reviewboard.service.ReviewCommentService;
import com.multi.mini6.reviewboard.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/reviewboard")
@Slf4j
public class ReviewController {
    @Autowired
    ReviewService reviewService;

    @Autowired
    ReviewCommentService reviewCommentService;

    @Autowired
    ServletContext servletContext;


    //도서 후기 isbn기반 가져옴
    //restAPI 방식으로 가져옴
    @GetMapping("/review_list/{isbn}")
    @ResponseBody
    public ResponseEntity<List<ReviewVO>> reviewList(@PathVariable("isbn") String isbn) {
        List<ReviewVO> list = reviewService.getReviewsByIsbn(isbn);
        return ResponseEntity.ok(list);
    }


    @PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
    @RequestMapping("/review_insert_move")
    public String insert_move() {
        return "reviewboard/review_insert";
    }


    @PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
    @RequestMapping("/review_insert")
    public String reviwe_insert(ReviewVO reviewVO, @RequestParam("file") MultipartFile file, Model model, Authentication authentication) {

        //유저 member_id 값 authentication으로 가져오기
        //로그인한 유저의 정보를 가져온다.
        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        int userId = customUser.getMember().getMember_id();
        reviewVO.setMember_id(userId);

        reviewService.insert(reviewVO);

        return "redirect:/reviewboard/review_list3?page=1";
    }

    private String getFileType(File file, ReviewAttachVO reviewAttachVO) {

        String fileName = file.getName();
        String fileType = "";

        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileType = fileName.substring(dotIndex + 1).toLowerCase();
        }


        reviewAttachVO.setReview_file_type(fileType);

        return fileType;


    }

    @PostMapping(value = "/uploadAjaxFormAction", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<ReviewAttachVO>> uploadFormPost(@RequestParam("file") MultipartFile[] files, HttpServletRequest request) {

        List<ReviewAttachVO> list = new ArrayList<>();

        String uploadFolder = request.getSession().getServletContext().getRealPath("/resources/reviewBoardUpload");
        // 절대 경로를 직접 지정합니다.
//        String uploadFolder = "/Users/Kang/DadokDadok/src/main/webapp/resources/reviewBoardUpload";


        log.info("uploadFolder: " + uploadFolder);

        File uploadPath = new File(uploadFolder);

        if (!uploadPath.exists()) {
            uploadPath.mkdirs(); // 디렉토리가 없으면 생성
        }

        for (MultipartFile multipartFile : files) {

            ReviewAttachVO attachVO = new ReviewAttachVO();
            String uploadFileName = multipartFile.getOriginalFilename();

            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
            attachVO.setReview_file_name(uploadFileName);

            // UUID 이용해 고유한 이름 적용
            UUID uuid = UUID.randomUUID();
            uploadFileName = uuid.toString() + "_" + uploadFileName;


            try {
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                attachVO.setReview_uuid(uuid.toString());

                // 파일 타입
                String fileType = getFileType(saveFile, attachVO);
                // 섬네일 생성
                if (fileType.equals("png") || fileType.equals("jpg") || fileType.equals("jpeg") || fileType.equals("gif")) { // 이미지 파일인지 확인
                    File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
                    try (FileOutputStream thumbnail = new FileOutputStream(thumbnailFile);
                         FileInputStream fis = new FileInputStream(saveFile)) {  // FileInputStream 추가
                        Thumbnailator.createThumbnail(fis, thumbnail, 100, 100);
                        // 이미지 파일을 사용한 후에 해당 파일 스트림을 닫기
                        // Files.deleteIfExists(saveFile.toPath());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }
                list.add(attachVO);
            } catch (Exception e) {
                e.printStackTrace();
            } // try
        } // for

        // JSON형태로 변환된 list를 반환
        return new ResponseEntity<>(list, HttpStatus.OK);
    }


    @RequestMapping("/review_update_move")
    public String reviewUpdateMove(@RequestParam("review_id") int review_id, Model model) {
        ReviewVO reviewVO = reviewService.reviewBoardOne(review_id);
        model.addAttribute("reviewUpdate", reviewVO);
        return "reviewboard/review_update";
    }

    @RequestMapping(value = "/review_update", consumes = "multipart/form-data")
    public String update(@ModelAttribute ReviewVO reviewVO) {
        // 게시글 업데이트 로직 실행
        reviewService.review_update(reviewVO);

        // 첨부 파일 업데이트 로직 실행
        reviewService.Fileupdate(reviewVO.getReview_id(), reviewVO.getAttachList());
        log.info("reviewVO.getBoard_id() _{} ", reviewVO.getReview_id());
        log.info("reviewVO.getAttachList() _{} ", reviewVO.getAttachList());
        System.out.println(reviewVO.getAttachList());
        // log.info("update freeBoardVO : " + freeBoardVO);
        return "redirect:/reviewboard/review_list3";

    }

    @RequestMapping("/review_list3")
    public void review_list(PageVo pageVO, Model model) {
        System.out.println("review_list3===========================================");
        if (pageVO.getPage() == 0) {
            pageVO.setPage(1);
        }

        pageVO.setStartEnd(); //start, end계산해주는 메서드
        System.out.println("===> " + pageVO);
        //  List<ReviewVO> list = reviewService.review_list3(pageVO);


        //System.out.println("pageVO page : " + pageVO.getPage());
        //전체 페이지수 구하기
        // System.out.println(list);
        int count = reviewService.searchCount(pageVO); //전체게시물 수
        System.out.println("전체 게시물수>> " + count);
        int pages = (count / 10) + (count % 10 != 0 ? 1 : 0);

        List<ReviewVO> list1 = reviewService.selectReviewAttach(pageVO);

        for (ReviewVO vo : list1) {
//            // 이미지 파일명에서 확장자를 제외한 부분을 UUID로 사용
//            String uuid = vo.getReview_attach().getReview_file_name().substring(0, vo.getReview_attach().getReview_file_name().lastIndexOf("."));
//            vo.getReview_attach().setReview_uuid(uuid);
            System.out.println(vo.getReview_id());
            System.out.println(vo.getReview_attach());
        }

        System.out.println("selectReviewAttach : " + list1.size());

        //모델로 views까지 페이지수를 넘겨야 페이지수 버튼을 만들 수 있음.
        System.out.println("페이지당 가지고 온 게시물수>> " + list1.size());

        //views의 list3.jsp로 전달
        model.addAttribute("list", list1);
        model.addAttribute("pages", pages);
        model.addAttribute("count", count);
        model.addAttribute("keyword", pageVO.getKeyword());
    }


    @RequestMapping("/review_delete")
    public String review_delete1(int review_id, Model model) {
        // BbsDAO dao = new BbsDAO();
        int result = reviewService.delete(review_id);

        model.addAttribute("result", result);

        return "redirect:/reviewboard/review_list3?page=1";
    }

    @PostMapping("/deleteFile")
    @ResponseBody
    public ResponseEntity<String> deleteFile(@RequestParam String fileName, @RequestParam String type, HttpServletRequest request) {
        String uploadFolder = request.getSession().getServletContext().getRealPath("/resources/reviewBoardUpload");

        String folder = servletContext.getRealPath("/resources/reviewBoardUpload");
        File file;
        try {
            fileName = fileName.replace("/resources/reviewBoardUpload/", "");
            file = new File(folder, URLDecoder.decode(fileName, "UTF-8"));

            file.delete();
            System.out.println("fileName" + fileName);
            System.out.println("folder" + folder);
            System.out.println("URLDecoder" + URLDecoder.decode(fileName, "UTF-8"));

            // 이미지 파일인 경우 원본도 삭제
            if (type.equals("image")) {
                String largeFileName = file.getAbsolutePath().replace("s_", "");

                file = new File(largeFileName);

                file.delete();

                // 삭제 실패시 파일 이름 출력
                if (!file.delete()) {
                    log.info("Failed to delete " + file);
                }

            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<String>("deleted", HttpStatus.OK);

    }

    //게시글 상세보기 - 첨부파일조회
    @GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<ReviewAttachVO>> getAttachList(@RequestParam("review_id") int review_id) {
        List<ReviewAttachVO> attachList = reviewService.getAttachList(review_id);

        return new ResponseEntity<>(attachList, HttpStatus.OK);

    }

    // 게시글 상세보기 - 파일다운로드
    @GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public ResponseEntity<Resource> downloadFile(String fileName, HttpServletRequest request) {
        // log.info("fileName file: " + fileName);

        String uploadFolder = request.getSession().getServletContext().getRealPath("/resources/reviewBoardUpload/");

        FileSystemResource resource = new FileSystemResource(uploadFolder + fileName);

        //log.info("resource: " + resource);

        String resourceName = resource.getFilename();

        HttpHeaders headers = new HttpHeaders();
        try {
            headers.add("Content-Disposition", "attacgment; filename=" + new String(resourceName.getBytes("UTF-8"), "ISO-8859-1"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }


        return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
    }

    @PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
    @RequestMapping("/review_one")
    public void review_one(ReviewVO reviewVO, Model model, Authentication authentication) throws Exception {

        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        int userId = customUser.getMember().getMember_id();

        ReviewCommentVO reviewCommentVO = new ReviewCommentVO();
        reviewCommentVO.setMember_id(userId);

        // BbsDAO dao = new BbsDAO();
        System.out.println(reviewVO);
        System.out.println("review_one==============================================================================================");
        ReviewVO reviewVO2 = reviewService.review_one(reviewVO);
        List<ReviewCommentVO> list = reviewCommentService.reviewCommentlist(reviewVO.getReview_id());
        System.out.println("review_one : " + list.size());

        reviewService.increaseViews(reviewVO.getReview_id());

        model.addAttribute("reviewVO", reviewVO2);
        model.addAttribute("list", list);
        model.addAttribute("reviewCommentVO", reviewCommentVO);

    }


    @PostMapping("/fileDelete")
    @ResponseBody
    public ResponseEntity<String> fileDelete(HttpServletRequest request, @RequestBody ArrayList<ReviewAttachVO> fileList) {
        //log.info("file Delete fileList: " + fileList);
        //log.info("file Delete fileListsize: " + fileList.size());
        // 삭제 순서: 파일DB삭제  ->  실제 파일 삭제  -> 게시글 삭제

        String uploadFolder = request.getSession().getServletContext().getRealPath("/resources/reviewBoardUpload/");
        //log.info("file Delete uploadFolder: " + uploadFolder);

        try {
            // 첨부파일 개수 만큼 실행
            for (ReviewAttachVO attach : fileList) {
                System.out.println("review_id: " + attach.getReview_id());
                // 파일DB삭제
                reviewService.fileDelete(attach.getReview_id());
                log.info("review_id {}", attach.getReview_id());


                String filePath = uploadFolder + attach.getReview_uuid() + "_" + URLDecoder.decode(attach.getReview_file_name(), "UTF-8");
                File file = new File(filePath);

                // 파일삭제
                file.delete();
                //log.info("file: " + file);

                String fileType = attach.getReview_file_type();
                // log.info("fileType: " + fileType);

                // 이미지 파일인 경우 썸네일도 같이 삭제
                if (fileType.equals("png") || fileType.equals("jpg") || fileType.equals("jpge") || fileType.equals("gif")) {
                    String imgFilePath = uploadFolder + "s_" + attach.getReview_uuid() + "_" + URLDecoder.decode(attach.getReview_file_name(), "UTF-8");
                    file = new File(imgFilePath);
                    log.info("imgFilePath: " + imgFilePath);

                    file.delete();
                }


                //게시글 삭제
                reviewService.fileDelete(attach.getReview_id());
            }

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            // 인코딩 문제가 발생한 경우 적절한 HTTP 상태 코드와 함께 에러 응답을 //            return ResponseEntity.badRequest().body("Failed to decode file names");
        }

        // 모든 파일 처리 후 성공 응답 반환
        return new ResponseEntity<String>("deleted", HttpStatus.OK);
    }


    @RequestMapping("/review_search1")
    public void review_search1(PageVo pageVO, Model model, @RequestParam(value = "keyword", required = false) String keyword) {
        System.out.println("review_search1===================================================");
        int count = 0;
        List<ReviewVO> list1 = reviewService.selectReviewAttach(pageVO);
        String result = "";
        System.out.println("page : " + pageVO.getPage());
        System.out.println("keyword" + keyword);
        pageVO.setStartEnd();
        List<ReviewVO> list;

        System.out.println("parama keyword : " + keyword);
        if (keyword != null && !keyword.isEmpty()) {
            System.out.println("get keyword : " + pageVO.getKeyword());
            list = reviewService.selectReviewAttach(pageVO);
            count = reviewService.searchCount(pageVO);
            System.out.println("review_count" + count);

        } else {

            list = reviewService.selectReviewAttach(pageVO);
            count = reviewService.review_count();
            System.out.println("pagePagePage" + count);
        }

        for (ReviewVO vo : list) {
            //            // 이미지 파일명에서 확장자를 제외한 부분을 UUID로 사용
            //            String uuid = vo.getReview_attach().getReview_file_name().substring(0, vo.getReview_attach().getReview_file_name().lastIndexOf("."));
            //            vo.getReview_attach().setReview_uuid(uuid);
            System.out.println(vo.getReview_id());
            System.out.println(vo.getReview_attach());
        }


        // 전체 게시물 수 및 페이지 계산
        // 전체 게시물 수
        int pages = count / 10;
        if (count % 10 != 0) {
            pages = count / 10 + 1;
        }
        System.out.println("count" + count);
        System.out.println("pages" + pages);
        System.out.println("list" + list);

        // 모델에 데이터 전달
        model.addAttribute("list", list);
        model.addAttribute("pages", pages);
        model.addAttribute("count", count);
        model.addAttribute("keyword", keyword);


        System.out.println("list size" + list.size());

    }

}
