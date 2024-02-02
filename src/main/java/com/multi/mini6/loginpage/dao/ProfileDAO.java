package com.multi.mini6.loginpage.dao;

import com.multi.mini6.loginpage.vo.MemberDeleteReasonVO;
import com.multi.mini6.loginpage.vo.MemberVO;
import com.multi.mini6.loginpage.vo.PasswordChangeDTO;
import com.multi.mini6.reviewboard.vo.ReviewVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProfileDAO {

    @Autowired
    SqlSessionTemplate sqlSession;

    public List<ReviewVO> getReviewListById(int memberId) {
        return sqlSession.selectList("getReviewListById", memberId);
    }
}
