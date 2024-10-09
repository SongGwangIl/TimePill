<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>

<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/addUserInfo.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>

<%-- header --%>
<c:import url="/WEB-INF/views/common/header.jsp" charEncoding="utf-8">
	<c:param name="title" value="TimePill - 스케줄 관리"/>
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
.single-line {
	width: 90%;
	text-align: center;
	padding: 10px;
	margin: 10px;
}

.same-line {
	justify-content: center;
	display: flex;
	width: 100%;
}

.med-title .med-info {
	border: 1px solid #ccc;
	border-radius: 3px;
	display: none;
	position: absolute;
	background-color: #fff;
	z-index: 1000;
}

.med-title:hover .med-info {
	display: block;
}

p, span {
	margin: 5px;
}

</style>
	
<div class="whiteBox">

<div class="content-wrapper">
	
	<div class="container">
				<form class="frm" action="/detail/${notice.id}" method="post">
					<ul>
						<li class="c1"><label class="label">제목</label> 
						 <input type="text" name="title" class="input" required value="${notice.title}"><br></li>
						<li class="c1"><label class="label">내용</label> <input type="text"
							name="content" class="input" value="${notice.content}"><br></li>
					</ul>
					<ul>
						<li>
							<button type="submit" id="changeNotice">변경</button>
						</li>
						<li>
							<a href="/delete/${notice.id}" id="deleteNotice">삭제</a>
						</li>
					</ul>
				<sec:csrfInput/>
				</form>
	</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		//정보변경
		$("#changeNotice").click(function(){
			if(!confirm("변경하시겠습니까?")){
				return false;
			}
		});
		
		$("#deleteNotice").click(function(){
			if(!confirm("삭제하시겠습니까?")){
				return false;
			}
		});
	});
</script>

<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>

