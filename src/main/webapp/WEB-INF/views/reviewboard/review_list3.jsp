<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@page import="java.util.List" %>
<%@page import="com.multi.mini6.reviewboard.vo.ReviewVO" %>
<%@page import="com.multi.mini6.reviewboard.vo.ReviewAttachVO" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<style>
    td {
        vertical-align: middle;
        text-align: center; /* If you also want the text to be centered horizontally */
    }

</style>
<jsp:include page="/WEB-INF/views/head.jsp"/>
<script type="text/javascript" src="../../../resources/js/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
        crossorigin="anonymous"></script>

<script type="text/javascript">

    $(function () {
        $('.btn.btn-outline-secondary').click(function () {

            console.log($(this).text());

            $.ajax({
                url: "review_search1",
                data: {
                    page: $(this).text(),
                    keyword: '${keyword}'

                },
                success: function (table) {
                    $('#result').html(table);
                    $('#keyword').val('${keyword}');

                },
                error: function (error) {
                    console.error(error);
                }
            });
        });


    });


</script>
</head>
<!-- ======= Top Bar ======= -->
<jsp:include page="/WEB-INF/views/topbar.jsp"/>
<!-- End Top Bar -->

<!-- ======= Header ======= -->
<jsp:include page="/WEB-INF/views/header.jsp"/>
<!-- End Header -->
<main id="main">
    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
        <div class="container">

            <div class="d-flex justify-content-between align-items-center">
                <h2>독서후기게시판</h2>
                <ol>
                    <li><a href="../mainpage/index">Home</a></li>
                    <li>Setting</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->

    <div class="container mt-4 reviewboard">
        <!-- 검색창과 버튼 -->
        <div class="row mb-3 justify-content-center">
            <!-- 검색창 -->
            <div class="col-md-6 text-center">
                <form action="review_list3" class="d-flex justify-content-center">

                    <input type="hidden" name="page" id="currentPage" value="1">
                    <input name="keyword" id="keyword" class="form-control form-control-sm me-2" type="search"
                           placeholder="검색어를 입력하세요" value="${keyword}"
                           aria-label="Search">

                    <button class="btn btn-outline-success btn-sm" id="btnSearch">검색</button>

                </form>
            </div>

            <!-- Insert 버튼 -->
            <div class="col-md-6 text-end">
                <sec:authorize access="isAuthenticated()"> <%-- 로그인한 상태에서만 보임 --%>

                    <a href="review_insert_move" class="btn btn-primary insert_btn">게시글 작성</a>

                </sec:authorize>

            </div>
        </div>
        <div id="result" class="rv_table">
            <%
                //jsp에서 자동 import : 클릭하고 ctrl + shiftl + m
                List<ReviewVO> list = (List<ReviewVO>) request.getAttribute("list");

            %>
            <div class="container mt-4">

                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">이미지</th>
                        <th scope="col">NO</th>
                        <th scope="col">제목</th>
                        <th scope="col">내용</th>
                        <th scope="col">작성일</th>
                        <th scope="col">조회수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (ReviewVO review : list) {
                    %>
                    <tr>
                        <td class="t_img">
                            <div>

                                <% if (review != null && review.getReview_attach() != null) {
                                    String fileType = review.getReview_attach().getReview_file_type().toLowerCase();
                                    if (fileType.equals("jpg") || fileType.equals("jpeg") || fileType.equals("png") || fileType.equals("gif")) { %>
                                <img src="${pageContext.request.contextPath}/resources/reviewBoardUpload/<%=review.getReview_attach().getReview_uuid()%>_<%=review.getReview_attach().getReview_file_name()%>">
                                <% } else { %>
                                <img src="${pageContext.request.contextPath}/resources/reviewBoardUpload/noimg.jpg">
                                <% }
                                } else { %>
                                <img src="${pageContext.request.contextPath}/resources/reviewBoardUpload/noimg.jpg">
                                <% } %>

                            </div>
                        </td>

                        <td>
                            <div><%=review.getReview_id()%>
                            </div>
                        </td>
                        <td>
                            <div><a href="review_one?review_id=<%=review.getReview_id()%>"><%=review.getReview_title()%>
                            </a></div>
                        </td>
                        <%--                            <td><div><%=review.getReview_content()%></div></td>--%>
                        <td>
                            <%
                                String content = review.getReview_content();
                                if (content.length() > 30) {
                                    content = content.substring(0, 30) + "...";
                                }
                            %>
                            <%= content %>
                        </td>
                        <td>
                            <div><fmt:formatDate pattern="yyyy-MM-dd" value="<%=review.getReview_createdAt()%>"/></div>
                        </td>
                        <td>
                            <div><%=review.getReview_views()%>
                            </div>
                        </td>


                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>


        <div class="text-center rv_page">
            <div>전체 게시물 수 : ${count}개</div>
            <div>전체 페이지 수 : ${pages}개</div>
            <div class="btn-group btn_box" role="group" aria-label="Basic example">
                <%
                    int pages = (int) request.getAttribute("pages");//int(작) <--- Object(큰)
                    String keyword = (String) request.getAttribute("keyword");

                    for (int p = 1; p <= pages; p++) {
                %>
                <button class="btn btn-outline-secondary"><%= p %>
                </button>


                <%
                    }
                %>
            </div>
        </div>
    </div>
</main>
<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->
</body>

</html>