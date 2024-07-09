<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/schedule/time/add3.do"
		method="post">
		<fieldset>
			<legend><c:out value="${svo.scheTitle}"/> 알람시간 등록 (3)</legend>
			<input type="hidden" name="scheId" value="${svo.scheId}"/>
			<ul>
				<label for="timeId">3회차 제목</label>
				<input type="text" name="timeName">
			</ul>
			<ul>
				<label for="scheStartDate">알림 시간</label>
				<input type="time" name="timeArlam"> 
			</ul>
            <ul>
				<label for="timeLimit">~ 시간 제한</label>
				<input type="time" name="timeLimit"> <br>
				위 시간이 지나면 복약 누락 처리됩니다.
			</ul>
			<ul>
				<label for="medLocation">디스펜서 칸 위치</label>
				<select name="medLocation">
					<option value=1 selected>1번</option>
					<option value=2>2번</option>
					<option value=3>3번</option>
				</select>
			</ul>
			<ul>
				<label for="reArlamTime">재알림 주기</label>
				<select name="reArlamTime">
					<option value=1>1분</option>
					<option value=3>3분</option>
					<option value=5>5분</option>
					<option value=10 selected>10분</option>
					<option value=30>30분</option>
					<option value=60>1시간</option>
				</select> 간격으로 
                <label for="reArlamCount"></label>
				<select name="reArlamCount">
					<option value=1>1회</option>
					<option value=2>2회</option>
					<option value=3 selected>3회</option>
					<option value=4>4회</option>
					<option value=5>5회</option>
                </select>
			</ul>
			</label> <input type="submit" value="다음">
		</fieldset>
	</form>
</body>
</html>