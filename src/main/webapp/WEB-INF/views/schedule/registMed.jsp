<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/add.css" type="text/css">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<span class="info-text GmarketSans">처방약 등록</span>

	<div id="insertList" class="box GmarketSans">
		<div>
		<form action="/medication/schedule${empty result.prescMedId ? '/add-med' : '/edit-med'}" method="post">
			<input type="hidden" name="prescMedId" value="${result.prescMedId}">
			<label for="prescMedName">처방약 이름</label> 
			<input type="text" name="prescMedName" class="GmarketSans" placeholder="처방약 이름" value="${result.prescMedName}"> 
			<label for="frequency">하루 복약횟수</label> 
			<select name="frequency" class="GmarketSans">
				<option value=1 ${result.frequency eq '1' ? 'selected' : '' }>1회</option>
				<option value=2 ${result.frequency eq '2' ? 'selected' : '' }>2회</option>
				<option value=3 ${result.frequency eq '3' ? 'selected' : '' }>3회</option>
				<option value=4 ${result.frequency eq '4' ? 'selected' : '' }>4회</option>
			</select> 
			<label for="startDate">처방일자</label> 
			<input type="date" name="startDate" id="startDate" class="GmarketSans" value="<fmt:formatDate value="${result.startDate}" pattern="yyyy-MM-dd" type="date"/>"> 
			<label for="duration">처방기간</label> 
			<input type="number" name="duration" id="duration" value="${not empty result.duration ? result.duration : 1}" onclick="clearInput()">일
			<label for="endDate">만료일자</label> 
			<input type="date" name="endDate" id="endDate" min="" class="GmarketSans" value="<fmt:formatDate value="${result.endDate}" pattern="yyyy-MM-dd" type="date"/>" readonly> 
			<input type="submit" id="button" class="GmarketSans" value="${empty result.prescMedName ? '등록' : '수정'}">
		</form>
		</div>
	</div>

<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
<script>
// 시작일자 설정(수정이 아닌 경우 오늘날짜로 셋)
if (document.getElementById('startDate').value === "") {
	var date = new Date();
	var offset = date.getTimezoneOffset() * 60000; // 한국 시간 오프셋
	var localDate = new Date(date.getTime() - offset);
	var today = localDate.toISOString().substring(0, 10);
       document.getElementById('startDate').value = today;
	updateEndDate();
}

// 만료일자 계산
function updateEndDate() {
	var startDate = new Date(document.getElementById('startDate').value);
	var duration = parseInt(document.getElementById('duration').value);
	startDate.setDate(startDate.getDate() + duration);
	var endDate = startDate.toISOString().substring(0, 10);
	document.getElementById('endDate').value = endDate;
}

document.getElementById('duration').addEventListener('input', updateEndDate);
	
</script>
	
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>