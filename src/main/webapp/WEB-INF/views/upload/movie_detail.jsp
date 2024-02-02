<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Movie Details</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<body>
<div class="container mt-3">
	<h1>Movie Details</h1>
	<hr color="grey">
	<div>
		<h3>${vo.title}</h3>
		<img src="${pageContext.request.contextPath}/resources/upload/${vo.img}" alt="${vo.title}" style="width: 300px;">
		<p><strong>Genre:</strong> ${vo.genre}</p>
		<p><strong>Running Time:</strong> ${vo.running_time} minutes</p>
		<p><strong>Link:</strong> <a href="${vo.link}" target="_blank">${vo.link}</a></p>
		<!-- Add other movie details if necessary -->
	</div>
	<a href="${pageContext.request.contextPath}/upload/movie_list?page=${currentPage}" class="btn btn-primary">Back to List</a>

</div>
</body>
</html>
