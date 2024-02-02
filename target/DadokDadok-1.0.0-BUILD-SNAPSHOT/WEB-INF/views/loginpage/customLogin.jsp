<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Optional JavaScript; choose one of the two! -->
    <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>


    <!-- Favicons -->
    <link href="../resources/assets/img/favicon.png" rel="icon">
    <link href="../resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Muli:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="../resources/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="../resources/assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="../resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="../resources/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="../resources/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="../resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="../resources/assets/css/style.css" rel="stylesheet">

  <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">

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

        .form-signin {
            width: 100%;
            max-width: 330px;
            padding: 15px;
            margin: auto;
        }

        /* 푸터를 화면 하단에 고정 */
        #footer {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100%;
            /* 푸터의 높이 및 기타 스타일링을 여기에 추가하세요 */
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
                <h2>Login</h2>
                <ol>
                    <li><a href="index.jsp">Home</a></li>
                    <li>Login</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= 설정 섹션 시작 ======= -->
    <section id="login" class="login">
        <div class="container">
            <form class="form-signin" action="/perform_login" method="post">
<%--                <h1 class="h3 mb-3 font-weight-normal">Login</h1>--%>
                <h2><c:out value="${error}"/></h2>
                <h2><c:out value="${logout}"/></h2>

                <label for="email" class="sr-only">이메일</label>
                <input type="text" id="email" name="email" class="form-control" placeholder="이메일" required autofocus>

                <label for="password" class="sr-only">비밀번호</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호" required>

                <div class="checkbox mb-3">
                    <label>
                        <input type="checkbox" name="remember-me"> 자동로그인
                    </label>
                </div>

                <button class="btn btn-lg btn-primary btn-block" type="submit">로그인하기</button>
                <button class="btn btn-lg btn-secondary btn-block" onclick="location.href='/loginpage/signup'">회원가입
                </button>


                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
            </form>


            <c:if test="${url ne null}">
                <div id="naver_id_login" class="mt-3">
                    <a href="${url}"><img width="223"
                                          src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a>
                </div>
            </c:if>
        </div>

    </section>
</main><!-- End #main -->

<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

<!-- Vendor JS Files -->
<script src="../resources/assets/vendor/aos/aos.js"></script>
<script src="../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="../resources/assets/vendor/waypoints/noframework.waypoints.js"></script>
<script src="../resources/assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="../resources/assets/js/main.js"></script>

</body>
</html>
