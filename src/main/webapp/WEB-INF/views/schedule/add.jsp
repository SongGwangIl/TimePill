<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- <script>
// 	// 구동 안되는 오늘날짜 넣기 코드
// 	const today = new Date();
// 	const yyyy = today.getFullYear();
// 	const mm = String(today.getMonth() + 1).padStart(2, '0'); // Months are zero-indexed
// 	const dd = String(today.getDate()).padStart(2, '0');
	
// 	const todayString = `${yyyy}-${mm}-${dd}`;
// 	document.getElementById('scheStartDate').value = todayString;
</script> -->
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/add.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
</head>
<body>  
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<span class="info-text">스케줄 등록</span>

	<div id=insertList" class="box">
		<div class="form-group">
		<form action="${pageContext.request.contextPath}/schedule/add.do" method="post">
			<label for="scheTitle">스케쥴 제목</label>
			<input type="text" id="scheTitle" name="scheTitle" placeholder="스케줄 제목을 입력하세요">  
		</div>

					<div class="form-group">
						<label for="scheTakeNum">하루 복약횟수</label>
						<select name="scheTakeNum">
							<option value=1>1회</option>
							<option value=2 >2회</option>
							<option value=3 selected>3회</option>
						</select>
				</div>
					<div class="form-group">
						<label for="scheStartDate">처방일자</label>
						<input type="date" id="scheStartDate" name="scheStartDate">	
					</div>
					<div class="form-group">
						<label for="scheSelect">처방기간</label>
						<select name="scheSelect">
							<option value=7>1주</option>
							<option value=14 selected>2주</option>
							<option value=21>3주</option>
							<option value=28>4주</option>
							<option value=35>5주</option>
							<option value=42>6주</option>
						</select>	
					</div>
					<div class="form-group">
						<label for="scheEndDate">만료일자</label>
						<input type="date" id="scheEndDate" name="scheEndDate">
					</div>
					
				
			<input id="button" type="submit" value="등록">
			
			
		</form>
		</div>
	</div>
	<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>