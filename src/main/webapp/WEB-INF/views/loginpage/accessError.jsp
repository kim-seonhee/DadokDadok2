<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>접근 거부</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        .error-container {
            text-align: center;
            margin-top: 50px;
        }
    </style>
</head>
<body>
<div class="container error-container">
    <h1 class="display-4">접근 거부됨</h1>
    <p class="lead">
        <c:out value="${SPRING_SECURITY_403_EXCEPTION.message}" escapeXml="false" />
    </p>
    <hr>
    <p>
        요청하신 페이지에 대한 접근 권한이 없습니다. 메인 페이지로 돌아가시려면 아래 링크를 클릭하세요.
    </p>
    <a href="/mainpage/index" class="btn btn-primary">메인 페이지로 돌아가기</a>
</div>
</body>
</html>
