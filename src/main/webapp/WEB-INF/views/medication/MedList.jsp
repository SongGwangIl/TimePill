<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="복약관리 - TimePill"/>
</c:import>

 <!-- 컨텐츠 시작 -->
<div id="contents" class="">

	<!-- 타이틀 -->
	<div>
		<h1 class="txa subtitle">복약리스트</h1>
	</div>

	<!-- 복약리스트 -->
	<div class="listbox checkline">
		
		<ul class="margin-init">
			<c:forEach var="resultMed" items="${medList}">
				<li class="medlistcard boxh checkline">
					<img class="checkline" src="/resources/img/medblue.png" width="25px">
					<p class="medname checkline"><c:out value="${resultMed.medName}"/></p>
					<a href="/medication/${resultMed.medId}" class="btn-upd txa">수정</a>
				</li>
			</c:forEach>
		</ul>
		
		<c:if test="${empty medList}">
			<ul class="margin-init">
				<p>등록된 약이 없습니다.</p>
			</li>
		</c:if>
		
	</div>
	
	<!-- 등록버튼 -->
	<a href="/medication/reg" class="checkline">
		<div class="boxh white-btn">
			<img id="logo" src="/resources/img/logo.svg" style="width: 30px; margin: 0;">
			<p style="margin-left: 5px;">복약 추가하기</p>
		</div>
	</a>
</div>
 <!-- 컨텐츠 끝 -->

<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>

