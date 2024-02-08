package com.multi.mini6.loginpage.service;

import com.multi.mini6.loginpage.dao.ProfileDAO;
import com.multi.mini6.reviewboard.vo.ReviewBoardVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j2
public class ProfileService {

    final private ProfileDAO profileDAO;

    public List<ReviewBoardVO> getReviewListById(int memberId) {
        return profileDAO.getReviewListById(memberId);
    }
}
