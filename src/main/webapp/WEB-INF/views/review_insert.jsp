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
        <form action="review_insert" method="post">
            <div class="form-group">
                <label for="member_id">member_id:</label>
                <input type="text" class="form-control" name="member_id" id="member_id">
            </div>
            <div class="form-group">
                <label for="book_ISBN">book_ISBN:</label>
                <input type="text" class="form-control" name="book_ISBN" id="book_ISBN">
            </div>
            <div class="form-group">
                <label for="review_writer">review_writer:</label>
                <input type="text" class="form-control" name="review_writer" id="review_writer">
            </div>
            <div class="form-group">
                <label for="review_title">review_title:</label>
                <input type="text" class="form-control" name="review_title" id="review_title">
            </div>
            <div class="form-group">
                <label for="review_content">review_content:</label>
                <input type="text" class="form-control" name="review_content" id="review_content">
            </div>
            <!--
            <div class="form-group">
                <label for="review_createdAt">review_createdAt:</label>
                <input type="text" class="form-control" name="review_createdAt" id="review_createdAt">
            </div>
            <div class="form-group">
                <label for="review_updatedAt">review_updatedAt:</label>
                <input type="text" class="form-control" name="review_updatedAt" id="review_updatedAt">
            </div>
            -->
            <button type="submit" class="btn btn-primary">서버로 전송</button>
        </form>
    </div>

    <!-- Bootstrap JS and dependencies (optional, if needed) -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>