<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Movie List</title>
	<!-- Bootstrap CSS link -->
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-3">
	<h1>Movie List</h1>
	<p>Total movies: ${count}</p>

	<!-- 영화 게시글 등록하러 가기 버튼 -->
	<div class="mb-3">
		<a href="${pageContext.request.contextPath}/upload/movie_insert" class="btn btn-primary">Register New Movie</a>
	</div>

	<table class="table table-bordered">
		<thead>
		<tr>
			<th>ID</th>
			<th>Title</th>
			<th>Genre</th>
			<th>Running Time</th>
			<th>Img</th>
			<th>Link</th>
			<!-- Add other headers if necessary -->
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${getPagedMovieList}" var="movie">
			<tr>
				<td>${movie.movie_id}</td>
				<td><a href="${pageContext.request.contextPath}/upload/movie_detail?movie_id=${movie.movie_id}&currentPage=${currentPage}">${movie.title}</a></td>
				<td>${movie.genre}</td>
				<td>${movie.running_time}</td>
				<td>${movie.img}</td>
				<td>${movie.link}</td>
				<!-- Add other movie properties if necessary -->
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<!-- 페이지네이션 -->
	<nav>
		<ul class="pagination">
			<c:forEach begin="1" end="${totalPages}" var="i">
				<li class="page-item ${pageVO.page == i ? 'active' : ''}">
					<a class="page-link" href="movie_list?page=${i}&pageSize=${pageVO.pageSize}">${i}</a>
				</li>
			</c:forEach>
		</ul>
	</nav>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
