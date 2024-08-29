<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- <script> 
	// 구동 안되는 오늘날짜 넣기 코드
	const today = new Date();
	const yyyy = today.getFullYear();
	const mm = String(today.getMonth() + 1).padStart(2, '0'); // Months are zero-indexed
	const dd = String(today.getDate()).padStart(2, '0');
	
	const todayString = `${yyyy}-${mm}-${dd}`;
	document.getElementById('scheStartDate').value = todayString;
</script> -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css" type="text/css">
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <span class="info-text">스케줄 관리</span>
	<div id=insertList" class="box">
		<form action="${pageContext.request.contextPath}/schedule/edit.do" method="post">
			<fieldset>
				<legend>스케줄 수정</legend>
				
					<input type="hidden" id="scheId" name="scheId" value="${vo.scheId}">
				
					<ul>
						<label for="scheTitle">스케줄 제목</label>
						<input type="text" id="scheTitle" name="scheTitle" value="${vo.scheTitle}"> 
					</ul>

					<ul>
						<label for="scheTakeNum">하루 복약횟수</label>
						<select name="scheTakeNum" disabled>
							<option value=1>1회</option>
							<option value=2 >2회</option>
							<option value=3 selected >3회</option>
						</select>
					</ul>
					<ul>
						<label for="scheStartDate">처방일자</label>
						<input type="date" id="scheStartDate" name="scheStartDate" value="${vo.scheStartDate}">	
					</ul>
					<ul>
						<label for="scheSelect">처방기간</label>
						<select name="scheSelect">
							<option value=7>1주</option>
							<option value=14 selected>2주</option>
							<option value=21>3주</option>
							<option value=28>4주</option>
							<option value=35>5주</option>
							<option value=42>6주</option>
							<!-- 계산 안할거면 굳이 안넣어도 될것같음 ㅠㅠ -->
						</select>
					</ul>
					<ul>
						<label for="scheEndDate">만료일자</label>
						<input type="date" id="scheEndDate" name="scheEndDate" value="${vo.scheEndDate}">
					</ul>
					
				</label>
			<input type="submit" value="수정">
			
			</fieldset>
		</form>
	</div>
</body>
</html>