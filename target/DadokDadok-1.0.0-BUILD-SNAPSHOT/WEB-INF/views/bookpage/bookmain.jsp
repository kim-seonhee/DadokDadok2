<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>BookMain</title>
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

        /* 추천 도서 카드 스타일링 */
        .hotTrend-books .card, .popular-books .card {
            transition: transform .2s; /* 호버 시 애니메이션 효과 */
            cursor: pointer; /* 마우스 포인터 모양 변경 */
        }

        /* 호버 효과 */
        .hotTrend-books .card:hover, .popular-books .card:hover {
            transform: scale(1.05); /* 카드 확대 */
        }

        /* 호버 시 그림자 효과 */
        .hotTrend-books .card:hover, .popular-books .card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* 미디어 쿼리를 사용하여 반응형으로 한 줄에 3개씩 표시 */
        @media (min-width: 992px) {
            .hotTrend-books .col-lg-4, .popular-books .col-lg-4 {
                flex: 0 0 33.333333%;
                max-width: 33.333333%;
            }
        }

        @media (max-width: 991px) {
            .hotTrend-books .col-lg-4, .popular-books .col-lg-4 {
                flex: 0 0 50%;
                max-width: 50%;
            }
        }

        @media (max-width: 767px) {
            .hotTrend-books .col-lg-4, .popular-books .col-lg-4 {
                flex: 0 0 100%;
                max-width: 100%;
            }
        }

        /* Custom CSS for five items per row */
        @media (min-width: 992px) {
            /* lg breakpoint */
            .col-custom-five {
                flex: 0 0 auto;
                width: 20%;
            }
        }

        .date-header {
            text-align: center;
        }

        .carousel {
            margin-bottom: 30px; /* 캐러셀과 다음 컨텐츠 사이의 간격 */
        }

        .carousel-indicators {
            bottom: -50px; /* 기본값에서 조정할 수 있습니다 */
        }

        .carousel-control-prev, .carousel-control-next {
            position: absolute;
            top: 50%; /* 중앙 정렬 */
            transform: translateY(-50%); /* Y축 기준 중앙 */
            width: auto; /* 기본 너비 설정 해제 */
            height: auto; /* 기본 높이 설정 해제 */
        }

        .carousel-control-prev {
            left: -50px; /* 왼쪽 화살표 위치 조정 */
        }

        .carousel-control-next {
            right: -50px; /* 오른쪽 화살표 위치 조정 */
        }


        .search-form .input-group {
            margin: 30px auto;
            width: 100%;
        }

        .search-form input.form-control {
            border-radius: 20px 0 0 20px;
            border: 2px solid #ddd;
        }

        .search-form .btn-primary {
            border-radius: 0 20px 20px 0;
            border: 2px solid #ddd;
            background-color: #5cb85c;
            color: white;
        }

        .search-form input.form-control:focus,
        .search-form .btn-primary:focus {
            outline: none;
            box-shadow: none;
        }

        .book-card {
            position: relative;
            max-width: 200px; /* Adjust the width as needed */
            margin: auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            overflow: hidden;
        }

        .carousel-inner img {
            width: 100%;
            height: auto; /* Adjust the height as needed */
        }

        .carousel-caption {
            background: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
            color: white;
            padding: 10px;
            border-radius: 0 0 10px 10px;
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100%;
        }

        /* Adjustments for smaller screens */
        @media (max-width: 768px) {
            .book-card {
                max-width: 100%;
            }
        }

        .carousel-gender-buttons {
            position: absolute;
            top: -60px; /* Adjust this value as needed to move the buttons above the carousel */
            right: 10px;
            z-index: 3; /* Ensure buttons are above carousel content */
        }

        .btn-gender {
            margin-left: 5px;
            opacity: 0.7;
            border: none;
            color: white;
            background-color: #6c757d; /* 기본 색상 */
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s;
        }

        .btn-gender:hover,
        .btn-gender.active { /* 호버 또는 활성화된 버튼에 대한 스타일 */
            opacity: 1;
            background-color: #007bff; /* 활성화 또는 호버 시 색상 */
        }

        /* 남성 버튼에 대한 추가 스타일 (선택적) */
        .btn-male.active {
            background-color: #007bff;
        }

        /* 여성 버튼에 대한 추가 스타일 (선택적) */
        .btn-female.active {
            background-color: #dc3545;
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
                        <form action="/bookpage/booklist" method="get" class="search-form">
                            <div class="input-group">
                                <input type="text" name="searchKeyword" placeholder="도서 검색" class="form-control">
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


    <section id="hotTrend-books" class="hotTrend-books section-bg">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>대출 급상승 <strong>도서</strong></h2>
                <p>3일간 대출빈도가 급상승한 도서입니다</p>
            </div>
            <!-- 캐러셀 슬라이드 -->
            <div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active"
                            aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1"
                            aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2"
                            aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active" data-bs-interval="10000">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>First slide label</h5>
                            <p>Some representative placeholder content for the first slide.</p>
                        </div>
                    </div>
                    <div class="carousel-item" data-bs-interval="2000">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>Second slide label</h5>
                            <p>Some representative placeholder content for the second slide.</p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>Third slide label</h5>
                            <p>Some representative placeholder content for the third slide.</p>
                        </div>
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark"
                        data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark"
                        data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
    </section>

    <section id="popular-books" class="popular-books">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>TOP 10 <strong>도서</strong></h2>
                <p>독자들에게 가장 사랑받는 도서들을 소개합니다.</p>
            </div>

            <!-- 캐러셀 슬라이드 -->
            <div id="carouselExample" class="carousel carousel-dark slide" data-bs-ride="carousel">
                <!-- Gender Buttons -->
                <div class="carousel-gender-buttons">
                    <button type="button" class="btn btn-gender btn-male active" aria-label="Male">남성</button>
                    <button type="button" class="btn btn-gender btn-female" aria-label="Female">여성</button>
                </div>
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active"
                            aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1"
                            aria-label="Slide 2"></button>
                </div>

                <!-- Carousel 내부 아이템 -->
                <div class="carousel-inner" id="bookCarouselInner">
                    <!-- 도서 아이템이 여기에 동적으로 삽입됩니다 -->
                </div>
                <!-- Carousel 컨트롤 -->
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample"
                        data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExample"
                        data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                </button>
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
    var authKey = 'c500550c260a842b762bc86dc21ee159406d97cfdc35d10d71726d7a7d998b6b';

    function formatDate(date) {
        var d = new Date(date);
        d.setDate(d.getDate() - 3); // 하루 전 날짜로 설정

        var month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }

    function increaseDateByOne(dateString) {
        var date = new Date(dateString);
        date.setDate(date.getDate() + 3); // 날짜에 1을 더합니다.

        var month = '' + (date.getMonth() + 1),
            day = '' + date.getDate(),
            year = date.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }


    function fetchHotTrendBooks() {
        var searchDt = formatDate(new Date()); // 오늘 날짜를 'yyyy-mm-dd' 형식으로 설정
        $.ajax({
            url: 'http://data4library.kr/api/hotTrend',
            type: 'GET',
            data: {
                authKey: authKey,
                searchDt: searchDt,
                format: 'json'
            },
            success: function (response) {
                var results = response.response.results; // results 배열입니다.
                // var html = '';
                var todayHtml = '', yesterdayHtml = '', twoDaysAgoHtml = '';

                // results 배열을 순회합니다.
                results.forEach(function (resultElement) {
                    var html = '';
                    var date = resultElement.result.date // 날짜 정보
                    var docs = resultElement.result.docs; // docs 배열
                    var realdate = increaseDateByOne(resultElement.result.date) // 날짜 정보
                    html += '<div class="row">';
                    html += '<div class="date-header text-center"><h4>' + realdate + '</h4></div>'; // 날짜별 제목을 추가합니다.
                    // docs 배열을 순회합니다.
                    for (var i = 0; i < docs.length && i < 5; i++) { // 하루에 최대 5권까지만 가져옵니다.
                        var book = docs[i].doc; // doc 객체 안의 책 정보
                        html += '<div class="col-custom-five mb-4">' +
                            '<a href="/bookpage/bookdetail/' + book.isbn13 + '" class="book-card-link">' + // 클릭 시 이동할 링크를 추가합니다.
                            '<div class="card h-100 book-card">' +
                            '<img src="' + book.bookImageURL + '" class="card-img-top" alt="' + book.bookname + '">' +
                            '<div class="card-body">' +
                            '<h5 class="card-title book-title">' + book.bookname + '</h5>' +
                            '<p class="card-text">' + book.authors + '</p>' +
                            '<p class="card-text">' + book.publisher + ', ' + book.publication_year + '</p>' +
                            '<p class="card-text">' + book.class_no + '</p>' +
                            '<p class="card-text">' + book.class_nm + '</p>' +
                            '</div>' +
                            '</div>' +
                            '</a>' +
                            '</div>';
                    }

                    var today = formatDate(new Date());
                    var yesterday = formatDate(new Date(new Date().setDate(new Date().getDate() - 1)));
                    var twoDaysAgo = formatDate(new Date(new Date().setDate(new Date().getDate() - 2)));

                    if (date === today) {
                        todayHtml += html;
                    } else if (date === yesterday) {
                        yesterdayHtml += html;
                    } else if (date === twoDaysAgo) {
                        twoDaysAgoHtml += html;
                    }

                });

                // 캐러셀 아이템에 HTML 삽입
                $('#carouselExampleDark .carousel-inner .carousel-item:first-child').html(todayHtml);
                $('#carouselExampleDark .carousel-inner .carousel-item:nth-child(2)').html(yesterdayHtml);
                $('#carouselExampleDark .carousel-inner .carousel-item:nth-child(3)').html(twoDaysAgoHtml);
            },
            error: function () {
                alert("급상승 도서를 불러오는 데 실패했습니다.");
            }
        });
    }

    // 성별 버튼 클릭 이벤트 핸들러
    $('.btn-gender').on('click', function () {
        var gender = $(this).hasClass('btn-male') ? '0' : '1';
        fetchBooksByGender(gender);
        $('.btn-gender').removeClass('active');
        $(this).addClass('active');
    });

    // 성별에 따른 도서 목록 가져오기
    function fetchBooksByGender(gender) {
        $.ajax({
            url: 'https://data4library.kr/api/loanItemSrch',
            type: 'GET',
            data: {
                authKey: authKey,
                gender: gender,
                pageNo: '1',
                pageSize: '10',
                format: 'json'
            },
            success: function(response) {
                var docs = response.response.docs;
                var html = '';
                var itemsPerSlide = 5;
                var carouselIndicatorsHtml = '';

                // Loop through books and create carousel items
                for (var i = 0; i < docs.length; i += itemsPerSlide) {
                    var activeClass = i === 0 ? 'active' : '';
                    html += '<div class="carousel-item ' + activeClass + '"><div class="container"><div class="row">';

                    // Loop to create up to 5 book cards inside each carousel item
                    for (var j = i; j < i + itemsPerSlide && j < docs.length; j++) {
                        var book = docs[j].doc;
                        html += '<div class="col-custom-five mb-4">' +
                            '<a href="/bookpage/bookdetail/' + book.isbn13 + '" class="book-card-link">' +
                            '<div class="card h-100 book-card">' +
                            '<img src="' + book.bookImageURL + '" class="card-img-top" alt="' + book.bookname + '">' +
                            '<div class="card-body">' +
                            '<h5 class="card-title book-title">' + book.bookname + '</h5>' +
                            '<p class="card-text">' + book.authors + '</p>' +
                            '<p class="card-text">' + book.publisher + ', ' + book.publication_year + '</p>' +
                            '<p class="card-text">' + book.class_no + '</p>' +
                            '<p class="card-text">' + book.class_nm + '</p>' +
                            '</div>' +
                            // Add a new paragraph element to display the ranking
                            '<div class="card-footer">' +
                            '<small class="text-muted">Ranking: ' + book.ranking + '</small>' +
                            '</div>' +
                            '</div></a></div>';
                    }
                    html += '</div></div></div>';

                    // Add carousel indicators
                    carouselIndicatorsHtml += '<button type="button" data-bs-target="#carouselExample" data-bs-slide-to="' + (i / itemsPerSlide) + '" class="' + (i === 0 ? 'active' : '') + '" aria-current="true" aria-label="Slide ' + (i / itemsPerSlide + 1) + '"></button>';
                }

                // Insert HTML into the carousel
                $('#carouselExample .carousel-inner').html(html);
                $('#carouselExample .carousel-indicators').html(carouselIndicatorsHtml);

                // Initialize or refresh carousel here if needed
            },

            error: function () {
                alert("도서 정보를 불러오는 데 실패했습니다.");
            }
        });
    }


    // CSS for hover effects
    $(document).ready(function () {
        $('head').append('<style>' +
            '.book-card:hover .book-title { color: #007bff; }' +
            '.book-card:hover { box-shadow: 0 5px 15px rgba(0,0,0,.1); transform: translateY(-2px); }' +
            '</style>');
    });

    $(document).ready(function () {
        fetchHotTrendBooks();
        fetchBooksByGender();
    });

</script>


</body>
</html>