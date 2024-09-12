<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header --%>
<c:import url="/WEB-INF/views/common/header.jsp" charEncoding="utf-8">
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
</style>

<div class="whiteBox">

<div class="content-wrapper">
	<h2 class="single-line">복약 스케줄 리스트</h2>
	<div class="same-line">
		<div>
			<div style="text-align: center;">
				<p>복용할 약의 스케줄을</p>
				<p>등록하고 알림을</p> 
				<p>받아보세요!</p>
			</div>
			<div style="text-align: center;">
				<a href='/medication/schedule/reg-med'>
					<img class="pill" src="/resources/img/timpill.svg">
					<p>처방약 등록</p>
				</a>
				<a href='/medication/schedule/reg-alarm'>
					<img class="pill" src="/resources/img/timpill.svg">
					<p>알람 등록</p>
				</a> 
 			</div>
		</div>
		
		<div style="width: 20%;"></div>
		
		
		<div>
			<c:forEach var="resultAlarmType" items="${scheList}">
				<c:if test="${resultAlarmType.alarmType ne previousAlarmType}">
					<div class="tablewrap">
						 <c:set var="previousAlarmType" value="${resultAlarmType.alarmType}" />
						<p>
						<c:choose>
							<c:when test="${resultAlarmType.alarmType eq '1'}">
								아침식전
							</c:when>
							<c:when test="${resultAlarmType.alarmType eq '2'}">
								아침식후
							</c:when>
							<c:when test="${resultAlarmType.alarmType eq '3'}">
								점심식전
							</c:when>
							<c:when test="${resultAlarmType.alarmType eq '4'}">
								점심식후
							</c:when>
							<c:when test="${resultAlarmType.alarmType eq '5'}">
								저녁식전
							</c:when>
							<c:when test="${resultAlarmType.alarmType eq '6'}">
								저녁식후
							</c:when>
							<c:when test="${resultAlarmType.alarmType eq '7'}">
								자기전
							</c:when>
						</c:choose>
						<fmt:parseDate value="${resultAlarmType.alarmTime}" pattern="HH:mm:ss" var="alarmTime"/>
						<span>[알람 시간 : <fmt:formatDate value="${alarmTime}" pattern="HH:mm"/>]</span>
						</p>
						<c:forEach var="result" items="${scheList}">
							<c:if test="${result.alarmType eq resultAlarmType.alarmType}">
								<span class="med-title">
									<c:url var="editMedInfo" value="/medication/schedule/reg-med">
										<c:param name="prescMedId">${result.prescMedId}</c:param>
									</c:url>
									<a href="${editMedInfo}">
										<<c:out value="${result.prescMedName}"/>>
									</a>
									<div class="med-info">
										<p>처방일 : <fmt:formatDate value="${result.startDate}" pattern="yyyy-MM-dd" type="date"/></p>
										<p>처방기간 : ${result.duration}일</p>
										<p>복약만료일자 : <fmt:formatDate value="${result.endDate}" pattern="yyyy-MM-dd" type="date"/></p>
										<p>하루 복약 횟수 : 하루 ${result.frequency}회</p>
									</div>
								</span>
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
<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>

