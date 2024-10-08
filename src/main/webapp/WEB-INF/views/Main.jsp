<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="TimePill - 스케줄 관리"/>
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

.med-title .med-info {
	border: 1px solid #ccc;
	border-radius: 3px;
	display: none;
	position: absolute;
	background-color: #fff;
	z-index: 1000;
}

.med-title:hover .med-info {
	display: block;
}

p, span {
	margin: 5px;
}
.timepick {
	border: 0px;
/* 	pointer-events: none; */
}
</style>

<div class="whiteBox">

<div class="content-wrapper">
	<h2 class="single-line" style="margin: 0;">복약 스케줄 리스트</h2>
	<div class="single-line" style="margin: 0;">
		<div style="margin-bottom: 10px;">
			<div style="text-align: center;">
				<a href='/medication'>복약 리스트</a>
 			</div>

			<form action="/kakao/message" method="post">
				<input type="submit" value="메세지 보내기 테스트">
				<sec:csrfInput />
			</form>
		</div>
		
		<div>
			<c:forEach var="resultAlarm" items="${scheList}">
				<c:if test="${resultAlarm.alarmType ne previousAlarmType}">
					<c:set var="previousAlarmType" value="${resultAlarm.alarmType}" />
					<div class="tablewrap" style="display: inline-block; vertical-align: top; border: 1px solid #ccc">
						
						<c:choose>
							<c:when test="${resultAlarm.alarmType eq '1'}">
								아침
							</c:when>
							<c:when test="${resultAlarm.alarmType eq '2'}">
								점심
							</c:when>
							<c:when test="${resultAlarm.alarmType eq '3'}">
								저녁
							</c:when>
							<c:when test="${resultAlarm.alarmType eq '4'}">
								취침전
							</c:when>
						</c:choose>
						<br>
						
						<fmt:parseDate value="${resultAlarm.alarmTime}" pattern="HH:mm:ss" var="alarmTime"/>
    					<input type="time" class="timepick" step="300" name="alarmTime" value="<fmt:formatDate value="${alarmTime}" pattern="HH:mm"/>" data-alarm="${resultAlarm.alarmId}" required>
						<br>
						
						<c:forEach var="result" items="${scheList}">
							<c:if test="${not empty result.medId}">
								<c:if test="${result.alarmType eq resultAlarm.alarmType}">
									<c:choose>
										<c:when test="${result.scheChk eq 'Y'}">
											<c:set var="icoUrl" value="/resources/img/ico-checked.png"/>
										</c:when>
										<c:otherwise>
											<c:set var="icoUrl" value="/resources/img/ico-unchecked.png"/>
										</c:otherwise>
									</c:choose>
									<img class="sche-chk" alt="체크" src="${icoUrl}" width="14px" height="14px" data-med-id="${result.medId}" data-alarm-id="${resultAlarm.alarmId}">
									<span class="med-title">
										${result.medName}
										<div class="med-info">
											<p>처방일 : <fmt:formatDate value="${result.startDate}" pattern="yyyy-MM-dd" type="date"/></p>
											<p>복약만료일자 : <fmt:formatDate value="${result.endDate}" pattern="yyyy-MM-dd" type="date"/></p>
										</div>
									</span>
									<br>
								</c:if>
							</c:if>
						</c:forEach>
					</div>
					</c:if>
			</c:forEach>
			<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
			<script type="text/javascript">
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				let uncompTodoCntList;
				async function getUncompTodoCntList () {
					await $.ajax({
						url: '/mthSchedule',
						type: 'post',
						data: {
							mthStartDate: firstDate
							, mthEndDate: lastDate
						},
						beforeSend: function(xhr){
							xhr.setRequestHeader(header, token);
							xhr.setRequestHeader("Accept", "application/json");
						},
						success: function (response) {
// 							console.log(response.mthScheList);
							uncompTodoCntList = response.mthScheList; // 날짜별 미완료 스케줄 리스트
							
						},
						error: function (error) {
							console.error('Error occurred: ' + error);
							alert('오류가 발생했습니다.');
						}
					});
					setTodoList();
				}
			</script>
			
			<c:import url="/calendar"/>
			<!-- 캘린터 선택한 날짜 변수 : selectedDay -->
			
			<button type="button" id="chk">체크</button>
			
			<!-- 이번달 총 스케줄 -->
			<c:forEach var="result" items="${mthScheList}">
			${result.medId} : <fmt:formatDate value="${result.startDate}" pattern="yyyy-MM-dd" type="date"/> : <fmt:formatDate value="${result.endDate}" pattern="yyyy-MM-dd" type="date"/> : ${result.totalDayTodo}
			<br>
			</c:forEach>
			<hr>
			<!-- 이번달 완료된 스케줄 -->
			<c:forEach var="result" items="${mthCompScheList}">
			${result.medId} : ${result.scheDate} : ${result.completedDayTodo}
			<br>
			</c:forEach>
		</div>
	</div>
	
</div>


</div>
<script src="${pageContext.request.contextPath}/resources/js/calendar/mainCalendar.js"></script>
<<script>



$(document).ready(function () {
	
	// 알람 시간 변경
	$('.timepick').on('focusout', function () {
		const timepick = $(this);
		const alarmTime = timepick.val();
		const alarmId = timepick.data('alarm');

		$.ajax({
			url: '/alarm',
			type: 'post',
			data: {
				alarmTime: alarmTime
				, alarmId: alarmId
			},
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
				xhr.setRequestHeader("Accept", "application/json");
			},
			success: function(response) {
				alert('알람 시간이 수정되었습니다.');
			},
			error: function(error) {
				console.error('Error occurred: ' + error);
				alert('오류가 발생했습니다.');
			}
		});
	});
	
	// 복약 스케줄 완료 체크 동작
	$(document).on('click', '.sche-chk', function () {
		const chk = $(this);
		const icoSrc = chk.attr('src');
		const medId = chk.data('med-id');
		const alarmId = chk.data('alarm-id');
		const scheChk = icoSrc === '/resources/img/ico-checked.png' ? 'N' : 'Y';
		
		$.ajax({
			url: '/log',
			type: 'post',
			data: {
				medId: medId
				, alarmId: alarmId
				, scheChk: scheChk
			},
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
				xhr.setRequestHeader("Accept", "application/json");
			},
			success: function(response) {
				if (response.scheChk === 'Y') {
					chk.attr('src', '/resources/img/ico-checked.png');
				} else if (response.scheChk === 'N') {
					chk.attr('src', '/resources/img/ico-unchecked.png');
				} else {
					alert('처리 중 문제가 발생했습니다.');
				}
			},
			error: function(error) {
				console.error('Error occurred: ' + error);
				alert('오류가 발생했습니다.');
			}
		});		
	});	
	
	// 날짜별 미완료 스케줄 리스트 가져오기
	$(document).on('click', '#chk', getUncompTodoCntList);
});

function setTodoList(){
	let keys = Object.keys(uncompTodoCntList).map(key=>+key.substring(8));
	let values = Object.values(uncompTodoCntList);
	let thisSpans = document.querySelectorAll('.this>span');
	
	for(let i=0; i<keys.length; i++){
		for(thisSpan of thisSpans){
			if(keys[i] == thisSpan.textContent){
				let p = document.createElement('p');
				p.textContent = values[i];
				thisSpan.after(p);
			}
		}
	}	
}
</script>


<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>

