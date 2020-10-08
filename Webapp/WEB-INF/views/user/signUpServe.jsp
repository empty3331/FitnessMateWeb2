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

    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
    <!-- header가 필요한 페이지에서 사용 -->

    <div id="container">
        <div class="wrapper">

            <form action="${pageContext.request.contextPath}/user/signUpComplete" method="post" class="signup-form"
                  id="signUpServeForm">
                <p class="title">추가정보 입력</p>

                <!-- 경력 -->
                <div class="form-group number">
                    <div class="age clearfix">
                        <p>생년월일</p>
                        <select name="birth">
                            <option>년도</option>
                            <c:forEach var="year" begin="1960" end="2020" step="1">
                                <option value="${year}">${year}년</option>
                            </c:forEach>
                        </select>

                        <select name="birth">
                            <option>월</option>
                            <c:forEach var="month" begin="1" end="12" step="1">
                                <option value="${month}">${month}</option>
                            </c:forEach>
                        </select>

                        <select name="birth" class="last">
                            <option>일</option>
                            <c:forEach var="date" begin="1" end="31" step="1">
                                <option value="${date}">${date}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="career">
                        <label for="career">경력</label>
                        <input type="text" name="career" value="" id="career" placeholder='0년 00개월'>
                    </div>
                </div>

                <!-- 지역 -->
                <div class="form-group clearfix">
                    <p>지역</p>
                    <select name="province">
                        <option>도/광역시</option>
                        <c:forEach items="${provinceList}" var="province">
                            <option>${province}</option>
                        </c:forEach>
                    </select>

                    <select name="city">
                        <option>시/구</option>
                    </select>

                    <select name="region" class="last">
                        <option>동/읍/면</option>
                    </select>
                </div>

                <!-- 소속회사 -->
                <div class="form-group">
                    <p>소속회사</p>
                    <input type="text" name="company" placeholder="소속회사를 입력하세요">
                </div>

                <!-- 전문분야 -->
                <p>전문분야</p>
                <div class="checkboxPart">
                    <c:forEach items="${interestList}" var="interest">
                        <input type="checkbox" id="interest-${interest.fieldNo}" value="${interest.fieldNo}"
                               name="fieldNo">
                        <label for="interest-${interest.fieldNo}" class="button-label">${interest.fieldName}</label>
                    </c:forEach>
                </div>

                <!-- 수상내역 -->
                <div class="recordPart">
                    <p>수상내역 / 이수이력</p>
                    <div>
                        <input type="text" name="careerRecord" placeholder="대회명(교육명) / 상세내용 ">
                        <i class="far fa-plus-square"></i>
                    </div>
                </div>

                <!-- 근무시간 -->
                <div>
                    <p>PT 운영 시간</p>
                    <textarea name="workingHours"></textarea>
                </div>

                <!-- 자기소개 -->
                <div>
                    <p>자기소개</p>
                    <textarea name="introduction"></textarea>
                </div>

                <!-- 가격 -->
                <div>
                    <p>가격</p>
                    <textarea name="price"></textarea>
                </div>

                <input type="hidden" name="userNo" value="${vo.userNo}">
                <input type="hidden" name="userId" value="${vo.userId}">
                <input type="hidden" name="name" value="${vo.name}">

                <button type="submit" class="button main">완료</button>

            </form>
        </div>

    </div>

    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    <!-- footer가 필요한 페이지에서 사용 -->


</body>
<script type="text/javascript">

    // +눌렀을 때 수상내역 추가
    $(".fa-plus-square").on("click", function () {
        var addRecord = '';
        addRecord += '<div>';
        addRecord += '    <input type="text" name="careerRecord" placeholder="대회명(교육명) / 상세내용 ">';
        addRecord += '    <i class="far fa-minus-square"></i>';
        addRecord += '</div>';

        $(this).closest(".recordPart").append(addRecord);
    });

    // -눌렀을 때 수상내역 삭제
    $(".recordPart").on("click", "i.fa-minus-square", function () {
        $(this).closest("div").remove();
    });

    //주소 2차 분류 가져오기
    $("select[name='province']").on("change", function () {
        //옵션 초기화
        $("select[name='city']").empty();

        var thisProvince = $(this).val();

        $.ajax({

            url: "${pageContext.request.contextPath}/user/getCity",
            type: "post",
            data: {thisProvince: thisProvince},

            dataType: "json",
            success: function (cityList) {

                /*성공시 처리해야될 코드 작성*/
                var cityStr = '<option>전체</option>';
                for (var i in cityList) {
                    cityStr += '<option>' + cityList[i] + '</option>';
                }

                $("select[name='city']").append(cityStr);

            },
            error: function (XHR, status, error) {
                console.error(status + " : " + error);
            }
        })

    });

    //주소 3차 분류 가져오기
    $("select[name='city']").on("change", function () {
        //옵션 초기화
        $("select[name='region']").empty();

        var thisCity = $(this).val();

        $.ajax({

            url: "${pageContext.request.contextPath}/user/getRegion",
            type: "post",
            data: {thisCity: thisCity},

            dataType: "json",
            success: function (regionList) {

                /*성공시 처리해야될 코드 작성*/
                var regionStr = '<option>전체</option>';

                for (var i in regionList) {
                    regionStr += '<option>' + regionList[i] + '</option>';
                }

                $("select[name='region']").append(regionStr);

            },
            error: function (XHR, status, error) {
                console.error(status + " : " + error);
            }
        })

    });


</script>
</html>