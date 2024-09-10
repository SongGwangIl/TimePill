<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sche_add.css" type="text/css">

<style>
.image {
	box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
	width: 310px;
	height: 638px;
	position: absolute;
	left: 590px;
	top: 316px;
	background-image:
		url(${pageContext.request.contextPath}/resources/img/image1.png);
	background-repeat: no-repeat;
	background-size: cover;
	z-index: 1; /* Ensures it's on top of other elements */
}

.med-title .med-info {
	border: 1px solid #ccc;
	border-radius: 3px;
	display: none;
	position: absolute;
/* 	bottom: 100%; */
	left: 0;
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


<span class="info-text">복약 스케줄 리스트</span>

<div class="image">
</div>
<div class="desc_text">
	<p>복용할 알람 스케줄을 <br> 등록하고 알림을 <br> 받아보세요!</p>
</div>
<div style="display: none;">
	<a href='${pageContext.request.contextPath}/medication/schedule/reg-alarm'>
		<div class="btn1">
			<img class="pill" src="${pageContext.request.contextPath}/resources/img/timpill.svg"></i>
			<p>스케줄 등록</p>
		</div>
	</a> 
</div>
<div>
	<a href='${pageContext.request.contextPath}/medication/schedule/reg-med'>
		<div class="btn1">
			<img class="pill" src="${pageContext.request.contextPath}/resources/img/timpill.svg"></i>
			<p>처방약 등록</p>
		</div>
	</a>
</div>


<div class="box">
	<div class="ab"></div>
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


<script>
</script>

<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

