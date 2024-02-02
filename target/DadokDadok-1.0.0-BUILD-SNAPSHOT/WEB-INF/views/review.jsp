<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap JS (optional) -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.7.1.js"></script>
<style>
/* 이미지 우측 텍스트 레이아웃을 위한 CSS */
.row {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.row img {
	max-width: 200px;
	margin-right: 20px;
}
</style>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "review_list3",
			success : function(data) {
				$('#result').html(data);
			}
		})
	})
</script>
</head>
<body bgcolor="yellow">
	<div class="container mt-4">
		<!-- 검색창과 버튼 -->
		<div class="row mb-3 justify-content-center">
			<!-- 검색창 -->
			<div class="col-md-6 text-center">
				<form class="d-flex justify-content-center">
					<input class="form-control form-control-sm me-2" type="search"
						placeholder="검색어를 입력하세요" aria-label="Search">
					<button class="btn btn-outline-success btn-sm" type="submit">검색</button>
				</form>
			</div>

			<!-- Insert 버튼 -->
			<div class="col-md-6 text-end">
				<a href="review_insert.jsp" class="btn btn-primary">새 글 쓰기</a>
				<a href="review_update.jsp" class="btn btn-primary">글 수정하기</a>
				<a href="review_delete.jsp" class="btn btn-primary">글 삭제하기</a>
			</div>
		</div>
		<hr>
		<h3>독서후기게시판</h3>
		<div id="result"></div>
	</div>
</body>
</html>