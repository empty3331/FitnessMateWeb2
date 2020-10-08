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

    <!-- calendar css/js -->
    <link href='${pageContext.request.contextPath}/assets/js/calendar/main.css' rel='stylesheet'>
    <script src='${pageContext.request.contextPath}/assets/js/calendar/main.js'></script>
    <script src='${pageContext.request.contextPath}/assets/js/calendar/theme-chooser.js'></script>

    <!-- 해당 페이지 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mypage2.css">

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar;

            initThemeChooser({

                init: function (themeSystem) {
                    calendar = new FullCalendar.Calendar(calendarEl, {
                        themeSystem: themeSystem,
                        locales: 'ko',
                        headerToolbar: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
                        },
                        weekNumbers: false,
                        navLinks: true, // can click day/week names to navigate views
                        editable: false,
                        selectable: true,
                        nowIndicator: true,
                        dayMaxEvents: false, // allow "more" link when too many events
                        // showNonCurrentDates: false,
                        dateClick: function (info) {
                            //TODO - 날짜 클릭시 발생 이벤트
                            resetModal();
                            $("#addScheduleModal").find("input[name='date']").val(info.dateStr);
                            showModal("#addScheduleModal");
                        },
                        eventClick: function (info) {
                            //TODO - 일정 클릭시 발생 이벤트
                            event.stopPropagation();
                            $(".btn_pop").remove();

                            var target = $(info.el);
                            var left = target.offset().left + 120;
                            var top = target.offset().top - 60;

                            var state = info.event.extendedProps.state;
                            var element;
                            switch (state) {
                                case "confirm" :
                                    element =
                                        "<button type='button' class='button btn_modify' onclick='changeScheduleState(" + info.event.extendedProps.dataId + ",\"trainerReject\");'>예약 취소</button>" +
                                        "<a href='${pageContext.request.contextPath}/mypage/recordEx?scheduleNo=" + info.event.extendedProps.dataId + "' class='button'>운동 시작</a>";
                                    break;
                                case "trainerReserve" :
                                    element = ""+
                                        "<button type='button' class='button btn_modify' onclick='deleteSchedule(" + info.event.extendedProps.dataId + ");'>예약 취소</button>"
                                    break;
                                case "traineeReserve" :
                                    element = "<button type='button' class='button btn_modify' onclick='changeScheduleState(" + info.event.extendedProps.dataId + ",\"confirm\");'>예약 수락</button>" +
                                        "<button type='button' class='button btn_modify' onclick='changeScheduleState(" + info.event.extendedProps.dataId + ",\"trainerReject\");'>예약 반려</button>"
                                    break;
                                case "traineeReject" :
                                    element = "<button type='button' class='button btn_modify' onclick='deleteSchedule(" + info.event.extendedProps.dataId + ");'>예약 삭제</button>"
                                    break;
                            }

                            $("#calendar").append(
                                "<div class='btn_pop'>" +
                                "<button type='button' class='button btn_modify' onclick='btnModify(" + info.event.extendedProps.dataId + ");'>예약 변경</button>" + element +
                                "<div>"
                            );
                            $(".btn_pop").css({
                                left: left,
                                top: top
                            });
                            if (info.event.extendedProps.state !== "confirm") {
                                $(".btn_pop").find("a.button").addClass("disabled");
                            }
                        },
                        height: 'auto',
                        events: [
                            <c:forEach items="${scheduleList}" var="schedule">
                            {
                                <c:choose>
                                <c:when test="${schedule.state eq 'confirm'}">
                                color: "#007bff",
                                </c:when>
                                <c:when test="${schedule.state eq 'trainerReserve'}">
                                color: "#ffc107",
                                </c:when>
                                <c:when test="${schedule.state eq 'traineeReserve'}">
                                color: "#28a745",
                                </c:when>
                                <c:when test="${schedule.state eq 'traineeReject'}">
                                color: "#dc3545",
                                </c:when>
                                <c:otherwise>
                                    display: "none",
                                </c:otherwise>
                                </c:choose>
                                title: '${schedule.userName}(${schedule.amount}분)',
                                start: '${schedule.startTime}',
                                end: '${schedule.endTime}',
                                extendedProps: {
                                    dataId: ${schedule.scheduleNo},
                                    state: "${schedule.state}"
                                }
                            },
                            </c:forEach>
                        ],
                        eventDisplay: "list-item"
                    });
                    calendar.render();
                }
            });
        });
    </script>
</head>
<body>
    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
    <div id="container" class="calendar-wrapper">
        <c:import url="/WEB-INF/views/mypage/includes/menu.jsp"></c:import>
        <div class="wrapper">
            <ul class="schedule-guide">
               <li class="confirm">예약 확정</li>
               <li class="reserved">고객 신청</li>
               <li class="waiting">확인 대기</li>
               <li class="rejected">예약 거절</li>
            </ul>
            <div id='top'>

                <div class='left'>

                    <div id='theme-system-selector' class='selector'>
                        Theme System:

                        <select>
                            <option value='bootstrap' selected>Bootstrap 4</option>
                            <option value='standard'>unthemed</option>
                        </select>
                    </div>

                    <div data-theme-system="bootstrap" class='selector' style='display:none'>
                        Theme Name:

                        <select>
                            <option value='' selected>Default</option>
                            <option value='cerulean'>Cerulean</option>
                            <option value='cosmo'>Cosmo</option>
                            <option value='cyborg'>Cyborg</option>
                            <option value='darkly'>Darkly</option>
                            <option value='flatly'>Flatly</option>
                            <option value='journal'>Journal</option>
                            <option value='litera'>Litera</option>
                            <option value='lumen'>Lumen</option>
                            <option value='lux'>Lux</option>
                            <option value='materia'>Materia</option>
                            <option value='minty'>Minty</option>
                            <option value='pulse'>Pulse</option>
                            <option value='sandstone'>Sandstone</option>
                            <option value='simplex'>Simplex</option>
                            <option value='sketchy'>Sketchy</option>
                            <option value='slate'>Slate</option>
                            <option value='solar'>Solar</option>
                            <option value='spacelab'>Spacelab</option>
                            <option value='superhero'>Superhero</option>
                            <option value='united'>United</option>
                            <option value='yeti'>Yeti</option>
                        </select>
                    </div>

                    <span id='loading' style='display:none'>loading theme...</span>

                </div>

                <div class='right'>
      <span class='credits' data-credit-id='bootstrap-standard' style='display:none'>
        <a href='https://getbootstrap.com/docs/3.3/' target='_blank'>Theme by Bootstrap</a>
      </span>
                    <span class='credits' data-credit-id='bootstrap-custom' style='display:none'>
        <a href='https://bootswatch.com/' target='_blank'>Theme by Bootswatch</a>
      </span>
                </div>

                <div class='clear'></div>
            </div>
            <div id='calendar'></div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    <div class="modal-layer hide-off" id="addScheduleModal">
        <div class="modal-wrapper">
            <div class="modal-content">
                <div class="">
                    <input type="hidden" name="date">
                    <p class="text">시작시간</p>
                    <ol>
                        <li>
                            <input type="radio" id="startAm" name="startTime" value="am" checked>
                            <label for="startAm">AM</label>
                        </li>
                        <li>
                            <input type="radio" id="startPm" name="startTime" value="pm">
                            <label for="startPm">PM</label>
                        </li>
                    </ol>
                    <select name="startHour">
                        <option value="00" selected>0시</option>
                        <option value="01">1시</option>
                        <option value="02">2시</option>
                        <option value="03">3시</option>
                        <option value="04">4시</option>
                        <option value="05">5시</option>
                        <option value="06">6시</option>
                        <option value="07">7시</option>
                        <option value="08">8시</option>
                        <option value="09">9시</option>
                        <option value="10">10시</option>
                        <option value="11">11시</option>
                    </select>
                    <select name="startMinute">
                        <option value="00" selected>00분</option>
                        <option value="10">10분</option>
                        <option value="20">20분</option>
                        <option value="30">30분</option>
                        <option value="40">40분</option>
                        <option value="50">50분</option>
                    </select>
                </div>
                <div>
                    <p class="text">소요시간(분)</p>
                    <input type="number" name="amount" placeholder="00분">
                </div>
                <div>
                    <p class="text">회원이름</p>
                    <select name="ptNo">
                        <option disabled selected value="default">회원 선택</option>
                        <c:forEach items="${ptList}" var="ptVo">
                            <c:if test="${ptVo.proceed eq true}">
                                <option value="${ptVo.ptNo}">${ptVo.name}(${ptVo.userId})</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="modal-btn-area">
                <button type="button" class="modal-cancel" onclick="forceHideModal('#addScheduleModal')">취소</button>
                <button type="button" class="modal-confirm" onclick="addSchedule();">확인</button>
            </div>
        </div>
    </div>
    <div class="modal-layer hide-off" id="modifyScheduleModal">
        <div class="modal-wrapper">
            <div class="modal-content">
                <div class="">
                    <input type="hidden" name="date">
                    <p class="text">시작시간</p>
                    <ol>
                        <li>
                            <input type="radio" id="modifyStartAm" name="startTime" value="am" checked>
                            <label for="modifyStartAm">AM</label>
                        </li>
                        <li>
                            <input type="radio" id="modifyStartPm" name="startTime" value="pm">
                            <label for="modifyStartPm">PM</label>
                        </li>
                    </ol>
                    <select name="startHour">
                        <option value="00" selected>0시</option>
                        <option value="01">1시</option>
                        <option value="02">2시</option>
                        <option value="03">3시</option>
                        <option value="04">4시</option>
                        <option value="05">5시</option>
                        <option value="06">6시</option>
                        <option value="07">7시</option>
                        <option value="08">8시</option>
                        <option value="09">9시</option>
                        <option value="10">10시</option>
                        <option value="11">11시</option>
                    </select>
                    <select name="startMinute">
                        <option value="00" selected>00분</option>
                        <option value="10">10분</option>
                        <option value="20">20분</option>
                        <option value="30">30분</option>
                        <option value="40">40분</option>
                        <option value="50">50분</option>
                    </select>
                </div>
                <div>
                    <p class="text">소요시간(분)</p>
                    <input type="number" name="amount" placeholder="00분" value="">
                </div>
                <div>
                    <p class="text">회원이름</p>
                    <select name="ptNo" class="disabled">
                        <option disabled selected value="default">회원 선택</option>
                        <c:forEach items="${ptList}" var="ptVo">
                            <option value="${ptVo.ptNo}">${ptVo.name}(${ptVo.userId})</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="modal-btn-area">
                <button type="button" class="modal-cancel" onclick="forceHideModal('#modifyScheduleModal')">취소</button>
                <button type="button" class="modal-confirm" onclick="">확인</button>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        $(document).ready(function () {
            //화면 아무곳이나 클릭시 팝업메뉴 제거
            $(window).on("click", function () {
                $(".btn_pop").remove();

            });
        });//레디함수종료

        function btnModify(scheduleNo) {
            var modal = $("#modifyScheduleModal");
            var date = modal.find("input[name='date']");
            var hour = modal.find("select[name='startHour']");
            var minute = modal.find("select[name='startMinute']");
            var amount = modal.find("input[name='amount']");
            var ptNo = modal.find("select[name='ptNo']");
            var scheduleVo = {
                scheduleNo: scheduleNo,
                trainerNo: ${authUser.userNo}
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/getSchedule",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(scheduleVo),
                dataType: "json",
                success: function (schedule) {
                    var dateVal = schedule.startTime.substring(0, 10);
                    var hourVal = schedule.startTime.substring(11, 13);
                    var minuteVal = schedule.startTime.substring(14, 16);

                    if (parseInt(hourVal) >= 12) {
                        modal.find("input#modifyStartPm").prop("checked", true);
                        hourVal = parseInt(hourVal) - 12;
                        if (hourVal < 10) {
                            hourVal = 0 + hourVal.toString();
                        }
                    } else {
                        modal.find("input#modifyStartAm").prop("checked", true);
                    }
                    date.val(dateVal);
                    hour.find("option[value='" + hourVal + "']").prop("selected", true);
                    minute.find("option[value='" + minuteVal + "']").prop("selected", true);
                    amount.val(schedule.amount);
                    ptNo.find("option[value='" + schedule.ptNo + "']").prop("selected", true);

                    modal.find(".modal-confirm").attr("onclick", "modifySchedule('" + schedule.scheduleNo + "')");
                    modal.find(".delete-btn").attr("onclick", "deleteSchedule('" + schedule.scheduleNo + "')");
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
            showModal("#modifyScheduleModal");
        }

        function addSchedule() {
            var modal = $("#addScheduleModal");
            var date = modal.find("input[name='date']").val();
            var time = modal.find("input[name='startTime']:checked").val();
            var hour = parseInt(modal.find("select[name='startHour']").find("option:selected").val());
            var minute = modal.find("select[name='startMinute']").find("option:selected").val();
            var amount = modal.find("input[name='amount']").val();
            var startTime;
            var ptNo = modal.find("select[name='ptNo']").find("option:selected").val();

            if (time === 'pm') {
                hour += 12;
            }
            if (hour < 10) {
                hour = 0 + hour.toString();
            }

            startTime = date + " " + hour + minute;


            if (amount === "" || amount == null) {
                alert("소요시간을 입력해주세요!");
                return false;
            }

            if (ptNo === "default") {
                alert("회원을 선택해주세요!");
                return false;
            }

            var scheduleVo = {
                startTime: startTime,
                amount: amount,
                ptNo: ptNo,
                state: "trainerReserve"
            }


            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/addSchedule",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(scheduleVo),
                dataType: "json",
                success: function (result) {
                    alert("스케쥴이 추가되었습니다.");
                    window.location.reload();
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
        }

        function modifySchedule(scheduleNo) {
            var modal = $("#modifyScheduleModal");
            var date = modal.find("input[name='date']").val();
            var time = modal.find("input[name='startTime']:checked").val();
            var hour = parseInt(modal.find("select[name='startHour']").find("option:selected").val());
            var minute = modal.find("select[name='startMinute']").find("option:selected").val();
            var amount = modal.find("input[name='amount']").val();
            var startTime;
            var ptNo = modal.find("select[name='ptNo']").find("option:selected").val();

            if (time === 'pm') {
                hour += 12;
            }
            if (hour < 10) {
                hour = 0 + hour.toString();
            }

            startTime = date + " " + hour + minute;


            if (amount === "" || amount == null) {
                alert("소요시간을 입력해주세요!");
                return false;
            }

            if (ptNo === "default") {
                alert("회원을 선택해주세요!");
                return false;
            }

            var scheduleVo = {
                startTime: startTime,
                amount: amount,
                ptNo: ptNo,
                scheduleNo: scheduleNo,
                state: "trainerReserve"
            }


            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/modifySchedule",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(scheduleVo),
                dataType: "json",
                success: function (result) {
                    if (result) {
                        alert("스케쥴이 수정되었습니다.");
                        window.location.reload();
                    }
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
        }

        function changeScheduleState(scheduleNo, state) {
            var resultText;
            var scheduleVo = {
                scheduleNo: scheduleNo,
                state: state
            }
            if(state === "trainerReject") {
                resultText = "취소";
            } else {
                resultText = "수락";
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/changeScheduleState",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(scheduleVo),
                dataType: "json",
                success: function (result) {
                    if (result) {
                        alert("예약이 "+ resultText +"되었습니다.");
                        window.location.reload();
                    }
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
        }

        function deleteSchedule(scheduleNo) {
            var scheduleVo = {
                scheduleNo: scheduleNo
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/deleteSchedule",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(scheduleVo),
                dataType: "json",
                success: function (result) {
                    if (result) {
                        alert("예약이 삭제되었습니다.");
                        window.location.reload();
                    }
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
        }

        function resetModal() {
            var modal = $("#addScheduleModal");
            modal.find("input[name='date']").val("");
            modal.find("select").find("option:first-child").prop("selected", true);
            modal.find("input#startAm").prop("checked", true);
            modal.find("input#endAm").prop("checked", true);
        }
    </script>
</body>
</html>
