<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Comment</title>
    <!-- 필요한 스타일이나 스크립트를 여기에 추가 -->
</head>
<body>
    <h2>댓글 삭제 페이지</h2>
    <form id="deleteCommentForm">
        <input type="hidden" id="cm_id" name="cm_id" value="<%= request.getParameter("cm_id") %>">
        <!-- 삭제할 댓글 ID를 숨겨진 필드로 전달 -->
        <button type="button" onclick="deleteComment()">댓글 삭제</button>
    </form>

    <script>
        function deleteComment() {
            let cm_id = document.getElementById('cm_id').value;

            // AJAX를 통해 댓글 삭제 처리
            // AJAX 코드 작성 (앞서 설명한 AJAX 요청 코드 참고)
        }
    </script>
</body>
</html>