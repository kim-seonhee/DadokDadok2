package com.multi.mini6.loginpage.dao;

import com.multi.mini6.loginpage.vo.GuestBookVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class GuestBookDAO {

    @Autowired
    SqlSessionTemplate sqlSession;

    //방명록 추가
    public void addEntry(GuestBookVO guestBookVO) {
        sqlSession.insert("addEntry", guestBookVO);
    }

    //방명록 삭제
    public void deleteEntry(int id) {
        sqlSession.delete("deleteEntry", id);
    }

    //방명록 수정
    public void updateEntry(GuestBookVO guestBookVO) {
        sqlSession.update("updateEntry", guestBookVO);
    }

    //방명록 아이디로 검색해서 가져오기
    public GuestBookVO getEntryByEmail(String email) {
        return sqlSession.selectOne("getEntryByEmail", email);
    }

    //방명록 5개만 가져오기
    public List<GuestBookVO> getEntriesByEmail(String email) {
        return sqlSession.selectList("getEntriesByEmail", email); // 'getEntriesByEmail' MyBatis 쿼리 ID
    }

    //방명록 전체 가져오기
//    public List<GuestBookVO> getAllEntriesByEmail(String email) {
//        return sqlSession.selectList("getAllEntriesByEmail", email);
//    }
    public List<GuestBookVO> getAllEntriesByEmail(String email, int pageSize, int offset) {
        Map<String, Object> params = new HashMap<>();
        params.put("email", email);
        params.put("pageSize", pageSize);
        params.put("offset", offset);
        return sqlSession.selectList("getAllEntriesByEmail", params);
    }
    //페이징 처리할때 사용할 방명록 전체 개수 가져오기
    public int countGuestBookEntriesByEmail(String email) {
        return sqlSession.selectOne("countGuestBookEntriesByEmail", email);
    }

    // 방명록 대댓글 가져오기
    public List<GuestBookVO> getChildEntries(int parent_id) {
        return sqlSession.selectList("getChildEntries", parent_id);
    }
    public GuestBookVO getGuestBookCommnetById(int id) {
        return sqlSession.selectOne("getGuestBookCommnetById", id);
    }


    //방명록 대댓글 글쓰기
    public void addEntryComment(GuestBookVO guestBookVO) {
        sqlSession.insert("addEntryComment", guestBookVO);
    }
    //방명록 부모자식댓글 전체 삭제를 위한 자식댓글삭제
    public void deleteAllEntry(int id) {
        sqlSession.delete("deleteAllEntry", id);
    }

}
