<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/device/regist.css" type="text/css">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">

<style>
.bg {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 1920px;
	height: 1080px;
	background: transparent url('${pageContext.request.contextPath}/resources/img/fake.png') no-repeat;
	background-size: cover;
    background-position: center;
    z-index: -1;
}

</style>

<div class="bg"></div>

	<div class="wrap">
		<h1 class="title">타임필 디스펜서 <br> 기기 등록</h1>
		<img class="devi" alt="디스펜서 이미지" src="${pageContext.request.contextPath}/resources/img/dispensor.png">
		
		<div id="wrap">
			<h2> Timepill 시리얼 코드 등록</h2>
			
			<form id="recordForm" action="${pageContext.request.contextPath}/device" method="post">
				<input class="submit" type="text" name="deviceId" id="deviceId" required>
				<br>
				<a class="okbtn" href="#" onclick="document.querySelector('#recordForm').submit(); return false;">
					<div class="btn1">
						<p>등록하기</p>
					</div>
				</a>
				<a class="nobtn" href="${pageContext.request.contextPath}/main" >
					<div class="btn2">
						<p>나중에 할게요</p>
					</div>
				</a>
			</form>
			
		</div>
	</div>


	
</body>
</html>