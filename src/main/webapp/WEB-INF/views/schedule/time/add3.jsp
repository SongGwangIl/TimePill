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
<title>알람시간 등록 - 3</title>
<style>
form {
	width: 500px;
	margin : 0 auto;
}
label {
	margin : 0 auto;
	text-align: center;
}
</style>
</head>
<body>
	<form action="${pageContext.request.contextPath}/schedule/time/add3.do"
		method="post">
		<fieldset>
			<legend><c:out value="${svo.scheTitle} 의 알람시간 등록 (3)"/> </legend>
			<input type="hidden" name="scheId" value="${svo.scheId}"/>
			<ul>
				<label for="timeId">3회차 제목</label>
				<input type="text" name="timeName">
			</ul>
			<ul>
				<label for="scheStartDate">알림 시간</label>
				<input type="time" name="timeAlarm"> 
			</ul>
            <ul>
				<label for="timeLimit">~ 시간 제한</label>
				<input type="time" name="timeLimit"> <br>
				<i>위 시간이 지나면 복약 누락 처리됩니다.</i>
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
				<label for="reAlarmTime">재알림 주기</label>
				<select name="reAlarmTime">
					<option value=1>1분</option>
					<option value=3>3분</option>
					<option value=5>5분</option>
					<option value=10 selected>10분</option>
					<option value=30>30분</option>
					<option value=60>1시간</option>
				</select> 간격으로 
                <label for="reAlarmCount"></label>
				<select name="reAlarmCount">
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