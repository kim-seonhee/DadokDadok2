<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="com.multi.mini6.reviewboard.vo.ReviewVO"%>



<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/views/head.jsp"/>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
  <script type="text/javascript">

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

      $("input[type='file']").change(function(e) {
        let formData = new FormData(); //key-value 형태의 데이터 쌍을 저장하는 객체
        let inputFile = $("input[name='file']");
        let files = inputFile[0].files; // 선택한 파일 목록 가져옴
        console.log("files: " + files);

        // 파일데이터 폼에 집어넣기
        for (let i = 0; i < files.length; i++) {
          if (!checkExtension(files[i].name, files[i].size)) {
            return false;
          }
          formData.append("file", files[i]);
        } //for
        console.log("----------파일 적재 후 formData 태그------------");
        console.log("formData: " + formData);

        $.ajax({
          url: "/reviewboard/uploadAjaxFormAction",
          processData: false,  // 데이터 변환 방지
          contentType: false,  // 콘텐츠 타입 설정 방지
          data: formData,
          type: "POST",
          dataType: "json",
          success: function(result) {
            console.log("result: " + result);
            console.log(JSON.stringify(result, null, 2));
            showUploadResult(result); // 업로드 결과 처리 함수

            //$(".file_box").html(cloneFile.html()); // 복사된 file_box내에 다시 추가해 초기화
          }
        }); //ajax
      }); //upload_btn change




      // 섬네일
      function showUploadResult(uploadResultArr){
        if(!uploadResultArr || uploadResultArr.length == 0 ){
          return;
        }
        let uploadUL = $(".file_preview");
        let str = "";
        $(uploadResultArr).each(function(i, obj){
          // 이미지 파일인 경우(png, jpg, jpge, gif)
          let imgType = ["png", "jpg", "jpeg", "gif"];
          if(imgType.includes(obj.review_file_type)){
            console.log("sdf");
            let fileCallPath = "/resources/reviewBoardUpload/s_" + obj.review_uuid + "_" + encodeURIComponent(obj.review_file_name);
            str += "<span class='preview_box' data-uuid='" + obj.review_uuid + "' data-filename='" + obj.review_file_name + "' data-type='" + obj.review_file_type + "'><div>";
            str += "<span>" + obj.review_file_name  + "</span>";
            str += "<p class='preview_close'><button type='button' data-file=\'" + fileCallPath + "\' data-type='image'><i class='fa fa-times'></i></button></p>";
            str += "<img src=" + fileCallPath + ">";
            str += "</div></span>";
          } else {
            console.log("****");
            var fileCallPath = "/resources/reviewBoardUpload/" + obj.review_uuid + "_" + encodeURIComponent(obj.review_file_name);
            var FileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
            str += "<span class='preview_box' data-uuid='" + obj.review_uuid + "' data-filename='" + obj.review_file_name + "' data-type='" + obj.review_file_type + "'><div>";
            str += "<span>" + obj.review_file_name  + "</span>";
            str += "<p class='preview_close'><button type='button' data-file=\'" + fileCallPath + "\' data-type='file'><i class='fa fa-times'></i></button></p>";
            str += "<img src='/resources/img/attach.png'>";
            str += "</div></span>";
          } // else end
        }); // uploadResultArr each end

        uploadUL.append(str);

      } // showUploadResult end
              // 파일삭제
              $(".file_preview").on("click","button",function(e){
                console.log("삭제버튼 클릭");

                let targetFile = $(this).data("file");
                  console.log("targetFile: " + targetFile);
                let type = $(this).data("type");
                  console.log("type: " + type);

                // 클릭한 x버튼의 부모중 가장 가까운 .preview_box
                let targetContent = $(this).closest(".preview_box");
                  console.log("targetContent: " + targetContent);

                $.ajax({
                  url: "/reviewboard/deleteFile",
                  type: "POST",
                  data: { fileName: targetFile, type: type },
                  success: function (response) {
                    // 성공적으로 삭제되면 섬네일을 DOM에서 제거
                    targetContent.remove();
                  }, //success
                  error: function(jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    console.error("Error deleting file:", error);
                  } //error
                }); // ajax
              }); //file_preview onclick(파일삭제버튼) end

              $("button[type='submit']").on("click", function(e){
                          // 첨부파일 정보 생성 후 submit 버튼 동작을 하기 위해 기본동작 막기
                          e.preventDefault();
                          console.log("submit btn click");
                                 // 제목, 내용 비어있는지 확인
                                                        let title = $("input[name='review_title']").val().trim();
                                                        let content = $("textarea[name='review_content']").val().trim();
                                                        let book_isbn = $("input[name='book_isbn']").val().trim();
                                                        if(title == "" || content == "" || book_isbn == ""){
                                                            alert("제목과 내용을 모두 입력해주세요.");
                                                            return false;
                                                        }
                          let formObj = $("form");
                          let str = "";

                          // 파일이 선택되었을 때만 파일 정보를 추가합니다.
                          if($(".preview_box").length > 0) {
                              $(".preview_box").each(function(i, obj){
                                  let jobj = $(obj);
                                  str += "<input type='hidden' name='attachList[" + i + "].review_file_name' value='" + jobj.data("filename") + "'>";
                                  str += "<input type='hidden' name='attachList[" + i + "].review_uuid' value='" + jobj.data("uuid") + "'>";
                                  str += "<input type='hidden' name='attachList[" + i + "].review_file_type' value='" + jobj.data("type") + "'>";
                              });
                          }
                            console.log(str)
                          formObj.append(str).submit();

                      }); // submit btn onclick end

    }); //script

  </script>
<body>

  <!-- ======= Top Bar ======= -->
  <jsp:include page="/WEB-INF/views/topbar.jsp"/>
  <!-- End Top Bar -->

  <%-- header --%>
  <jsp:include page="/WEB-INF/views/header.jsp"/>

  <main id="main" >
    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
        <div class="container">

            <div class="d-flex justify-content-between align-items-center">
                <h2>Setting</h2>
                <ol>
                    <li><a href="../mainpage/index">Home</a></li>
                    <li>Setting</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->

<%
session.setAttribute("member_id", "1");
%>
   <div class="container mt-4 reviewboard rv_insert" >
       <form action="/reviewboard/review_insert" method="post" enctype="multipart/form-data" class="insert_form">
           <div class="form-group">
               <label for="review_title">게시글 제목:</label>
               <input type="text" class="form-control" name="review_title" id="review_title" placeholder="제목을 입력해주세요.">
           </div>
           <div>

            </div>
           <div class="form-group">
               <label for="review_content">게시글 내용:</label>
              <textarea class="form-control" name="review_content" id="review_content" rows="5"   placeholder="내용을 입력해주세요."></textarea>
           </div>
               <div class="form-group">
                           <label for="book_isbn">book isbn:</label>
                          <input type="text" class="form-control" name="book_isbn" id="book_isbn"  placeholder="고유번호를 입력해주세요.">
                       </div>

           <div class="file_row">
                            <p>파일첨부</p>
                            <div class="file_box">
                                <div class="file_info">
                                   <input type="file" name="file" id="upload_btn" multiple>
                                   <label for="upload_btn">파일첨부</label>

                                </div>
                               <div class="file_preview"> </div>
                            </div>



           <input type="hidden" name="member_id" value="${member_id}">

           <p>${path}</p>
   </div>
   <div class="form-group btn_box">
                             <button type="submit" class="btn btn-primary">등록</button>
                             <a href="${pageContext.request.contextPath}/reviewboard/review_list3?page=1" class="btn btn-secondary">취소</a>
                         </div>
       </form>
</div>
</main>
  <script>
      window.onload = function() {
          // URL에서 쿼리 파라미터를 파싱하는 함수
          function getQueryParam(param) {
              var searchParams = new URLSearchParams(window.location.search);
              return searchParams.get(param);
          }

          // URL에서 'isbn' 쿼리 파라미터 값을 가져옵니다.
          var isbn = getQueryParam('isbn');

          // ISBN 값을 입력 필드에 설정합니다.
          if(isbn) {
              document.getElementById('book_isbn').value = isbn;
          }
      };
  </script>

  <!-- jQuery 추가 -->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
   <!-- Bootstrap JS 추가 -->
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- ======= Footer ======= -->
    <jsp:include page="/WEB-INF/views/footer.jsp"/>
    <!-- End Footer -->
   </body>
   </html>
</body>
</html>