<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
		<script type="text/javascript">
			$(function() {
				$('.pages').click(function() {
					$.ajax({
						url: "reviewboard/pageList3",
						data: {
							page: $(this).text()
						},
						success: function(table) {
							$('#result').html(table)
						}
					})
				})
			})
		</script>
	</head>
	<body>
	<hr color="red">
	전체 게시물 수 : ${count}개 <br>
	전체 페이지 수 : ${pages}개 <br>
	<%
		int pages = (int)request.getAttribute("pages");//int(작) <--- Object(큰)
		for(int p = 1; p <= pages; p++){
	%>
			<button style="background:lime;" class="pages"><%= p %></button>
		&nbsp;
	<%
		}
	%>
	<hr color="red">
	<div id="result">
			<table border="1">
			    <tr bgcolor="lime">

		        <th scope="col">id</th>
				<th scope="col">제목</th>
				<th scope="col">내용</th>
				<th scope="col">작성일</th>
				<th scope="col">수정일</th>
				<th scope="col">조회수</th>

			    </tr>
			<c:forEach items="${list}" var="vo">
			    <tr>
			        <td>${vo.member_id}</td>
			        <td>${vo.review_title}</td>
			        <td>${vo.review_content}</td>
			        <td>${vo.review_createdAt}</td>
			        <td>${vo.review_updatedAt}</td>
			         <td>${vo.review_views}</td>
			    </tr>
			</c:forEach>
		</table>
	</div>
	</body>
</html>