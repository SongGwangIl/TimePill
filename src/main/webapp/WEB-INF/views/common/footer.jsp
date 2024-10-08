<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


    <!-- 푸터 : nav -->

    <nav id="mainmenu">
        <ul class="menu">
            <li>
                <a href="#">
                    <div class="boxv">
                        <img id="logo" src="/resources/img/timpill.svg">
                        <a href="#"> 공지사항 </a>
                    </div>
                </a>
            </li>
            <li>
                <a href="#">
                    <div class="boxv">
                        <img id="logo" src="/resources/img/timpill.svg">
                        <a href="/myPage"> 내 정보 </a>
                    </div>
                </a>
            </li>
            <li>
                <a href="#">
                    <div class="boxv">
                        <img id="logo" src="/resources/img/timpill.svg">
                        <a href="/medication"> 복약관리 </a>
                    </div>
                </a>
            </li>
            <li>
                <a href="#">
                    <div class="boxv">
                        <img id="logo" src="/resources/img/timpill.svg">
                        <a href="#"> 가이드 </a>
                    </div>
                </a>
            </li>
        </ul>
    </nav>
</div>

<script>
<c:if test="${not empty sessionScope.message}">
	alert("<c:out value='${sessionScope.message}'/>");
	<c:remove var="message" scope="session"/>
</c:if>
</script>

</body>
</html>
