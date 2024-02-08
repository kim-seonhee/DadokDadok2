<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/views/head.jsp"/>
<body>
  <!-- ======= Top Bar ======= -->
  <jsp:include page="/WEB-INF/views/topbar.jsp"/>
  <!-- End Top Bar -->
  <%-- header --%>
  <jsp:include page="/WEB-INF/views/header.jsp"/>
  <main id="main">
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
              <p>후기게시판</p>
              <div>독서 후기를 자유롭게 작성할 수 있는 공간 입니다.</div>
              <div>로그인한 회원만 글 작성할 수 있습니다.</div>
          </div>
          <div>
              <form action="/reviewboard/review_list" method="get" class="search">
                  <select name="searchType">
                      <option value="title">제목</option>
                      <option value="content">내용</option>
                      <option value="writer">작성자</option>
                  </select>
                  <input type="text" name="keyword" placeholder="검색할 내용을 입력하세요.">
                  <input type="hidden" name="page" value="${page}">
                  <button type="submit"><i class="fas fa-search"></i></button>
              </form>
          </div> <%-- 검색 end--%>

          <sec:authorize access="isAuthenticated()"> <%-- 로그인한 상태에서만 보임 --%>
              <div class="insert_btn">
                  <a href="/reviewboard/review_insert">작성하기</a>
              </div>
          </sec:authorize>
          <p>총 게시물: ${count}</p>

          <div class="b_list">
              <table class="review_list_table">
                  <thead>
                      <tr>
                          <td>NO</td>
                          <td>제목</td>
                          <td>작성자</td>
                          <td>조회수</td>
                          <td>작성일</td>
                      </tr>
                  </thead>
                  <tbody>
                      <c:forEach items="${reviewList}" var="review">
                          <tr>
                              <td>${review.review_board_no}</td>
                              <td>
                                  <div class="bl_title">
                                      <sec:authorize access="isAuthenticated()"><%--로그인한 사람만 자세히보기할 수 있음 --%>
                                          <a href="/reviewboard/review_one?review_id=${review.review_id}&page=${page}&searchType=${searchType}&keyword=${keyword}">${review.review_title}</a>
                                          <div class="bl_cm">[${countComment[review.review_id]}]</div>
                                          <c:if test="${attachList.contains(review.review_id)}">
                                             <i class="far fa-file-alt bl_file"></i>
                                          </c:if>
                                      </sec:authorize>
                                      <sec:authorize access="isAnonymous()"><%-- 로그인하지 않은 사용자는 로그인 페이지로 이동--%>
                                          <a href="/loginpage/customLogin">${review.review_title}</a>
                                          <div class="bl_cm">[${countComment[review.review_id]}]</div>
                                          <c:if test="${attachList.contains(review.review_id)}">
                                              <i class="far fa-file-alt bl_file"></i>
                                          </c:if>
                                      </sec:authorize>
                                  </div>
                              </td>
                              <td>${review.nickname}</td>
                              <td>${review.review_views}</td>
                              <td><fmt:formatDate pattern="yyyy-MM-dd" value="${review.review_createdAt}" /></td>
                          </tr>
                      </c:forEach>
                  </tbody>
              </table>
            </div>
          <!-- 페이징 -->
     <div class="b_paging">
        <ul>
         <c:set var="startPage" value="${page - 2}" />
         <c:set var="endPage" value="${page + 2}" />
         <c:if test="${startPage lt 1}">
             <c:set var="startPage" value="1" />
         </c:if>
         <c:if test="${endPage gt totalPage}">
             <c:set var="endPage" value="${totalPage}" />
         </c:if>
         <c:if test="${endPage - startPage lt 4}">
             <c:if test="${startPage eq 1}">
                 <c:set var="endPage" value="${(endPage + 4 - (endPage - startPage)) le totalPage ? (endPage + 4 - (endPage - startPage)) : totalPage}" />
             </c:if>
             <c:if test="${endPage eq totalPage}">
                 <c:set var="startPage" value="${(startPage - 4 + (endPage - startPage)) ge 1 ? (startPage - 4 + (endPage - startPage)) : 1}" />
             </c:if>
         </c:if>

         <c:choose>
             <c:when test="${page gt 1}">
                 <li><a href="/reviewboard/review_list?page=${page - 1}&searchType=${searchType}&keyword=${keyword}">이전</a></li>
             </c:when>
             <c:otherwise>
                <li><a href="#">이전</a></li>
             </c:otherwise>
         </c:choose>

         <c:forEach var="i" begin="${startPage}" end="${endPage}">
             <c:choose>
                 <c:when test="${i eq page}">
                     <li><a href="/reviewboard/review_list?page=${i}&searchType=${searchType}&keyword=${keyword}" class="active">${i}</a></li>
                 </c:when>
                 <c:otherwise>
                     <li><a href="/reviewboard/review_list?page=${i}&searchType=${searchType}&keyword=${keyword}">${i}</a></li>
                 </c:otherwise>
             </c:choose>
         </c:forEach>

         <c:choose>
             <c:when test="${page lt totalPage}">
                 <li><a href="/reviewboard/review_list?page=${page + 1}&searchType=${searchType}&keyword=${keyword}">다음</a></li>
             </c:when>
             <c:otherwise>
                 <li><a href="#">다음</a></li>
             </c:otherwise>
         </c:choose>
         </ul>
     </div>
     </section>

  </main>
  <!-- ======= Footer ======= -->
  <jsp:include page="/WEB-INF/views/footer.jsp"/>
  <!-- End Footer -->
</body>
</html>