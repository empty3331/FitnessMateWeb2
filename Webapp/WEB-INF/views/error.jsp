<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/fontawesome/all.css">

    <!-- 반드시 넣어야 하는 2가지 css -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/common.css">

    <!-- 반드시 넣어야 하는 2가지 js -->
    <script
            src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/modal.js"></script>

    <!-- 해당 페이지 css -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/main.css">

    <style>
        .img-box {
            width: 100%;
            height: 650px;
            background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url("../assets/image/error.jpg");
            position: relative;
            background-size: cover;
            background-position: center 40%;
            background-repeat: no-repeat;
        }

        .img-box .color-box {
            color: #fff;
            position: absolute;
            z-index: 2;
            left: 50%;
            top: 57%;
            transform: translate(-50%, -50%);
            box-sizing: border-box;
            padding: 45px;
            width: 800px;
            height: 450px;
            border-radius: 4px;
            background-color: transparent;

        }

        .img-box .color-box i {
            font-size: 240px;
            color: #fff;
        }

        .img-box .color-box p {
            font-size: 18px;
            color: #fff;
            line-height: 160%;
            text-align: left;
        }

        .img-box .color-box .errorMsg {
            font-size: 40px;
            font-weight: 600;
            color: #fff;
            position: absolute;
            top: 90px;
            left: 305px;
            line-height: 160%;
        }

        .img-box .color-box a {
            position: absolute;
            bottom: 160px;
            left: 290px;
            display: block;
            box-sizing: border-box;
            border-radius: 4px;
            border: 1px solid #ffffff;
            height: 40px;
            padding: 0 15px;
            margin: 0 20px;
            font-size: 16px;
            font-weight: 400;
            line-height: 40px;
            text-align: center;
            cursor: pointer;
            background: none;
            color: #ffffff;
        }

    </style>


</head>
<body>
    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

    <div class="img-box">
        <div class="color-box">
            <i class="far fa-frown"></i>
            <p class="errorMsg">
                횐님!<br>여기는 보실 수 없어요!
            </p>

            <a href="${pageContext.request.contextPath}/main">메인페이지로 돌아가기</a>
        </div>
    </div>

    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>


</body>
</html>