<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/notice.css"/>">
</head>
<body>
   <main class="main-banner04">
   		<div class="main_text_wrap">
	        <h2>Notice</h2>
	        <div class="indicator">
	            <ul>
	                <li><a href="/index.html"><img src= "<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
	                <li><a href="/service/notice.html">SERVICE</a></li>
	                <li><a href="/service/notice.html">공지사항</a></li>
	            </ul>
	        </div>
        </div>
    </main>
    <div class="title-box">
        <h2>공지사항</h2>
        <p>
            스메그의 공지사항 안내 페이지입니다.<br>
			공지사항은 신제품, 매장, 이슈, 안내 카테고리로 나뉩니다.
        </p>
    </div>
    <div class="main-contents">
            <div class="h3title-wrap">
                <h3>[${notice.no_nc_name}] ${notice.no_title}</h3>
                <p><fmt:formatDate value="${notice.no_date}" pattern="yyyy-MM-dd"/></p>
            </div>
            <div class="content">
            	<!-- 기존 이미지는 resources폴더에서 지울것 : CSS 변경이 있음 -->
                ${notice.no_content}
            </div>
            <div class="prev-box">
                <div class="left">이전글</div>
                <div class="right">
               		<c:choose>
               			<c:when test="${noticePrev != null}">
               				<c:url value="/notice/detail" var="url">
								<c:param name="page" value="${cri.page}"/>
								<c:param name="type" value="${cri.type}"/>
								<c:param name="search" value="${cri.search}"/>
								<c:param name="noNum" value="${noticePrev.no_num}"/>
							</c:url>
               				<a href="${url}">${noticePrev.no_title}</a>
               			</c:when>
               			<c:otherwise>
							<span>이전글이 없습니다.</span>
						</c:otherwise>
               		</c:choose>
                </div>
            </div>
            <div class="next-box">
                <div class="left">다음글</div>
                <div class="right">
                	<c:choose>
               			<c:when test="${noticeNext != null}">
               				<c:url value="/notice/detail" var="url">
								<c:param name="page" value="${cri.page}"/>
								<c:param name="type" value="${cri.type}"/>
								<c:param name="search" value="${cri.search}"/>
								<c:param name="noNum" value="${noticeNext.no_num}"/>
							</c:url>
               				<a href="${url}">${noticeNext.no_title}</a>
               			</c:when>
               			<c:otherwise>
							<span>다음글이 없습니다.</span>
						</c:otherwise>
               		</c:choose>
                </div>
            </div>
            <c:url value="/notice/list" var="url">
				<c:param name="page" value="${cri.page}"/>
				<c:param name="type" value="${cri.type}"/>
				<c:param name="search" value="${cri.search}"/>
			</c:url>
            <a href="${url}" class="list-btn btn-hover">목록보기</a>
		</div>
</body>
</html>