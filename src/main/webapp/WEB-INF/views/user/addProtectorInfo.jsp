<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/addProtectorInfo.css" type="text/css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div id="wrap">
		<h1>보호자 정보 입력</h1>
		<form action="${pageContext.request.contextPath}/addProtectorInfo" method="post">
			<input type="hidden" name="userId" value="${loginUser.userId}"><br>
			<ul class="input">
				<li><label class="label">이름</label> <input type="text"
					name="protName" required><br></li>
				<li><label class="label">전화번호</label> <input type="text"
					name="protPhone" placeholder="-를 제외한 숫자만 입력"><br></li>
				<li><label class="label">관계</label> <input type="text"
					name="protRelation"><br></li>
			</ul>
			<ul id="buttons">
				<li>
					<button type="submit">등록</button>
					<br>
				</li>
				<li>
					<button type="button" onclick="location.href='main'">다음에 입력</button>
					<br>
				</li>
			</ul>
		</form>
	</div>
</body>
</html>