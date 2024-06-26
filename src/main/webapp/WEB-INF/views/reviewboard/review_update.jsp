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
// isbn 검색
    function bookSearch() {
        let bookName = $("#bookName").val();

        $.ajax({
            url: "/reviewboard/searchBook",
            method: "GET",
            data: {bookName: bookName},
            success: function (data) {
                let html = "";
                data.documents.forEach(doc => {
                    html += "<div class='r_row'>";
                    html += "<div class='r_left'><p class='r_title'>책 이름: " + doc.title + "</p>";
                    html += "<p>지은이: " + doc.authors + "</p>";
                    html += "<p>ISBN: <button type='button' data-bs-dismiss='modal' aria-label='Close' id='isbn_result'>" + doc.isbn.slice(-13) + "</span></p></div>";
                    html += "<div class='r_right'><img src='" + doc.thumbnail +"'/></div>"
                    html += "</div>";
                });
                $("#search_result").html(html);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error("AJAX request failed: " + textStatus, errorThrown);
            }
        }); // end ajax
    } // end bookSearch

    // 검색한 isbn 클릭시 input에 입력
    $(document).on("click", "#isbn_result", function () {
        // 클릭된 div 태그에서 ISBN 값을 가져옴
        let isbn = $(this).text();

        // 가져온 ISBN을 #isbnText에 넣음
        $("#isbnText").val(isbn);

        // 검색어, 결과 초기화
        $("#bookName").val("");
        $("#search_result").empty();
    });

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

            let id = ${reviewBoardVO.review_id};

            // 제목, 내용 비어 있는지 확인
            let title = $("input[name='review_title']").val().trim();
            let content = $("textarea[name='review_content']").val().trim();
            let isbn = $("input[name='book_isbn']").val().trim();
            if (title == "" || content == "" || isbn == "") {
                alert("제목, 내용, ISBN은 필수 입력 사항입니다.");
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
            formData.append('review_id', $("input[name='review_id']").val());
            formData.append('review_title', $("input[name='review_title']").val()); // 제목 추가
            formData.append('review_content', $("input[name='review_content']").val()); // 내용 추가
            formData.append('member_id', $("input[name='member_id']").val());

            $.ajax({
                type: "POST",
                url: "/reviewboard/review_update",
                data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                    alert("게시글 수정이 완료 되었습니다.");
                    window.location.href = "/reviewboard/review_one?review_id=" + data;
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert("게시글 수정 중 오류가 발생 하였습니다.");
                }
            });
        }); // submit btn onclick end
    }); //script



</script>
<body>
<%-- 모달 --%>
<div class="modal fade isbn_modal" id="staticBackdrop" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">ISBN 검색</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="search_title">
                    <input type="text" id="bookName" placeholder="책 이름이나 지은이를 입력하세요.">
                    <button type="button" onclick="bookSearch()" class="btn btn-primary">검색</button>
                </div>
                <div id="search_result">
                </div>
            </div>
        </div>
    </div>
</div>
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
    </section><!-- End Breadcrumbs -->
    <section class="freeboard">
        <div class="b_info">
            <p>후기게시판 게시글 수정</p>
            <div>공포심, 불안감 또는 불쾌감을 유발할 수 있는 게시물 작성은 금지합니다.</div>
        </div>
        <form action="/reviewboard/review_update" method="post" enctype="multipart/form-data"  class="insert_form">
            <input type="hidden" name="review_id" value="${reviewBoardVO.review_id}">
            <div class="in_row">
                <p>제 목:</p>
                <input type="text" name="review_title" value="${reviewBoardVO.review_title}" maxlength="50">
            </div>
            <div class="in_row">
                <p>내 용:</p>
                <textarea name="review_content" maxlength="2000">${reviewBoardVO.review_content}</textarea>
            </div>
            <div class="in_row isbn_row">
                <p>ISBN:</p>
                <input type="text" name="book_isbn" id="isbnText" maxlength="13" value="${reviewBoardVO.book_isbn}">
                <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#staticBackdrop">ISBN 검색
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
                <a href="${pageContext.request.contextPath}/review/review_list">취소하기</a>
            </div>
        </form>
    </section>
</main>
<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->
</body>
</html>
