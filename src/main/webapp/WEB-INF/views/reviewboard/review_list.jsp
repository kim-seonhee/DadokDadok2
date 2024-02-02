<%@page import="java.util.List"%>
<%@page import="com.multi.mini6.ReviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//jsp에서 자동 import : 클릭하고 ctrl + shiftl + m
List<ReviewVO> list = (List<ReviewVO>) request.getAttribute("list");
%>
<div class="container mt-4">
	<table class="table">
		<thead>
			<tr>
				<th scope="col">id</th>
				<th scope="col">이미지</th>
				<th scope="col">작성자</th>
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
				<td><%=review.getReview_id()%></td>
				<td><img src="resources/img/<%=review.getReview_img1()%>"
					width="50" height="50"></td>
				<td><%=review.getReview_writer()%></td>
				<td><a href="review_one?review_id=<%=review.getReview_id()%>"><%=review.getReview_title()%></a></td>
				<td><%=review.getReview_content()%></td>
				<td><%=review.getReview_createdAt()%></td>
				<td><%=review.getReview_updatedAt()%></td>
				<td><%=review.getReview_views()%></td>


			</tr>
			<%
				}
			%>

		</tbody>
	</table>

</div>
