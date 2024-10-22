<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/product.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/search.css"/>">
    <script src="<c:url value="/resources/js/sub.js"/>"></script>
</head>
<body class="product">
	<!-- sub-common.css : 메인이미지 추가 -->
	<main class="main-banner10">
		<div class="main_text_wrap">
			<h2>검색결과 : ${pm.cri.search}</h2>
       </div>
	</main>
	<div class="main-contents">
		<div class="top-text-wrap">
			<ul>
				<li>검색결과 : ${pm.cri.search}</li>
				<li>총 ${totalCount}개의 상품이 있습니다.</li>
			</ul> 
		</div>
		<ul class="products">
    		<!-- 제품리스트가 있는 경우 -->
    		<c:if test="${productlist.size() != 0}">
	    		<c:forEach items="${productlist}" var="product">
	    			<li>
	    				<!-- 이미지 크기 땜에 CSS처리 -->
	    				<a href="<c:url value="/product/detail?pr_code=${product.pr_code}" />">  <!-- productDetail 작업 후 수정 필요 내역 -->
	    					<img src="<c:url value="/download${product.slidelist[0].sp_name}"/>" alt="${product.pr_name}">
	    					<div class="text-wrap">
	    						<h3>${product.pr_name}</h3>
								<p class="code">${product.pr_code}</p>
								<p class="price">${product.pr_price}</p>
								<c:if test="${product.pr_ps_state == '품절'}">
									<p class="sold-out">품절</p>
								</c:if>
	    					</div>
	    				</a>
	    			</li>
	    		</c:forEach>
    		</c:if>
    		<!-- 제품리스트가 없는 경우 -->
    		<c:if test="${productlist.size() == 0}">
    			<li class="list-blank">
    				<img src="<c:url value="/resources/images/sub/data_empty.svg" />" alt="빈공간 아이콘">
    				<br>
    				<p>
    					검색결과가 없습니다.<br>
    					제품명 혹은 제품명의 일부를 검색해주세요.
    				</p>
    			</li>
    		</c:if>
    	</ul>
    	<ul class="pagination">
    		<c:if test="${pm.prev}">
				<!--백엔드에서 주소를 통해서 active를 변경시킴-->
				<!-- 이전버튼 -->
				<li>
					<c:url var="url" value="/product/search">
						<c:param name="page" value="${pm.startPage - 1}"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="type" value="${pm.cri.type}"/>
					</c:url>
					<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_prev.svg"/>" alt="이전으로"></a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			<c:set var="active" value="${pm.cri.page == i ?'active':'' }"/>
				<li>
					<c:url var="url" value="/product/search">
						<c:param name="page" value="${i}"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="type" value="${pm.cri.type}"/>
					</c:url>
					<a href="${url}" class="${active}">${i}</a>
				</li>
			</c:forEach>
			<!-- 다음버튼 -->
			<c:if test="${pm.next}">
				<li class="page-item">
					<c:url var="url" value="/product/search">
						<c:param name="page" value="${pm.endPage + 1}"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="type" value="${pm.cri.type}"/>
					</c:url>
					<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_next.svg"/>" alt="다음으로"></a>
				</li>
			</c:if>
    	</ul>
	</div>
</body>
</html>