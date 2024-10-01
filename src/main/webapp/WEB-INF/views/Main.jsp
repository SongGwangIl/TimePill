<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	<h2 class="single-line">복약 스케줄 리스트</h2>
	<div class="same-line">
		<div style="margin-right: 20px;">
			<div style="text-align: center;">
				<a href='/medication'>
					<p>복약 리스트</p>
				</a>
 			</div>

			<form action="/kakao/message" method="post">
				<input type="submit" value="메세지 보내기 테스트">
			</form>

		</div>
		
		<div>
			<c:forEach var="resultAlarmType" items="${scheList}">
				<c:if test="${resultAlarmType.alarmType ne previousAlarmType}">
					<c:set var="previousAlarmType" value="${resultAlarmType.alarmType}" />
					<div class="tablewrap">
						<p>
						<c:choose>
							<c:when test="${resultAlarmType.alarmType eq '1'}">
								아침
							</c:when>
							<c:when test="${resultAlarmType.alarmType eq '2'}">
								점심
							</c:when>
							<c:when test="${resultAlarmType.alarmType eq '3'}">
								저녁
							</c:when>
							<c:when test="${resultAlarmType.alarmType eq '4'}">
								취침전
							</c:when>
						</c:choose>
						<fmt:parseDate value="${resultAlarmType.alarmTime}" pattern="HH:mm:ss" var="alarmTime"/>
						
    					<input type="time" class="timepick" name="alarmTime" value="<fmt:formatDate value="${alarmTime}" pattern="HH:mm"/>" data-alarm="${resultAlarmType.alarmId}" required>
						</p>
						<c:forEach var="result" items="${scheList}">
							<c:if test="${result.alarmType eq  resultAlarmType.alarmType}">
								<c:choose>
									<c:when test="${result.scheChk eq 'Y'}">
										<c:set var="icoUrl" value="/resources/img/ico-unchecked.png"/>
									</c:when>
									<c:otherwise>
										<c:set var="icoUrl" value="/resources/img/ico-unchecked.png"/>
									</c:otherwise>
								</c:choose>
								<img class="sche-chk" alt="체크" src="${icoUrl}" width="14px" height="14px">
								<span class="med-title">
									${result.medName}
									<div class="med-info">
										<p>처방일 : <fmt:formatDate value="${result.startDate}" pattern="yyyy-MM-dd" type="date"/></p>
										<p>복약만료일자 : <fmt:formatDate value="${result.endDate}" pattern="yyyy-MM-dd" type="date"/></p>
									</div>
								</span>
								<br>
							</c:if>
						</c:forEach>
					</div>
					</c:if>
			</c:forEach>
			<c:if test="${empty scheList}">
				<div class="tablewrap">
					<p>등록된 알람이 없습니다.</p>
				</div>
			</c:if>
		</div>
	</div>
	
</div>


</div>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<<script>
$(document).ready(function () {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	// 알람 시간 변경
	$('.timepick').on('focusout', function () {
		let alarmTime = $(this).val();
		let alarmId = $(this).data('alarm');
		console.log(alarmTime, alarmId);
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
	
	
	$('.sche-chk').on('click', function () {
		let icoSrc = $(this).attr('src');
		if (icoSrc == '/resources/img/ico-checked.png') {
			$(this).attr('src', '/resources/img/ico-unchecked.png');
		} else {
			$(this).attr('src', '/resources/img/ico-checked.png');
		}
		
	});
});
</script>


<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>

