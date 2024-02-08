package com.multi.mini6.reviewboard.dao;

import com.multi.mini6.freeboard.vo.FreeBoardPageVO;
import com.multi.mini6.reviewboard.vo.ReviewBoardAttachVO;
import com.multi.mini6.reviewboard.vo.ReviewBoardCommentVO;
import com.multi.mini6.reviewboard.vo.ReviewBoardVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import lombok.extern.slf4j.Slf4j;
@Repository
@Slf4j
public class ReviewBoardDAO {

    @Autowired
    SqlSessionTemplate sqlSession;

    // 후기게시판 게시글 작성
    public int reviewBoardInsert(ReviewBoardVO reviewBoardVO){
        return sqlSession.insert("reviewBoardInsert", reviewBoardVO);
    }

    // 후기게시판 게시글 목록 조회
    public List<ReviewBoardVO> getReviewBoardList(FreeBoardPageVO freeBoardPageVO){
        return sqlSession.selectList("reviewBoardList", freeBoardPageVO);
    }

    // 후기게시판 게시글 총 개수 구하기
    public int reviewBoardCount(FreeBoardPageVO freeBoardPageVO){
        return sqlSession.selectOne("reviewBoardCount", freeBoardPageVO);
    }

    //후기게시판  게시글 상세 보기
    public ReviewBoardVO reviewBoardOne(int review_id) {
        return sqlSession.selectOne("reviewBoardOne", review_id);
    }

    // 후기게시판 게시글 클릭시 조회수 증가
    public void reviewBoardViewsCount(ReviewBoardVO reviewBoardVO) {
        sqlSession.update("reviewBoardViewsCount", reviewBoardVO);
    }

    // 후기게시판 상세보기페이지에서 이전글 찾기
    public ReviewBoardVO reviewBoardGetPreviousPost(int review_id) {
        return sqlSession.selectOne("reviewBoardGetPreviousPost", review_id);
    }

    // 후기게시판 상세보기페이지에서 다음글 찾기
    public ReviewBoardVO reviewBoardGetNextPost(int review_id) {
        return sqlSession.selectOne("reviewBoardGetNextPost", review_id);
    }

    // 후기게시판  게시글 수정
    public void reviewBoardUpdate(ReviewBoardVO reviewBoardVO) {
        sqlSession.update("reviewBoardUpdate", reviewBoardVO);
    }

    // 후기게시판 게시글만 삭제
    public void reviewBoardDelete(int review_id) {
        sqlSession.delete("reviewBoardDelete", review_id);
    }

    // 후기게시판 댓글 저장
    public void reviewBoardCommentInsert(ReviewBoardCommentVO reviewBoardCommentVO) {
        sqlSession.insert("reviewBoardCommentInsert", reviewBoardCommentVO);
    }

    // 후기게시판 댓글리스트 가져오기
    public List<ReviewBoardCommentVO>reviewBoardCommentList (int review_id) {
        return sqlSession.selectList("reviewBoardCommentList", review_id);
    }

    // 후기게시판 댓글 수정
    public int reviewBoardCommentUpdate(ReviewBoardCommentVO reviewBoardCommentVO) {
        return sqlSession.update("reviewBoardCommentUpdate",reviewBoardCommentVO);
    }

    // 후기게시판 댓글 삭제
    public int reviewBoardCommentDelete(int  review_id, int cm_group) {
        Map<String, Object> commentInfo = new HashMap<>();
        commentInfo.put("review_id", review_id);
        commentInfo.put("cm_group", cm_group);
        return sqlSession.delete("reviewBoardCommentDelete", commentInfo);
    }

    // 후기게시판 대댓글 삭제
    public int reviewBoardCommentChildDelete(int  review_cm_id) {
        return sqlSession.delete("reviewBoardCommentChildDelete", review_cm_id);
    }

    // 후기게시판 대댓글 입력
    public void reviewBoardCommentReply(ReviewBoardCommentVO reviewboardCommentVO) {
        sqlSession.insert("reviewBoardCommentReply", reviewboardCommentVO);
    }


    // 후기게시판  파일업로드시 s3 이용
    public void reviewBoardFileS3Insert(ReviewBoardAttachVO reviewBoardAttachVO) {
        sqlSession.insert("reviewBoardS3Insert", reviewBoardAttachVO);
    }

    // 후기게시판 글 상세보기 - s3에 있는 파일정보 DB에서 찾기
    public List<ReviewBoardAttachVO> findByS3FileInfo(int review_id){
        return sqlSession.selectList("reviewBoardS3Find", review_id);
    }

    // 후기게시판 첨부파일 정보 삭제
    public int deleteReviewBoardFileInfo(int review_id) {
        return sqlSession.delete("reviewBoardS3InfoDelete", review_id);
    }

    // 후기게시판 게시글의 댓글 개수 구하기
    public int getCommentCountByReviewId(int review_id) {
        return sqlSession.selectOne("getCommentCountByReviewId", review_id);
    }

    //후기게시판 목록에서 제목 옆에 첨부파일 여부 확인
    public List<Object> reviewAttachCheck(int review_id) {
        return sqlSession.selectList("reviewAttachCheck", review_id);
    }

    // 후기게시판 첨부파일 정보 파일 이름으로 찾기
    public List<ReviewBoardAttachVO> findByFileName(String fileName) {
        return sqlSession.selectList("findByFileName", fileName);
    }
}
