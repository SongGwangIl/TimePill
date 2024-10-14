<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:choose>
	<c:when test="${empty result.medId}">
		<c:import url="/header" charEncoding="utf-8">
			<c:param name="title" value="복약등록 - TimePill"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/header" charEncoding="utf-8">
			<c:param name="title" value="복약수정 - TimePill"/>
		</c:import>
	</c:otherwise>
</c:choose>

<!-- 컨텐츠 시작 -->
<div id="contents" class="">
	
	<!-- 타이틀 -->
	<div>
		<c:choose>
			<c:when test="${empty result.medId}">
				<h1 class="txa subtitle">복약 등록</h1>
			</c:when>
			<c:otherwise>
				<h1 class="txa subtitle">복약 수정</h1>
			</c:otherwise>
		</c:choose>
	</div>
	
	<!-- 작성 영역 -->
	<form id="frm" action="/medication/${result.medId}${empty result.medId ? 'add' : '/edit'}" method="post">
		<div style="display: block;">
		<input type="hidden" name="medId" value="${result.medId}">
		<input type="text" name="medName"placeholder="복약이름" value="${result.medName}" required> <br>
		
		<c:forEach var="resultAlarmType" items="${result.alarmTypes}">
			<c:choose>
				<c:when test="${resultAlarmType eq '1'}">
					<c:set var="alarmOn1" value="true"/>
				</c:when>
				<c:when test="${resultAlarmType eq '2'}">
					<c:set var="alarmOn2" value="true"/>
				</c:when>
				<c:when test="${resultAlarmType eq '3'}">
					<c:set var="alarmOn3" value="true"/>
				</c:when>
				<c:when test="${resultAlarmType eq '4'}">
					<c:set var="alarmOn4" value="true"/>
				</c:when>
			</c:choose>
		</c:forEach>
		<input type="checkbox" id="alarm1" name="alarmTypes" value="1" ${not empty alarmOn1 ? 'checked' : ''}>
		<label for="alarm1">아침</label>
		<input type="checkbox" id="alarm2" name="alarmTypes" value="2" ${not empty alarmOn2 ? 'checked' : ''}>
		<label for="alarm2">점심</label>
		<input type="checkbox" id="alarm3" name="alarmTypes" value="3" ${not empty alarmOn3 ? 'checked' : ''}>
		<label for="alarm3">저녁</label>
		<input type="checkbox" id="alarm4" name="alarmTypes" value="4" ${not empty alarmOn4 ? 'checked' : ''}>
		<label for="alarm4">취침전</label>
		<br>
		
		<label for="startDate">처방일자</label> 
		<input type="text" name="startDate" id="start" value="<fmt:formatDate value="${result.startDate}" pattern="yyyy-MM-dd"/>" required> <br>
		<label for="endDate">만료일자</label> 
		<input type="text" name="endDate" id="end" value="<fmt:formatDate value="${result.endDate}" pattern="yyyy-MM-dd"/>" required> <br>
		
		<c:import url="/calendar"/>
		
		<button type="submit" id="btn-reg" >${empty result.medId ? '등록' : '수정'}</button> <br>
		<c:if test="${not empty result.medId}">
			<button type="submit" id="btn-del">삭제</button> <br>
		</c:if>
		<button type="button" onclick="location.href='/medication'">취소</button>
		</div>
		<sec:csrfInput/>
	</form>
	
</div>
<!-- 컨텐츠 끝 -->

<script src="/resources/js/calendar/medCalendar.js"></script>
<script>
$(document).ready(function () {
	let medId = "${result.medId}";
	
	console.log(medId);
	
	//공백제거
	$('input').on('input', function() {
		$(this).val($(this).val().replace(/\s/g, ''));
	});
	
	// 삭제버튼
	$('#btn-del').on('click', function () {
		event.preventDefault();
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$('#frm').attr('action', '/medication/'+medId+'/del');
		$('#frm').submit();
	});
});
</script>
	
<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>
	