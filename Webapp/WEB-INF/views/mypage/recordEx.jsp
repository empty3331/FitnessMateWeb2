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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/recordForm.css">
    
    <style>
    .summary-wrapper .summary .statistics h3.title.left {
    text-align: left;
	}
	.summary-wrapper .summary .statistics .info {
    color: #fff;
    font-size: 20px;
    margin-bottom: 25px;
	}
    </style>
    
</head>
<body>
    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
    <div id="container">
        <c:import url="/WEB-INF/views/mypage/includes/menu.jsp"></c:import>
        <div class="wrapper">
            <p>운동 기록 | August 13, 2020</p>
            <div id="first_select" class="box_color">
                <p>운동 부위</p>
                <ul>
                    <c:forEach items="${partList}" var="part">
                        <li onclick="showEx(${part.exPartNo})">${part.exPartName}</li>
                    </c:forEach>
                </ul>
            </div>

            <div class="fir-arrow"><i class="fas fa-arrow-circle-right"></i></div>

            <div id="second_select" class="box_color">
                <p>운동 이름</p>
                <ul>

                </ul>
            </div>

            <div class="sec-arrow"><i class="fas fa-arrow-circle-right"></i></div>

            <div class="third_record">

            </div>
            <button type="button" class="button sub btn_save" onclick="saveRecord();">저장</button>
        </div>
    </div>
    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    <script type="text/javascript">
        //두번째 리스트 보여주기
        function showEx(exPartNo) {
            var exVo = {
                exPartNo : exPartNo
            };
            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/showExPart",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(exVo),
                dataType: "json",
                success: function (exList) {
                    $("#second_select ul").html("");
                    if(exList) {
                        for (i = 0; i < exList.length; i++) {
                            $("#second_select ul").append(
                                "<li onclick='addExForm("+exList[i].exNo+",$(this));'>" +
                                "<span class='name'>"+ exList[i].exName +"</span>" +
                                "(단위: <span class='unit'>"+ exList[i].unit +"</span>)" +
                                "</li>"
                            );
                        }
                    } else {
                        alert("Fail to show Exercise!")
                    }
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
        }

        function addExForm(exNo,target) {
            var exName = target.find("span.name").text();
            var unit = target.find("span.unit").text();

            $(".third_record").append(
                "<div class='box_color each' data-no='"+exNo+"'>" +
                    "<div class='float_wrap'>" +
                            "<p>"+ exName +"("+ unit +")"+"</p>" +
                            "<p class='btn_toggle'><i class='fas fa-caret-up'></i></p>"+
                            "<i class='far fa-minus-square setDelete' onclick='deleteExBox($(this))'></i>"+
                    "</div>"+
                    "<div class='setPart'>"+
                        "<div class='record-box'>"+
                            "<input type='number' name='amount' placeholder='중량/초'> "+
                            "<input type='number' name='count' placeholder='횟수'> "+
                            "<i class='far fa-plus-square' onclick='addExSet($(this))'></i>" +
                        "</div>"+
                    "</div>"+
                "</div>"
            );
        }

        function deleteExBox(target) {
            target.parents(".each").remove();
        }

        function addExSet(target) {
            target.parents(".setPart").append(
                "<div class='record-box'>" +
                    "<input type='number' name='amount' placeholder='중량/초'> "+
                    "<input type='number' name='count' placeholder='횟수'> "+
                    "<i class='far fa-minus-square' onclick='deleteExSet($(this))'></i>"+
                "</div>"
            );
        }

        function deleteExSet(target) {
            target.parent('.record-box').remove();
        }

        //입력창 접기
        $(".third_record").on("click", "i.fa-caret-up", function(){
            $(this).parents(".each").children(".setPart").slideUp();
            $(this).removeClass("fa-caret-up");
            $(this).addClass("fa-caret-down");
        });

        //입력창 열기
        $(".third_record").on("click", "i.fa-caret-down", function(){
            $(this).parents(".each").children(".setPart").slideDown();
            $(this).removeClass("fa-caret-down");
            $(this).addClass("fa-caret-up");
        });

        function saveRecord() {
            var recordArray = [];
            $(".record-box").each(function() {
                var scheduleNo = ${param.scheduleNo};
                var exNo = $(this).parents(".each").attr("data-no");
                var count = $(this).find("input[name='count']").val();
                var amount = $(this).find("input[name='amount']").val();
                var recordVo = {
                    scheduleNo : scheduleNo,
                    exNo : exNo,
                    count : count,
                    amount : amount
                }
                recordArray.push(recordVo);
            });
            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/addRecord",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(recordArray),
                dataType: "json",
                success: function (result) {
                    alert("저장되었습니다!");
                    window.location.href = '${pageContext.request.contextPath}/mypage/schedule';
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
        }
    </script>
</body>
</html>

