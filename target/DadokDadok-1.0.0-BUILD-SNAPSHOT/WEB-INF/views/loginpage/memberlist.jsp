<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Member List</title>
</head>
<body>
<h2>Member List</h2>
<table border="1">
    <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone Number</th>
        <th>Created At</th>
        <th>Nickname</th>
        <th>Info</th>
        <th>User Image</th>
    </tr>
    <c:forEach items="${list}" var="member">
        <tr>
            <td>${member.member_id}</td>
            <td>${member.name}</td>
            <td>${member.email}</td>
            <td>${member.phoneNum}</td>
            <td><fmt:formatDate value="${member.createdAt}" pattern="yyyy-MM-dd"/></td>
            <td>${member.nickname}</td>
            <td>${member.info}</td>
            <td><img src="${member.userImg}" alt="User Image"/></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
