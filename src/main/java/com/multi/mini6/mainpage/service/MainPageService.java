package com.multi.mini6.mainpage.service;

import com.multi.mini6.freeboard.vo.FreeBoardVO;
import com.multi.mini6.mainpage.dao.MainPageDAO;
import com.multi.mini6.noticeboard.vo.NoticeBoardVO;
import com.multi.mini6.reviewboard.vo.ReviewBoardVO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MainPageService {

  @Autowired
  private MainPageDAO mainPageDAO;

  public List<FreeBoardVO> getFreeBoardList(FreeBoardVO freeBoardVO) {
    return mainPageDAO.freeBoardListFive(freeBoardVO);
  }

  public List<NoticeBoardVO> getNoticeBoardList(NoticeBoardVO noticeBoardVO) {
    return mainPageDAO.noticeBoardListFive(noticeBoardVO);
  }

  public List<ReviewBoardVO> getReviewList(ReviewBoardVO reviewBoardVO) {
    return mainPageDAO.reviewListTen(reviewBoardVO);
  }


}
