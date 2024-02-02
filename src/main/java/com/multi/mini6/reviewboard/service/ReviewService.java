package com.multi.mini6.reviewboard.service;


import com.multi.mini6.freeboard.vo.FreeBoardAttachVO;
import com.multi.mini6.reviewboard.dao.ReviewDAO;
import com.multi.mini6.reviewboard.vo.PageVo;
import com.multi.mini6.reviewboard.vo.ReviewAttachVO;
import com.multi.mini6.reviewboard.vo.ReviewVO;
import com.multi.mini6.reviewboard.dao.ReviewDAO;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReviewService {

    @Autowired
    ReviewDAO reviewDAO;

    //도서 후기 isbn 으로 가져옴
    public List<ReviewVO> getReviewsByIsbn(String isbn) {
        return reviewDAO.getReviewsByIsbn(isbn);
    }
    @Transactional
    public int insert(ReviewVO reviewVO){
        System.out.println("1111" + reviewVO);
        int result = reviewDAO.reviewInsert(reviewVO);
        System.out.println("insert s");
        System.out.println(reviewVO.getReview_id());
        System.out.println(reviewVO.getAttachList());
        System.out.println("insert e");
        if(reviewVO.getAttachList() == null || reviewVO.getAttachList().size() <= 0){
            return result;
        }


        reviewVO.getAttachList().forEach(attach -> {
            attach.setReview_id(reviewVO.getReview_id()); // 첨부파일에 게시글 ID 설정
            reviewDAO.fileInsert(attach);
        });

        return result;
    }

    public void review_insert(ReviewVO reviewVO){


        reviewDAO.reviewInsert(reviewVO);
    }

    public int review_update(ReviewVO reviewVO){
        return  reviewDAO.reviewUpdate(reviewVO);

    }

    public List<ReviewVO> review_list3(PageVo pageVO){

        return reviewDAO.reviewList(pageVO);
    }
    public int delete(int review_id){

        return reviewDAO.reviewDelete(review_id);
    }
    public void reviewFileChange(String review_uuid){
        reviewDAO.reviewFileChange(review_uuid);
    }

    public ReviewVO review_one(ReviewVO reviewVO) throws Exception {

        return reviewDAO.getReviewOne(reviewVO);
    }
    public int review_count() {
        return reviewDAO.reviewCount();
    }

    public List<ReviewVO> review_search(PageVo pageVo) {
        return reviewDAO.reviewSearch(pageVo);
    }

    public int searchCount(PageVo pageVo) {
        return reviewDAO.searchCount(pageVo);
    }
    @Transactional
    public int increaseViews(int reviewId) {
        return reviewDAO.increaseViews(reviewId);
    }

    public void file_insert(ReviewAttachVO reviewAttachVO) {
        reviewDAO.fileInsert(reviewAttachVO);
    }
    // 게시글 상세보기 - 첨부파일조회
    public List<ReviewAttachVO> getAttachList(int review_id){
        return reviewDAO.reviewFileID(review_id);
    }
    // 게시글 삭제시 첨부파일 삭제
    public void fileDelete(int review_id){
        reviewDAO.fileDelete(review_id);
    }
    // 게시글 첨부파일 수정
    public void Fileupdate(int reviewId, List<ReviewAttachVO> fileList) {
        System.out.println("Fileupdate reviewId: " + reviewId + ", fileList: " + fileList);

        // 데이터베이스에서 현재 reviewId에 해당하는 첨부 파일 목록을 조회
        List<ReviewAttachVO> fileInfo = reviewDAO.reviewFileID(reviewId);
        System.out.println("fileInfo from DB: " + fileInfo);

        if (fileList != null) {
            // fileList의 UUID 목록을 생성
            List<String> fileUuid = fileList.stream().map(ReviewAttachVO::getReview_uuid).collect(Collectors.toList());

            System.out.println("fileUuid from fileList: " + fileUuid);

            // 데이터베이스에 있는 파일 중 fileList에 없는 파일을 삭제
            for (ReviewAttachVO existingFile : fileInfo) {
                if (!fileUuid.contains(existingFile.getReview_uuid())) {
                    reviewDAO.reviewFileChange(existingFile.getReview_uuid());
                }
            }
        } else {
            // fileList가 null인 경우, 모든 파일을 삭제
            for (ReviewAttachVO existingFile : fileInfo) {
                reviewDAO.reviewFileChange(existingFile.getReview_uuid());
            }
        }

        // fileList에서 새로 추가된 파일을 데이터베이스에 추가
        if (fileList != null) {
            for (ReviewAttachVO file : fileList) {
                if (fileInfo.stream().noneMatch(f -> f.getReview_uuid().equals(file.getReview_uuid()))) {
                    reviewDAO.fileInsert(file);
                }
            }
        }
    }

    public List<ReviewAttachVO> getReviewAttachList(ReviewAttachVO reviewAttachVO) {
        return reviewDAO.reviewAttachList(reviewAttachVO);
    }
    public ReviewVO reviewBoardOne(int review_id) {
        return reviewDAO.reviewBoardOne(review_id);
    }
    public List<ReviewVO> selectReviewAttach(PageVo pageVO){
        return reviewDAO.selectReviewAttach(pageVO);
    }
}

