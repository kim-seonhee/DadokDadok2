<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>MyPage</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

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
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Template Main CSS File -->
    <link href="../resources/assets/css/style.css" rel="stylesheet">


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

        .rounded-image {
            border-radius: 50%; /* 원형으로 만듭니다 */
            width: 300px; /* 원하는 크기로 설정하세요 */
            height: 300px; /* 원하는 크기로 설정하세요 */
            object-fit: cover; /* 이미지가 div를 벗어나지 않도록 설정합니다 */
        }

        .guestbook-link:hover .sidebar-title {
            color: #fd5c28; /* 마우스 오버 시 색상 변경 */
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
                <h2>MyPage</h2>
                <ol>
                    <li><a href="/mainpage/index">Home</a></li>
                    <li>MyPage</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Profile Section ======= -->
    <section id="profile" class="profile">
        <div class="container" data-aos="fade-up">
            <div class="row">
                <div class="col-lg-4">
<%--                    <c:set var="dbPath" value = "upload-dir/" + "${member.userImg}" +  />--%>
<%--                    <c:set var="dbPath" value="/Users/Kang/Downloads/apache-tomcat-8.5.95/bin/upload-dir/"/>--%>
                    <c:set var="dbPath" value="/home/ec2-user/local/apache-tomcat-8.5.98/upload-dir/"/>
                    <c:set var="defaultImagePath"
                           value="${pageContext.request.contextPath}/resources/assets/img/profile/profile.png"/>
                    <c:set var="imagePath" value="${member.userImg}"/>
                    <c:set var="relativePath" value="${fn:replace(imagePath, dbPath, '')}"/>
                    <c:choose>
                        <c:when test="${not empty imagePath}">
                            <!-- 사용자가 이미지를 업로드한 경우 -->
                            <img src="${pageContext.request.contextPath}/upload-dir/${relativePath}"
                                 class="img-fluid rounded-image" alt="Profile">
                        </c:when>
                        <c:otherwise>
                            <!-- 기본 이미지 표시 -->
                            <img src="${defaultImagePath}" class="img-fluid rounded-image" alt="Profile">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-lg-8 pt-4 pt-lg-0 content">
                    <h3><sec:authentication property="principal.member.nickname"/></h3>
                    <p class="fst-italic">
                        <!-- info 가 들어갈 곳 -->
                        ${member.info}
                    </p>
                </div>
            </div>
        </div>
    </section><!-- End Profile Section -->

    <hr>
    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
        <div class="container" data-aos="fade-up">

            <div class="row">

                <div class="col-lg-8 entries">

                    <article class="entry">
                        <div id="reviewContent"></div>
                    </article><!-- End blog entry -->


                    <div class="blog-pagination">
                        <ul class="justify-content-center">
                            <li><a href="#">1</a></li>
                            <li class="active"><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                        </ul>
                    </div>

                </div><!-- End blog entries list -->

                <div class="col-lg-4">

                    <div class="sidebar">

                        <%--                        <h3 class="sidebar-title">Search</h3>--%>
                        <%--                        <div class="sidebar-item search-form">--%>
                        <%--                            <form action="">--%>
                        <%--                                <input type="text">--%>
                        <%--                                <button type="submit"><i class="bi bi-search"></i></button>--%>
                        <%--                            </form>--%>
                        <%--                        </div><!-- End sidebar search form-->--%>

                        <a href="/profilepage/GuestBookPage/guestbookDetail" class="guestbook-link">
                            <h3 class="sidebar-title">Guestbook</h3>
                        </a>
                        <div class="guestbook-entry">
                        </div>

                        <div class="sidebar-item">
                        </div>

                        <div class="guestbook-entries">
                            <form id="guestbookForm" method="post">
                                <div class="form-group">
                                    <textarea id="guestbookMessage" class="form-control" rows="4" required
                                              placeholder="Leave a message"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </form>
                            <br>
                        </div><!-- End guestbook entries -->


                        <%--                        <h3 class="sidebar-title">Categories</h3>--%>
                        <%--                        <div class="sidebar-item categories">--%>
                        <%--                            <ul>--%>
                        <%--                                <li><a href="#">General <span>(25)</span></a></li>--%>
                        <%--                                <li><a href="#">Lifestyle <span>(12)</span></a></li>--%>
                        <%--                                <li><a href="#">Travel <span>(5)</span></a></li>--%>
                        <%--                                <li><a href="#">Design <span>(22)</span></a></li>--%>
                        <%--                                <li><a href="#">Creative <span>(8)</span></a></li>--%>
                        <%--                                <li><a href="#">Educaion <span>(14)</span></a></li>--%>
                        <%--                            </ul>--%>
                        <%--                        </div><!-- End sidebar categories-->--%>

                        <%--                        <h3 class="sidebar-title">Recent Posts</h3>--%>
                        <%--                        <div class="sidebar-item recent-posts">--%>
                        <%--                            <div class="post-item clearfix">--%>
                        <%--                                <img src="../resources/assets/img/blog/blog-recent-1.jpg" alt="">--%>
                        <%--                                <h4><a href="blog-single.jsp">Nihil blanditiis at in nihil autem</a></h4>--%>
                        <%--                                <time datetime="2020-01-01">Jan 1, 2020</time>--%>
                        <%--                            </div>--%>

                        <%--                            <div class="post-item clearfix">--%>
                        <%--                                <img src="../resources/assets/img/blog/blog-recent-2.jpg" alt="">--%>
                        <%--                                <h4><a href="blog-single.jsp">Quidem autem et impedit</a></h4>--%>
                        <%--                                <time datetime="2020-01-01">Jan 1, 2020</time>--%>
                        <%--                            </div>--%>

                        <%--                            <div class="post-item clearfix">--%>
                        <%--                                <img src="../resources/assets/img/blog/blog-recent-3.jpg" alt="">--%>
                        <%--                                <h4><a href="blog-single.jsp">Id quia et et ut maxime similique occaecati ut</a></h4>--%>
                        <%--                                <time datetime="2020-01-01">Jan 1, 2020</time>--%>
                        <%--                            </div>--%>

                        <%--                            <div class="post-item clearfix">--%>
                        <%--                                <img src="../resources/assets/img/blog/blog-recent-4.jpg" alt="">--%>
                        <%--                                <h4><a href="blog-single.jsp">Laborum corporis quo dara net para</a></h4>--%>
                        <%--                                <time datetime="2020-01-01">Jan 1, 2020</time>--%>
                        <%--                            </div>--%>

                        <%--                            <div class="post-item clearfix">--%>
                        <%--                                <img src="../resources/assets/img/blog/blog-recent-5.jpg" alt="">--%>
                        <%--                                <h4><a href="blog-single.jsp">Et dolores corrupti quae illo quod dolor</a></h4>--%>
                        <%--                                <time datetime="2020-01-01">Jan 1, 2020</time>--%>
                        <%--                            </div>--%>

                        <%--                        </div><!-- End sidebar recent posts-->--%>

                        <%--                        <h3 class="sidebar-title">Tags</h3>--%>
                        <%--                        <div class="sidebar-item tags">--%>
                        <%--                            <ul>--%>
                        <%--                                <li><a href="#">App</a></li>--%>
                        <%--                                <li><a href="#">IT</a></li>--%>
                        <%--                                <li><a href="#">Business</a></li>--%>
                        <%--                                <li><a href="#">Mac</a></li>--%>
                        <%--                                <li><a href="#">Design</a></li>--%>
                        <%--                                <li><a href="#">Office</a></li>--%>
                        <%--                                <li><a href="#">Creative</a></li>--%>
                        <%--                                <li><a href="#">Studio</a></li>--%>
                        <%--                                <li><a href="#">Smart</a></li>--%>
                        <%--                                <li><a href="#">Tips</a></li>--%>
                        <%--                                <li><a href="#">Marketing</a></li>--%>
                        <%--                            </ul>--%>
                        <%--                        </div><!-- End sidebar tags-->--%>

                    </div><!-- End sidebar -->

                </div><!-- End blog sidebar -->

            </div>

        </div>
    </section><!-- End Blog Section -->

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

<script>
    $(document).ready(function () {
        $.ajax({
            url: '/profilepage/GuestBookPage/myGuestBookEntries', // 여기서 URL은 REST API 엔드포인트와 일치해야 합니다.
            type: 'GET',
            dataType: 'json',
            success: function (response) {
                var guestbookEntryDiv = $('.guestbook-entry');
                guestbookEntryDiv.empty(); // 기존 내용을 비웁니다.

                $.each(response, function (index, entry) {
                    guestbookEntryDiv.append('<p>' + entry.author_nickname + ': ' + entry.message + '</p>');
                });
            },
            error: function (error) {
                console.log('Error fetching guest book entries:', error);
            }
        });
    });
</script>

<script>
    $(document).ready(function () {
        $('#guestbookForm').on('submit', function (e) {
            e.preventDefault(); // 폼 기본 제출 이벤트 방지

            var message = $('#guestbookMessage').val(); // textarea에서 메시지 내용을 가져옴
            var postData = {
                message: message // 메시지 내용
            };

            $.ajax({
                url: '/profilepage/GuestBookPage/addGuestBook', // 서버의 POST 엔드포인트
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(postData), // JSON 형식으로 변환
                success: function (response) {
                    alert('Guest book entry added successfully.'); // 성공 메시지 표시
                    $('#guestbookMessage').val(''); // 메시지 입력 필드 초기화
                    //페이지 새로고침
                    location.reload();
                },
                error: function (xhr, status, error) {
                    alert('Error adding guest book entry: ' + error); // 오류 메시지 표시
                }
            });
        });
    });
</script>

<script>


    function loadReviewData() {
        $.ajax({
            url: '/profilepage/review-list-by-id', // API 경로
            type: 'GET',
            success: function(data) {
                let reviewContentHtml = '';
                data.forEach(review => {
                    var reviewDate = new Date(review.review_createdAt).toLocaleDateString();
                    var reviewLink = '/reviewboard/review_one?review_id=' + review.review_id;
                    reviewContentHtml +=

                        '<article class="entry">' +
                        '<h2 class="entry-title">' +
                        '<a href=' + reviewLink + '>' + review.review_title + '</a>' +
                        '</h2>' +
                        '<div class="entry-meta">' +
                        '<ul>' +
                        '<li class="d-flex align-items-center"><i class="bi bi-person"></i> <a href="profile.jsp?memberId=' + review.member_id + '">' + review.nickname + '</a></li>' +
                        '<li class="d-flex align-items-center"><i class="bi bi-clock"></i>' + reviewDate + '</li>' +
                        '<li class="d-flex align-items-center"><i class="bi bi-chat-dots"></i> <a href="blog-single.jsp?reviewId=' + review.review_id + '">' + review.review_views + ' Views</a></li>' +
                        '</ul>' +
                        '</div>' +
                        '<div class="entry-content">' +
                        '<p>' + review.review_content.substring(0, 50) + '...</p>' +
                        '<div class="read-more">' +
                        '<a href=' + reviewLink + '>Read More</a>' +
                        '</div>' +
                        '</div>' +
                        '</article>';
                });
                $('#reviewContent').html(reviewContentHtml);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Error loading review data:', textStatus, errorThrown);
                // 에러 처리 로직
            }
        });
    }

    // 사용 예시: 페이지 로드 시 해당 함수를 호출합니다.
    $(document).ready(function () {
        loadReviewData();
    });

</script>

</body>
</html>