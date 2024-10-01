<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header --%>
<c:import url="/WEB-INF/views/common/header.jsp" charEncoding="utf-8">
	<c:param name="title" value="TimePill - 알람 설정"/>
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

table * {
	padding: 5px;
}
</style>


<div class="whiteBox">
	<div class="content-wrapper">
		<h2 class="single-line">알람 설정</h2>
			<div style="justify-content: center; align-items: center; text-align: center;">
				<table style="text-align: center;">
					<thead>
						<tr>
							<th>알람타입</th>
							<th>알람시간</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${alarmList}" varStatus="status">
							<tr data-no="row-data">
								<td>
								<c:choose>
									<c:when test="${result.alarmType eq '1'}">
										아침
									</c:when>
									<c:when test="${result.alarmType eq '2'}">
										점심
									</c:when>
									<c:when test="${result.alarmType eq '3'}">
										저녁
									</c:when>
									<c:when test="${result.alarmType eq '4'}">
										취침전
									</c:when>
								</c:choose>
								</td>
								<td>
									<!-- 알람 시간 -->
									<c:choose>
										<c:when test="${status.count <= 1}">
											<select name="alarmHour" required>
											<c:forEach begin="05" end="11" step="1" varStatus="time">
												<option value="${time.index}" ${fn:split(result.alarmTime,':')[0] eq time.index ? 'selected' : '' } >${time.index}</option>
											</c:forEach>
											</select>
										</c:when>
										<c:when test="${status.count <= 2}">
											<select name="alarmHour" required>
											<c:forEach begin="11" end="16" step="1" varStatus="time">
												<option value="${time.index}" ${fn:split(result.alarmTime,':')[0] eq time.index ? 'selected' : '' }>${time.index}</option>
											</c:forEach>
											</select>
										</c:when>
										<c:when test="${status.count <= 3}">
											<select name="alarmHour" required>
											<c:forEach begin="16" end="20" step="01" varStatus="time">
												<option value="${time.index}" ${fn:split(result.alarmTime,':')[0] eq time.index ? 'selected' : '' }>${time.index}</option>
											</c:forEach>
											</select>
										</c:when>
										<c:when test="${status.count == 4}">
											<select name="alarmHour" required>
											<c:forEach begin="20" end="23" step="01" varStatus="time">
												<option value="${time.index}" ${fn:split(result.alarmTime,':')[0] eq time.index ? 'selected' : '' }>${time.index}</option>
											</c:forEach>
											</select>
										</c:when>
									</c:choose>시
									<input type="number" name="alarmMin" min="0" max="59" step="1" value="${fn:split(result.alarmTime,':')[1]}" data-no="${status.count}" required>
									분
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button type="button" onclick="submit();">등록</button>
				<button type="button" onclick="location.href='/schedule/list'">취소</button>
			</div>
	</div>
	
</div>

<script src="/resources/js/common/jquery-3.7.1.min.js"></script>
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
            
			var alarmHour = row.querySelector('select[name="alarmHour"]').value; // 시간
			var alarmMin = row.querySelector('input[name="alarmMin"]').value; // 분
            var alarmTime = alarmHour + ':' + alarmMin; // 알람시간
            
            // 알람정보 배열에 삽입
            data.push({
                alarmId: alarmId,
                alarmTime: alarmTime,
            });
        });
    	console.log(data);
        return data;
    }
	// 알람 저장
	var resultList = collectData();
	$.ajax({
		url: '/schedule/set-alarm',
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

//공백제거
$('input').on('input', function() {
	$(this).val($(this).val().replace(/\s/g, ''));
});
</script>
	
<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>