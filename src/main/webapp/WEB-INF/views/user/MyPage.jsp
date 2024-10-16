<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="TimePill"/>
</c:import>

<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/mypage.css">

<div id="contents">

	<div>
		<h1 class="txa subtitle">내정보 설정</h1>
	</div>
	
	<div class="boxv btns">
        <div class="boxh genbtn">
			<a href="/mypage/change-myinfo" class="btn-sky" id="changeInfoBtn">
                <p class="btndesc"> 내정보 변경 </p>
            </a>
            <sec:authorize access="!principal.username.contains('KAKAO_')">			
				<a href="/mypage/change-password" class="btn-sky" id="changePwBtn">
	                <p class="btndesc"> 비밀번호 변경 </p>
	            </a>          
            </sec:authorize>
        </div>	        
    </div>
	<div class="fModal">
		<div class="fModal_body">
			<form id="pwFrm" action="/mypage" method="post">
				<div class="pwFrmWrap">
					<label class="pwLabel">비밀번호확인</label>
					<input class="form-input" name="password" type="password" placeholder="비밀번호를 입력해주세요." requierd>
				</div>
				<div class="buttonWrap">
					<button class="btn" type="button" id="submitBtn">확인</button>
					<button class="btn" type="button" id="cancelBtn">취소</button>
				</div>
				<sec:csrfInput/>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
	const fModal = document.querySelector('.fModal');
	const fModalBody = document.querySelector('.fModal_body');
	const pwFrm = document.querySelector('#pwFrm');
	const submitBtn = document.querySelector('#submitBtn');
	const cancelBtn = document.querySelector('#cancelBtn');

	<c:if test="${empty sessionScope.changeInfoUser}">
		userAuth();	
	</c:if>
	
	function userAuth(){
		// 모달 열기 
		fModal.style.display = "flex";
	}
	
	submitBtn.onclick = function(){
		pwFrm.submit();
	}
	
	cancelBtn.onclick = function(){
		
		window.location.href = '/';
		
	}
</script>

<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>
