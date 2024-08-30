<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/myPage.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>

<body>



	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<span class="info-text">기기정보변경</span>
	
	<div class="box">
		
		<form action="${pageContext.request.contextPath}/mydevice" method="post">
			<ul>
				<li>
					<label class="label">나의기기</label> 
					<input type="text" name="deviceId" class="input" value="${mydeviceInfo.deviceId}" readonly>
				</li>
				<li>
					<label class="label">기기이름</label> 
					<input type="text" name="deviceName" class="input" value="${mydeviceInfo.deviceName}">
				</li>
			</ul>

			<ul>
				<li>
					<button type="submit" id="changedeviceInfo">변경</button>
				</li>
				<li>
					<a href="device/delete">기기삭제</a>
				</li>
				<li>
					<button type="button" onclick="location.href='main'">취소</button>
				</li>
			</ul>
		</form>
	</div>


<script>
	$(document).ready(function(){
		//정보변경
		$("#changedeviceInfo").click(function(){
			if(!confirm("변경하시겠습니까?")){
				return false;
			}
		});
		
		$("#deletemydevice").click(function(){
			if(!confirm("삭제하시겠습니까?")){
				return "device/mydelete";
			}
		});
	});
</script>

<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>