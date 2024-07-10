<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 복약 기록 조회 </title>
<link href="${pageContext.request.contextPath}/resources/css/recordlist.css" rel="stylesheet">
</head>
<body>


<p><br>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> </p>
<br><br>

<div id="container">

<!-- 조회 날짜 선택 -->
<form action="${pageContext.request.contextPath}/record/selectChart" method="post">
	<label for="takeDate"> 조회 날짜 선택 : </label>
	<input type="date" id="takeDate" name="takeDate">
	<input type="submit" value="조회">
</form> <br><br>

<h3> ${name} 님의 복약 상황을 확인해보세요!</h3>
<div style="width:600px; height:400px; margin : 0 auto">
	<canvas id="myChart"></canvas>
</div>

차트 알아보기 쉽게 + 꾸미기 
리스트페이지 들어갈 때 같이 조회할 수 있도록
차트 바 별로 넣을 데이터값이나 속성등에 대해서 어떻게 할지 option

</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>

var jsonData = ${JSON}
var jsonObject = JSON.stringify(jsonData);
var jData = JSON.parse(jsonObject);
		
var labelList = new Array();
var valueList = new Array();
var colorList = new Array();

function colorize() {
	var r = Math.floor(Math.random()*200);
	var g = Math.floor(Math.random()*200);
	var b = Math.floor(Math.random()*200);
	var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
	return color;
}

for(var i = 0; i<jData.length; i++) {
	var d = jData[i];
	labelList.push(d.Date);
	valueList.push(d.Rate);
	colorList.push(colorize());
}


var data = {
			labels: labelList,
			datasets: [{
					backgroundColor: colorList,
					data : valueList
			}],
			options : {
				title : {
				display : true,
				text: '이게될까?'
				}
		}
};
		
var ctx1 = document.getElementById('myChart').getContext('2d');
new Chart(ctx1, {
	      type: 'bar',
		  data: data
});


</script>
</body>
</html>