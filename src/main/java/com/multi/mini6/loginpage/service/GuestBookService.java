package com.multi.mini6.loginpage.service;

import com.multi.mini6.loginpage.dao.GuestBookDAO;
import com.multi.mini6.loginpage.vo.GuestBookVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class GuestBookService {

    final private GuestBookDAO guestBookDAO;

    // 방명록 추가
    public void addGuestBook(GuestBookVO guestBookVO) {
        guestBookDAO.addEntry(guestBookVO);
    }

    // 이메일을 기반으로 방명록을 가져오는 메소드 5개만가져옴
    public List<GuestBookVO> getGuestBookEntriesByEmail(String email) {
        return guestBookDAO.getEntriesByEmail(email); // DAO가 이메일을 기반으로 방명록을 가져올 수 있도록 메소드 구현
    }

    // 이메일을 기반으로 방명록을 가져오는 메소드 전체 가져옴
//    public List<GuestBookVO> getAllGuestBookEntriesByEmail(String email) {
//        return guestBookDAO.getAllEntriesByEmail(email); // DAO가 이메일을 기반으로 방명록을 가져올 수 있도록 메소드 구현
//    }
    public List<GuestBookVO> getAllGuestBookEntriesByEmail(String email, int pageSize, int offset) {
        return guestBookDAO.getAllEntriesByEmail(email, pageSize, offset);
    }
    //페이징 처리할때 사용할 방명록 전체 개수 가져오기
    public int countGuestBookEntriesByEmail(String email) {
        return guestBookDAO.countGuestBookEntriesByEmail(email);
    }
    // 방명록 대댓글 가져오기
    public List<GuestBookVO> getChildGuestBookEntries(int parent_id) {
        return guestBookDAO.getChildEntries(parent_id);
    }

    //방명록 대댓글 삭제
    public void deleteGuestBook(int id) {
        guestBookDAO.deleteEntry(id);
    }

    //방명록 업데이트
    public void updateGuestBook(GuestBookVO guestBookVO) {
        guestBookDAO.updateEntry(guestBookVO);
    }

    //방명록 아이디로 검색해서 가져오기
    public GuestBookVO getGuestBookCommnetById(int id) {
        return guestBookDAO.getGuestBookCommnetById(id);
    }



    //방명록 대댓글 글쓰기
    public void addGuestBookComment(GuestBookVO guestBookVO) {
        guestBookDAO.addEntryComment(guestBookVO);
    }
    //방명록 부모자식 전체 삭제
    @Transactional
    public void deleteAllGuestBook(int id) {
        guestBookDAO.deleteAllEntry(id);
        guestBookDAO.deleteEntry(id);
    }
}
