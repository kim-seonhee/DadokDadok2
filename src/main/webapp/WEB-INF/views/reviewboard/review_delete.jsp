<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <form action="review_delete" method="post">
            <div class="form-group">
                <label for="review_id">review_id:</label>
                <input type="text" class="form-control" name="review_id" id="review_id">

            <button type="submit" class="btn btn-primary">게시글 삭제하기</button>


    <!-- Bootstrap JS and dependencies (optional, if needed) -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>