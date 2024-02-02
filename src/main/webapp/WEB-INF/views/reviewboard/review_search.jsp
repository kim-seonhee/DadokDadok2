<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review Search Results</title>
    <!-- 여기에 필요한 CSS, 스타일링, 스크립트 등을 포함하시면 됩니다. -->
</head>
<body>
    <h1>Review Search Results</h1>
    <hr>

  <div id="result">
              <%
                  //jsp에서 자동 import : 클릭하고 ctrl + shiftl + m
                  List<ReviewVO> list = (List<ReviewVO>) request.getAttribute("list");
              %>
              <div class="container mt-4">
                  <table class="table">
                      <thead>
                          <tr>
                              <th scope="col">id</th>
                              <th scope="col">제목</th>
                              <th scope="col">내용</th>
                              <th scope="col">작성일</th>
                              <th scope="col">수정일</th>
                              <th scope="col">조회수</th>
                          </tr>
                      </thead>
                      <tbody>
                          <%
                              for (ReviewVO review : list) {
                          %>
                          <tr>
                              <td>1111<%=review.getReview_id()%></td>

                              <td><a href="review_one?review_id=<%=review.getReview_id()%>"><%=review.getReview_title()%></a>
                              </td>
                              <td><%=review.getReview_content()%></td>
                              <td><%=review.getReview_createdAt()%></td>
                              <td><%=review.getReview_updatedAt()%></td>
                              <td><%=review.getReview_views()%></td>
                          </tr>
                          <%
                              }
                          %>
                      </tbody>
                  </table>
              </div>
          </div>
            <hr color="red">
                  <div class="text-center">
                      전체 게시물 수 : ${count}개 <br>
                      전체 페이지 수 : ${pages}개 <br>
                      <div class="btn-group" role="group" aria-label="Basic example">
                          <%
                              int pages = (int) request.getAttribute("pages");//int(작) <--- Object(큰)
                              for (int p = 1; p <= pages; p++) {
                          %>
                          <button class="btn btn-outline-secondary"><%= p %></button>


                          <%
                              }
                          %>
                      </div>
                  </div>
                  <hr color="red">
              </div>
</body>
</html>