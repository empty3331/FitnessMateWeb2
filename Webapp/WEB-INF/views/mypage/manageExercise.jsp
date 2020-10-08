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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mypage2.css">
        
</head>
<body>
    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
    <div id="container">
        <c:import url="/WEB-INF/views/mypage/includes/menu.jsp"></c:import>
        <div class="wrapper clearfix">
            <form id="addExercise" class="clearfix">
                <h2>운동 추가하기</h2>
                <div class="input-box">
                    <h3 class="title">부위</h3>
                    <select name="exercisePart">
                        <c:forEach items="${showList}" var="exPart" varStatus="index">
                            <option ${index.count eq 1 ? 'selected' : ''} value="${exPart.exPartNo}">${exPart.exPartName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="input-box">
                    <h3 class="title">운동명</h3>
                    <input type="text" name="exerciseName" placeholder="운동명을 입력해주세요">
                </div>
                <div class="input-box">
                    <h3 class="title">단위</h3>
                    <div class="radio-wrapper">
                        <input type="radio" id="unitKG" name="unit" value="kg" checked>
                        <label for="unitKG">kg</label>
                        <input type="radio" id="unitPound" name="unit" value="lbs">
                        <label for="unitPound">lbs</label>
                        <input type="radio" id="unitTime" name="unit" value="sec">
                        <label for="unitTime">sec</label>
                    </div>
                </div>
                <button type="button" class="button main add-exercise" onclick="addExercise();">추가</button>
            </form>
            <div id="exerciseList">
                <h2>운동 목록</h2>
                <c:forEach items="${exList}" var="exercise">
                    <div class="exercise">
                        <h4 class="title">${exercise.exName}</h4>
                        <p class="detail">
                            <span class="part">운동부위 : ${exercise.exPartName}</span><span class="unit">기록단위 : ${exercise.unit}</span>
                        </p>
                        <button type="button" class="delete-btn" onclick="deleteExercise($(this),${exercise.exNo});"><i
                                class="fas fa-times"></i></button>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    <script type="text/javascript">
        function addExercise() {
            var result = true;
            var form = $("form#addExercise");
            var exPartNo = form.find("select[name='exercisePart']").find("option:selected").val();
            var exName = form.find("input[name='exerciseName']").val();
            var unit = form.find("input[name='unit']:checked").next("label").text();
            var exVo = {
                exName : exName,
                exPartNo : exPartNo,
                unit : unit
            }
            console.log(exPartNo);
            if (exName === "" || exName == null) {
                result = false;
                alert("운동이름을 입력해주세요");
            }
            if (!result) {
                return result;
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/addExercise",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(exVo),
                dataType: "json",
                success: function (result) {
                    if(result) {
                        $("#exerciseList").append(
                            "<div class='exercise'>" +
                            "<h4 class='title'>" + result.exName + "</h4>" +
                            "<p class='detail'>" +
                            "<span class='part'>운동부위 : " + result.exPartName + "</span>" +
                            "<span class='unit'>기록단위 : " + result.unit + "</span>" +
                            "</p>" +
                            "<button type='button' class='delete-btn' onclick='deleteExercise($(this),"+ result.exNo + ")'>" +
                            "<i class='fas fa-times'></i>" +
                            "</button>" +
                            "</div>"
                        );
                        form.find("input[name='exerciseName']").val("");
                    } else {
                        alert("Fail to add Exercise!")
                    }
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });


        }

        function deleteExercise(target,number) {
            var exVo = {
                exNo : number
            };
            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/deleteExercise",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(exVo),
                dataType: "json",
                success: function (boolean) {
                    if(boolean) {
                        target.parent("div.exercise").remove();
                        alert("운동을 삭제하였습니다");
                    } else {
                        alert("Fail to remove Exercise!")
                    }
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
        }
    </script>
</body>
</html>
