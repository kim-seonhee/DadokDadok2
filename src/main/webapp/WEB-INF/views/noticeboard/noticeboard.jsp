<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.multi.mini6.noticeboard.vo.NoticeBoardVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/views/head.jsp"/>
<style>
    .pinned-notice {
        background-color: #f2f2f2; /* Light gray background */
        font-weight: bold; /* Make text bold */
    }
</style>
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
                     <li><a href="../mainpage/index">Home</a></li>
                    <li>공지게시판</li>
                </ol>
            </div>
        </div>
    </section><!-- End Breadcrumbs -->

    <div class="center noticeboard">
        <div class="n_info">
            <p>공지게시판</p>
            <div>공지 사항을 준수해 주세요.</div>
            <div>중요 공지는 상단에 고정되어 있습니다.</div>
            <br>
        </div>
        <form action="noticeboard_search" method="get" class="search-form">
            <div class="input-group n_search">
                <select id="searchType" name="searchType">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="titleContent">제목+내용</option>
                </select>
                <input type="text" id="keyword" name="keyword" placeholder="검색어 입력">
                <input type="submit" value="검색" class="btn btn-secondary">
                <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                    <a href="noticeboard_write" class="btn btn-primary">새 글 쓰기</a>
                </c:if>
            </div>
        </form>
        <br><br>
        <div class="row">
        <p>총 게시물 수: ${count}</p>
            <div class="col">
                <table id="noticeboardTable" class="table n_table">
                    <thead>
                        <tr>
                            <th scope="col">NO</th>
                            <th scope="col">제목</th>
                            <th scope="col">작성자</th>
                            <th scope="col">조회수</th>
                            <th scope="col">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pinnedNotices}" var="noticeboardVO">
                            <tr class="pinned-notice">
                                <td><span class="post-number">${noticeboardVO.notc_id}</span></td>
                                <td>
                                    <a href="noticeboard_one?notc_id=${noticeboardVO.notc_id}">
                                        <c:out value="${fn:substring(noticeboardVO.notc_title, 0, 20)}${fn:length(noticeboardVO.notc_title) > 20 ? '...' : ''}" />
                                    </a>
                                </td>
                                <td>관리자</td>
                                <td><c:out value="${noticeboardVO.notc_views}" /></td>
                                <td><fmt:formatDate value="${noticeboardVO.notc_createdAt}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                        <c:forEach items="${noticeboard}" var="noticeboardVO">
                            <c:if test="${!noticeboardVO.pinned}">
                                <tr>
                                    <td><c:out value="${noticeboardVO.notc_id}" /></td>
                                    <td>
                                        <a href="noticeboard_one?notc_id=${noticeboardVO.notc_id}">
                                            <c:out value="${fn:substring(noticeboardVO.notc_title, 0, 20)}${fn:length(noticeboardVO.notc_title) > 20 ? '...' : ''}" />
                                        </a>
                                    </td>
                                    <td>관리자</td>
                                    <td><c:out value="${noticeboardVO.notc_views}" /></td>
                                    <td><fmt:formatDate value="${noticeboardVO.notc_createdAt}" pattern="yyyy-MM-dd"/></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
                <br>
                <ul class="pagination justify-content-center n_page">
                    <li class="page-item${noticeBoardPageVO.page == 1 ? ' disabled' : ''}">
                        <a class="page-link" href="noticeboard?page=1&pageSize=10" aria-label="First">
                            &lt;&lt;<span aria-hidden="true"></span>
                        </a>
                    </li>
                    <li class="page-item${noticeBoardPageVO.page == 1 ? ' disabled' : ''}">
                        <a class="page-link" href="noticeboard?page=${noticeBoardPageVO.page - 1}&pageSize=10" aria-label="Previous">
                            &lt;<span aria-hidden="true"></span>
                        </a>
                    </li>
                    <c:forEach begin="1" end="${noticeBoardPageVO.totalPages}" var="i">
                        <li class="page-item${noticeBoardPageVO.page == i ? ' active' : ''}">
                            <a class="page-link" href="noticeboard?page=${i}&pageSize=10">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item${noticeBoardPageVO.page == noticeBoardPageVO.totalPages ? ' disabled' : ''}">
                        <a class="page-link" href="noticeboard?page=${noticeBoardPageVO.page + 1}&pageSize=10" aria-label="Next">
                            ><span aria-hidden="true"></span>
                        </a>
                    </li>
                    <li class="page-item${noticeBoardPageVO.page == noticeBoardPageVO.totalPages ? ' disabled' : ''}">
                        <a class="page-link" href="noticeboard?page=${noticeBoardPageVO.totalPages}&pageSize=10" aria-label="Last">
                            >><span aria-hidden="true"></span>
                        </a>
                    </li>
                </ul>
                <br>
            </div>
        </div>
    </div>
</main><!-- End #main -->
<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->
</body>
</html>