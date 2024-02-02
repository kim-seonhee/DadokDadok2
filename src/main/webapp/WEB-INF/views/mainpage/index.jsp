<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">


<jsp:include page="/WEB-INF/views/head.jsp"/>


<!-- Vendor JS Files -->
<link href="../../../resources/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
<script src="../../../resources/assets/vendor/aos/aos.js"></script>
<script src="../../../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../../../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="../../../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="../../../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="../../../resources/assets/vendor/waypoints/noframework.waypoints.js"></script>
<script src="../../../resources/assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="../../../resources/assets/js/main.js"></script>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

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
</style>
<body>

<!-- ======= Top Bar ======= -->
<jsp:include page="/WEB-INF/views/topbar.jsp"/>
<!-- End Top Bar -->

<!-- ======= Header ======= -->
<jsp:include page="/WEB-INF/views/header.jsp"/>
<!-- End Header -->


<!-- ======= Hero Section ======= -->
<section id="hero">
    <!-- 도서 검색 -->
    <div class="book_search">
        <form action="/bookpage/booklist" method="get" class="search-form">
            <div>
                <input type="text" name="searchKeyword" placeholder="원하는 독서 후기를 검색해보세요!" class="form-control">
                <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
            </div>
        </form>
    </div>
</section><!-- End Hero -->


<main id="main">
    <div id="heroCarousel" data-bs-interval="5000" class="carousel slide carousel-fade library_slide"
         data-bs-ride="carousel">

        <div class="carousel-inner" role="listbox">

            <!-- Slide 1 -->
            <div class="carousel-item active test">
                <div class="carousel-container">
                    <%--                    <div class="carousel-content animate__animated animate__fadeInUp">--%>
                    <div class="carousel-content animate__animated animate__fadeInLeft">
                        <div class="library_slide_inner">
                            <div class="lb_row">
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=121008">부산광역시립시민도서관</a></p>
                                        <p>부산광역시 부산진구 월드컵대로 462</p>
                                        <p>051-810-8200</p>
                                        <p><a href="https://home.pen.go.kr/siminlib" target="_blank">https://home.pen.go.kr/siminlib</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=50001">국립세종도서관</a></p>
                                        <p>세종특별자치시 다솜3로 48</p>
                                        <p>044-900-9114</p>
                                        <p><a href="http://sejong.nl.go.kr/"
                                              target="_blank">http://sejong.nl.go.kr/</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                            </div>
                            <%-- end lb_row --%>
                            <div class="lb_row">
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=141010">경기중앙교육도서관</a></p>
                                        <p>경기도 수원시 장안구 조원로 18</p>
                                        <p>031-240-4064</p>
                                        <p><a href="https://lib.goe.go.kr/gg/"
                                              target="_blank">https://lib.goe.go.kr/gg/</a></p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=141008">경기성남교육도서관</a></p>
                                        <p>경기도 성남시 수정구 공원로370번길 26</p>
                                        <p>031-730-3500</p>
                                        <p><a href="https://lib.goe.go.kr/sn/index.do" target="_blank">https://lib.goe.go.kr/sn/index.do</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                            </div>
                            <%-- end lb_row --%>
                        </div>
                        <%-- end library_slide_inner --%>

                        <%--                        </div>--%>
                    </div>
                </div>
            </div>

            <!-- Slide 2 -->
            <div class="carousel-item">
                <div class="carousel-container">
                    <div class="carousel-content animate__animated animate__fadeInLeft">
                        <div class="library_slide_inner">
                            <div class="lb_row">
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=141004">경기과천교육도서관</a></p>
                                        <p>경기도 과천시 도서관길 36</p>
                                        <p>02-3677-0371</p>
                                        <p><a href="https://lib.goe.go.kr/kwa/" target="_blank">https://lib.goe.go.kr/kwa/</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=125003">한밭도서관</a></p>
                                        <p>대전광역시 중구 서문로 10</p>
                                        <p>042-270-7420</p>
                                        <p><a href="https://www.daejeon.go.kr/hanbatlibrary" target="_blank">https://www.daejeon.go.kr/hanbatlibrary</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                            </div>
                            <%-- end lb_row --%>
                            <div class="lb_row">
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=141141">경기평생교육학습관</a></p>
                                        <p>경기도 수원시 권선구 권중로 55</p>
                                        <p>031-259-1028</p>
                                        <p><a href="https://lib.goe.go.kr/gglec/" target="_blank">https://lib.goe.go.kr/gglec/</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=111010">서울특별시교육청남산도서관</a></p>
                                        <p>서울특별시 용산구 소월로 109</p>
                                        <p>02-754-7338</p>
                                        <p><a href="http://nslib.sen.go.kr/" target="_blank">http://nslib.sen.go.kr/</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                            </div>
                            <%-- end lb_row --%>
                        </div>
                        <%-- end library_slide_inner --%>
                    </div>
                </div>
            </div>

            <!-- Slide 3 -->
            <div class="carousel-item">
                <div class="carousel-container">
                    <div class="carousel-content animate__animated animate__fadeInLeft">
                        <div class="library_slide_inner">
                            <div class="lb_row">
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=123001">미추홀도서관</a></p>
                                        <p>인천광역시 남동구 인주대로776번길 53</p>
                                        <p>032-462-3900</p>
                                        <p><a href="https://www.michuhollib.go.kr/" target="_blank">https://www.michuhollib.go.kr/</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=141019">광명시하안도서관</a></p>
                                        <p>경기도 광명시 철망산로 46</p>
                                        <p>02-2680-2871</p>
                                        <p><a href="https://gmlib.gm.go.kr/" target="_blank">https://gmlib.gm.go.kr/</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                            </div>
                            <%-- end lb_row --%>
                            <div class="lb_row">
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=143015">제천시립도서관</a></p>
                                        <p>충청북도 제천시 내제로 318</p>
                                        <p>043-646-2019</p>
                                        <p><a href="https://www.jecheon.go.kr/jclib/index.do" target="_blank">https://www.jecheon.go.kr/jclib/index.do</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                                <div class="lb_content">
                                    <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                    <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=126157">부산도서관</a></p>
                                        <p>부산광역시 사상구 사상로310번길 33</p>
                                        <p>051-310-5400</p>
                                        <p><a href="https://library.busan.go.kr" target="_blank">https://library.busan.go.kr</a>
                                        </p>
                                    </div>
                                </div>
                                <%-- end lb_content --%>
                            </div>
                            <%-- end lb_row --%>
                        </div>
                        <%-- end library_slide_inner --%>
                    </div>
                </div>
            </div>


        </div>
        <a class="carousel-control-prev" href="#heroCarousel" role="button" data-bs-slide="prev">
          <span class="carousel-control-prev-icon bx bx-left-arrow" aria-hidden="true">
              <i class="fas fa-chevron-left"></i>
          </span>
        </a>

        <a class="carousel-control-next" href="#heroCarousel" role="button" data-bs-slide="next">
          <span class="carousel-control-next-icon bx bx-right-arrow" aria-hidden="true">
              <i class="fas fa-chevron-right"></i>
          </span>
        </a>

        <ol class="carousel-indicators" id="hero-carousel-indicators">
            <li data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></li>
            <li data-bs-target="#heroCarousel" data-bs-slide-to="1" aria-label="Slide 2"></li>
            <li data-bs-target="#heroCarousel" data-bs-slide-to="2" aria-label="Slide 3"></li>
        </ol>


    </div>

    <!-- ======= board Section ======= -->
    <section id="board" class="board">
        <div class="container">
            <div class="b_inner">
                <div class="b_title">
                    <p>공지 게시판</p>
                    <a href="/noticeboard"><i class="bx bx-plus"></i></a>
                </div>
                <div class="nb_list b_list">
                    <c:forEach items="${noticeBoardList}" var="notice">
                        <div>
                            <!-- 공지사항 제목에 링크 적용. 링크는 각 공지사항의 ID를 포함합니다. -->
                            <p><a href="/noticeboard/noticeboard_one?notc_id=${notice.notc_id}">${notice.notc_title}</a>
                            </p>
                            <p><fmt:formatDate value="${notice.notc_createdAt}" pattern="yyyy-MM-dd"/></p>
                        </div>
                    </c:forEach>
                </div>

            </div>
            <%-- end notice_board --%>
            <div class="b_inner">
                <div class="b_title">
                    <p>자유 게시판</p>
                    <a href="/freeboard/board_list"><i class="bx bx-plus"></i></a>
                </div>
                <div class="fb_list b_list">
                    <c:forEach items="${freeBoardList}" var="freeboard">
                        <div>
                            <p>
                                <a href="/freeboard/board_one?board_id=${freeboard.board_id}">${freeboard.board_title}</a>
                            </p>
                            <p>${freeboard.nickname}</p>
                            <p><fmt:formatDate pattern="yyyy-MM-dd" value="${freeboard.board_createdAt}"/></p>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <%-- end free_board --%>
        </div>
        <%-- end container --%>
    </section> <!-- End board Section -->

    <!-- ======= review Section ======= -->
    <section id="review" class="review portfolio"> <%-- class portfolio  지우면 안됨 --%>
        <div class="container">
            <div class="rv_title">후기 게시판</div>
            <div class="portfolio-container" data-aos="fade-up">

            </div>
            <%-- container --%>
    </section><!-- End review Section -->
</main><!-- End #main -->

<script>
    $(document).ready(function () {
        $.ajax({
            url: '/mainpage/review-list',
            type: 'GET',
            success: function (reviews) {
                reviews.forEach(function (review) {
                    var contentShort = review.review_content.substring(0, 50) + '...';
                    var reviewDate = new Date(review.review_createdAt).toLocaleDateString();
                    var reviewLink = '/reviewboard/review_one?review_id=' + review.review_id;

                    $('.portfolio-container').append(
                        '<div class="col-md-4 portfolio-item">' +
                        '<div class="review-item">' +
                        '<a href="' + reviewLink + '" class="review-title-link">' + review.review_title + '</a>' +
                        '<div class="review-date">' + reviewDate + '</div>' +
                        '<p class="review-content">' + contentShort + '</p>' +
                        '</div>' +
                        '</div>'
                    );
                });
            },
            error: function () {
                console.log('리뷰를 불러오는 데 실패했습니다.');
            }
        });
    });
</script>
<script>
    $(document).ready(function () {
        $('.carousel').carousel();
    });

</script>
<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->


</body>

</html>