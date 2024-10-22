<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- header --%>
<!DOCTYPE html>
<html>
<head>
	
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 변경 - TimePill</title>

<!-- 시큐리티 csrf토큰 -->
<sec:csrfMetaTags/>
<!-- 시큐리티 로그인 여부 -->
<sec:authorize access="isAuthenticated()" var="auth">
	<sec:authentication property="principal" var="principal"/>
</sec:authorize>

<!-- 파비콘 -->
<link rel="icon" href="/resources/img/logo.svg">

<!-- Gmarket SANS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/GmarketSans/GmarketSans.css" type="text/css"/>
<!-- NotoSans KR-->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<!-- 기본 템플릿 CSS -->
<link rel="stylesheet" href="/resources/css/common/common.css">
<link rel="stylesheet" href="/resources/css/common/header.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
	<div id="backcontainer" class="boxv">
		<!-- 헤더 : main logo, user status -->
		<header id="header" class="boxh">
			<div class="boxh headerbar">
				<a href="/">
					<div class="boxh title">
						<img id="logo" src="/resources/img/logo.svg">
						<h1>TimePill</h1>
					</div>
				</a>
				<div class="boxh logout">
					<c:if test="${auth eq true}">
						<a href="#" onclick="document.getElementById('logoutForm').submit();">
							<img src="/resources/img/logout.png" alt="로그아웃" style="width: 35px;">
						</a>
						<form id="logoutForm" method="POST" action="/user/logout" style="display: none;">
							<sec:csrfInput/>
						</form>
					</c:if>
				</div>
			</div>
		</header>

<link rel="stylesheet" href="/resources/css/myPage/myPassword.css">

<div id="contents">
	<!-- 타이틀 -->
	<div>
	    <h1 class="txa subtitle">비밀번호 변경</h1>
	</div>
	
	<form:form id="passFrm" action="/mypage/myPassword" method="post" modelAttribute="userVO">
		<div class="passWrap input">
			<label>새비밀번호</label>
			<form:input id="password" class="form-input pwd" type="password" path="password" required="required"/>
			<img class="eye" src="/resources/img/eye.png"></img>
			<p id="userPwdMsg" class="msg"></p>
			<form:errors path="password" cssClass="errors"></form:errors><br>
			<label>비밀번호확인</label>
			<input id="checkUserPwd" class="form-input" type="password" required="required"/>
			<p id="checkUserPwdMsg" class="msg"></p>			
        </div>
		<div class="btns boxh">
            <a class="btn-sky" id="change">
                <p class="btndesc"> 변경하기 </p>
            </a>
            <a class="btn-white" id="cancel">
                <p class="btndesc"> 돌아가기 </p>
            </a>
		</div>
		<sec:csrfInput/>
	</form:form>	
</div>
<script src="/resources/js/user/myPassword.js"></script>
<script>
// eye 이미지 클릭 시 패스워드 필드 토글
document.querySelector('.eye').addEventListener('click', function() {
    const pwdfiled = document.querySelector('.pwd');
    const type = pwdfiled.getAttribute('type');
    
    if (type === 'password') {
        pwdfiled.setAttribute('type', 'text');
        this.src = '/resources/img/eyeno.png';
    } else {
        pwdfiled.setAttribute('type', 'password');
        this.src = '/resources/img/eye.png';
    }
});

const passwordInp = document.querySelector('#password');
const checkUserPwdInp = document.querySelector('#checkUserPwd');

document.getElementById('change').addEventListener('click', function () {
    let changeConfirm = confirm("등록된 정보로 수정하시겠습니까?");
    if(changeConfirm){
    	if (!checkValidity()) {
            event.preventDefault(); // 유효성 검사 실패 시 제출 방지
            alert("입력을 확인하세요.");
        }
    	else
    		document.getElementById('passFrm').submit();
    }
});
document.getElementById('cancel').addEventListener('click', function () {
	window.location.href = "/mypage ";
});

function checkValidity(){
	if(passwordInp.value === '' || checkUserPwdInp === '')
		return false;
	return true;
}
    
</script>
<%-- footer --%>
<link rel="stylesheet" href="/resources/css/common/footer.css">

		<!-- 푸터 : nav -->
        <nav id="mainmenu" class="">
            <ul class="menu">
                <li>
					<div class="boxv">
					    <a class="menu-link" href="/">
					     <img id="logo" src="/resources/img/sched.png" style="width: 50px;">
					    	<br><span class="footer-menu">스케줄</span>
					     </a>
					</div>
                </li>
                <li>
					<div class="boxv">
					    <a class="menu-link" href="/medication">
					     <img id="logo" src="/resources/img/medmng.png" style="width: 50px; margin-left: 5px;">
					    	<br><span class="footer-menu">복약관리</span>
					    </a>
					</div>
                </li>
                <li>
					<div class="boxv">
					    <a class="menu-link" href="/mypage">
					    	<img id="logo" src="/resources/img/myinfo.png" style="width: 50px;">
					    	<br><span class="footer-menu">내 정보</span>
					     </a>
					</div>
                </li>
                <li>
					<div class="boxv">
					    <a class="menu-link" href="/notice">
					     <img id="logo" src="/resources/img/notice.png" style="width: 50px;">
					     <br><span class="footer-menu">공지사항</span>
					    </a>
					</div>
                </li>
            </ul>
        </nav>
    </div>
    
<script>
<c:if test="${not empty sessionScope.message}">
	alert("<c:out value='${sessionScope.message}'/>");
	<c:remove var="message" scope="session"/>
</c:if>
</script>

</body>
</html>
