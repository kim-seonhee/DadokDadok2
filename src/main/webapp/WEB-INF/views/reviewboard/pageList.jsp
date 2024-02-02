<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table border="1">
    <tr bgcolor="lime">
	<th scope="col">id</th>
				<th scope="col">제목</th>
				<th scope="col">내용</th>
				<th scope="col">작성일</th>
				<th scope="col">수정일</th>
				<th scope="col">조회수</th>
    </tr>
<c:forEach items="${list2}" var="vo">
    <tr>
        <td>${vo.member_id}</td>
        <td>${vo.review_title}</td>
        <td>${vo.review_content}</td>
        <td>${vo.review_createdAt}</td>
        <td>${vo.review_updatedAt}</td>
        <td>${vo.review_views}</td>
    </tr>
</c:forEach>
</table>