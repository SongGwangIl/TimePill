<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header --%>
<c:import url="/WEB-INF/views/common/header.jsp" charEncoding="utf-8">
	<c:param name="title" value="TimePill - 처방약 등록"/>
</c:import>

<style>
.content-wrapper {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 90%;
	margin: 20px auto;
}
.single-line {
	width: 90%;
	text-align: center;
	padding: 10px;
	margin: 10px;
}

.same-line {
	justify-content: center;
	display: flex;
	width: 100%;
}
</style>

<div class="whiteBox">

<div class="content-wrapper">
	<h2 class="single-line">처방약 등록</h2>
	<form action="/medication/schedule${not empty result.prescMedId ? '/edit-med' : '/add-med'}" method="post">
		<div style="display: block;">
		<input type="hidden" name="prescMedId" value="${result.prescMedId}">
		<label for="prescMedName">처방약 이름</label> 
		<input type="text" name="prescMedName"placeholder="처방약 이름" value="${result.prescMedName}" required> <br>
		<label for="frequency">하루 복약횟수</label> 
		<select name="frequency">
			<option value=1 ${result.frequency eq '1' ? 'selected' : '' }>1회</option>
			<option value=2 ${result.frequency eq '2' ? 'selected' : '' }>2회</option>
			<option value=3 ${result.frequency eq '3' ? 'selected' : '' }>3회</option>
			<option value=4 ${result.frequency eq '4' ? 'selected' : '' }>4회</option>
		</select> <br>
		<label for="startDate">처방일자</label> 
		<input type="date" name="startDate" id="startDate" value="<fmt:formatDate value="${result.startDate}" pattern="yyyy-MM-dd" type="date"/>" required> <br>
		<label for="duration">처방기간</label> 
		<input type="number" name="duration" id="duration" min="1" value="${not empty result.duration ? result.duration : 1}" onclick="clearInput()" required>일 <br>
		<label for="endDate">만료일자</label> 
		<input type="date" name="endDate" id="endDate" value="<fmt:formatDate value="${result.endDate}" pattern="yyyy-MM-dd" type="date"/>" readonly> <br>
		<input type="submit" id="button" value="${empty result.prescMedName ? '등록' : '수정'}">
		<button type="button" onclick="location.href='/medication/schedule/list'">취소</button>
		</div>
	</form>
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


//공백제거
$('input').on('input', function() {
	$(this).val($(this).val().replace(/\s/g, ''));
});
</script>
	
</div>
<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>
	