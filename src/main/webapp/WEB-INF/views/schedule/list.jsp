<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>복약 스케줄 리스트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css" type="text/css">
</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	

    <span class="info-text">복약 스케줄 리스트</span>
    
    <div class="box">
    <a href='${pageContext.request.contextPath}/schedule/add.do'>
        <button>신규 스케줄 등록</button>
    </a>
    
    <br><br>
    
    <c:forEach var="vo" items="${lvo}">
        <ul class="schedule">
            <li>
                제목 : <strong><c:out value="${vo.scheTitle}" /></strong> 
                (매일 <c:out value="${vo.scheTakeNum}" />회)
                <a href='${pageContext.request.contextPath}/schedule/edit.do?scheId=${vo.scheId}'>
                    <button>수정</button>
                </a>
                <a href='${pageContext.request.contextPath}/schedule/delete.do?scheId=${vo.scheId}'>
                    <button>삭제</button>
                </a>
            </li>
            <li>
                처방기간 : <c:out value="${vo.scheStartDate}" /> ~ 
                <span class="endDate"><c:out value="${vo.scheEndDate}" /></span>
            </li>
            <c:if test="${vo.timeList.isEmpty()}">
                <li class="addTime">
                    <a href="${pageContext.request.contextPath}/schedule/time/add1.do?scheId=${vo.scheId}">
                        알림 시간을 등록해주세요.
                    </a>
                </li>
            </c:if>
            <c:forEach var="timeVo" items="${vo.timeList}">
                <li>
                    <c:out value="${timeVo.timeName}" /> - <c:out value="${timeVo.timeAlarm}" />
                    <a href='${pageContext.request.contextPath}/schedule/time/edit.do?timeId=${timeVo.timeId}'>
                        <button>수정</button>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </c:forEach>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var today = new Date();
            var dateList = document.querySelectorAll(".endDate");
            var addTimeList = document.querySelectorAll(".addTime");
            
            for (var i = 0; i < dateList.length; i++) {
                var endDate = new Date(dateList[i].innerText);
                if (endDate < today) {
                    dateList[i].innerText += " [기간 만료]";
                    addTimeList[i].innerText = "등록된 알림이 없습니다.";
                }
            }
        });
    </script>
</div>
</body>
</html>
