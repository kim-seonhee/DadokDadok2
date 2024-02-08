<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/views/head.jsp"/>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

<body>
  <!-- ======= Top Bar ======= -->
  <jsp:include page="/WEB-INF/views/topbar.jsp"/>
  <!-- End Top Bar -->
  <%-- header --%>
  <jsp:include page="/WEB-INF/views/header.jsp"/>

  <main>
      <!-- ======= Breadcrumbs ======= -->
      <section id="breadcrumbs" class="breadcrumbs">
            <div class="container">
                 <div class="d-flex justify-content-between align-items-center">
                      <h2>후기게시판</h2>
                      <ol>
                          <li><a href="../mainpage/index">Home</a></li>
                          <li>후기게시판</li>
                      </ol>
                 </div>
            </div>
      </section>
      <section class="freeboard">
            <div class="b_info">
                <p>후기 게시글 작성</p>
                <div>공포심, 불안감 또는 불쾌감을 유발할 수 있는 게시물 작성은 금지합니다.</div>
            </div>
            <form action="/reviewboard/review_insert" method="post" enctype="multipart/form-data" class="insert_form">
                <div class="in_row">
                   <p>제 목:</p>
                   <input type="text" name="review_title" maxlength="50">
                </div>
                <div class="in_row">
                   <p>내 용:</p>
                   <textarea name="review_content" maxlength="2000"></textarea>
                </div>
                <div class="file_row">
                   <p>파일첨부</p>
                   <div class="file_box">
                       <div class="file_info">
                          <input type="file" name="file" id="upload_btn" multiple>
                          <label for="upload_btn">파일선택</label>
                          <div> 첨부 가능한 파일 개수: 5개, 파일 형식: png, jpg, jpeg, gif, pdf, doc/docx, xls/xlsx, ppt/pptx</div>
                       </div>
                      <div class="file_preview">
                        <span class="preview_box"></span>
                      </div>
                   </div>
                </div>
                <div class="in_btn">
                    <button type="submit">등록</button>
                    <a href="${pageContext.request.contextPath}/reviewboard/review_list">취소</a>
                </div>
               <input type="hidden" name="member_id" value="<sec:authentication property='principal.member.member_id'/>" />
            </form>
      </section>
  </main>
  <!-- ======= Footer ======= -->
  <jsp:include page="/WEB-INF/views/footer.jsp"/>
  <!-- End Footer -->


  <script type="text/javascript">
  let selectedFiles  = []; // 업로드를 취소한 파일의 이름을 저장하는 배열
      $(document).ready(function(){
          // 확장자 확인
          var regex = new RegExp("(.?)\\.(png|jpg|jpeg|gif|pdf|doc|docx|xls|xlsx|ppt|pptx)$");
          // 파일 크기 제한
          var maxSize = 5242880; // 5MB

          function checkExtension(fileName, fileSize){
              // 파일 크기 확인
              if(fileSize >= maxSize){
                alert("파일 크기가 5MB 이상입니다.");
                return false;
              }
              // 확장자 확인
              if (!regex.test(fileName.toLowerCase())) {
               alert("지원하지 않는 파일 형식입니다.");
               return false;
              }

              // 파일 확장자가 허용된 경우
              return true;
          }

          // .file_box 복제
          let cloneFile =  $(".file_box").clone();

          // 파일첨부 할 때마다
          $("input[type='file']").change(function(e) {
              let maxFile = 5;
              let formData = new FormData(); //key-value 형태의 데이터 쌍을 저장하는 객체
              let inputFile = $("input[name='file']");
              let files = inputFile[0].files; // 선택한 파일 목록 가져옴
              console.log("files: " + files);

              // 선택한 파일 개수 확인
              if(files.length > maxFile) {
                  alert("업로드 가능한 최대 파일 개수는 " + maxFile + "개 입니다.");
                  return false; // 추가파일 처리 중단
              }

              // 선택한 파일이 없는 경우 아무 작업도 하지 않고 함수를 종료
               if(files.length === 0) {
                      return false;
                }
               // 파일 이름 보여주기
              let fileList = $(".file_preview");
              fileList.empty(); // 새 파일 이름을 추가하기 전에 목록 지우기

              for (var i=0; i<this.files.length; i++) {
                  let file = this.files[i];

                  // 파일 이름에 공백이 있는지 확인
                  if (file.name.includes(' ')) {
                      alert("파일 이름에 공백을 포함할 수 없습니다.");
                      return false;  // 파일 업로드 처리 중단
                  }

                  let listItem = "<div class='preview_box'><div class='p_title'><p>" + file.name + "</p><p><button type='button'><i class='fa fa-times'></i></button></p></div></div>";
                   fileList.append(listItem);
              }

              // 파일데이터 폼에 집어넣기
               for (let i = 0; i < files.length; i++) {
                     if (!checkExtension(files[i].name, files[i].size)) {
                           return false;
                     }
                     // 모든 파일이 유효한 경우에만 selectedFiles 배열에 추가
                      selectedFiles.push(files[i]);
                } //for

          }); //input[type=file] change



          // 파일삭제
           $(".file_preview").on("click","button",function(e){
                  // 파일 이름 가져오기
                  let fileName = $(this).parent().prev().text();

                  // 선택한 파일 배열에서 해당 파일 제거
                 selectedFiles = selectedFiles.filter(file => file.name !== fileName);

                  // 화면에서 파일 이름 제거
                  $(this).closest('.preview_box').remove();
           }); //file_preview onclick(파일삭제버튼) end

  }); //script

  $("button[type='submit']").on("click", function(e){
      // 이벤트 버블링 막기
      e.preventDefault();

      // 제목, 내용 비어있는지 확인
      let title = $("input[name='review_title']").val().trim();
      let content = $("textarea[name='review_content']").val().trim();
      if(title == "" || content == ""){
          alert("제목과 내용을 모두 입력해주세요.");
          return false;
      }

      let fileInput = $('#upload_btn')[0];
      let formData = new FormData();

      // 첨부파일이 있을 경우에만 파일 관련 처리 수행
      if(selectedFiles.length > 0){
            for (let i = 0; i < selectedFiles.length; i++) {
                   let file = selectedFiles[i];
                   // 파일 크기가 5MB를 초과하는지 검사
                   if(file.size > 5 * 1024 * 1024){
                         alert("파일 크기가 5MB를 초과할 수 없습니다.");
                          return false;
                   }
                   formData.append('file' , file); // 각 파일을 별도로 추가
            }
      }


      formData.append('review_title', $("input[name='review_title']").val()); // 제목 추가
      formData.append('review_content', $("textarea[name='review_content']").val()); // 내용 추가
      formData.append('member_id', $("input[name='member_id']").val());

      $.ajax({
          type: 'POST',
          url: '/reviewboard/review_insert',
          data: formData,
          processData: false,
          contentType: false,
          success: function(data) {
              window.location.href = "/reviewboard/review_list";
          },
          error: function(error) {
              alert(JSON.stringify(error));
          }
      });
  }); // submit btn onclick end


    </script>

</body>
</html>