<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케쥴 등록 화면</title>

<style>

</style>

</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<body>
	<div id=insertList">
		<form action="${pageContext.request.contextPath}/schedule/add.do" method="post">
			<fieldset>
				<legend>스케쥴 등록</legend>
				
					<ul>
						<label for="scheTitle">스케쥴 제목</label>
						<input type="text" id="scheTitle" name="scheTitle">  
					</ul>

					<ul>
						<label for="scheTakeNum">하루 복약횟수</label>
						<select name="scheTakeNum">
							<option value=1>1회</option>
							<option value=2 >2회</option>
							<option value=3 selected>3회</option>
						</select>
					</ul>
					<ul>
						<label for="scheStartDate">처방일자</label>
						<input type="date" id="scheStartDate" name="scheStartDate">	
					</ul>
					<ul>
						<label for="scheSelect">처방기간</label>
						<select name="scheSelect">
							<option value=7 selected>1주</option>
							<option value=14>2주</option>
							<option value=21>3주</option>
							<option value=28>4주</option>
							<option value=35>5주</option>
							<option value=42>6주</option>
						</select>	
						<br>직접 선택은 스크립트 어떻게 할지 아직 구상못함...
					</ul>
					<ul>
						<label for="scheEndDate">만료일자</label>
						<input type="date" id="scheEndDate" name="scheEndDate">
					</ul>
					
				</label>
			<input type="submit" value="등록">
			
			</fieldset>
		</form>
	</div>
</body>

<script>
	

</script>
</html>