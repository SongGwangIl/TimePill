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
							<th>알람활성화</th>
							<th>알람타입</th>
							<th>알람시간</th>
							<th>알람만료시간</th>
							<th>알람간격</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${alarmList}" varStatus="status">
							<tr data-no="row-data">
								<td>
									<input type="hidden" name="alarmId" value="${result.alarmId}" data-no="${status.count}">
									<input type="checkbox" name="alarmUseAt" value="${result.alarmUseAt}" ${result.alarmUseAt eq 'Y' ? 'checked' : '' } 
											data-no="${status.count}" onclick="toggleChk(this, ${status.count})" required>
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
										<c:choose>
											<c:when test="${status.count <= 2}">
												<select name="alarmHour" required>
												<c:forEach begin="05" end="11" step="1" varStatus="time">
													<option value="${time.index}" ${fn:split(result.alarmTime,':')[0] eq time.index ? 'selected' : '' } >${time.index}</option>
												</c:forEach>
												</select>
											</c:when>
											<c:when test="${status.count <= 4}">
												<select name="alarmHour" required>
												<c:forEach begin="11" end="16" step="1" varStatus="time">
													<option value="${time.index}" ${fn:split(result.alarmTime,':')[0] eq time.index ? 'selected' : '' }>${time.index}</option>
												</c:forEach>
												</select>
											</c:when>
											<c:when test="${status.count <= 6}">
												<select name="alarmHour" required>
												<c:forEach begin="16" end="20" step="01" varStatus="time">
													<option value="${time.index}" ${fn:split(result.alarmTime,':')[0] eq time.index ? 'selected' : '' }>${time.index}</option>
												</c:forEach>
												</select>
											</c:when>
											<c:when test="${status.count == 7}">
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
								</c:if>
								<td>
									<!-- 알람 만료시간 -->
									<input type="number" name="alarmInterval" min="20" max="60" step="5" value="${result.alarmInterval}" data-no="${status.count}" required>
								</td>
								<td>
									<!-- 알람 간격 -->
									<input type="number" name="rptInterval" min="1" max="20" step="1" value="${result.rptInterval}" data-no="${status.count}" required>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button type="button" onclick="submit();">등록</button>
				<button type="button" onclick="location.href='/medication/schedule/list'">취소</button>
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
            var alarmUseAt = row.querySelector('input[name="alarmUseAt"]').value;
        	// 식전 식후 알람시간 동일화 
        	var dataNo = row.querySelector('input[name="alarmId"]').getAttribute('data-no'); // 식전,식후 알람시간 동일화를 위한 값
            if (parseInt(dataNo) % 2 === 0) {
        		var alarmTime = prevAlarmTime;
            } else {
				var alarmHour = row.querySelector('select[name="alarmHour"]').value; // 시간
				var alarmMin = row.querySelector('input[name="alarmMin"]').value; // 분
	            var alarmTime = alarmHour + ':' + alarmMin; // 알람시간
	            prevAlarmTime = alarmTime;
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
    	console.log(data);
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

//공백제거
$('input').on('input', function() {
	$(this).val($(this).val().replace(/\s/g, ''));
});
</script>
	
<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>