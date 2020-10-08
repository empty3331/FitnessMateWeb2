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

    <!-- slide -->
    <link
            href="${pageContext.request.contextPath}/assets/js/swiper-4.2.6/dist/css/swiper.min.css"
            rel="stylesheet">
    <script
            src="${pageContext.request.contextPath}/assets/js/swiper-4.2.6/dist/js/swiper.min.js"></script>
            
    <%--차트--%>
    <script src="${pageContext.request.contextPath}/assets/js/chart/dist/Chart.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/js/chart/dist/Chart.min.css">

    <!-- 해당 페이지 css -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/mypage.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/mypage2.css">

</head>

<body>
    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
    <div id="container">
        <c:import url="/WEB-INF/views/mypage/includes/menu.jsp"></c:import>
        <div class="wrapper content-wrapper">
            <p>운동 내역</p>

            <div id="first_select" class="box_color">
                <p>운동 날짜</p>
                <div>
                    <ul>
                        <c:forEach items="${exMap.exRecordDate}" var="date">
                            <li onclick='showDateList(${date.scheduleNo},"${date.startTime}")'>${date.startTime}</li>
                        </c:forEach>

                    </ul>
                </div>
            </div>

            <div id="second_select" class="box_color recordList">
                <p class="exDate">${exMap.exRecordDate[0].startTime}</p>
                <div>
                    <c:if test="${exMap.exTitleList.size() eq 0}">
                        <div class="emtMsg">
                            이 날 운동 기록이 없어요 :(
                        </div>
                    </c:if>
                    <c:forEach items="${exMap.exTitleList}" var="title">
                        <table>
                            <tr>
                                <th rowspan="${title.setCount+1}">${title.exPart}</th>
                                <td class="exTitle">${title.exName}(${title.setCount} set)</td>
                            </tr>
                            <c:forEach items="${exMap.exSetList}" var="detail">
                                <c:if test="${title.exName eq detail.exName}">
                                    <tr>
                                        <td>${detail.amount}${title.unit} ${detail.count}회</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </table>
                    </c:forEach>
                </div>
            </div>
        	
        	<div class="exSelect-wrapper">
        		<select id='exPart'>
        			<option value="">운동부위</option>
        			<c:forEach items="${exMap.exPartList}" var="part">
        				<option value="${part.exPartNo}">${part.exPartName}</option>
        			</c:forEach>
        		</select>
        		
				<input type="text" name="exList" list="exList" placeholder="운동이름">
			    <datalist id="exList">
			    	<c:forEach items="${exMap.exList}" var="ex">
			    		<option value="${ex.exName}" data-exno="${ex.exNo}"></option>
			    	</c:forEach>
				</datalist>
				
				<button id="btn-ShowGraph" class="button main">운동량 변화 보기</button>
				
				<p>
					<i class="fas fa-exclamation-circle"></i>
					운동을 선택하시면 변화 그래프를 보실 수 있어요 :)
				</p>
				
	        	<canvas id="canvas" width="500" height="400">
	        	</canvas>
        
        	</div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    <script type="text/javascript">
    
    /* 운동부위 변경되었을 때 데이터리스트 변화 */
    $("#exPart").on("change", function(){
    	var thisPartNo = $(this).val();
    	
    	$("input[name='exList']").val("");
    	$("datalist").empty();
    	
    	var str = ""
    	
   		<c:forEach items = "${exMap.exList}" var="ex">
	    	if( thisPartNo == "" ){
    			str += '<option value="${ex.exName}" data-exno="${ex.exNo}"></option>';
	    	}else {
	    		if(thisPartNo == '${ex.exPartNo}'){
	    			str += '<option value="${ex.exName}" data-exno="${ex.exNo}"></option>';
	    		}
	    	}
   		</c:forEach>
    	
    	$("datalist").append(str);    	
    	
    });
    
    $("#btn-ShowGraph").on("click", function(){
    	var exName = $("input[name='exList']").val();
    	var exNo = $("option[value='"+exName+"']").data("exno");
    	
    	var userNo = ${authUser.userNo};
    	
    	if( exNo ){
	    	
            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/showExGraph",
                type: "post",
                data: {userNo: userNo,
                		exNo: exNo},

                dataType: "json",
                success: function (graphInfo) {
			    	$(".exSelect-wrapper > p").remove();
			    	$("input[name='exList']").val("");

                    $("#canvas").removeAttr("style");
                    $("#canvas").attr("width", "500");
                    $("#canvas").attr("height", "400");
			    	drawChart(exName, graphInfo);

                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });

    	}else{
    		$(".exSelect-wrapper > p").html('<i class="fas fa-exclamation-circle"></i> 운동 이름을 선택해 주셔야 해요 :( ');
    		alert(" 운동 이름을 선택해 주셔야 해요 :( ");
    	}
    		
    	
    });
    		
    /* 그래프 그리기 함수 */
	function drawChart(exName, graphInfo) {
	    var amountArr = [];
	    var countArr = [];
	    var labelArr = [];
	    var listLength = graphInfo.length - 1;
	    
	    for (var i = listLength; i >= 0; i--) {
	    	amountArr.push(graphInfo[i].maxAmount);
	    	countArr.push(graphInfo[i].maxCount);
	        labelArr.push(graphInfo[i].exDate);
	    }
	
	    var lineChartData = {
	        labels: labelArr,
	        datasets: [
	            {
	                label: '최대중량/최대시간',
	                borderColor: '#cc2121',
	                backgroundColor: '#cc2121',
	                fill: false,
	                data: amountArr,
	                yAxisID: 'y-axis-1',
	            }, {
	                label: '최대횟수',
	                borderColor: '#008526',
	                backgroundColor: '#008526',
	                fill: false,
	                data: countArr,
	                yAxisID: 'y-axis-1'
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
	                text: exName+' 운동량 변화 그래프'
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

    	/* 날짜 클릭했을 때 운동 기록 보기 */
        function showDateList(scheduleNo, date) {
            $(".recordList>div").children().remove();
            $("p.exDate").text(date);

            $.ajax({
                url: "${pageContext.request.contextPath}/mypage/showExRecord",
                type: "post",
                data: {scheduleNo: scheduleNo},

                dataType: "json",
                success: function (map) {

                    if (map.thisExList.length != 0) {
                        var str = '';
                        for (i = 0; i < map.thisExList.length; i++) {
                            str += '<table>';
                            str += '	<tr>';
                            str += '		<th rowspan="' + (map.thisExList[i].setCount + 1) + '">' + map.thisExList[i].exPart + '</th>';
                            str += '		<td class="exTitle">' + map.thisExList[i].exName + '(' + map.thisExList[i].setCount + ' set)</td>';
                            str += '	</tr>';

                            for (j = 0; j < map.thisSetList.length; j++) {
                                if (map.thisExList[i].exName == map.thisSetList[j].exName) {
                                    str += '			<tr>';
                                    str += '				<td>' + map.thisSetList[j].amount + map.thisExList[i].unit + ' ' + map.thisSetList[j].count + '회</td>';
                                    str += '			</tr>';
                                }
                            }
                            str += '</table>';
                        }
                        $(".recordList>div").append(str);

                    } else {
                        $(".recordList>div").append('<div class="emtMsg"> 이 날 운동 기록이 없어요 :( </div>');
                    }

                },
                error: function (XHR, status, error) {
                    console.error(status + ":" + error);
                }
            });
        };


    </script>
</body>
</html>
