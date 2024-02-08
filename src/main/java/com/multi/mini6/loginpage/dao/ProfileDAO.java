package com.multi.mini6.loginpage.dao;

import com.multi.mini6.reviewboard.vo.ReviewBoardVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProfileDAO {

    @Autowired
    SqlSessionTemplate sqlSession;

    public List<ReviewBoardVO> getReviewListById(int memberId) {
        return sqlSession.selectList("getReviewListById", memberId);
    }
}
