
![image1](https://github.com/myoungsuk/DadokDadok/assets/94948198/4d1298b3-ecaa-4f8d-a32c-9b51ed6fac1c)


# 다독다독
*다독(多讀, 다양한 종류의 책을 많이 읽는 독서 방법)을 다독이다.*
<br>
Spring, mybatis, jsp 를 사용한 독서 커뮤니티 사이트 **다독다독**입니다.
<br><br>

## 📌 프로젝트 일정
프로젝트 기간 : 2023년 12월 19일 ~ 2024년 1월 28일
<br><br>

## 📌 프로젝트 설명
- 도서에 관련된 후기를 보관하고 공유하는 커뮤니티 사이트입니다.
- 게시판을 통해 독서 후기 및 댓글로 이용자들 간 의견 공유를 할 수 있습니다.
- API를 활용한 도서관 조회, 도서 소장/대출 여부 조회, 도서 상세 조회, 도서 추천 등의 기능을 사용할 수 있습니다.
<br><br>

## 📌 프로젝트 팀원
![image](https://github.com/myoungsuk/DadokDadok/assets/94948198/66316b9d-1565-4876-9e41-d5fae24e28a6)
<br><br>

## 📌 프로젝트 구현 화면
![01main](https://github.com/myoungsuk/DadokDadok/assets/94948198/a44a2f80-b519-4d61-a8e3-1883711e669d)
![02book](https://github.com/myoungsuk/DadokDadok/assets/94948198/710a4314-dbad-4dca-a848-3b92786c9b85)
![03library](https://github.com/myoungsuk/DadokDadok/assets/94948198/6bd5dc27-605c-4bc4-9a72-d6f6ea0e2818)
![04review](https://github.com/myoungsuk/DadokDadok/assets/94948198/eb99b3fd-e454-4636-b07f-dc10c398b76e)
![05free](https://github.com/myoungsuk/DadokDadok/assets/94948198/baa2e14b-e8f4-42a8-b690-0ff437f0308b)
![06notice](https://github.com/myoungsuk/DadokDadok/assets/94948198/ba08a969-12ba-4f10-8711-9af4a3c1a06c)
![07adminupload](https://github.com/myoungsuk/DadokDadok/assets/94948198/14497ecd-6934-4775-8cf4-163a4b30c426)
![08setting](https://github.com/myoungsuk/DadokDadok/assets/94948198/f733aebc-923e-4220-a80e-82d91bf50ab7)
![09mypage](https://github.com/myoungsuk/DadokDadok/assets/94948198/14e800cf-6e6d-4d1d-9433-19f5d263fd92)
<br><br>

## 📌 프로젝트 주요 정의서
![image67](https://github.com/myoungsuk/DadokDadok/assets/94948198/06c1e9b5-1d71-4017-9633-a6c3ce27d21c)
<br><br>

## 📌 프로젝트 전체 순서도
![image68](https://github.com/myoungsuk/DadokDadok/assets/94948198/575e1038-a218-4371-ba92-e18d6f3c212c)
<br><br>

## 📌 프로젝트 ERD
![image (28)](https://github.com/myoungsuk/DadokDadok/assets/94948198/9ed4cd24-425b-4791-868f-137d1e034a81)
<br><br>

## 📌 프로젝트 트리
```
DADOKDADOK
│  .classpath
│  .project
│  .springBeans
│  pom.xml
│  README.md
│  
├─.idea
│      
├─.settings
│      
├─src
│  ├─main
│  │  ├─java
│  │  │  └─com
│  │  │      └─multi
│  │  │          └─mini6
│  │  │              ├─adminpage
│  │  │              │  ├─controller
│  │  │              │  │      BookUploadController.java
│  │  │              │  │      
│  │  │              │  ├─dao
│  │  │              │  │      BookUploadDAO.java
│  │  │              │  │      
│  │  │              │  └─service
│  │  │              │          BookUploadService.java
│  │  │              │          
│  │  │              ├─bookpage
│  │  │              │  ├─controller
│  │  │              │  │      BookController.java
│  │  │              │  │      
│  │  │              │  ├─dao
│  │  │              │  │      BookDAO.java
│  │  │              │  │      
│  │  │              │  ├─service
│  │  │              │  │      BookAPIService.java
│  │  │              │  │      BookService.java
│  │  │              │  │      
│  │  │              │  └─vo
│  │  │              │      │  BooksHistoryVO.java
│  │  │              │      │  BooksLibrariesVO.java
│  │  │              │      │  BooksVO.java
│  │  │              │      │  LibrariesVO.java
│  │  │              │      │  PageVO.java
│  │  │              │      │  
│  │  │              │      └─bookAPI
│  │  │              │              AgeResultDTO.java
│  │  │              │              BookDTO.java
│  │  │              │              DetailDTO.java
│  │  │              │              GenderResultDTO.java
│  │  │              │              LoanInfoDTO.java
│  │  │              │              RegionResultDTO.java
│  │  │              │              RequestDTO.java
│  │  │              │              ResponseDTO.java
│  │  │              │              TotalDTO.java
│  │  │              │              
│  │  │              ├─freeboard
│  │  │              │  ├─config
│  │  │              │  │      S3Config.java
│  │  │              │  │      
│  │  │              │  ├─controller
│  │  │              │  │      FreeBoardController.java
│  │  │              │  │      
│  │  │              │  ├─dao
│  │  │              │  │      FreeBoardDAO.java
│  │  │              │  │      
│  │  │              │  ├─service
│  │  │              │  │      FreeBoardService.java
│  │  │              │  │      
│  │  │              │  └─vo
│  │  │              │          boardVO.java
│  │  │              │          FreeBoardAttachVO.java
│  │  │              │          FreeBoardCommentVO.java
│  │  │              │          FreeBoardPageVO.java
│  │  │              │          FreeBoardVO.java
│  │  │              │          
│  │  │              ├─librarypage
│  │  │              │  ├─controller
│  │  │              │  │      LibraryController.java
│  │  │              │  │      LibraryPageController.java
│  │  │              │  │      
│  │  │              │  ├─dao
│  │  │              │  │      LibraryDAO.java
│  │  │              │  │      LibraryPageDAO.java
│  │  │              │  │      
│  │  │              │  ├─service
│  │  │              │  │      LibraryAPI.java
│  │  │              │  │      LibraryPageService.java
│  │  │              │  │      LibraryService.java
│  │  │              │  │      
│  │  │              │  └─vo
│  │  │              │          LibraryPageVO.java
│  │  │              │          LibraryVO.java
│  │  │              │          
│  │  │              ├─loginpage
│  │  │              │  │  PathUtil.java
│  │  │              │  │  
│  │  │              │  ├─config
│  │  │              │  │      CustomSessionListener.java
│  │  │              │  │      
│  │  │              │  ├─controller
│  │  │              │  │      GuestBookController.java
│  │  │              │  │      MemberController.java
│  │  │              │  │      ProfileController.java
│  │  │              │  │      SecurityController.java
│  │  │              │  │      SettingController.java
│  │  │              │  │      
│  │  │              │  ├─dao
│  │  │              │  │      GuestBookDAO.java
│  │  │              │  │      MemberDAO.java
│  │  │              │  │      ProfileDAO.java
│  │  │              │  │      
│  │  │              │  ├─security
│  │  │              │  │      CustomAccessDeniedHandler.java
│  │  │              │  │      CustomLoginSuccessHandler.java
│  │  │              │  │      CustomUserDetailsService.java
│  │  │              │  │      
│  │  │              │  ├─service
│  │  │              │  │      GuestBookService.java
│  │  │              │  │      MemberService.java
│  │  │              │  │      ProfileService.java
│  │  │              │  │      
│  │  │              │  └─vo
│  │  │              │          AuthorityVO.java
│  │  │              │          CustomUser.java
│  │  │              │          GuestBookVO.java
│  │  │              │          MemberDeleteReasonVO.java
│  │  │              │          MemberVO.java
│  │  │              │          PasswordChangeDTO.java
│  │  │              │          
│  │  │              ├─mainpage
│  │  │              │  ├─controller
│  │  │              │  │      MainPageController.java
│  │  │              │  │      
│  │  │              │  ├─dao
│  │  │              │  │      MainPageDAO.java
│  │  │              │  │      
│  │  │              │  └─service
│  │  │              │          MainPageService.java
│  │  │              │          
│  │  │              ├─noticeboard
│  │  │              │  ├─controller
│  │  │              │  │      NoticeBoardController.java
│  │  │              │  │      NoticeBoardImageController.java
│  │  │              │  │      
│  │  │              │  ├─dao
│  │  │              │  │      NoticeBoardDAO.java
│  │  │              │  │      
│  │  │              │  ├─service
│  │  │              │  │      NoticeBoardService.java
│  │  │              │  │      
│  │  │              │  └─vo
│  │  │              │          NoticeBoardPageVO.java
│  │  │              │          NoticeBoardVO.java
│  │  │              │          
│  │  │              ├─profilepage
│  │  │              │  └─vo
│  │  │              │          profileVO.java
│  │  │              │          
│  │  │              ├─reviewboard
│  │  │              │  ├─controller
│  │  │              │  │      ReviewCommentController.java
│  │  │              │  │      ReviewController.java
│  │  │              │  │      
│  │  │              │  ├─dao
│  │  │              │  │      ReviewCommentDAO.java
│  │  │              │  │      ReviewDAO.java
│  │  │              │  │      
│  │  │              │  ├─service
│  │  │              │  │      ReviewCommentService.java
│  │  │              │  │      ReviewService.java
│  │  │              │  │      
│  │  │              │  └─vo
│  │  │              │          PageVo.java
│  │  │              │          ReviewAttachVO.java
│  │  │              │          ReviewCommentVO.java
│  │  │              │          ReviewVO.java
│  │  │              │          
│  │  │              └─settingpage
│  │  │                  └─vo
│  │  │                          settingVO.java
│  │  │                          
│  │  ├─resources
│  │  │  │  application.properties
│  │  │  │  db.properties
│  │  │  │  log4j.xml
│  │  │  │  log4j2.xml
│  │  │  │  mybatis-config.xml
│  │  │  │  
│  │  │  └─mapper
│  │  │          BookSQL.xml
│  │  │          BookUploadSQL.xml
│  │  │          FreeBoardSQL.xml
│  │  │          GuestBookEntrySQL.xml
│  │  │          LibrarySQL.xml
│  │  │          MainPageSQL.xml
│  │  │          MemberSQL.xml
│  │  │          NoticeBoardSQL.xml
│  │  │          ReviewCommentSQL.xml
│  │  │          ReviewSQL2.xml
│  │  │          
│  │  └─webapp
│  │      ├─resources
│  │      │  ├─assets
│  │      │  │              
│  │      │  ├─css
│  │      │  │      freeboard.css
│  │      │  │      main.css
│  │      │  │      notice.css
│  │      │  │      review.css
│  │      │  │      
│  │      │  ├─form
│  │      │  │      
│  │      │  ├─img
│  │      │  │      
│  │      │  └─reviewBoardUpload
│  │      │          
│  │      └─WEB-INF
│  │          │  web.xml
│  │          │  
│  │          ├─spring
│  │          │  │  root-context.xml
│  │          │  │  security-context.xml
│  │          │  │  
│  │          │  └─appServlet
│  │          │          servlet-context.xml
│  │          │          
│  │          └─views
│  │              │  footer.jsp
│  │              │  head.jsp
│  │              │  header.jsp
│  │              │  topbar.jsp
│  │              │  
│  │              ├─adminpage
│  │              │      BookUploadPage.jsp
│  │              │      
│  │              ├─bookpage
│  │              │      bookdetail.jsp
│  │              │      booklist.jsp
│  │              │      bookmain.jsp
│  │              │      
│  │              ├─freeboard
│  │              │      board_insert.jsp
│  │              │      board_list.jsp
│  │              │      board_one.jsp
│  │              │      board_update.jsp
│  │              │      
│  │              ├─librarypage
│  │              │      library_admin.jsp
│  │              │      library_insert.jsp
│  │              │      library_list3.jsp
│  │              │      library_list4.jsp
│  │              │      library_one.jsp
│  │              │      library_search_address.jsp
│  │              │      library_search_address2.jsp
│  │              │      library_search_name.jsp
│  │              │      library_search_name2.jsp
│  │              │      
│  │              ├─loginpage
│  │              │      accessError.jsp
│  │              │      admin.jsp
│  │              │      all.jsp
│  │              │      customLogin.jsp
│  │              │      customLogout.jsp
│  │              │      member.jsp
│  │              │      memberlist.jsp
│  │              │      signupPage.jsp
│  │              │      
│  │              ├─mainpage
│  │              │      index.jsp
│  │              │      
│  │              ├─noticeboard
│  │              │      noticeboard.jsp
│  │              │      noticeboard_one.jsp
│  │              │      noticeboard_search.jsp
│  │              │      noticeboard_update.jsp
│  │              │      noticeboard_write.jsp
│  │              │      
│  │              ├─profilepage
│  │              │  │  mypage.jsp
│  │              │  │  
│  │              │  └─GuestBookPage
│  │              │          guestbookDetail.jsp
│  │              │          
│  │              ├─reviewboard
│  │              │      review_comment_delete.jsp
│  │              │      review_comment_insert.jsp
│  │              │      review_comment_update.jsp
│  │              │      review_delete.jsp
│  │              │      review_insert.jsp
│  │              │      review_list.jsp
│  │              │      review_list3.jsp
│  │              │      review_list33.jsp
│  │              │      review_one.jsp
│  │              │      review_search1.jsp
│  │              │      review_update.jsp
│  │              │      
│  │              └─settingpage
│  │                     settingpage.jsp
│  │                      
│  └─test 
│ 
├─target
│                             
└─work

```
<br><br>



