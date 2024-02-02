<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <form action="review_update" method="post">
            <h3 class="mb-4">게시글 수정</h3>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="member_id" class="form-label">Member ID</label>
                    <input type="text" class="form-control" id="member_id" name="member_id">
                </div>
                <div class="col-12">
                    <label for="review_title" class="form-label">Review Title</label>
                    <input type="text" class="form-control" id="review_title" name="review_title">
                </div>
                <div class="col-12">
                    <label for="review_content" class="form-label">Review Content</label>
                    <input type="text" class="form-control" id="review_content" name="review_content">
                </div>
                <div class="col-12 mt-3">
                    <button type="submit" class="btn btn-primary">게시글 수정 요청</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>