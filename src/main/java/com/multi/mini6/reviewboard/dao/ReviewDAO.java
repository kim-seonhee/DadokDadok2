package com.multi.mini6.reviewboard.dao;

import com.multi.mini6.reviewboard.vo.PageVo;
import com.multi.mini6.reviewboard.vo.ReviewAttachVO;
import com.multi.mini6.reviewboard.vo.ReviewVO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class ReviewDAO {

    @Autowired
    SqlSessionTemplate my;

    public int reviewInsert(ReviewVO reviewVO){
        return my.insert("reviewInsert", reviewVO);
    };
    public int reviewUpdate(ReviewVO reviewVO) {
        return my.update("reviewUpdate", reviewVO);
    }

    public int reviewDelete(int review_id) {
        return my.delete("reviewDelete", review_id);
    }
    public List<ReviewVO> reviewList(PageVo pageVO) {
        return my.selectList("reviewList", pageVO);
    }
    public ReviewVO getReviewOne(ReviewVO reviewVO) throws Exception {
        // 3.SQL문 결정/생성
        ReviewVO dto = my.selectOne("getReviewOne", reviewVO);

        return dto;
    }

    public List<ReviewVO> list1(PageVo pageVO) {
        return my.selectList("list2", pageVO); //==>bbs.html에 있는 bbs를 호출
    }
    public int reviewCount() {
        return my.selectOne("reviewCount");
    }
    public List<ReviewVO> reviewSearch(PageVo pageVo) {
        return my.selectList("reviewSearch", pageVo);
    }

    public int searchCount(PageVo pageVo) {
        return my.selectOne("searchCount", pageVo);
    }

    public int increaseViews(int reviewId) {
        return my.update("increaseViews", reviewId);
    }
    // 게시글 등록 - 파일업로드
    public int fileInsert(ReviewAttachVO reviewAttachVO) {
        return my.insert("attachInsert", reviewAttachVO);
    }
    // 게시글 상세보기 - 첨부파일조회
    public List<ReviewAttachVO> reviewFileID(int review_id){
        return my.selectList("reviewFileID", review_id);
    }
    // 게시글 삭제시 첨부파일 삭제
    public  void fileDelete(int review_id){
        my.delete("reviewFileDelete", review_id);
    }
    // 게시글 수정시 첨부파일 삭제
    public  void reviewFileChange(String review_uuid){
        my.delete("reviewFileChange", review_uuid);
    }
    public List<ReviewAttachVO> reviewAttachList(ReviewAttachVO reviewAttachVO) {
        return my.selectList("selectReviewAttach", reviewAttachVO);
    }
    public ReviewVO reviewBoardOne(int review_id) {
        return my.selectOne("reviewBoardOne", review_id);
    }

    public List<ReviewVO> selectReviewAttach(PageVo pageVO){

        return my.selectList("selectReviewAttach", pageVO);
    }

    //후기 정보 isbn으로 가져옴
    public List<ReviewVO> getReviewsByIsbn(String isbn) {
        return my.selectList("reviewListByIsbn", isbn);
    }

}
