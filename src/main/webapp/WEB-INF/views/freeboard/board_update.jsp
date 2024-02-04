<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/views/head.jsp"/>
  <script type="text/javascript">
    $(document).ready(function(){
         // 확장자 확인
         let regex = new RegExp("(.?)\\.(png|jpg|jpeg|gif|pdf|doc|docx|xls|xlsx|ppt|pptx)$");
         // 파일 크기 제한
         let maxSize = 5242880; // 5MB

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
          }); //upload_btn change

         let selectedFiles  = []; // 업로드를 취소한 파일의 이름을 저장하는 배열


          // 파일삭제
           $(".file_preview").on("click","button",function(e){
                  // 파일 이름 가져오기
                  let fileName = $(this).parent().prev().text();

                  // 선택한 파일 배열에서 해당 파일 제거
                 selectedFiles = selectedFiles.filter(file => file.name !== fileName);

                  // 화면에서 파일 이름 제거
                  $(this).closest('.preview_box').remove();
            }); //file_preview onclick(파일삭제버튼) end


          $("#updateBtn").on("click", function(e){
                // 이벤트 버블링 막기
                e.preventDefault();

                let id = ${freeBoardVO.board_id};

                // 제목, 내용 비어 있는지 확인
                let title = $("input[name='board_title']").val().trim();
                let content = $("textarea[name='board_content']").val().trim();
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
                formData.append('board_id', $("input[name='board_id']").val());
                formData.append('board_title', $("input[name='board_title']").val()); // 제목 추가
                formData.append('board_content', $("textarea[name='board_content']").val()); // 내용 추가
                formData.append('member_id', $("input[name='member_id']").val());

                $.ajax({
                    type: "POST",
                    url: "/freeboard/board_update",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(data) {
                       alert("게시글 수정이 완료 되었습니다.");
                       window.location.href = "/freeboard/board_one?board_id=" + data;
                        },
                    error: function(jqXHR, textStatus, errorThrown) {
                       alert("게시글 수정 중 오류가 발생 하였습니다.");
                    }
                });
            }); // submit btn onclick end
  }); //script



  </script>
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
                      <h2>자유게시판</h2>
                      <ol>
                          <li><a href="../mainpage/index">Home</a></li>
                          <li>자유게시판</li>
                      </ol>
                 </div>
            </div>
        </section><!-- End Breadcrumbs -->
        <section class="freeboard">
              <div class="b_info">
                    <p>자유게시판 게시글 수정</p>
                    <div>공포심, 불안감 또는 불쾌감을 유발할 수 있는 게시물 작성은 금지합니다.</div>
              </div>
              <form action="/freeboard/board_update" method="post" enctype="multipart/form-data"  class="insert_form">
                    <input type="hidden" name="board_id" value="${freeBoardVO.board_id}">
                    <div class="in_row">
                          <p>제 목:</p>
                           <input type="text" name="board_title" value="${freeBoardVO.board_title}" maxlength="50">
                    </div>
                    <div class="in_row">
                          <p>내 용:</p>
                           <textarea name="board_content" maxlength="2000">${freeBoardVO.board_content}</textarea>
                   </div>
                    <div class="file_row">
                           <p>파일첨부</p>
                           <div class="file_box">
                                 <div class="file_info">
                                      <input type="file" name="file" id="upload_btn" multiple>
                                      <label for="upload_btn">파일선택</label>
                                      <div> png, jpg, jpeg, gif, pdf, doc/docx, xls/xlsx, ppt/pptx 만 업로드 가능합니다.</div>
                                 </div>
                              <div class="file_preview">
                                  <span class="preview_box">
                                  <c:forEach var="attachment" items="${FileList}" varStatus="status">
                                      <div class="p_title">
                                         <p>${modifiedNames[status.index]}</p>
                                         <p><button type='button'><i class='fa fa-times'></i></button></p>
                                       </div>
                                  </c:forEach>
                                  </span>
                              </div>
                           </div>
                    </div>
                    <div class="in_btn">
                          <button type="submit" id="updateBtn">수정완료</button>
                          <a href="${pageContext.request.contextPath}/freeboard/board_list">취소하기</a>
                    </div>
              </form>
        </section>
    </main>
    <!-- ======= Footer ======= -->
    <jsp:include page="/WEB-INF/views/footer.jsp"/>
    <!-- End Footer -->
</body>
</html>
