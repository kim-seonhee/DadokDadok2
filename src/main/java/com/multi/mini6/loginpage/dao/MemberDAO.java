package com.multi.mini6.loginpage.dao;

import com.multi.mini6.loginpage.vo.MemberDeleteReasonVO;
import com.multi.mini6.loginpage.vo.MemberVO;
import com.multi.mini6.loginpage.vo.PasswordChangeDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MemberDAO {

    @Autowired
    SqlSessionTemplate sqlSession;

    //멤버 리스트 가져오기
    public List<MemberVO> getMemberList(){
        return sqlSession.selectList("getMemberList");
    }

    //권한추가
    public int insertMemberAuthority(MemberVO memberVO) {
    	return sqlSession.insert("insertMemberAuthority", memberVO);
    }
    //멤버 추가
    public int insertMember(MemberVO memberVO){
        return sqlSession.insert("insertMember", memberVO);
    }
    //이메일로 멤버 가져오기
    public MemberVO getMember(String email){
        return sqlSession.selectOne("getMember", email);

    }
    public int changePassword(PasswordChangeDTO passwordChangeDTO) {
        return sqlSession.update("changePassword", passwordChangeDTO);
    }
    public String getCurrentHashedPassword(String email) {
        return sqlSession.selectOne("getCurrentHashedPassword", email);
    }
    //이메일 중복확인
    public int checkEmail(String email){
        return sqlSession.selectOne("checkEmail", email);
    }

    //멤버 아이디로 멤버 가져오기
    public MemberVO getMemberById(int memberId){
        return sqlSession.selectOne("getMemberById", memberId);
    }
    //멤버 수정
    public int updateMember(MemberVO member){
        return sqlSession.update("updateMember", member);
    }

    //프로필 이미지 저장
    public int updateProfileImg(Map<String, Object> params) {
        return sqlSession.update("updateProfileImg", params);
    }
    
    //이미지 경로 가져오기
    public String getProfileImgPathByEmail(String email) {
        return sqlSession.selectOne("getProfileImgPathByEmail", email);
    }

    //멤버 삭제
    public void deleteMemberAuthority(String email) {
        sqlSession.delete("deleteMemberAuthority", email);
    }
    public int deleteMember(int memberId){
        return sqlSession.delete("deleteMember", memberId);
    }

    //삭제 이유 추가
    public void insertMemberDeleteReason(MemberDeleteReasonVO memberDeleteReasonVO) {
        sqlSession.insert("insertMemberDeleteReason", memberDeleteReasonVO);
    }
}
