<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>알람시간 수정</title>
    <style>
        form {
            width: 500px;
            margin: 0 auto;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="submit"] {
            display: block;
            margin: 20px auto;
        }
        ul {
            list-style: none;
            padding: 0;
            margin-bottom: 15px;
        }
        i {
            font-size: 0.9em;
            color: gray;
        }
    </style>
</head>

<body>
    <form action="${pageContext.request.contextPath}/schedule/time/edit.do" method="post">
        <fieldset>
            <legend><c:out value="알람시간 수정" /></legend>
            
            <input type="hidden" name="timeId" value="${svo.timeId}" />
            
            <ul>
                <label for="timeName">제목</label>
                <input type="text" name="timeName" value="${svo.timeName}" />
            </ul>
            
            <ul>
                <label for="timeAlarm">알림 시간</label>
                <input type="time" name="timeAlarm" value="${svo.timeAlarm}" />
            </ul>
            
            <ul>
                <label for="timeLimit">~ 시간 제한</label>
                <input type="time" name="timeLimit" value="${svo.timeLimit}" />
                <i>위 시간이 지나면 복약 누락 처리됩니다.</i>
            </ul>
            
            <ul>
                <label for="medLocation">디스펜서 칸 위치</label>
                <select name="medLocation">
                    <option value="1" ${svo.medLocation == 1 ? "selected" : ""}>1번</option>
                    <option value="2" ${svo.medLocation == 2 ? "selected" : ""}>2번</option>
                    <option value="3" ${svo.medLocation == 3 ? "selected" : ""}>3번</option>
                </select>
            </ul>
            
            <ul>
                <label for="reAlarmTime">재알림 주기</label>
                <select name="reAlarmTime">
                    <option value="1" ${svo.reAlarmTime == 1 ? "selected" : ""}>1분</option>
                    <option value="3" ${svo.reAlarmTime == 3 ? "selected" : ""}>3분</option>
                    <option value="5" ${svo.reAlarmTime == 5 ? "selected" : ""}>5분</option>
                    <option value="10" ${svo.reAlarmTime == 10 ? "selected" : ""}>10분</option>
                    <option value="30" ${svo.reAlarmTime == 30 ? "selected" : ""}>30분</option>
                    <option value="60" ${svo.reAlarmTime == 60 ? "selected" : ""}>1시간</option>
                </select>
                간격으로 
                <label for="reAlarmCount">재알림 횟수</label>
                <select name="reAlarmCount">
                    <option value="1" ${svo.reAlarmCount == 1 ? "selected" : ""}>1회</option>
                    <option value="2" ${svo.reAlarmCount == 2 ? "selected" : ""}>2회</option>
                    <option value="3" ${svo.reAlarmCount == 3 ? "selected" : ""}>3회</option>
                    <option value="4" ${svo.reAlarmCount == 4 ? "selected" : ""}>4회</option>
                    <option value="5" ${svo.reAlarmCount == 5 ? "selected" : ""}>5회</option>
                </select>
            </ul>
            
            <input type="submit" value="수정" />
        </fieldset>
    </form>
</body>
</html>