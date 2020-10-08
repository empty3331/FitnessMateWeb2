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
            <p>인바디내역</p>
                
            <div class="box_color">
                <p>측정 날짜</p>
                <div>
                    <ol class="dateList">
                        <c:forEach items="${inbodyInfo.inbodyList}" var="inbody">
	                        <li data-inbodyno="${inbody.inbodyNo}">${inbody.measureDate}</li>
                        </c:forEach>
                    </ol>
                </div>
            </div>

            <div class="tableBox">
                <p class="measureDate">${inbodyInfo.recentInbody.measureDate}</p>
                <table>
                    <tr>
                        <th>체중 (kg)</th>
                        <td id="weight">${inbodyInfo.recentInbody.weight} kg</td>
                    <tr>
                        <th>체지방률 (%)</th>
                        <td id="percentFat">${inbodyInfo.recentInbody.percentFat} %</td>
                    </tr>
                    <tr>
                        <th>골격근량 (kg)</th>
                        <td id="muscleMass">${inbodyInfo.recentInbody.muscleMass} kg</td>
                    </tr>
                    <tr>
                        <th>BMI (kg/m²)</th>
                        <td id="bmi">${inbodyInfo.recentInbody.bmi} kg/m²</td>
                    </tr>
                </table>
            </div>        

			<canvas id="canvas" width="500" height="400">
            </canvas>

        </div>
    </div>
    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    

</body>

<script type="text/javascript">

	$(document).ready(function(){
		 
		var weightArr = [];
		var muscleMassArr = [];
		var percentFatArr = [];
		var bmiArr = [];
		var labelArr = [];
		
		<c:forEach items="${inbodyInfo.inbodyList}" var="graphInfo">
		 
			weightArr.push("${graphInfo.weight}");
			muscleMassArr.push("${graphInfo.muscleMass}");
			percentFatArr.push("${graphInfo.percentFat}");
			bmiArr.push("${graphInfo.bmi}");
			labelArr.push("${graphInfo.measureDate}");
	 
		</c:forEach>

		var lineChartData = {
			labels : labelArr,
			datasets : [ {
				label : '체중',
				borderColor : '#cc2121',
				backgroundColor : '#cc2121',
				fill : false,
				data : weightArr,
				yAxisID : 'y-axis-1',
			}, {
				label : '골격근량',
				borderColor : '#008526',
				backgroundColor : '#008526',
				fill : false,
				data : muscleMassArr,
				yAxisID : 'y-axis-1'
			}, {
				label : '체지방',
				borderColor : '#ffc0cb',
				backgroundColor : '#ffc0cb',
				fill : false,
				data : percentFatArr,
				yAxisID : 'y-axis-2'
			}, {
				label : 'BMI',
				borderColor : '#45474d',
				backgroundColor : '#45474d',
				fill : false,
				data : bmiArr,
				yAxisID : 'y-axis-2'
			} ]
		};
		var chartCanvas = document.getElementById("canvas");
		var myLineChart = new Chart(chartCanvas, {
			type : 'line',
			data : lineChartData,
			options : {
				responsive : false,
				hoverMode : 'index',
				stacked : false,
				title : {
					display : true,
					text : '인바디 그래프'
				},
				scales : {
					yAxes : [ {
						type : 'linear',
						display : true,
						position : 'left',
						id : 'y-axis-1',
					}, {
						type : 'linear',
						display : true,
						position : 'right',
						id : 'y-axis-2',

						// grid line settings
						gridLines : {
							drawOnChartArea : false
						},
					} ],
				}
			}
		});

	});
	
	$("ol.dateList li").on("click", function(){
		
		$("p.measureDate").text("");
		$("td#weight").text("");
		$("td#percentFat").text("");
		$("td#muscleMass").text("");
		$("td#bmi").text("");
		
		var inbodyNo = $(this).data("inbodyno");

		//데이터 전송
		$.ajax({
			//보낼 때 옵션
			url : "${pageContext.request.contextPath}/mypage/getInbodyInfo",
			type : "post",
			data : {inbodyNo: inbodyNo},
					
			//받을 때 옵션
			dataType : "json",
			success : function(inbodyInfo) {
				
				$("p.measureDate").text(inbodyInfo.measureDate);
				$("td#weight").text(inbodyInfo.weight+" kg");
				$("td#percentFat").text(inbodyInfo.percentFat+" %");
				$("td#muscleMass").text(inbodyInfo.muscleMass+" kg");
				$("td#bmi").text(inbodyInfo.bmi+" kg/m²");
				
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		})

    });
	

</script>

</html>
