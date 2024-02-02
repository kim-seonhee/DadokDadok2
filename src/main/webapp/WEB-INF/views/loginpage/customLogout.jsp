<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <script>
        // 로그아웃 메시지 표시를 위한 JavaScript
        // 이 페이지로 이동할 때 logout 파라미터가 있으면 alert 메시지를 표시한다.
        window.onload = function() {
            <c:if test="${not empty logout}">
            alert("로그아웃되었습니다.");
            </c:if>
        };
    </script>
</head>
<body>
<h1>로그아웃 처리 페이지</h1>
<form action="/loginpage/customLogout" method="post">
    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
    <input type="submit" value="로그아웃"/>
</form>
</body>
</html>