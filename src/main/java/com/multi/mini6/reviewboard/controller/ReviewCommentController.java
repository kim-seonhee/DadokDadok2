package com.multi.mini6.reviewboard.controller;

import com.multi.mini6.reviewboard.vo.ReviewCommentVO;
import com.multi.mini6.reviewboard.service.ReviewCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/reviewboard")
public class ReviewCommentController {
    @Autowired
    ReviewCommentService reviewCommentService;

    @RequestMapping("/review_comment_insert")
    public void reviewCommentinsert(ReviewCommentVO reviewCommentVO, Model model) {
        System.out.println("review_comment_insert");
        int result = reviewCommentService.reviewCommentinsert(reviewCommentVO);
        System.out.println("comment insert결과" + result);
        System.out.println("reviewCommentVO cm_id : "  + reviewCommentVO.getCm_id());
        model.addAttribute("result",result);
        model.addAttribute("cm_id",reviewCommentVO.getCm_id());


    }

    @RequestMapping("/review_comment_update")
    @ResponseBody
    public int reviewCommentupdate(ReviewCommentVO reviewCommentVO, Model model) {
        int result = reviewCommentService.reviewCommentupdate(reviewCommentVO);
        return result;
    }
    @RequestMapping("/review_comment_delete")
    public String reviewCommentdelete(ReviewCommentVO reviewCommentVO, Model model) {

        int result = reviewCommentService.reviewCommentdelete(reviewCommentVO);

        model.addAttribute("result", result);
        return "forward:/reviewboard/review_list3?page=1" + reviewCommentVO.getReview_id();
    }

}
