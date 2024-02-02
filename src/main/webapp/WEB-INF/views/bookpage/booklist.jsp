<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>BookList</title>
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

    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Template Main CSS File -->
    <link href="../../../resources/assets/css/style.css" rel="stylesheet">

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

        .book-title-link {
            color: black; /* 제목 색상 변경 */
            text-decoration: none; /* 링크 밑줄 제거 */
        }

        .book-card:hover {
            transform: scale(1.05); /* 호버 시 카드 확대 */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
        }


        .book-search .input-group {
            margin: 30px auto;
            width: 100%;
        }

        #bookSearchForm .form-control {
            border-radius: 20px 0 0 20px;
            border: 2px solid #ddd;
        }

        .book-search .btn-primary {
            border-radius: 0 20px 20px 0;
            border: 2px solid #ddd;
            background-color: #5cb85c;
            color: white;
        }

        .book-search input.form-control:focus,
        .book-search .btn-primary:focus {
            outline: none;
            box-shadow: none;
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
                <h2>Book</h2>
                <ol>
                    <li><a href="../mainpage/index">Home</a></li>
                    <li>Book</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->

    <section id="about-us" class="about-us">
        <div class="container">
            <h3 data-aos="fade-up" class="text-center">도서 검색</h3>
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="book-search" data-aos="fade-right">
                        <!-- 도서 검색 폼 -->
                        <form id="bookSearchForm" onsubmit="return searchBooks($('#searchKeyword').val());">
                            <div class="input-group"> <!-- 검색창 크기 조정 -->
                                <input type="text" id="searchKeyword" placeholder="도서 검색" class="form-control">
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-primary">검색</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <hr>
        </div>
    </section>


    <section id="book-search-results" class="book-search-results">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>도서 검색 결과</h2>
            </div>

            <div class="row" id="searchResultsList">
                <!-- 검색 결과가 여기에 동적으로 로드됩니다. -->
            </div>
        </div>
    </section>


</main><!-- End #main -->

<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

<!-- Vendor JS Files -->
<script src="../../../resources/assets/vendor/aos/aos.js"></script>
<script src="../../../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../../../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="../../../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="../../../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="../../../resources/assets/vendor/waypoints/noframework.waypoints.js"></script>
<script src="../../../resources/assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="../../../resources/assets/js/main.js"></script>

<script>

    $(document).ready(function () {
        var urlParams = new URLSearchParams(window.location.search);
        var searchKeyword = urlParams.get('searchKeyword');
        if (searchKeyword) {
            searchBooks(searchKeyword);
        }
        // 가져온 키워드를 검색창에 설정합니다.
        if (searchKeyword) {
            $('#searchKeyword').val(searchKeyword);
        }
    });


    function searchBooks(keyword) {
        // var keyword = $('#searchKeyword').val();
        $.ajax({
            url: '/bookpage/book-search', // 컨트롤러의 엔드포인트 경로
            type: 'GET',
            data: {searchKeyword: keyword},
            success: function (books) {
                // 검색 결과를 booklist.jsp로 렌더링하는 로직
                renderBookList(books);
            },
            error: function () {
                alert("도서 검색에 실패했습니다.");
            }
        });
        return false; // 폼 제출 방지
    }

    function renderBookList(books) {
        var html = '';
        $.each(books, function (index, book) {
            html += '<div class="col-lg-4 col-md-6 mb-4">' +
                '<div class="card h-100 book-card">' + // 카드 호버 효과를 위한 클래스 추가
                '<div class="card-body">' +
                '<h5 class="card-title">' +
                '<a href="/bookpage/bookdetail/' + book.isbn + '" class="book-title-link">' + // 제목 색상 변경을 위한 클래스 추가
                '<strong>' + book.title + '</strong></a>' + // 제목 강조
                '</h5>' +
                '<h6>저자: ' + book.author + '</h6>' +
                '<p class="card-text">출판사: ' + book.publisher + '</p>' +
                '<p class="card-text">출판 연도: ' + book.year_of_publication + '</p>' +
                '<p class="card-text">ISBN: ' + book.isbn + '</p>' +
                '</div>' +
                '<div class="card-footer">' +
                '<small class="text-muted">세트 ISBN: ' + book.set_isbn + '</small><br>' +
                '<small class="text-muted">추가 기호: ' + book.additional_symbol + '</small><br>' +
                '<small class="text-muted">권수: ' + book.volume + '</small><br>' +
                '<small class="text-muted">분류 번호: ' + book.subject_classification_number + '</small>' +
                '</div>' +
                '</div>' +
                '</div>';
        });
        $('#searchResultsList').html(html);
    }


</script>
</body>
</html>