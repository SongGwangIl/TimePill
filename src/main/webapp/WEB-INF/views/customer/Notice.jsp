<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="공지사항 - TimePill"/>
</c:import>

 <!-- 컨텐츠 시작 -->
<div id="contents" class="">

	<!-- 타이틀 -->
	<div>
		<h1 class="txa subtitle">공지사항</h1>
	</div>
	
	<!-- 공지사항 리스트 -->
	<c:forEach var="getAllnoticeList" items="${noticeList}">
	<div style="border: 1px solid #ccc">
		<p><fmt:formatDate value="${getAllnoticeList.date}" pattern="yyyy. MM. dd" /></p>
		<a href="/detail/${getAllnoticeList.id}"><p>${getAllnoticeList.title}</p></a>
	</div>
	</c:forEach>
	<br>
	
	<!-- 관리자만 접근 가능 -->
	<sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_MANAGER')">
		<a href="/write">글쓰기</a>
	</sec:authorize>
	
</div>
<!-- 컨텐츠 끝 -->

<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>

