<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>복약 스케쥴 리스트</title>
<style>
* {
	margin: 0 auto;
	text-align: center;
}

h1 {
	width: 300px;
	margin: 0 auto;
	text-align: center;
	padding: 20px;
}

ul {
	width: 500px;
	border: 1px solid black;
	list-style-type: none;
	padding: 10px;
	margin: 5px auto;
}

li {
	padding: 5px;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<h1>복약 스케쥴 리스트</h1>
	<a href='${pageContext.request.contextPath}/schedule/add.do'><button>신규
			스케쥴 등록</button></a>
	<br>
	<br>
	<c:forEach var="vo" items="${lvo}">
		<!-- 고유번호 : <c:out value= "${vo.scheId}"/> <br>  -->
		<ul class="schedule">
			<li>제목 : <strong><c:out value="${vo.scheTitle}" /></strong> (매일
				<c:out value="${vo.scheTakeNum}" />회) 
				<a href='${pageContext.request.contextPath}/schedule/delete.do?scheId=${vo.scheId}'><button>지우기</button></a>
			</li>

			<li>처방기간 : <c:out value="${vo.scheStartDate}" /> ~ <span class="endDate"><c:out
					value="${vo.scheEndDate}" /></span>
			</li>
			<c:if test="${vo.timeList.isEmpty()}">
				<li class="addTime"><a
					href="${pageContext.request.contextPath}/schedule/time/add1.do?scheId=${vo.scheId}">알림
						시간을 등록해주세요.</a></li>
			</c:if>
			<c:forEach var="timeVo" items="${vo.timeList}">
				<li><c:out value="${timeVo.timeName}" /> - <c:out
						value="${timeVo.timeAlarm}" /></li>
			</c:forEach>
		</ul>
	</c:forEach>
	
<script>
document.addEventListener("DOMContentLoaded", function(){
	
	var today = new Date();
	var dateList = document.querySelectorAll(".endDate");
	
	for(var i=0; i<dateList.length; i++) {
		var endDate = new Date(dateList[i].innerText);
		if(endDate < today){
			dateList[i].innerText += " [기간 만료]";
			var addtime = document.querySelectorAll(".addTime")[i]
			// addtime.removeChild(addtime.children[0]);
			addtime.innerText = "등록된 알림이 없습니다."
		}
	}
})
</script>

</body>
