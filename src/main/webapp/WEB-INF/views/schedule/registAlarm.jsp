<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/add.css" type="text/css">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<span class="info-text GmarketSans">알람 설정</span>

	<div id="insertList" class="box GmarketSans">
		<div>
			<table>
				<th><td>알람활성화</td><td>알람타입</td><td>알람시간</td><td>알람만료시간</td><td>알람간격</td></th>
				<c:forEach var="result" items="${alarmList}" varStatus="status">
					<tr data-no="row-data">
						<td>
							<input type="hidden" name="alarmId" value="${result.alarmId}" data-no="${status.count}">
							<input type="checkbox" name="alarmUseAt" value="${result.alarmUseAt}" ${result.alarmUseAt eq 'Y' ? 'checked' : '' } data-no="${status.count}" onclick="toggleChk(this, ${status.count})">
						</td>
						<td>
						<c:choose>
							<c:when test="${result.alarmType eq '1'}">
								아침식전
							</c:when>
							<c:when test="${result.alarmType eq '2'}">
								아침식후
							</c:when>
							<c:when test="${result.alarmType eq '3'}">
								점심식전
							</c:when>
							<c:when test="${result.alarmType eq '4'}">
								점심식후
							</c:when>
							<c:when test="${result.alarmType eq '5'}">
								저녁식전
							</c:when>
							<c:when test="${result.alarmType eq '6'}">
								저녁식후
							</c:when>
							<c:when test="${result.alarmType eq '7'}">
								자기전
							</c:when>
						</c:choose>
						</td>
						<c:if test="${(status.count mod 2) ne 0}">
							<td rowspan="2">
								<!-- 알람 시간 -->
								<input type="time" name="alarmTime" value="${result.alarmTime}" data-no="${status.count}">
							</td>
						</c:if>
						<td>
							<!-- 알람 만료시간 -->
							<input type="number" name="alarmInterval" min="20" max="60" step="5" value="${result.alarmInterval}" data-no="${status.count}">
						</td>
						<td>
							<!-- 알람 간격 -->
							<input type="number" name="rptInterval" min="1" max="20" step="1" value="${result.rptInterval}" data-no="${status.count}">
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<button type="button" onclick="submit();">등록</button>
	</div>

<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
<script>
function submit () {
	if (!confirm("알람을 등록하시겠습니까?")) {
		return false;
	}
	// 알람정보 배열화
	function collectData() {
        var data = [];
        var rows = document.querySelectorAll('tr[data-no="row-data"]');
        var prevAlarmTime
        rows.forEach(function(row) {
            var alarmId = row.querySelector('input[name="alarmId"]').value;
            var alarmUseAt = row.querySelector('input[name="alarmUseAt"]').value;
        	// 식전 식후 알람시간 동일화 
        	var dataNo = row.querySelector('input[name="alarmId"]').getAttribute('data-no'); // 식전,식후 알람시간 동일화를 위한 값
            if (parseInt(dataNo) % 2 === 0) {
        		var alarmTime = prevAlarmTime;
            } else {
	            var alarmTime = row.querySelector('input[name="alarmTime"]').value;
	            prevAlarmTime = row.querySelector('input[name="alarmTime"]').value;
            }
            var alarmInterval = row.querySelector('input[name="alarmInterval"]').value;
            var rptInterval = row.querySelector('input[name="rptInterval"]').value;
            // 알람정보 배열에 삽입
            data.push({
                alarmId: alarmId,
                alarmUseAt: alarmUseAt,
                alarmTime: alarmTime,
                alarmInterval: alarmInterval,
                rptInterval: rptInterval
            });
        });
//      console.log(data);
        return data;
    }
	// 알람 저장
	var resultList = collectData();
	$.ajax({
		url: '/medication/schedule/set-alarm',
		type: 'post',
		contentType: 'application/json',
		data: JSON.stringify(resultList),
		success: function(response) {
			alert('알람 정보가 저장되었습니다.');
		},
		error: function(error) {
			console.error('Error occurred: ' + error);
			alert('오류가 발생했습니다.');
		}
	});
}

//체크박스 동작
function toggleChk(checkbox, count) {
	var isChecked = checkbox.checked;
	var value = isChecked ? "Y" : "N";
	checkbox.value = value;

	var fields = document.querySelectorAll('[data-no="'+count+'"]');
	fields.forEach(function(field) {
		field.readOnly = !isChecked;
	});
}

</script>
	
<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>