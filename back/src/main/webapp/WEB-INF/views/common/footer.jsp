<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<footer>
    <div class="inner-wrap">
        <div class="footer-top">
            <div class="sns-box">
                <h3>SMEG SNS</h3>
                <ul>
                    <!--
                        a태그의 target속성 : 열릴 페이지가 어디에 뜰지 지정해주는 속성
                        기본값(작성안한다는 뜻)은 _self로 현재 창에서 변경
                        새창이나 새탭에서 처리하려면 _blank로 처리
                    -->
                    <li><a href="https://www.facebook.com/smegkorea" target="_blank"><img src="<c:url value="/resources/images/common/sns01.svg" />" alt="페이스북아이콘"></a></li>
                    <li><a href="https://www.instagram.com/smegkorea/" target="_blank"><img src="<c:url value="/resources/images/common/sns02.svg" />" alt="인스타그램아이콘"></a></li>
                    <li><a href="https://www.youtube.com/channel/UCCwqSNH1-AN1C-AwWhZnKHw?reload=9" target="_blank"><img src="<c:url value="/resources/images/common/sns03.svg" />" alt="유튜브아이콘"></a></li>
                    <li><a href="https://cafe.naver.com/smegcafe" target="_blank"><img src="<c:url value="/resources/images/common/sns04.svg" />" alt="네이버카페아이콘"></a></li>
                </ul>
            </div>
            <div class="footer-nav">
                <ul>
                    <li><a href="<c:url value="/smeg/history" />">스메그소개</a></li>
                    <li><a href="<c:url value="/service/store" />">매장안내</a></li>
                    <li><a href="<c:url value="/faq/list" />">FAQ</a></li>
                    <li><a href="<c:url value="/notice/list" />">공지사항</a></li>
                    <!-- 관리자는 추후에 관리자만 보이게 처리 -->
                    <!-- 로그인한 상태 -->
           			<c:if test="${user != null && user.me_authority == 'ADMIN' }">
                    	<li><a href="<c:url value="/admin/user_list" />">관리자</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>Copyright Ⓒ SMEGKOREA Co., Ltd. All Right Reserved.</p>
            <h1><img src="<c:url value="/resources/images/common/logo.svg" />" alt="스메그로고"></h1>
        </div>
    </div>
</footer>
<!--스크롤탑버튼-->
<a href="#top" class="scroll-btn">
    <img src="<c:url value="/resources/images/common/top_anchor.png" />" alt="상단으로 가기">
</a>
</html>