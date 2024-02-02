package com.multi.mini6.reviewboard.service;

import com.multi.mini6.reviewboard.vo.ReviewCommentVO;
import com.multi.mini6.reviewboard.dao.ReviewCommentDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewCommentService {
    @Autowired
    ReviewCommentDAO reviewCommentDAO;


    public int reviewCommentinsert(ReviewCommentVO reviewCommentVO){

        return reviewCommentDAO.reivewCommentInsert(reviewCommentVO);


    }

    public int reviewCommentupdate(ReviewCommentVO reviewCommentVO){
        return  reviewCommentDAO.reviewCommentUpdate(reviewCommentVO);
    }

    public List<ReviewCommentVO> reviewCommentlist(int review_id){
        return  reviewCommentDAO.reviewCommentList(review_id);
    }
    public int reviewCommentdelete(ReviewCommentVO reviewCommentVO) {
        return reviewCommentDAO.reviewCommentDelete(reviewCommentVO);
    }



}
