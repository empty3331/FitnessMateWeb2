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

    <%--차트--%>
    <script src="${pageContext.request.contextPath}/assets/js/chart/dist/Chart.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/js/chart/dist/Chart.min.css">

    <!-- 해당 페이지 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mypage2.css">
</head>
<body>
    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

    <div id="container">
        <c:import url="/WEB-INF/views/mypage/includes/menu.jsp"></c:import>

        <div class="wrapper">
            <form id="userSearchForm" class="clearfix">
                <h3 class="title">회원 검색</h3>
                <div class="radio-wrapper clearfix">
                    <input type="radio" id="nowMember" name="member" value="now" checked>
                    <label for="nowMember" onclick="showUserList($(this));">현재회원</label>
                    <input type="radio" id="formerMember" name="member" value="former">
                    <label for="formerMember" onclick="showUserList($(this));">이전회원</label>
                </div>
                <input type="text" id="searchKeyword" name="searchKeyword" placeholder="이름 혹은 아이디를 입력해주세요"
                       onkeyup="searchByKeyword($(this));">
                <button type="button" id="addUserBtn" class="button main" onclick="showAddUserModal();">회원 추가</button>
            </form>

            <ul class="user-list clearfix">
                <!-- 반복 -->
                <c:forEach items="${ptList}" var="pt">
                    <li class="user clearfix ${pt.proceed eq false ? 'former off':'now'}"
                        onclick="showUser(${pt.ptNo});">
                        <img src="${pageContext.request.contextPath}/upload/${pt.profileImg}" alt="profile image"
                             title="profile image">
                        <p class="info">
                            <span class="name">${pt.name}</span>
                            <span class="id">${pt.userId}</span>
                        </p>
                    </li>
                </c:forEach>
                <!-- 반복 끝 -->
            </ul>
        </div>
    </div>
    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>

    <div class="modal-layer" id="userInfoModal">
        <div class="modal-wrapper">
            <button type="button" class="close-btn" onclick="forceHideModal('#userInfoModal')">X</button>
            <div class="label-wrapper clearfix">
                <button type="button" class="label-btn profile-btn on" data-tab="profile" onclick="showTab($(this))">
                    프로필
                </button>
                <button type="button" class="label-btn review-btn" data-tab="inbody" onclick="showTab($(this))">인바디
                </button>
                <button type="button" class="label-btn location-btn" data-tab="exercise" onclick="showTab($(this))">
                    운동기록
                </button>
            </div>
            <div class="modal-content">
                <div class="label-tab profile-wrapper on">
                    <img src="" alt="profile image" title="profile image" id="modalUserImg">
                    <div>
                        <p class="label">· 회원 이름</p>
                        <p id="userName"></p>

                        <p class="label">· ID</p>
                        <p id="userId"></p>

                        <p class="label">· 연락처</p>
                        <p id="phone"></p>

                        <p class="label">· 등록기간</p>
                        <p id="period"></p>

                        <p class="label">· 사용횟수</p>
                        <p id="count"></p>
                        <div class="extendForm">
                            <input type="number" name="extendMonth" min="0">
                            <label>개월</label>
                            <input type="number" name="extendCount" min="0">
                            <label>회</label>
                        </div>
                        <button type="button" id="showAddCount">추가등록</button>
                        <p class="label">· 메모</p>
                        <textarea id="memo"></textarea>
                        <input type="hidden" id="modifyPtNo" value="">
                        <button type="button"
                                onclick="modifyMemo($('textarea#memo').val(), $('input#modifyPtNo').val());">메모 수정
                        </button>
                    </div>
                </div>
                <div class="label-tab inbody-wrapper clearfix">
                    <div class="inbody_record">
                        <select name="inbodyDate">

                        </select>

                        <table>
                            <tr>
                                <th>체중 (kg)</th>
                                <td id="weight">
                                    <input name="weight" type="number" max="200" min="0" step="0.1" placeholder="00.0">
                                </td>
                            </tr>
                            <tr>
                                <th>체지방률 (%)</th>
                                <td id="percentFat">
                                    <input name="percentFat" type="number" max="200" min="0" step="0.1"
                                           placeholder="00.0">
                                </td>
                            </tr>
                            <tr>
                                <th>골격근량 (kg)</th>
                                <td id="muscleMass">
                                    <input name="muscleMass" type="number" max="200" min="0" step="0.1"
                                           placeholder="00.0">
                                </td>
                            </tr>
                            <tr>
                                <th>BMI (kg/m²)</th>
                                <td id="bmi">
                                    <input name="bmi" type="number" max="200" min="0" step="0.1" placeholder="00.0">
                                </td>
                            </tr>
                        </table>
                        <button type="button" class="button main btnSave" data-ptno="">저장</button>

                    </div>

                    <canvas id="canvas" width="550" height="400">
                    </canvas>
                </div>
                <div class="label-tab exercise-wrapper">
                    <select name="recordDate">
                    </select>
                    <ul id="recordList" class="clearfix">
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-layer" id="addUserModal">
        <div class="modal-wrapper">
            <div class="modal-content">
                <p class="title">회원 추가</p>
                <div class="search-wrapper clearfix">
                    <input type="text" name="keyword" placeholder="ID를 입력해주세요">
                    <button type="button" class="button search">검색</button>
                </div>
                <div class="search-result">
                    <p class="defaultMsg">아이디로 회원을 검색해주세요.</p>
                    <p class="errMsg">검색 결과가 없습니다.</p>

                    <div class="user clearfix">
                        <!-- 검색결과나오는 부분 -->
                    </div>
                </div>
            </div>
            <div class="modal-btn-area">
                <button type="button" class="modal-cancel" onclick="forceHideModal('#addUserModal')">취소</button>
                <button type="button" class="modal-confirm main off" onclick="addUser();">추가</button>
            </div>
        </div>
    </div>

    <script type="text/javascript">

        //인바디 저장버튼 클릭
        $("button.btnSave").on("click", function () {

            var ptNo = $(this).data("ptno");
            var weight = $("input[name='weight']").val();
            var percentFat = $("input[name='percentFat']").val();
            var muscleMass = $("input[name='muscleMass']").val();
            var bmi = $("input[name='bmi']").val();

            if (weight == "") {
                alert("체중값이 비어있어요");
                return false;
            } else if (percentFat == "") {
                alert("체지방값이 비어있어요");
                return false;
            } else if (muscleMass == "") {
                alert("골격근량값이 비어있어요");
                return false;
            } else if (bmi == "") {
                alert("bmi값이 비어있어요");
                return false;
            } else {

                //데이터 전송
                $.ajax({
                    //보낼 때 옵션
                    url: "${pageContext.request.contextPath}/mypage/saveInbody",
                    type: "post",
                    data: {
                        ptNo: ptNo,
                        weight: weight,
                        percentFat: percentFat,
                        muscleMass: muscleMass,
                        bmi: bmi
                    },

                    //받을 때 옵션
                    dataType: "json",
                    success: function (inbodyVo) {

                        alert("인바디 값이 저장되었습니다.");

                        $("input[name='weight']").val("");
                        $("input[name='percentFat']").val("");
                        $("input[name='muscleMass']").val("");
                        $("input[name='bmi']").val("");

                        $("option[value='0']").after('<option value="' + inbodyVo.ptNo + '">' + inbodyVo.measureDate + '</option>');

                    },
                    error: function (XHR, status, error) {
                        console.error(status + " : " + error);
                    }
                })
            }//else 끝

        });

        //인바디 모달 - 셀렉박스 선택했을 때
        $("select[name='inbodyDate']").on("change", function () {

            $("input[name='weight']").val("");
            $("input[name='percentFat']").val("");
            $("input[name='muscleMass']").val("");
            $("input[name='bmi']").val("");
            $("button.btnSave").hide();

            var inbodyNo = $(this).val();

            if (inbodyNo == 0) {
                $("input[name='weight']").css("disabled", true);
                $("input[name='percentFat']").css("disabled", true);
                $("input[name='muscleMass']").css("disabled", true);
                $("input[name='bmi']").css("disabled", true);
                $("button.btnSave").show();
            } else {

                //데이터 전송
                $.ajax({
                    //보낼 때 옵션
                    url: "${pageContext.request.contextPath}/mypage/getInbodyInfo",
                    type: "post",
                    data: {inbodyNo: inbodyNo},

                    //받을 때 옵션
                    dataType: "json",
                    success: function (inbodyInfo) {

                        $("input[name='weight']").css("disabled", false);
                        $("input[name='percentFat']").css("disabled", false);
                        $("input[name='muscleMass']").css("disabled", false);
                        $("input[name='bmi']").css("disabled", false);

                        $("input[name='weight']").val(inbodyInfo.weight + " kg");
                        $("input[name='percentFat']").val(inbodyInfo.percentFat + " %");
                        $("input[name='muscleMass']").val(inbodyInfo.muscleMass + " kg");
                        $("input[name='bmi']").val(inbodyInfo.bmi + " kg/m²");
                        $("button.btnSave").hide();

                    },
                    error: function (XHR, status, error) {
                        console.error(status + " : " + error);
                    }
                })
            }//else 끝
        })

        //pt횟수 추가 버튼 보이기
        $("button#showAddCount").on("click", function () {
            $(".extendForm").show();
            $(this).text("저장");
            $(this).attr("id", "btnAddCount");
            $(this).attr("onclick", "addCount();");
        });

        //운동기록 날짜 select
        $("select[name='recordDate']").on("change",function(){
            var scheduleNo = $(this).find("option:selected").val();
            $(this).siblings("ul#recordList").find("li").removeClass("on");
            $(this).siblings("ul#recordList").find("li[data-no='"+scheduleNo+"']").addClass("on");
        });

        //pt횟수 추가 저장 버튼 누르면!
        function addCount() {
            console.log("asdfasdf");
            var ptNo = $("input#modifyPtNo").val();
            var extendMonth = $("input[name='extendMonth']").val();
            var extendCount = $("input[name='extendCount']").val();

            if (extendMonth == "") {
                alert("등록개월 란이 비어있어요");
                return false;
            } else if (extendCount == "") {
                alert("등록횟수 란이 비어있어요");
                return false;
            } else {

                //데이터 전송
                $.ajax({
                    //보낼 때 옵션
                    url: "${pageContext.request.contextPath}/mypage/extendPt",
                    type: "post",
                    data: {
                        ptNo: ptNo,
                        extendMonth: extendMonth,
                        extendCount: extendCount
                    },

                    //받을 때 옵션
                    dataType: "json",
                    success: function (userInfo) {

                        alert("PT가 추가 등록 되었습니다.");

                        //userInfo 다시 넣기
                        $("#period").text("\u00A0 " + userInfo.ptInfo.startDate + " ~ " + userInfo.ptInfo.endDate);
                        $("#count").text("\u00A0 " + userInfo.ptInfo.scheduleCount + " / " + userInfo.ptInfo.regCount);

                        //버튼 초기화
                        $(".extendForm").hide();
                        $("#btnAddCount").text("추가등록");
                        $("#btnAddCount").attr("id", "showAddCount");
                        $("#btnAddCount").attr("onclick", "");

                    },
                    error: function (XHR, status, error) {
                        console.error(status + " : " + error);
                    }
                })

            }
        };


        //인바디 모달 - 셀렉박스 선택했을 때
        $("select[name='inbodyDate']").on("change", function () {

            var inbodyNo = $(this).val();
            console.log("inbodyNo: " + inbodyNo);

            if (inbodyNo == 0) {

                $("input[name='weight']").attr("type", "number");
                $("input[name='percentFat']").attr("type", "number");
                $("input[name='muscleMass']").attr("type", "number");
                $("input[name='bmi']").attr("type", "number");

                $("input[type='number']").attr("disabled", false);

            } else {

                //데이터 전송
                $.ajax({
                    //보낼 때 옵션
                    url: "${pageContext.request.contextPath}/mypage/getInbodyInfo",
                    type: "post",
                    data: {inbodyNo: inbodyNo},

                    //받을 때 옵션
                    dataType: "json",
                    success: function (inbodyInfo) {

                        $("input[type='number']").attr("disabled", true);

                        $("input[name='weight']").attr("type", "text");
                        $("input[name='percentFat']").attr("type", "text");
                        $("input[name='muscleMass']").attr("type", "text");
                        $("input[name='bmi']").attr("type", "text");

                        $("input[name='weight']").val(inbodyInfo.weight + " kg");
                        $("input[name='percentFat']").val(inbodyInfo.percentFat + " %");
                        $("input[name='muscleMass']").val(inbodyInfo.muscleMass + " kg");
                        $("input[name='bmi']").val(inbodyInfo.bmi + " kg/m²");

                    },
                    error: function (XHR, status, error) {
                        console.error(status + " : " + error);
                    }
                })
            }//else 끝
        })

        //회원추가 모달에서 검색
        $("button.search").on("click", function () {
            $("div.user").empty();

            var keyword = $("input[name='keyword']").val();

            //데이터 전송
            $.ajax({
                //보낼 때 옵션
                url: "${pageContext.request.contextPath}/mypage/searchUser",
                type: "post",
                data: {keyword: keyword},

                //받을 때 옵션
                dataType: "json",
                success: function (userVo) {
                    $("p.errMsg").hide();
                    $("p.defaultMsg").hide();

                    var result = '';
                    result += '<img src="${pageContext.request.contextPath}/upload/'+ userVo.profileImg +'" alt="profile image" title="profile image">';
                    result += '<p class="info">';
                    result += '    <span class="name">' + userVo.name + '</span>';
                    result += '    <span class="id">' + userVo.userId + '</span>';
                    result += '</p>';
                    result += '<div class="schedule-input-wrapper clearfix">';
                    result += '    <input class="schedule-input" type="number" name="period" placeholder="1" max="60" onkeyup="checkEmpty();">';
                    result += '    <span class="mark">개월</span>';
                    result += '    <input class="schedule-input" type="number" name="regCount" placeholder="0" max="999" onkeyup="checkEmpty();">';
                    result += '    <span class="mark">회</span>';
                    result += '    <input type="hidden" name="userNo" value="' + userVo.userNo + '">';
                    result += '</div>';

                    $("div.user").prepend(result);

                },
                error: function (XHR, status, error) {
                    $("p.defaultMsg").hide();
                    $("p.errMsg").show();

                }
            })

        });

        //회원 모달 탭 눌렀을 때
        function showTab(target) {
            var targetTab = target.attr("data-tab");

            //다른 버튼 on 제거
            $(".label-wrapper .label-btn").removeClass("on");
            //다른 탭 on 제거
            $(".label-tab").removeClass("on");

            //label에 on
            target.addClass("on");

            //tab에 on
            $("#userInfoModal").find("." + targetTab + "-wrapper").addClass("on");

            //인풋태그 초기화
            $("#userInfoModal input").val("");

            //추가 폼 가리기
            $(".extendForm").hide();
            $("#btnAddCount").text("추가등록");
            $("#btnAddCount").attr("id", "showAddCount");
            $("#btnAddCount").attr("onclick", "");
        }

        function showUserList(target) {
            var targetType = target.prev("input[type='radio']").val();
            $("input#searchKeyword").val("");
            $("ul.user-list li").addClass("off");
            $("ul.user-list li." + targetType).removeClass("off");

        }

        function showUser(ptNo, trainerNo) {

            $("select[name='inbodyDate']").empty();
            $("button.btnSave").data("ptno", ptNo);

            //인풋태그 초기화
            $("#userInfoModal input").val("");

            //추가폼 가리기
            $(".extendForm").hide();
            $("#btnAddCount").text("추가등록");
            $("#btnAddCount").attr("id", "showAddCount");
            $("#btnAddCount").attr("onclick", "");

            //데이터 전송
            $.ajax({
                //보낼 때 옵션
                url: "${pageContext.request.contextPath}/mypage/userInfo",
                type: "post",
                data: {
                    ptNo: ptNo,
                    trainerNo: trainerNo
                },

                //받을 때 옵션
                dataType: "json",
                success: function (userInfo) {
                    //userInfo 넣기
                    $("#userName").text("\u00A0 " + userInfo.ptInfo.name + " (" + userInfo.ptInfo.gender + ")");
                    $("p#userId").text("\u00A0 " + userInfo.ptInfo.userId);
                    $("#phone").text("\u00A0 " + userInfo.ptInfo.phone);
                    $("#period").text("\u00A0 " + userInfo.ptInfo.startDate + " ~ " + userInfo.ptInfo.endDate);
                    $("#count").text("\u00A0 " + userInfo.ptInfo.scheduleCount + " / " + userInfo.ptInfo.regCount);
                    $("textarea#memo").text(userInfo.ptInfo.memo);
                    $("input#modifyPtNo").val(userInfo.ptInfo.ptNo);
                    $("#modalUserImg").attr("src","${pageContext.request.contextPath}/upload/"+userInfo.ptInfo.profileImg)

                    //인바디 인풋 초기화
                    $("input[name='weight']").val("");
                    $("input[name='percentFat']").val("");
                    $("input[name='muscleMass']").val("");
                    $("input[name='bmi']").val("");

                    //인바디 날짜 리스트
                    var dateList = '<option value="0">인바디 입력하기</option>';
                    for (var inbody of userInfo.inbodyList) {
                        dateList += '<option value="' + inbody.inbodyNo + '">' + inbody.measureDate + '</option>';
                    }

                    $("select[name='inbodyDate']").append(dateList);

                    //인바디 그래프 그리기
                    $("#canvas").removeAttr("style");
                    $("#canvas").attr("width", "550");
                    $("#canvas").attr("height", "400");
                    drawChart(userInfo.inbodyList);

                    //운동내역 출력
                    writeRecords(userInfo.recordList);

                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });
            showModal("#userInfoModal");
        }

        function searchByKeyword(target) {
            var type = target.prev(".radio-wrapper").find("input[name='member']:checked").val();
            var keyword = target.val();

            $("ul.user-list li").each(function(){
                $(this).addClass("off");
                if($(this).find("span.name").is(":contains("+keyword+")") || $(this).find("span.id").is(":contains("+keyword+")")  ) {
                    $(this).removeClass("off");
                }
                if(!$(this).hasClass(type)) {
                    $(this).addClass("off");
                }
            });
        }

        function showAddUserModal() {
            $("div.user").empty();
            $("p.errMsg").hide();
            $("p.defaultMsg").show();
            $("input[name='keyword']").val("");
            $("#addUserModal").find(".modal-confirm").addClass("off");

            showModal("#addUserModal");
        }

        //메모 수정하기
        function modifyMemo(memo, ptNo) {

            //데이터 전송
            $.ajax({
                //보낼 때 옵션
                url: "${pageContext.request.contextPath}/mypage/modifyMemo",
                type: "post",
                data: {
                    ptNo: ptNo,
                    memo: memo
                },

                //받을 때 옵션
                dataType: "json",
                success: function (result) {
                    alert("메모가 저장되었습니다.");

                },
                error: function (XHR, status, error) {
                    console.error(status + " : " + error);
                }
            })
        }

        function addUser() {
            /* input, 회원 비엇을 때 버튼 막아야함 */
            var userNo = $("input[name='userNo']").val();

            var period = $("input[name='period']").val();

            var regCount = $("input[name='regCount']").val();

            var trainerNo = ${authUser.userNo};

            if (!period || !regCount) {
                alert("입력 정보를 다시 확인해주세요.");
                return;
            }

            //데이터 전송
            $.ajax({
                //보낼 때 옵션
                url: "${pageContext.request.contextPath}/mypage/addPt",
                type: "post",
                data: {
                    userNo: userNo,
                    period: period,
                    regCount: regCount,
                    trainerNo: trainerNo
                },

                //받을 때 옵션
                dataType: "json",
                success: function (result) {

                    alert("PT 정보가 추가되었습니다.");

                    forceHideModal('#addUserModal');

                    location.reload(true);

                },
                error: function (XHR, status, error) {
                    alert("입력 정보를 다시 확인해주세요.");

                    console.error(status + " : " + error);
                }
            })

        }

        function checkEmpty() {
            var period = $("#addUserModal").find("input[name='period']").val();
            var regCount = $("#addUserModal").find("input[name='regCount']").val();

            if (period === "" || period == null || regCount === "" || regCount == null) {
                $("#addUserModal").find(".modal-confirm").addClass("off");
            } else {
                $("#addUserModal").find(".modal-confirm").removeClass("off");
            }
        }

        function drawChart(inbodyList) {
            var weightArr = [];
            var muscleMassArr = [];
            var percentFatArr = [];
            var bmiArr = [];
            var labelArr = [];
            var inbodyListLength = inbodyList.length - 1;
            for (var i = inbodyListLength; i >= 0; i--) {
                weightArr.push(inbodyList[i].weight);
                muscleMassArr.push(inbodyList[i].muscleMass);
                percentFatArr.push(inbodyList[i].percentFat);
                bmiArr.push(inbodyList[i].bmi);
                labelArr.push(inbodyList[i].measureDate);
            }

            var lineChartData = {
                labels: labelArr,
                datasets: [
                    {
                        label: '체중',
                        borderColor: '#cc2121',
                        backgroundColor: '#cc2121',
                        fill: false,
                        data: weightArr,
                        yAxisID: 'y-axis-1',
                    }, {
                        label: '골격근량',
                        borderColor: '#008526',
                        backgroundColor: '#008526',
                        fill: false,
                        data: muscleMassArr,
                        yAxisID: 'y-axis-1'
                    }, {
                        label: '체지방',
                        borderColor: '#ffc0cb',
                        backgroundColor: '#ffc0cb',
                        fill: false,
                        data: percentFatArr,
                        yAxisID: 'y-axis-2'
                    }, {
                        label: 'BMI',
                        borderColor: '#45474d',
                        backgroundColor: '#45474d',
                        fill: false,
                        data: bmiArr,
                        yAxisID: 'y-axis-2'
                    }
                ]
            };
            var chartCanvas = document.getElementById("canvas");
            var myLineChart = new Chart(chartCanvas, {
                type: 'line',
                data: lineChartData,
                options: {
                    responsive: false,
                    hoverMode: 'index',
                    stacked: false,
                    title: {
                        display: true,
                        text: '인바디 그래프'
                    },
                    scales: {
                        yAxes: [{
                            type: 'linear',
                            display: true,
                            position: 'left',
                            id: 'y-axis-1',
                        }, {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            id: 'y-axis-2',

                            // grid line settings
                            gridLines: {
                                drawOnChartArea: false
                            },
                        }],
                    }
                }
            });
        }

        function writeRecords(recordList) {
            var targetTab = $("#userInfoModal").find(".exercise-wrapper");
            var select = targetTab.find("select[name='recordDate']");
            var ul = targetTab.find("ul#recordList");
            select.html("");
            ul.html("");

            for (var i = 0; i < recordList.length; i++) {
                var recordDate = recordList[i].recordDate.substring(0,16);
                var unit = recordList[i].unit;
                switch (unit) {
                    case "kg" :
                        unit = "킬로그램";
                        break;
                    case "lbs" :
                        unit = "파운드";
                        break;
                    case "sec" :
                        unit = "초";
                        break;
                    default :
                        unit = "";
                }
                if(select.find("option[value='"+recordList[i].scheduleNo+"']").length === 0) {
                    select.prepend(
                        "<option value='"+ recordList[i].scheduleNo +"'>"+recordDate+"</option>"
                    );
                }
                ul.append(
                    "<li data-no='"+ recordList[i].scheduleNo +"'>" +
                    "<p class='name'>" + recordList[i].exName + "</p>" +
                    "<p class='part'>" + recordList[i].exPart + "</p>" +
                    "<p class='detail'>" +
                        "<span class='amount'>"+ recordList[i].amount +"</span>"+
                        "<span>"+ unit +"</span>"+
                        "<span> "+recordList[i].count+"회</span>"+
                    "</li>"
                );
            }
            select.prepend(
                "<option selected disabled>날짜를 선택해주세요</option>"
            );
        }
    </script>
</body>
</html>
