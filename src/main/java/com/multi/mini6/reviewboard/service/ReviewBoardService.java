package com.multi.mini6.reviewboard.service;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import com.amazonaws.services.s3.AmazonS3;
import com.multi.mini6.freeboard.vo.FreeBoardPageVO;

import java.io.IOException;
import java.util.*;

import com.multi.mini6.reviewboard.dao.ReviewBoardDAO;
import com.multi.mini6.reviewboard.vo.ReviewBoardAttachVO;
import com.multi.mini6.reviewboard.vo.ReviewBoardCommentVO;
import com.multi.mini6.reviewboard.vo.ReviewBoardVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@Slf4j
public class ReviewBoardService {

    @Autowired
    private ReviewBoardDAO reviewBoardDAO;

    private final AmazonS3 s3Client;

    @Autowired
    public ReviewBoardService(AmazonS3 amazonS3) {
        this.s3Client = amazonS3;
    }

    @Value("${bucketName}")
    private String bucketName;


    // 후기게시판 게시글 작성
    public int reviewBoardInsert(ReviewBoardVO reviewBoardVO){
        return reviewBoardDAO.reviewBoardInsert(reviewBoardVO);
    }

    // 후기게시판  글 목록
    public List<ReviewBoardVO> reviewBoardList(FreeBoardPageVO freeBoardPageVO) {
        return reviewBoardDAO.getReviewBoardList(freeBoardPageVO);
    }

    // 후기게시판 전체 게시물 수 구하기
    public int boardCount(FreeBoardPageVO freeBoardPageVO) {
        return  reviewBoardDAO.reviewBoardCount(freeBoardPageVO);
    }

    // 후기게시판 게시글 상세보기
    public ReviewBoardVO reviewboardOne(int review_id) {
        return reviewBoardDAO.reviewBoardOne(review_id);
    }

    // 후기게시판 게시글 클릭시 조회수 증가
    public void viewsCount(ReviewBoardVO reviewboardVO) {
        reviewBoardDAO.reviewBoardViewsCount(reviewboardVO);
    }

    // 후기게시판 상세페이지에서 이전글 가져오기
    public ReviewBoardVO reviewBoardGetPreviousPost(int review_id) {
        return reviewBoardDAO.reviewBoardGetPreviousPost(review_id);
    }

    // 후기게시판 상세페이지에서 다음글 가져오기
    public ReviewBoardVO reviewBoardGetNextPost(int review_id) {
        return reviewBoardDAO.reviewBoardGetNextPost(review_id);
    }

    // 후기게시판 게시글 삭제
    public void reviewboardDelete(int review_id) {
        reviewBoardDAO.reviewBoardDelete(review_id);
    }

    // 후기게시판 게시글 수정
    public void reviewboardUpdate(ReviewBoardVO reviewboardVO){
        reviewBoardDAO.reviewBoardUpdate(reviewboardVO);
    }


    // 후기게시판 댓글 저장
    public void commentInsert(ReviewBoardCommentVO reviewBoardCommentVO){
        reviewBoardDAO.reviewBoardCommentInsert(reviewBoardCommentVO);
    }

    // 후기게시판 댓글 리스트 가져오기
    public Map<Integer, List<ReviewBoardCommentVO>> findList(int review_id) {
        // 댓글 정보 가져오기
        List<ReviewBoardCommentVO> commentInfo = reviewBoardDAO.reviewBoardCommentList(review_id);

        Map<Integer, List<ReviewBoardCommentVO>> groupedComments = new HashMap<>();
        // 댓글 정보를 그룹별로 분류
        for (ReviewBoardCommentVO comment : commentInfo) {
            // 현재 댓글의 그룹 ID 가져오기
            int groupId = comment.getCm_group();

            // 해당 그룹 ID의 댓글 리스트를 조회
            List<ReviewBoardCommentVO> group = groupedComments.get(groupId);

            // 리스트가 없으면 새로 생성하고 맵에 추가
            if (group == null) {
                group = new ArrayList<>();
                groupedComments.put(groupId, group);
            }

            // 현재 댓글을 그룹 리스트에 추가
            group.add(comment);
        }
        return groupedComments;
    }

    // 후기게시판  댓글 수정
    public void commentUpdate(ReviewBoardCommentVO reviewboardCommentVO) {
        reviewBoardDAO.reviewBoardCommentUpdate(reviewboardCommentVO);
    }

    // 후기게시판 댓글삭제
    public void commentDelete(int review_id, int cm_group) {
        reviewBoardDAO.reviewBoardCommentDelete(review_id, cm_group);
    }

    // 후기게시판 대댓글삭제
    public void commentChildDelete(int review_cm_id) {
        reviewBoardDAO.reviewBoardCommentChildDelete(review_cm_id);
    }

    // 후기게시판 대댓글 입력
    public void commentReply(ReviewBoardCommentVO reviewboardCommentVO) {
        reviewBoardDAO.reviewBoardCommentReply(reviewboardCommentVO);
    }


    // 후기게시판 S3 버킷에 파일 업로드
    @Transactional // 하나라도 실패할 경우 롤백
    public String reviewBoardInsertS3(MultipartFile file, int review_id, ReviewBoardAttachVO reviewboardAttachVO) throws IOException {

        // 첨부파일이 있는 경우에만 파일정보 저장
        if (!file.isEmpty()) {

            // 각 파일마다 고유한 UUID 생성
            String originalFileName = file.getOriginalFilename();
            String uuidFileName = UUID.randomUUID().toString() + "_" + originalFileName;

            // 파일정보 저장 위한 review_id 설정
            reviewboardAttachVO.setReview_id(review_id);
            reviewboardAttachVO.setReview_file_name(uuidFileName);


            try {
                // s3에 업로드
                String filePath = "ReviewBoard/" + uuidFileName;
                ObjectMetadata metadata = new ObjectMetadata();
                metadata.setContentLength(file.getSize());
                metadata.setContentType(file.getContentType());
                // S3 버킷에 파일 업로드
                s3Client.putObject(new PutObjectRequest(bucketName, filePath, file.getInputStream(), metadata));

                // 파일정보 저장
                reviewBoardDAO.reviewBoardFileS3Insert(reviewboardAttachVO);

                // S3 버킷에 업로드 된 파일의 url return
                return s3Client.getUrl(bucketName, filePath).toString();
            } catch (AmazonServiceException e) {
                log.error("AmazonServiceException: {}", e.getMessage());
                throw e;
            } catch (SdkClientException e) {
                log.error("SdkClientException: {}", e.getMessage());
                throw e;
            }
        }
        return null;
    }

    // 후기게시판 s3에 업로드 되어 있는 파일정보 DB에서 가져오기
    public List<String> getS3FileList(int review_id) {
        // s3에 업로드 되어 있는 파일정보 DB에서 가져오기
        List<ReviewBoardAttachVO> s3FileInfo = reviewBoardDAO.findByS3FileInfo(review_id);

        List<String> s3Url = new ArrayList<>();

        for (ReviewBoardAttachVO s3FileInfoList : s3FileInfo) {
            String s3FileName = "ReviewBoard/" + s3FileInfoList.getReview_file_name();
            String url = s3Client.getUrl(bucketName, s3FileName).toString();
            s3Url.add(url);
        }

        return s3Url;  // URL 리스트 반환
    }

    // 후기게시판 첨부파일 정보 db에서 검색
    public List<ReviewBoardAttachVO> reviewboardFileList(int review_id) {
        List<ReviewBoardAttachVO> s3FileInfo = reviewBoardDAO.findByS3FileInfo(review_id);
        return s3FileInfo;
    }

    // 후기게시판 첨부파일 정보 db에서 삭제
    public void reviewboardFileDelete(int review_id) {
        reviewBoardDAO.deleteReviewBoardFileInfo(review_id);
    }

    // 후기게시판 첨부파일 s3에서 삭제
    public void reviewboardDeleteS3(String s3FileUrl) throws AmazonServiceException {
        String s3Filename = "ReviewBoard/" + s3FileUrl;
        s3Client.deleteObject(new DeleteObjectRequest(bucketName, s3Filename));
    }

    // 후기게시판 게시글의 댓글 개수 구하기
    public int getCommentCountByReviewId(int review_id) {
        return reviewBoardDAO.getCommentCountByReviewId(review_id);
    }

    // 후기게시판 목록에서 제목 옆에 첨부 파일 여부 확인
    public List<Object> reviewBoardAttachCheck(int review_id) {
        return reviewBoardDAO.reviewAttachCheck(review_id);
    }

    // 후기게시판 첨부파일 정보 파일 이름으로 찾기
    public List<ReviewBoardAttachVO> findByFileName(String fileName) {
        return reviewBoardDAO.findByFileName(fileName);
    }



}
