schedule list.jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


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
	background-image: url(${pageContext.request.contextPath}/resources/img/image1.png);
	background-repeat: no-repeat;
	background-size: cover;
	z-index: 100; /* Ensures it's on top of other elements */
}
</style>


<span class="info-text">복약 스케줄 리스트</span>

<div class="image"></div>
<div class="desc_text">
	<p>복용할 알람 스케줄을 <br> 등록하고 알림을 <br> 받아보세요!</p>
</div>
<div>
	<a href='${pageContext.request.contextPath}/schedule/add.do'>
		<div class="btn1"> 
			<img class="pill" src="${pageContext.request.contextPath}/resources/img/timpill.svg"></i>
			<p>
			신규 스케줄 등록
			</p>
		</div>
	</a>
</div>


<div class="box">
	<div class="ab"></div>


	<c:forEach var="vo" items="${lvo}">
		<div class="tablewrap">
	
		<table>
			<tr>
				<td colspan="2" >
					<strong><c:out value="${vo.scheTitle}" /></strong> 
					(매일 <c:out value="${vo.scheTakeNum}" />회)
				</td>
			</tr>

			<tr>
				<td colspan="2" >
					<span><c:out value="${vo.scheStartDate}" /></span> ~ 
					<span class="endDate"><c:out value="${vo.scheEndDate}" /></span>
				</td>
			</tr>
			<tr>
				<c:if test="${vo.timeList.isEmpty()}">
						<td>
							<a class="light" href="${pageContext.request.contextPath}/schedule/time/add1.do?scheId=${vo.scheId}">
							알림 시간을 등록해주세요!
							</a>
						</td>
				</c:if>
				
			<c:forEach var="timeVo" items="${vo.timeList}">
				<tr>
					<td>
						<span class="bold">
							<c:out value="${timeVo.timeName}" /> 
						</span>
						<span class="light">
							<c:out value="${timeVo.timeAlarm}" />
						</span>
					</td>

					<td>
						<a href='${pageContext.request.contextPath}/schedule/time/edit.do?timeId=${timeVo.timeId}'>
							수정 
						</a>
					</td>
				</tr>
			</c:forEach>
			</tr>
			<tr>
				<td colspan="2" >
					<br>
					<a class ="a" 
						href='${pageContext.request.contextPath}/schedule/edit.do?scheId=${vo.scheId}'>
						<div class="btn2">
							수정
						</div>
					</a> 
					<a class ="a" 
						href='${pageContext.request.contextPath}/schedule/delete.do?scheId=${vo.scheId}'>
						<div class="btn2">
							삭제
						</div>
					</a>
				</td>
			</tr>
		</table>
			</div>
		<br><br>
		
	</c:forEach>
	
</div>


<script>
	document.addEventListener("DOMContentLoaded", function() {
		var today = new Date();
		var dateList = document.querySelectorAll(".endDate");
		var addTimeList = document.querySelectorAll(".addTime");

		for (var i = 0; i < dateList.length; i++) {
			var endDate = new Date(dateList[i].innerText);
			if (endDate < today) {
				dateList[i].innerText += " [만료]";
				addTimeList[i].innerText = "등록된 알림이 없습니다.";
			}
		}
	});
</script>

<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

