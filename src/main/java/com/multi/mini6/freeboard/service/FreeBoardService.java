package com.multi.mini6.freeboard.service;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import com.amazonaws.services.s3.AmazonS3;
import com.multi.mini6.freeboard.dao.FreeBoardDAO;
import com.multi.mini6.freeboard.vo.*;

import java.io.IOException;
import java.util.*;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@Slf4j
public class FreeBoardService {

  @Autowired
  private FreeBoardDAO freeBoardDAO;

  private final AmazonS3 s3Client;

  @Autowired
  public FreeBoardService(AmazonS3 amazonS3) {
    this.s3Client = amazonS3;
  }

  @Value("${bucketName}")
  private String bucketName;


  // 자유게시판 게시글 작성
  public int freeBoardInsert(FreeBoardVO freeBoardVO){
    return freeBoardDAO.freeBoardInsert(freeBoardVO);
  }

  // 자유게시판  글 목록
  public List<FreeBoardVO> freeBoardList(FreeBoardPageVO freeboardPageVO) {
    return freeBoardDAO.getFreeBoardList(freeboardPageVO);
  }

  // 자유게시판 전체 게시물 수 구하기
  public int boardCount(FreeBoardPageVO freeboardPageVO) {
    return  freeBoardDAO.freeBoardCount(freeboardPageVO);
  }

  // 자유게시판 게시글 상세보기
  public FreeBoardVO freeBoardOne(int board_id) {
    return freeBoardDAO.freeBoardOne(board_id);
  }

  // 자유게시판 게시글 클릭시 조회수 증가
  public void viewsCount(FreeBoardVO freeBoardVO) {
    freeBoardDAO.freeBoardViewsCount(freeBoardVO);
  }

  // 자유게시판 상세페이지에서 이전글 가져오기
  public FreeBoardVO getPreviousPost(int board_id) {
    return freeBoardDAO.getPreviousPost(board_id);
  }

  // 자유게시판 상세페이지에서 다음글 가져오기
  public FreeBoardVO getNextPost(int board_id) {
    return freeBoardDAO.getNextPost(board_id);
  }

  // 자유게시판 게시글 삭제
  public void freeBoardDelete(int board_id) {
    freeBoardDAO.freeBoardDelete(board_id);
  }

  // 자유게시판 게시글 수정
  public void freeBoardUpdate(FreeBoardVO freeBoardVO){
    freeBoardDAO.freeBoardUpdate(freeBoardVO);
  }


  // 자유게시판 댓글 저장
public void commentInsert(FreeBoardCommentVO freeBoardCommentVO){
    freeBoardDAO.freeBoardCommentInsert(freeBoardCommentVO);
}

// 자유게시판 댓글 리스트 가져오기
  public Map<Integer, List<FreeBoardCommentVO>> findList(int board_id ){
     // 댓글 정보 가져오기
      List<FreeBoardCommentVO> commentInfo =  freeBoardDAO.freeBoardCommentList(board_id);

      Map<Integer, List<FreeBoardCommentVO>> groupedComments = new HashMap<>();
      // 댓글 정보를 그룹별로 분류
      for (FreeBoardCommentVO comment : commentInfo) {
          // 현재 댓글의 그룹 ID 가져오기
          int groupId = comment.getCm_group();

          // 해당 그룹 ID의 댓글 리스트를 조회
          List<FreeBoardCommentVO> group = groupedComments.get(groupId);

          // 리스트가 없으면 새로 생성하고 맵에 추가
          if (group == null) {
              group = new ArrayList<>();
              groupedComments.put(groupId, group);
          }

          // 현재 댓글을 그룹 리스트에 추가
          group.add(comment);
      }
      return groupedComments;
  }

  // 자유게시판  댓글 수정
  public void commentUpdate(FreeBoardCommentVO freeBoardCommentVO) {
    freeBoardDAO.freeBoardCommentUpdate(freeBoardCommentVO);
  }

  // 자유게시판 댓글삭제
  public void commentDelete(int board_id, int cm_group){
    freeBoardDAO.freeBoardCommentDelete(board_id, cm_group);
  }

  // 자유게시판 대댓글삭제
  public void commentChildDelete(int bocm_id){
    freeBoardDAO.freeBoardCommentChildDelete(bocm_id);
  }

  // 자유게시판 대댓글 입력
  public void commentReply(FreeBoardCommentVO freeBoardCommentVO){
    freeBoardDAO.freeBoardCommentReply(freeBoardCommentVO);
  }



  // 자유게시판 S3 버킷에 파일 업로드
  @Transactional // 하나라도 실패할 경우 롤백
  public String freeBoardInsertS3(MultipartFile file, int board_id, FreeBoardAttachVO freeBoardAttachVO) throws IOException {

      // 첨부파일이 있는 경우에만 파일정보 저장
      if (!file.isEmpty()) {

        // 각 파일마다 고유한 UUID 생성
        String originalFileName = file.getOriginalFilename();
        String uuidFileName = UUID.randomUUID().toString() + "_" + originalFileName;

        // 파일정보 저장 위한 board_id 설정
        freeBoardAttachVO.setBoard_id(board_id);
        freeBoardAttachVO.setBoard_file_name(uuidFileName);


        try {
          // s3에 업로드
          String filePath = "FreeBoard/" + uuidFileName;
          ObjectMetadata metadata = new ObjectMetadata();
          metadata.setContentLength(file.getSize());
          metadata.setContentType(file.getContentType());
          // S3 버킷에 파일 업로드
          s3Client.putObject(new PutObjectRequest(bucketName, filePath, file.getInputStream(), metadata));

          // 파일정보 저장
          freeBoardDAO.freeBoardFileS3Insert(freeBoardAttachVO);

          // S3 버킷에 업로드 된 파일의 url return
          return s3Client.getUrl(bucketName, filePath).toString();
        } catch (AmazonServiceException e) {
          log.error("AmazonServiceException: {}", e.getMessage());
          throw e;
        } catch (SdkClientException e) {
          log.error("SdkClientException: {}", e.getMessage());
          throw e;
        }
      }
   // }
    return null;
  }

  // 자유게시판 s3에 업로드 되어 있는 파일정보 DB에서 가져오기
  public List<String> getS3FileList(int board_id){
    // s3에 업로드 되어 있는 파일정보 DB에서 가져오기
    List<FreeBoardAttachVO> s3FileInfo = freeBoardDAO.findByS3FileInfo(board_id);

    List<String> s3Url = new ArrayList<>();

    for (FreeBoardAttachVO s3FileInfoList : s3FileInfo) {
      String s3FileName = "FreeBoard/" + s3FileInfoList.getBoard_file_name();
      String url = s3Client.getUrl(bucketName, s3FileName).toString();
      s3Url.add(url);
    }

    return s3Url;  // URL 리스트 반환
  }

  // 자유게시판 첨부파일 정보 db에서 검색
  public List<FreeBoardAttachVO> freeBoardFileList (int board_id){
    List<FreeBoardAttachVO> s3FileInfo = freeBoardDAO.findByS3FileInfo(board_id);
    return s3FileInfo;
  }

  // 자유게시판 첨부파일 정보 db에서 삭제
  public void freeBoardFileDelete (int board_id){
    freeBoardDAO.deleteFreeBoardFileInfo(board_id);
  }

  // 자유게시판 첨부파일 s3에서 삭제
    public void freeBoardDeleteS3(String s3FileUrl) throws AmazonServiceException {
      String s3Filename = "FreeBoard/" + s3FileUrl;
      s3Client.deleteObject(new DeleteObjectRequest(bucketName, s3Filename));
    }

  // 자유게시판 목록에서 제목 옆에 댓글 개수 표시
  public int getCommentCountByBoardId(int board_id) {
    return freeBoardDAO.getCommentCountByBoardId(board_id);
  }

  public List<Object> boardAttachCheck(int board_id) {
    return freeBoardDAO.boardAttachCheck(board_id);
  }
}


