<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/error.css"/>">
</head>
<body>
	<div class="main-contents error">
		<div class="logo">
			<img src="<c:url value="/resources/images/common/logo_black.svg" />" alt="스메그로고" >
		</div>
		<div class="error-wrap">
			<div class="text-wrap">
				<h2>Oops!</h2>
				<p class="p1">원하시는 페이지를 찾을 수 없습니다.</p>
				<p class="p2">Error code: 500</p>
				<p class="p4">
					오류가 발생했으며 문제를 해결하기 위해 노력하고 있습니다!<br>
					SMEG 사이트는 곧 준비되어 실행될 것입니다.<br>
					<br>
					진행 중인 구매과 관련하여 고객 서비스 팀의 즉각적인 도움이 필요한 경우 전화해 주세요. 
					긴급한 문제가 아닌 경우 고객 센터를 방문하여 추가 정보를 확인하세요.<br>
					고객님께 불편함을 드려 죄송합니다.
				</p>
				<ul>
					<li><a href="<c:url value="/"/>">☞ HOME</a></li>
				</ul>
			</div>
			<div class="img-wrap">
				<img src="<c:url value="/resources/images/sub/error.gif" />" alt="에러이미지">
			</div>
		</div>
	</div>
</body>
</html>