<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>복약 스케줄 리스트</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            text-align: center;
        }
        body {
            padding: 20px;
        }
        h1 {
            margin-bottom: 20px;
        }
        ul.schedule {
            width: 500px;
            border: 1px solid black;
            list-style-type: none;
            padding: 10px;
            margin: 5px auto;
        }
        li {
            padding: 5px;
        }
        button {
            margin-left: 10px;
        }
        .addTime a {
            color: red;
        }
    </style>
</head>
<body>

	<!-- 헤더 -->
	<p><br>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/> </p>
	<br><br>
	
	<hr>

    <h1>복약 스케줄 리스트</h1>
    
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

</body>
</html>
