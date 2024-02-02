<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 상세보기</title>
    <!-- jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        // 제목 클릭 시 조회수 증가 함수
        function increaseViews(reviewId) {
            $.ajax({
                type: "GET",
                url: "/review_views", // 실제 요청을 처리할 컨트롤러의 매핑 주소
                data: { review_views: reviewId }, // reviewId를 전달
                success: function(response) {

                    $("#reviewTitle").text(response.title);
                    $("#reviewContent").text(response.content);
                    $("#reviewViews").text("조회수: " + response.views);
                },
                error: function(xhr, status, error) {
                    console.error("Error occurred while increasing views: " + error);
                }
            });
        }
    </script>
</head>
<body>
    <h1 id="reviewTitle" onclick="increaseViews(${reviewboard.id})">${reviewboard.title}</h1>
    <p id="reviewContent">${reviewboard.content}</p>
    <p id="reviewViews">조회수: ${reviewboard.views}</p>
</body>
</html>