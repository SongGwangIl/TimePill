<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/jquery-ui.css" type="text/css">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">

<style>
.bg { 
	width:1920px;
	height:700px;
	position:absolute;
	left:0px;
	top:80px;
	background-image:url(resources/img/background.png);
	background-repeat:no-repeat;
	background-size:cover;
}
.text4 {
        position: absolute;
        top: 830px;
        left:880px;
        width: 262px;
        height: 20px;
        text-align: left;
        font: normal normal normal 14px/20px 'Noto Sans CJK KR';
        letter-spacing: 0px;
        color: #000000;
        opacity: 1;
    }
</style>


<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
</head>
<body>  
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<span class="info-text">나의정보변경</span>
	
	<div class="box">
		
		<c:choose>
			<c:when test="${myInfo.userSelect eq 'user'}">
		<div class="container">
				<form action="${pageContext.request.contextPath}/myPage" method="post">
					<input type="hidden" name="userId" value="${myInfo.userId}"><br>
					<ul>
						<li class="c1"><label class="label">이름</label> 
						 <input type="text" name="userName" class="input" required value="${myInfo.userName}"><br></li>
						<li class="c1"><label class="label">전화번호</label> <input type="text"
							name="userPhone" class="input" placeholder="-를 제외한 숫자만 입력" value="${myInfo.userPhone}"><br></li>
						
						<li class="c1"><label class="label">키</label> <input type="number"
							name="userHeight" class="input" value="${myInfo.userHeight}"><br></li>
						<li class="c1"><label class="label">몸무게</label> <input type="number"
							name="userWeight" class="input" value="${myInfo.userWeight}"><br></li>
						
						<li class="c1">
							<label class="label">이메일</label>
							<input type="text" name="userEmail" value="${myInfo.userEmail}">
						</li>
					</ul>
					<div>
							<button class="btn" type="submit" id="changeUserInfo">변경</button>
							<button class="btn" type="button" onclick="location.href='main'">취소</button> <br>
					</div>

				</form>
			</div>
			</c:when>
			<c:otherwise>
				<form action="${pageContext.request.contextPath}/myPage"
					method="post">
					<input type="hidden" name="userId" value="${myInfo.userId}"><br>
					<ul>
						<li>
							<label class="label">이름</label> 
							<input type="text" name="protName" value="${myInfo.protName}" required>
						</li>
						<li>
							<label class="label">전화번호</label>
							<input type="text" name="protPhone" value="${myInfo.protPhone}">
						</li>
						<li>
							<label class="label">관계</label>
							<input type="text" name="protRelation" value="${myInfo.protRelation}">
						</li>
						<li>
							<label class="label">이메일</label>
							<input type="text" name="userEmail" value="${myInfo.userEmail}">
						</li>
					</ul>
					<ul id="buttons">
						<li>
							<button type="submit" id="changeProtectorInfo">변경</button>
						</li>
						<li>
							<button type="button" onclick="location.href='main'">취소</button> <br>
						</li>
					</ul>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
<script>
	$(document).ready(function(){
		//정보변경
		$("#changeUserInfo").click(function(){
			if(!confirm("변경하시겠습니까?")){
				return false;
			}
		});
		
		$("#changeProtectorInfo").click(function(){
			if(!confirm("변경하시겠습니까?")){
				return false;
			}
		});
	});
</script>

<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
