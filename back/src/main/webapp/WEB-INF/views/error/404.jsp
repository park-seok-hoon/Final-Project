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
				<p class="p2">Error code: 404</p>
				<p class="p3">대신 고객님을 도와 줄 수 있는 페이지를 안내합니다 : </p>
				<ul>
					<li><a href="<c:url value="/"/>">HOME</a></li>
					<li><a href="<c:url value="/smeg/history"/>">SMEG소개</a></li>
					<li><a href="<c:url value="/service/store"/>">매장안내</a></li>
					<li><a href="<c:url value="/faq/list"/>">자주하는 질문</a></li>
					<li><a href="<c:url value="/notice/list"/>">공지사항</a></li>
					<li><a href="<c:url value="/product/list/1/1"/>">제품페이지</a></li>
				</ul>
			</div>
			<div class="img-wrap">
				<img src="<c:url value="/resources/images/sub/error.gif" />" alt="에러이미지">
			</div>
		</div>
	</div>
</body>
</html>