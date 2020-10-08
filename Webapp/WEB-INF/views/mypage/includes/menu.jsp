<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy" var="year"/>
<fmt:formatDate value="${now}" pattern="MM" var="month"/>
<fmt:formatDate value="${now}" pattern="dd" var="day"/>
<!-- 달력 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>


</style>

<div class="summary-wrapper">
    <div class="summary clearfix">
        <p class="date">${year}년 ${month}월 ${day}일</p>

        <c:choose>
            <c:when test="${authUser.userType eq 'trainer'}">
                <div class="statistics">
                    <h3 class="title left">평점</h3>
                    <div class="info">${summary.summaryVo.avgScore}점/
                            ${summary.summaryVo.reviewCount}개
                    </div>

                    <h3 class="title left">현재 회원 수</h3>
                    <div class="info">${summary.summaryVo.countCurrent}명</div>

                    <h3 class="title left">누적 회원 수</h3>
                    <div class="info">${summary.summaryVo.countAll}명</div>
                </div>
                <div class="schedule-wrapper">
                    <h3 class="title">오늘의 일정</h3>
                    <ul class="schedule-list">
                        <c:forEach items="${summary.scheduleList}" var="schedule">
                            <li class="schedule"><span class="name">${schedule.userName}
										회원님</span> <span class="time">${schedule.startTime} -
                                    ${schedule.endTime}</span></li>
                        </c:forEach>
                    </ul>

                </div>
            </c:when>

            <c:otherwise>
                <div class="statistics">
                    <h3 class="title left">다음 PT</h3>
                    <div class="info">${summaryNormal.nextPt.startTime}-
                            ${summaryNormal.nextPt.endTime}</div>

                    <h3 class="title left">등록기간</h3>
                    <div class="info">${summaryNormal.ptVo.startDate}~
                            ${summaryNormal.ptVo.endDate}</div>

                    <h3 class="title left">잔여횟수</h3>
                    <div class="info">${summaryNormal.ptVo.regCount-summaryNormal.ptVo.scheduleCount}
                        / ${summaryNormal.ptVo.regCount}</div>
                </div>

                <div class="schedule-wrapper">
                    <h3 class="title">예약 현황</h3>
                    <div class="reserved-wrapper">
                        <ul class="schedule-list">
                            <c:forEach items="${summaryNormal.reserveList}" var="reservation">
                                <c:choose>
                                    <c:when test="${reservation.state eq 'confirm'}">
                                        <li class="schedule">
                                            <span class="time">
                                                <i class="fas fa-check"></i>${reservation.startTime} (확정)
                                            </span>
                                        </li>
                                    </c:when>
                                    <c:when test="${reservation.state eq 'traineeReserve'}">
                                        <li class="schedule">
                                            <span class="time">
                                                <i class="fas fa-spinner"></i>${reservation.startTime} (대기)
                                            </span>
                                        </li>
                                    </c:when>
                                    <c:when test="${reservation.state eq 'trainerReserve'}">
                                        <li class="schedule">
                                            <span class="time question"
                                                  onclick="popMenu(${reservation.scheduleNo},$(this))">
                                                <i class="fas fa-question"></i> ${reservation.startTime} (요청)
                                            </span>
                                        </li>
                                    </c:when>
                                    <c:when test="${reservation.state eq 'trainerReject'}">
                                        <li class="schedule">
                                            <span class="time rejected"
                                                  onclick="reserveDel(${reservation.scheduleNo},$(this))">
                                                <i class="fas fa-times"></i>${reservation.startTime} (반려)
                                            </span>
                                        </li>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </div>
                    <button id="btn-reserved" class="button sub">PT 예약하기</button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div class="menu-wrapper">
    <ul class="menu clearfix">
        <c:choose>
            <c:when test="${authUser.userType eq 'trainer'}">
                <li><a
                        href="${pageContext.request.contextPath}/mypage/schedule">스케쥴</a></li>
                <li><a
                        href="${pageContext.request.contextPath}/mypage/manageExercise">운동
                    관리</a></li>
                <li><a
                        href="${pageContext.request.contextPath}/mypage/manageUser">회원
                    관리</a></li>
                <li><a href="${pageContext.request.contextPath}/mypage/profile">프로필
                    수정</a></li>
            </c:when>
            <c:otherwise>
                <li><a
                        href="${pageContext.request.contextPath}/mypage/exerciseRecord">운동기록</a></li>
                <li><a
                        href="${pageContext.request.contextPath}/mypage/inbodyRecord">인바디내역</a></li>
                <li><a href="${pageContext.request.contextPath}/mypage/profile">프로필
                    수정</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</div>

<c:if test="${authUser.userType ne 'trainer'}">
    <div class="modal-layer hide-off" id="reservationModal">
        <div class="modal-wrapper">

            <div id="modalCalender"></div>

            <div class="reserv-info">
                <h3 class="title"> · 예약하기 </h3>
                <div class="time-wrapper">
                    <p class="text">예약 날짜</p>
                    <div id="reserveDate"> 날짜를 선택 해 주세요 :)</div>
                </div>
                <div class="time-wrapper">
                    <p class="text">예약 시간</p>
                    <div id="reserveTime">
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
                </div>
                <div class="time-wrapper">
                    <p class="text">소요시간(분)</p>
                    <input type="number" name="amount" placeholder="00분" value="">
                </div>
            </div>

            <div class="modal-btn-area">
                <button type="button" class="modal-cancel" onclick="forceHideModal('#reservationModal')">취소</button>
                <button type="button" class="modal-confirm" onclick="scheduleReservation()">확인</button>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        $(document).ready(function () {
            $(window).on("click", function () {
                $(".btnPop").remove();

            });
        });

        /* ?  클릭  */
        function popMenu(scheduleNo, target) {
            event.stopPropagation();
            $(".tipMsg").remove();
            $(".btnPop").remove();
			console.log("asdf");
            target.prepend(
                "<div class='btnPop'>" +
                "<button type='button' class='button btn_modify' onclick='changeScheduleState(" + scheduleNo + ",\"confirm\");'>수락</button>" +
                "<button type='button' class='button btn_modify' onclick='changeScheduleState(" + scheduleNo + ",\"traineeReject\");'>거절</button>" +
                "<div>"
            );

        };

        /* 예약버튼클릭 */
        $("#btn-reserved").on("click", function () {
            /* 초기화 */
            $("#modalCalender").datepicker("destroy");
            $("#reserveDate").text(" 날짜를 선택 해 주세요 :) ");
            $("#reserveTime select").prop('disabled', true);

            /* 날짜 설정 */
            $("#modalCalender").datepicker({
                dateFormat: 'yy-mm-dd',
                defaultDate: null,
                minDate: new Date(getTimeStamp()),
                maxDate: new Date("${summaryNormal.ptVo.endDate}"),
                onSelect: function (d) {
                    clickDate(d)
                }
            });

            $("a.ui-state-default").removeClass("ui-state-active");
            /* 모달 열기 */
            showModal("#reservationModal");
        });

        /* 날짜 클릭했을 때 */
        function clickDate(date) {
            $("#reserveDate").text(date);
            $("#reserveTime select").prop('disabled', false);
        }

        function scheduleReservation() {
            var modal = $("#reservationModal");
            var ptNo = ${summaryNormal.ptVo.ptNo};
            var date = $("#reserveDate").text();
            var time = modal.find("input[name='startTime']:checked").val();
            var hour = parseInt(modal.find("select[name='startHour']").find("option:selected").val());
            var minute = modal.find("select[name='startMinute']").find("option:selected").val();
            var amount = modal.find("input[name='amount']").val();
            var startTime;

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
            var scheduleVo = {
                startTime: startTime,
                amount: amount,
                ptNo: ptNo,
                state: "traineeReserve"
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

        function changeScheduleState(scheduleNo, state) {
            var resultText;
            var scheduleVo = {
                scheduleNo: scheduleNo,
                state: state
            }
            if (state === "traineeReject") {
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
                        alert("예약이 " + resultText + "되었습니다.");
                        window.location.reload();
                    }
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
        }

        /* 반려된 예약 삭제 */
        function reserveDel(scheduleNo, target) {

            alert("반려된 예약이 삭제됩니다.");

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
                        target.parents("li").remove();
                    } else {
                        alert("관리자에게 문의 바랍니다 :(");
                    }
                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
        };
    </script>

</c:if>


<script type="text/javascript">

    /* 오늘날짜 가져오기 */
    function getTimeStamp() {
        var d = new Date();
        var s =
            leadingZeros(d.getFullYear(), 4) + '-' +
            leadingZeros(d.getMonth() + 1, 2) + '-' +
            leadingZeros(d.getDate() + 1, 2);
        return s;
    }

    /* 날짜에 0채우기 */
    function leadingZeros(n, digits) {
        var zero = '';
        n = n.toString();

        if (n.length < digits) {
            for (i = 0; i < digits - n.length; i++)
                zero += '0';
        }
        return zero + n;
    }


</script>

