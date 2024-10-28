<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="공지사항 - TimePill"/>
</c:import>

<style>
.content-wrapper {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 90%;
	margin: 20px auto;
}

.container{
	width: 80%;
	margin: 0 auto;
}

.frm{
	width: 100%;
}

.form-input {
	width: 100%;
	height: 32px;
	font-family: 'Noto Sans KR';
	font-size: 15px;
	border: 0;
	border-radius: 12px;
	outline: none;
	background-color: rgb(233, 233, 233);
}

.form-input-area {
	width: 100%;
	height: 100%;
	font-family: 'Noto Sans KR';
	font-size: 15px;
	border: 0;
	border-radius: 12px;
	outline: none;
	background-color: rgb(233, 233, 233);
}

.btn-sky {
	width: 100px;
	height: 40px;
	border-radius: 15px;
	margin-right: 2%;
	margin-bottom: 3%;
	background-color: skyblue;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
}

.btn-pink {
	width: 100px;
	height: 40px;
	border-radius: 15px;
	margin-right: 2%;
	margin-bottom: 3%;
	background-color: pink;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
}

.btn-white {
	width: 100px;
	height: 40px;
	border-radius: 15px;
	background-color: #dddddd;
	margin-bottom: 3%;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
}
.btns {
	display: flex;
	justify-content: center;
}

</style>

<div id="contents">
	<h1 class="txa subtitle">공지사항</h1>	
	<div class="container">
		<form id="frm" action="/notice/edit" method="post">
			<div>
				<input type="hidden" name="id" value="${notice.id}">
									
				<label class="label">제목</label> 
				<input type="text" name="title" class="form-input" value="${notice.title}">
								 
			
				<label class="label">내용</label> 
				<textarea name="content" rows="10" class="form-input-area">${notice.content}</textarea>					
			</div>
			<div class="btns">					
				<a id="editSubmit" class="btn-sky">수정</a>				
				<a id="delete" class="btn-pink">삭제</a>					
				<a href="/notice" class="btn-white">취소</a>				
			</div>
			<sec:csrfInput/>				
		</form>				
	</div>	
</div>
<script type="text/javascript">
	const noticeForm = document.querySelector('#frm');
	
	document.querySelector('#editSubmit').onclick = function(){
		if(confirm("수정하시겠습니까?")){
			noticeForm.action = "/notice/edit";
			noticeForm.method = "POST";
			noticeForm.submit();			
		}
	};

	document.querySelector('#delete').onclick = function(){
		if(confirm("정말로 삭제하시겠습니까?")){
			noticeForm.action = "/notice/delete";
			noticeForm.method = "GET";
			noticeForm.submit();			
		}
	};



</script>

<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>

