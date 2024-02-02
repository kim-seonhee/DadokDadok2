<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>다독다독</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="../../../resources/assets/img/favicon.png" rel="icon">
    <link href="../../../resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Muli:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">
    <!-- Vendor CSS Files -->
    <link href="../../../resources/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
    <link href="../../../resources/assets/css/style.css" rel="stylesheet">
    <style>
    .logo-link {
      display: flex;
      align-items: center;
      text-decoration: none; /* 링크 밑줄 제거 */
    }

    .logo-image {
      max-width: 300px; /* 로고 이미지 크기 조정 */
      height: auto; /* 이미지 높이 자동 조절 */
    }

    .logo-text {
      font-size: 24px; /* 로고 텍스트 크기 */
      font-weight: bold; /* 글씨 굵게 */
      color: #333; /* 글씨 색상 */
      /*margin-left: 5px; !* 이미지와 텍스트 간격 *!*/
    }
    .n_info {
        text-align: center;
    }
    .button-container {
        text-align: right;
    }
    .main {
      display: grid;
        place-items: center;
        min-height: 100dvh;
    }
    .edit {
        justify-content: center;
        margin-left: 20%;
        margin-right: 20%;
    }
    </style>
</head>
<body>

<!-- ======= Top Bar ======= -->
<jsp:include page="/WEB-INF/views/topbar.jsp"/>
<!-- End Top Bar -->

<!-- ======= Header ======= -->
<jsp:include page="/WEB-INF/views/header.jsp"/>
<!-- End Header -->
<main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h2>공지게시판</h2>
                <ol>
                    <li><a href="../mainpage/index.jsp">Home</a></li>
                    <li>공지게시판</li>
                </ol>
            </div>
        </div>
    </section><!-- End Breadcrumbs -->
<div class="center">
    <div class="n_info">
                <br><br>
                        <p style="font-size: 24px; font-weight: bold;">공지게시판</p>
                        <div>공지 글 작성 화면입니다.</div>
                        <br>
                    </div>
    <div class="edit">
    <form id="noticeboardForm" action="noticeboard_insert" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
        <div class="form-group">
            <label for="notc_title">제목</label>
            <input type="text" class="form-control" id="notc_title" name="notc_title" placeholder="제목을 입력하세요." required>
        </div>
        <br>
        <div class="form-group">
            <label for="notc_content">내용</label>
            <textarea class="form-control" id="notc_content" name="notc_content" rows="10" required></textarea>
        </div>
        <br>
        <div id="imagePreview"></div>
        <div class="form-group">
            <label for="file">파일 첨부: </label>
            <input type="file" id="file" name="file" onchange="previewImage(event)">
        </div>
        <br>
        상단에 고정<input type="checkbox" id="pinnedCheckbox" name="pinnedCheckbox" value="true">
        <input type="hidden" id="pinnedHidden" name="pinned" value="false">
        <br><br>
        <button type="submit" class="btn btn-primary">등록</button>
        <a href="noticeboard" class="btn btn-secondary">목록으로</a>
        <br><br>
    </form>
        </div>
    </div>
    </main><!-- End #main -->
                <!-- ======= Footer ======= -->
                <jsp:include page="/WEB-INF/views/footer.jsp"/>
                <!-- End Footer -->
</body>
<script>
    document.getElementById('pinnedCheckbox').addEventListener('change', function() {
        var hiddenInput = document.getElementById('pinnedHidden');
        if (this.checked) {
            hiddenInput.value = 'true'; // Set the value to 'true' when checked
        } else {
            hiddenInput.value = 'false'; // Set the value to 'false' when unchecked
        }
    });
    function previewImage(event) {
        var input = event.target;
        var reader = new FileReader();

        reader.onload = function() {
            var img = new Image();
            img.src = reader.result;
            img.onload = function() {
                var canvas = document.createElement('canvas');
                var ctx = canvas.getContext('2d');
                canvas.width = 150; // Set the width to your desired size
                canvas.height = 150; // Set the height to your desired size
                ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                document.getElementById('imagePreview').innerHTML = '';
                document.getElementById('imagePreview').appendChild(canvas);
            };
        };

        reader.readAsDataURL(input.files[0]);
    }
</script>
</html>
