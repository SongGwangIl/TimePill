<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="TimePill"/>
</c:import>
<style>

	input[name="password"]{
		width: 250px;
	}

	.modal {
		display: none;
		position: fixed;
		width: 450px;
		padding: 10px;
		border-radius: 10px;
		top: 40%;
		left: 50%;
		z-index: 2;
		background: white;
	}
	
	.modal.active {
		display: block;
	}
</style>

<h1>설정</h1>
<button id="changeBtn">내 정보 변경</button><br>
<form id="pwFrm" class="modal" action="/myPage" method="post">
	<label>비밀번호확인</label>
	<input name="password" type="password" placeholder="현재 사용하고있는 비밀번호를 입력하세요" requierd>
	<button type="button" id="submitBtn">확인</button><button type="button" id="cancelBtn">취소</button>
	<sec:csrfInput/>
</form>
<button id="changePwBtn">비밀번호변경</button><br>
<span>카카오톡 알림설정</span><button>토클버튼</button>

<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>
<script type="text/javascript">
	let pwFrm = document.querySelector('#pwFrm');
	let cancelBtn = document.querySelector('#cancelBtn');
	let changePwBtn = document.querySelector('#changePwBtn');
	let submitBtn = document.querySelector('#submitBtn');
	
	pwFrm.style.left = ( window.innerWidth/2 - parseInt(window.getComputedStyle(pwFrm)
		.getPropertyValue('width')) /2 ) + 'px';
	
	document.querySelector('#changeBtn').onclick = function(){
		let modal = document.querySelector('.modal');
		modal.classList.add('active');
		pwInp.focus();		
	}
	
	changePwBtn.onclick = function(){
		window.location.href = "/myPage/changePw";
	}
	
	submitBtn.onclick = function(){
		pwFrm.submit();
	}
	
	cancelBtn.onclick = function(){
		pwFrm.classList.remove('active');
	}
</script>
<script>
<c:if test="${not empty sessionScope.message}">
	alert("<c:out value='${sessionScope.message}'/>");
	<c:remove var="message" scope="session"/>
</c:if>
</script>
