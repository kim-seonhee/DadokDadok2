<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        .main {
          display: grid;
            place-items: center;
            min-height: 100dvh;
        }
        .row {
          display: flex;
            justify-content: center;
            margin-left: 20%;
            margin-right: 20%;
        }
        .search-form {
        text-align: center; /* Center align the form */
        }

        .input-group {
        display: inline-block; /* Display the group as inline-block */
        vertical-align: middle; /* Align the group vertically */
        }

        .input-group select,
        .input-group input[type="text"],
        .input-group input[type="submit"] {
            margin: 0; /* Remove default margins */
            vertical-align: middle; /* Align elements vertically */
        }
        .n_info {
            text-align: center;
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
            <div>검색 결과입니다.</div>
            <div><p>검색된 게시물 수: ${searchCount}</p></div>
        <br>
        </div>
        <form action="noticeboard_search" method="get" class="search-form">
            <div class="input-group">
                <select id="searchType" name="searchType">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="titleContent">제목+내용</option>
                </select>
                <input type="text" id="keyword" name="keyword" placeholder="검색어 입력">
                <input type="submit" value="검색" class="btn btn-secondary">
                <a href="noticeboard" class="btn btn-secondary">목록으로</a>
            </div>
        </form>
        <br><br>
        <div class="row">
            <div class="col">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">NO</th>
                            <th scope="col">제목</th>
                            <th scope="col">내용</th>
                            <th scope="col">조회수</th>
                            <th scope="col">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${searchResults}" var="result">
                            <tr>
                                <td>${result.notc_id}</td>
                                <td>
                                    <a href="noticeboard_one?notc_id=${result.notc_id}">
                                        <c:out value="${fn:substring(result.notc_title, 0, 20)}${fn:length(result.notc_title) > 20 ? '...' : ''}" />
                                    </a>
                                </td>
                                <td>
                                    ${fn:substring(result.notc_content, 0, 20)}${fn:length(result.notc_content) > 20 ? '...' : ''}
                                </td>
                                <td>${result.notc_views}</td>
                                <td><fmt:formatDate value="${result.notc_createdAt}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <br>
                <ul class="pagination justify-content-center">
                    <li class="page-item${noticeBoardPageVO.page == 1 ? ' disabled' : ''}">
                        <a class="page-link" href="/noticeboard/noticeboard_search?page=1&pageSize=${noticeBoardPageVO.pageSize}&searchType=${searchType}&keyword=${keyword}" aria-label="First">
                            <<
                        </a>
                    </li>
                    <li class="page-item${noticeBoardPageVO.page == 1 ? ' disabled' : ''}">
                        <a class="page-link" href="/noticeboard/noticeboard_search?page=${noticeBoardPageVO.page - 1}&pageSize=${noticeBoardPageVO.pageSize}&searchType=${searchType}&keyword=${keyword}" aria-label="Previous">
                            <
                        </a>
                    </li>
                    <c:forEach begin="1" end="${noticeBoardPageVO.totalPages}" var="pageNumber">
                                        <li class="page-item${noticeBoardPageVO.page == pageNumber ? ' active' : ''}">
                                            <a class="page-link" href="/noticeboard/noticeboard_search?page=${pageNumber}&pageSize=${noticeBoardPageVO.pageSize}&searchType=${searchType}&keyword=${keyword}">
                                                ${pageNumber}
                                            </a>
                                        </li>
                                    </c:forEach>
                    <li class="page-item${noticeBoardPageVO.page == noticeBoardPageVO.totalPages ? ' disabled' : ''}">
                        <a class="page-link" href="/noticeboard/noticeboard_search?page=${noticeBoardPageVO.page + 1}&pageSize=${noticeBoardPageVO.pageSize}&searchType=${searchType}&keyword=${keyword}" aria-label="Next">
                            >
                        </a>
                    </li>
                    <li class="page-item${noticeBoardPageVO.page == noticeBoardPageVO.totalPages ? ' disabled' : ''}">
                        <a class="page-link" href="/noticeboard/noticeboard_search?page=${noticeBoardPageVO.totalPages}&pageSize=${noticeBoardPageVO.pageSize}&searchType=${searchType}&keyword=${keyword}" aria-label="Last">
                            >>
                        </a>
                    </li>
                </ul>
           </div>
       </div>
    </div><br>
    </main><!-- End #main -->
    <!-- ======= Footer ======= -->
    <jsp:include page="/WEB-INF/views/footer.jsp"/>
    <!-- End Footer -->
</div>
</body>
</html>