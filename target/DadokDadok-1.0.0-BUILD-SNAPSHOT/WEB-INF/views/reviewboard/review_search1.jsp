<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@page import="java.util.List"%>
        <%@page import="com.multi.mini6.reviewboard.vo.ReviewVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
                                                      <td>
                        <div style="width: 300px; height: 200px; overflow: hidden; position: relative;">

                            <% if (review != null && review.getReview_attach() != null) {
                                if ((review.getReview_attach().getReview_file_type()).equals("jpg")) { %>
                                    <img src="${pageContext.request.contextPath}/resources/reviewBoardUpload/<%=review.getReview_attach().getReview_uuid()%>_<%=review.getReview_attach().getReview_file_name()%>" style="width: 100%; height: 100%; object-fit: cover;">
                                <% } else { %>
                                    <%=review.getReview_attach().getReview_file_type()%>
                                    <img src="${pageContext.request.contextPath}/resources/reviewBoardUpload/noimg.jpg" style="width: 100%; height: 100%; object-fit: cover;">
                                <% }
                            } else { %>
                                <img src="${pageContext.request.contextPath}/resources/reviewBoardUpload/noimg.jpg" style="width: 100%; height: 100%; object-fit: cover;">
                            <% } %>

                        </div>

                             </td>

                                                       <td><%=review.getReview_id()%></td>
                                                       <td><a href="review_one?review_id=<%=review.getReview_id()%>"><%=review.getReview_title()%></a>
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