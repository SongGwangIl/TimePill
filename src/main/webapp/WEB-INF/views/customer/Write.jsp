<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>

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
	<h2 class="single-line">공지사항</h2>
	<div class="same-line">
	
		<div class="container">
				<form class="frm" action="/write" method="post">
					<ul>
						<li class="c1"><label class="label">제목</label> 
						 <input type="text" name="title" class="input"><br></li>
						<li class="c1"><label class="label">내용</label> <input type="text"
							name="content" class="input"><br></li>
					</ul>
					<ul>
						<li>
							<a href="/notice">목록</a>
						</li>
						<li>
							<button type="submit">글쓰기</button>
						</li>
					</ul>
				<sec:csrfInput/>
				</form>
				
	</div>
		</div>
	</div>
	
</div>


</div>
<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>

