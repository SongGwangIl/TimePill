<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="공지사항 - TimePill"/>
</c:import>

<link rel="stylesheet" href="/resources/css/notice/notice.css">


 <!-- 컨텐츠 시작 -->
<div id="contents" class="">

	<!-- 타이틀 -->
	<section>
		<h1 class="txa subtitle">공지사항</h1>
	</section>

	<!-- 공지사항 리스트 -->
	<c:forEach var="getAllnoticeList" items="${noticeList}">
		<article class="bbslist">
			<!-- 날짜 -->
			<p class="bbsdate">
				<fmt:formatDate value="${getAllnoticeList.date}" pattern="yyyy. MM. dd" />
			</p>
			<details class="bbs">
				<!-- 제목 -->
				<summary class="bbstitle">
					<h1 class="bbstitledesc">
						<c:out value="${getAllnoticeList.title}" />
					</h1>
					<img src="/resources/img/down.png">
				</summary>
				<!-- 내용 -->
				<div class="bbsdescbox">
					<p class="bbsdesc">
						<c:out value="${getAllnoticeList.content}" />
					</p>
				</div>
			</details>
		</article>
	</c:forEach>

	<!-- 관리자만 접근 가능 -->
	<sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_MANAGER')">
		<a href="/notice/write">글쓰기</a>
	</sec:authorize>
	
</div>
<!-- 컨텐츠 끝 -->

<script>
const titles = document.querySelectorAll('.bbstitle');

titles.forEach(title => {
	title.addEventListener('click', function () {
		const img = title.querySelector('img');
		if (img.src.includes('down.png')) {
			img.src = '/resources/img/up.png';  // up 이미지로 변경
		} else {
			img.src = '/resources/img/down.png';  // 다시 down 이미지로 변경
		}
	});
});
</script>

<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>

