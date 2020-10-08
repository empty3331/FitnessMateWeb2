<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>FitnessMate</title>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/image/favicon.ico"/>

    <!-- icon 사용을 위한 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/fontawesome/all.css">

    <!-- 반드시 넣어야 하는 2가지 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">

    <!-- 반드시 넣어야 하는 2가지 js -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/modal.js"></script>

    <!-- slide -->
    <link href="${pageContext.request.contextPath}/assets/js/swiper-4.2.6/dist/css/swiper.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/assets/js/swiper-4.2.6/dist/js/swiper.min.js"></script>

    <!-- 해당 페이지 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/signUp.css">
</head>
<body>


    <div id="container" class="no-header">
        <div class="signUp-wrapper clearfix">
            <div class="img-part"></div>
            <div class="signUp-part">
                <a class="logo" href="${pageContext.request.contextPath}/main">
                    <img src="${pageContext.request.contextPath}/assets/image/logoC.png" title="logo" alt="logo">
                </a>
                <p class="title larger">환영합니다!</p>
                <p class="guide larger">${vo.name} 님, 회원가입을 축하합니다.<br>
                    가입하신 아이디는 <span class="bold">${vo.userId}</span> 입니다.</p>
                <a href="${pageContext.request.contextPath}/main" class="button main" id="btn_login">메인페이지로 돌아가기</a>
            </div>
        </div>
    </div>

    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    <!-- footer가 필요한 페이지에서 사용 -->


</body>


</html>