<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		<table class="table table-bordered table-striped">
			<thead class="thead-dark">
				<tr>
					<th class="custom-width-15">도서관코드</th>
					<th class="custom-width-30">도서관명</th>
					<th class="custom-width-40">도서관주소</th>
					<th class="custom-width-15">도서관전화번호</th>
					<th class="hidden-column">도서관위도</th>
                    <th class="hidden-column">도서관경도</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="libraryVO">
					<tr>
						<td>${libraryVO.lib_code }</td>
						<td><a href = "library_one?lib_code=${libraryVO.lib_code }">${libraryVO.lib_name }</a></td>
						<td>${libraryVO.lib_address }</td>
						<td>${libraryVO.lib_tel }</td>
						<td class="hidden-column">${libraryVO.lib_latitude}</td>
                        <td class="hidden-column">${libraryVO.lib_longitude}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

