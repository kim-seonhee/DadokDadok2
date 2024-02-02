<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<section id="topbar" class="d-flex align-items-center">
    <div class="container d-flex justify-content-center justify-content-md-between">
        <div class="contact-info d-flex align-items-center">
            <!-- 비로그인 상태일 때 표시 -->
            <sec:authorize access="!isAuthenticated()">
                <i class="bi bi-person d-flex align-items-center"><a href="/loginpage/signup">Register</a></i>
                <i class="bi bi-lock d-flex align-items-center ms-4"><a href="/loginpage/customLogin">Login</a></i>
            </sec:authorize>

            <!-- 로그인 상태일 때 표시 -->
            <sec:authorize access="isAuthenticated()">
                <i class="bi bi-unlock d-flex align-items-center ms-2"><a href="/loginpage/customLogout">Logout</a></i>
            </sec:authorize>
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <i class="bi bi-gear d-flex align-items-center ms-3"><a href="/adminpage/BookUploadPage">관리자 페이지</a></i>
            </sec:authorize>

        </div>
        <div class="social-links d-none d-md-flex align-items-center">
            <sec:authorize access="isAuthenticated()">
                <a href="/profilepage/mypage" class="my-page"><i class="bi bi-person"></i>MYPAGE</a>
            </sec:authorize>
            <!-- 소셜 링크 등 기타 요소들 -->
        </div>
    </div>
</section>