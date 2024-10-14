<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="공지사항 - TimePill"/>
</c:import>

<style>
.cha {
    margin-left: 1%;
    width: 25px;
}
.agredetaildesc {
    font-family: 'Noto Sans Kr';
    width: 80%;
/*     height: 300px; */
/*     border: 1px solid #999; */
	margin: 10px;
    padding: 3%;
    overflow: auto;
}
</style>

 <!-- 컨텐츠 시작 -->
<div id="contents" class="">

	<!-- 타이틀 -->
	<div>
		<h1 class="txa subtitle">공지사항</h1>
	</div>
	
	<!-- 공지사항 리스트 -->
	<c:forEach var="getAllnoticeList" items="${noticeList}">
	<div style="border: 1px solid #ccc">
		<p style="margin: 10px; margin-bottom: 5px;"><fmt:formatDate value="${getAllnoticeList.date}" pattern="yyyy. MM. dd" /></p>
		<span style="font-size: x-large; margin: 10px;"><c:out value="${getAllnoticeList.title}"/></span>
		<img class="cha" src="/resources/img/ico-unfolding.png">
		<div class="checkdesc" style="display: none;">
			<hr style="width: 90%;">
			<p class="agredetaildesc"><c:out value="${getAllnoticeList.content}"/></p>
		</div>
	</div>
	</c:forEach>
	<br>
	
	<!-- 관리자만 접근 가능 -->
	<sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_MANAGER')">
		<a href="/write">글쓰기</a>
	</sec:authorize>
	
</div>
<!-- 컨텐츠 끝 -->

<script>
// 모든 .cha 요소를 선택
const chaElements = document.querySelectorAll('.cha');

// 각 .cha 요소에 클릭 이벤트 추가
chaElements.forEach(cha => {
    cha.addEventListener('click', function() {

        const checkdesc = this.nextElementSibling;

        // checkdesc가 존재할 때 토글 동작
        if (checkdesc.style.display === "none") {
        	this.src = '/resources/img/ico-folding.png';
            checkdesc.style.removeProperty('display'); // display 속성 제거 (기본값으로 돌아감)
        } else {
        	this.src = '/resources/img/ico-unfolding.png';
            checkdesc.style.setProperty('display', 'none'); // display 속성을 none으로 설정
        }
    });
});
</script>

<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>

