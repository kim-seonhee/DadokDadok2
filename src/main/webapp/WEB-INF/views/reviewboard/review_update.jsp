<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/views/head.jsp"/>
  <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
  <script type="text/javascript">
    $(document).ready(function(){
        // 저장된 파일 불러오기
        (function(){
            let review_id = ${reviewUpdate.review_id}

            $.getJSON("getAttachList/?review_id=" + review_id, function(arr){
             //console.dir("arr: " + arr);

             let img_str = "";
             let file_str = "";
             let str = "";

             $(arr).each(function(i, attach){
                 // 이미지 파일인 경우 이미지 보여지기
                 //console.log("review_file_type(밖): "  + attach.review_file_type);
                 if(attach.review_file_type == "png" || attach.review_file_type == "jpg" || attach.review_file_type == "jpeg" || attach.review_file_type == "gif") {
                    let fileCallPath = "/resources/reviewBoardUpload/s_" + attach.review_uuid+ "_" + encodeURIComponent(attach.review_file_name);
                    // console.log("fileCallPath: " + fileCallPath);
                    // console.log("review_file_type(안): "  + attach.review_file_type);
                    str += "<span class='preview_box' data-uuid='" + attach.review_uuid + "' data-filename=" + attach.review_file_name + "' data-type='" + attach.review_file_type + "'><div><div class='p_title'>";
                    str += "<span>" + attach.review_file_name + "</span>";
                    str +="<p class='preview_close'><button type='button' data-file=\'" + fileCallPath + "\' data-type='image'><i class='fa fa-times'></i></button></p></div>";
                    str += "<img src='" + fileCallPath + "'></div></span>";
                    //console.log("img str :  " + img_str);
                    //$(".file_preview").html(img_str);
                } else {
                    // 이미지 파일이 아닌경우
                    //console.log("review_file_type(안2): "  + attach.review_file_type);
                     let fileCallPath = "/resources/reviewBoardUpload/" + attach.review_uuid + "_" + encodeURIComponent(attach.review_file_name);
                    str += "<span class='preview_box' data-uuid='" + attach.review_uuid + "' data-filename='" + attach.review_file_name + "' data-type='" + attach.review_file_type + "'><div><div class='p_title'>";
                    str += "<span>" + attach.review_file_name + "</span>";
                    str +="<p class='preview_close'><button type='button' data-file=\'" + fileCallPath + "\' data-type='image'><i class='fa fa-times'></i></button></p></div>";
                    str += "<img src='/resources/img/attach.png'></div></span>";
                   // $(".file_preview").html(file_str);
                } // else end
                $(".file_preview").html(str);
             }); // arr each end
             }); // getJSON end
        })(); // function end

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

          $("input[type='file']").change(function(e) {
            let formData = new FormData(); //key-value 형태의 데이터 쌍을 저장하는 객체
            let inputFile = $("input[name='file']");
            let files = inputFile[0].files; // 선택한 파일 목록 가져옴
            //console.log("files: " + files);

            // 파일데이터 폼에 집어넣기
            for (let i = 0; i < files.length; i++) {
              if (!checkExtension(files[i].name, files[i].size)) {
                return false;
              }
              formData.append("file", files[i]);
            } //for

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

                                   let formObj = $("form");
                                   let formData = new FormData(formObj[0]);
                                   let reviewId = ${reviewUpdate.review_id};
                                   let str = "";

                                    // 파일 하나당 이름, uuid, type 정보를 FormData에 담기
                                    console.log( $(".preview_box"));
                                    $(".preview_box").each(function(i, obj){
                                                 let jobj = $(obj);
                                                 formData.append('attachList[' + i + '].review_id', reviewId);
                                                 formData.append('attachList[' + i + '].review_file_name', jobj.data("filename"));
                                                 formData.append('attachList[' + i + '].review_uuid', jobj.data("uuid"));
                                                 formData.append('attachList[' + i + '].review_file_type', jobj.data("type"));
                                    }); // preview_box each end
                                    for (let key of formData.keys()){
                                        console.log(key, ":", formData.get(key));
                                    }

                                    // AJAX를 사용하여 폼 데이터와 함께 PUT 요청을 서버로 전송
                                                $.ajax({
                                                  url: formObj.attr('action'), // form의 action 속성 값 사용
                                                  type: 'post',
                                                  data: formData,
                                                  processData: false, // FormData를 사용할 때는 processData와 contentType을 false로 설정
                                                  contentType: false,
                                                  success: function(response) {
                                                    console.log('서버 응답:', response);
                                                    window.location.href = "/reviewboard/review_one?review_id=" + reviewId;
                                                  },
                                                  error: function(xhr, status, error) {
                                                    console.error('에러 발생:', error);
                                                    // 에러 처리 로직
                                                  }
                                                }); // ajax end

                                     console.log(str)
                                   //formObj.append(str).submit();



                               }); // submit btn onclick end

             }); //script


  </script>
<body>
    <!-- ======= Top Bar ======= -->
    <jsp:include page="/WEB-INF/views/topbar.jsp"/>
    <!-- End Top Bar -->

    <main>
        <!-- ======= Breadcrumbs ======= -->
        <section id="breadcrumbs" class="breadcrumbs">
            <div class="container">
                 <div class="d-flex justify-content-between align-items-center">
                      <h2>독서후기게시판</h2>
                      <ol>
                          <li><a href="../mainpage/index">Home</a></li>
                          <li>자유게시판</li>
                      </ol>
                 </div>
            </div>
        </section><!-- End Breadcrumbs -->
<section class="reviewboard">
    <div class="container">
        <div class="b_info">
            <h2>후기게시판 게시글 수정</h2>
            <p>공포심, 불안감 또는 불쾌감을 유발할 수 있는 게시물 작성은 금지합니다.</p>
        </div>
        <form action="/reviewboard/review_update" method="post" class="insert_form" enctype="multipart/form-data">
            <input type="hidden" name="review_id" value="${reviewUpdate.review_id}">
            <div class="mb-3">
                <label for="review_title" class="form-label">제목:</label>
                <input type="text" class="form-control" id="review_title" name="review_title" value="${reviewUpdate.review_title}">
            </div>
            <div class="mb-3">
                <label for="review_content" class="form-label">내용:</label>
                <textarea class="form-control" id="review_content" name="review_content">${reviewUpdate.review_content}</textarea>
            </div>
         <p>파일첨부</p>
         <div class="file_box">
               <div class="file_info">
                    <input type="file" name="file" id="upload_btn" multiple>
                    <label for="upload_btn">파일선택</label>
                    <div> png, jpg, jpeg, gif, pdf, doc/docx, xls/xlsx, ppt/pptx 만 업로드 가능합니다.</div>
               </div>
            <div class="file_preview"> </div>
         </div>
            <div class="in_btn">
                <button type="submit" class="btn btn-primary">수정완료</button>
                <a href="${pageContext.request.contextPath}/reviewboard/review_list3?page=1" class="btn btn-secondary">취소하기</a>
            </div>
        </form>
    </div>
</section>
    </main>
    <!-- ======= Footer ======= -->
    <jsp:include page="/WEB-INF/views/footer.jsp"/>
    <!-- End Footer -->
</body>
</html>
