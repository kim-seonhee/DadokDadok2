<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
    <meta charset="UTF-8">
    <title>다독다독 도서관 정보</title>

    <!-- 부트스트랩 및 자바스크립트 CDN -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=feb6a3c31b035f2a61bd30ac29509330&libraries=services"></script>

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

    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Template Main CSS File -->
    <link href="../../../resources/assets/css/style.css" rel="stylesheet">




    <style>
        /*.container {*/
        /*    margin-top: 20px;*/
        /*}*/

        .container2 {
            display: flex;
            justify-content: center;
            /* 가로 중앙 정렬 */

        }

        .left-panel,
        .right-panel {
            flex: 1;
            border: 0px solid #ccc;
            padding: 20px;
        }

        .pages {
            margin: 5px;
        }
        .hidden-column {
            display: none;
        }
        .custom-width-15 {
            width: 15%;
        }
        .custom-width-30 {
            width: 30%;
        }
        .custom-width-40 {
            width: 40%;
        }

        #map {
            width: 100%;
            height: 350px;
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

    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
        <div class="container">

            <div class="d-flex justify-content-between align-items-center">
                <h2>도서관 찾기</h2>
                <ol>
                    <li><a href="../mainpage/index">Home</a></li>
                    <li>Library</li>
                </ol>
            </div>
        </div>
    </section>
    <!-- End Breadcrumbs -->

    <div class="container">
        DB 저장 완료
        <br>
        <button type="button" class="btn btn-primary">
            <a href="/library_admin" style="color: white; text-decoration: none;">
                도서 관리자 페이지로 이동
            </a>
        </button>
        <br><br><br>
    </div>


    </div>



    <!-- ======= Footer ======= -->
    <jsp:include page="/WEB-INF/views/footer.jsp"/>
    <!-- End Footer -->
</body>

</html>