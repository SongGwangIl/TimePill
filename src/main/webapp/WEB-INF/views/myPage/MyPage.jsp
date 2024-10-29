<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="내 정보 - TimePill" />
</c:import>

<link rel="stylesheet" href="/resources/css/myPage/myPage.css">

<div id="contents">

	<div>
		<h1 class="txa subtitle">내 정보</h1>
	</div>

	<div class="boxv btns">
		<div class="boxh genbtn">
			<a href="/mypage/myinfo" class="btn-sky" id="changeInfoBtn">
				<p class="btndesc">내 정보 변경</p>
			</a>
			<sec:authorize access="!principal.username.contains('KAKAO_')">
				<a href="/mypage/myPassword" class="btn-sky" id="changePwBtn">
					<p class="btndesc">비밀번호 변경</p>
				</a>
			</sec:authorize>
			<a href="#" class="btn-sky" id="delAcctBtn">
				<p class="btndesc">회원탈퇴</p>
			</a>
		</div>
	</div>
	<div class="fModal">
		<div class="fModal_body">
			<form id="pwFrm" action="/mypage" method="post" style="display: none;">
				<div class="pwFrmWrap">
					<label class="pwLabel">비밀번호확인</label> <input class="form-input" name="password" type="password" placeholder="비밀번호를 입력해주세요." requierd>
				</div>
				<div class="buttonWrap">
					<button class="btn" type="button" id="submitBtn">확인</button>
					<button class="btn" type="button" id="cancelBtn">취소</button>
				</div>
				<sec:csrfInput />
			</form>
			<form id="delAcctFrm" action="/deleteAccount" method="post" style="display: none;">
				<div class="pwFrmWrap">
					<label class="pwLabel">회원탈퇴</label> <input class="form-input" id="delAcctAgree" name="delAcctAgree" type="text" placeholder="'회원탈퇴'를 입력해주세요." requierd>
				</div>
				<div class="buttonWrap">
					<button class="btn" type="button" id="subDelAcctBtn">탈퇴</button>
					<button class="btn" type="button" id="cxlBtn">취소</button>
				</div>
				<sec:csrfInput />
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

	const delAcctBtn = document.querySelector('#delAcctBtn');
	const delAcctFrm = document.querySelector('#delAcctFrm');
	const delAcctAgree = document.querySelector('#delAcctAgree');
	const subDelAcctBtn = document.querySelector('#subDelAcctBtn');
	const cxlBtn = document.querySelector('#cxlBtn');

	// 회원탈퇴 모달창 열기
	delAcctBtn.addEventListener('click', function() {
		pwFrm.style.display = 'none';
		fModal.style.display = "flex";
		delAcctFrm.style.display = 'block';
		delAcctAgree.value = '';
	});

	// 회원탈퇴 문구 입력칸 공백제거
	delAcctAgree.addEventListener('input', function() {
		this.value = this.value.replace(/\s/g, '');
	});

	// 엔터키로 폼제출 방지
	delAcctFrm.addEventListener("keydown", function(event) {
		if (event.key === "Enter") {
			event.preventDefault();
		}
	});

	// 회원탈퇴 버튼 클릭
	subDelAcctBtn.addEventListener('click', function() {
		if (delAcctAgree.value !== '회원탈퇴') {
			alert('잘못입력하셨습니다.');
			return;
		}
		if (!confirm('정말로 탈퇴하시겠습니까?')) {
			return;
		}
		delAcctFrm.submit();
	});

	// 회원탈퇴 취소 클릭
	cxlBtn.addEventListener('click', function() {
		fModal.style.display = "none";
		delAcctFrm.style.display = 'none';
		delAcctAgree.value = '';
	});

	<c:if test="${empty sessionScope.changeInfoUser}">
	userAuth();
	</c:if>

	function userAuth() {
		// 모달 열기 
		fModal.style.display = "flex";
		pwFrm.style.display = "block";
	}

	submitBtn.onclick = function() {
		pwFrm.submit();
	}

	cancelBtn.onclick = function() {

		window.location.href = '/';

	}
</script>

<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8" />
