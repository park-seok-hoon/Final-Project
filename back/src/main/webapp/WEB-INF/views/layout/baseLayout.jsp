<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
<title>
	<c:choose>
		<c:when test="${title != null }">${title}</c:when>
		<c:otherwise>SMEG - 3차프로젝트</c:otherwise>
	</c:choose>
</title>
<link rel="icon" type="image/x-icon" href="<c:url value="/resources/images/common/favicon.ico" />" />
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
<link rel="stylesheet" href="<c:url value="/resources/css/swiper-bundle.min.css" />" />
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
<script src="<c:url value="/resources/js/common.js" />"></script>
<script src="<c:url value="/resources/js/swiper-bundle.min.js" />"></script>
</head>
<body>
	<tiles:insertAttribute name="header"/>
	<tiles:insertAttribute name="body" />
	<tiles:insertAttribute name="footer" />
</body>
</html>