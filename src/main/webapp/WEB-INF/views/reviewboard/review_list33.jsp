<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@page import="java.util.List"%>
        <%@page import="com.multi.mini6.reviewboard.vo.ReviewVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	  <div id="result">
                <%
                    //jsp에서 자동 import : 클릭하고 ctrl + shiftl + m
                    List<ReviewVO> list = (List<ReviewVO>) request.getAttribute("list");

                %>
                <div class="container mt-4">

                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">이미지</th>
                                <th scope="col">id</th>
                                <th scope="col">제목</th>
                                <th scope="col">내용</th>
                                <th scope="col">작성일</th>
                                <th scope="col">수정일</th>
                                <th scope="col">조회수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (ReviewVO review : list) {
                            %>
                            <tr>

                               <td>${reviewAttachVO.review_file_name}</td>
                                <td><%=review.getReview_id()%></td>

                                <td>
                                 <sec:authorize access="isAuthenticated()"><%--로그인한 사람만 자세히보기할 수 있음 --%>
                                                                      <a href="review_one?review_id=<%=review.getReview_id()%>"><%=review.getReview_title()%></a>

                                                                  </sec:authorize>
                                                                  <sec:authorize access="isAnonymous()"><%-- 로그인하지 않은 사용자는 로그인 페이지로 이동--%>
                                                                      <a href="/loginpage/customLogin">${board.board_title}</a>
                                                                  </sec:authorize>

                                </td>
                                <td><%=review.getReview_content()%></td>
                                 <td><fmt:formatDate pattern="yyyy-MM-dd" value="<%=review.getReview_createdAt()%>" /></td>
                                 <td><fmt:formatDate pattern="yyyy-MM-dd" value="<%=review.getReview_updatedAt()%>" /></td>
                                <td><%=review.getReview_views()%></td>


                            </tr>
                            <%
                                }
                            %>
        		</tbody>
        	</table>

		</div>