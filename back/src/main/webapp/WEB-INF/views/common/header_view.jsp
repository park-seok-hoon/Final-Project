<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>

</head>
<header>
    <h1>
        <a href="<c:url value="/"/>">
            <img src="<c:url value="/resources/images/common/logo.svg" />" alt="스메그로고" class="white">
            <img src="<c:url value="/resources/images/common/logo_black.svg" />" alt="스메그로고" class="black">
        </a>
    </h1>
    <nav class="gnb">
        <ul>
            <li>
                <a href="<c:url value="/smeg/history" />">SMEG</a>
                <ul class="sub-nav">
                    <li><a href="<c:url value="/smeg/history" />">연혁</a></li>
                    <li><a href="<c:url value="/smeg/story" />">스토리</a></li>
                    <li><a href="<c:url value="/smeg/award" />">수상내역</a></li>
                </ul>
            </li>
            <!-- group을 찍기 위한 c:foreach -->
            <c:forEach items="${grouplist}" var="group">
            	<!-- category를 찍기 위한 c:foreach  -->
            	<li>
            		<c:forEach items="${group.categorylist}" var="category" varStatus="status" begin="0" end="0">
                		<a href="<c:url value="/product/list/${group.gr_num}/${category.ca_num}" />">${group.gr_name}</a>
               		</c:forEach>
                 	<ul class="sub-nav">
		            	<c:forEach items="${group.categorylist}" var="category">
		            		<li><a href="<c:url value="/product/list/${group.gr_num}/${category.ca_num}" />">${category.ca_name}</a></li>
		            	</c:forEach>
	            	</ul>
	            </li>
            </c:forEach>
            <li>
                <a href="<c:url value="/notice/list" />">SERVICE</a>
                <ul class="sub-nav">
                    <li><a href="<c:url value="/notice/list"/>">공지사항</a></li>
                    <li><a href="<c:url value="/faq/list" />">FAQ</a></li>
                    <li><a href="<c:url value="/service/store" />">매장 안내</a></li>
                </ul>
            </li>
        </ul>
    </nav>
    <!-- 하위메뉴 뒤에 깔릴 배경 -->
    <div class="gnb-bg"></div>
    <div class="top-nav">
        <ul>
            <li>
                <a href="#" class="search-btn">
                    <img src="<c:url value="/resources/images/common/search.svg" />" alt="검색아이콘" class="white">
                    <img src="<c:url value="/resources/images/common/search_black.svg" />" alt="검색아이콘" class="black">
                </a>
            </li>
            <li>
                <!-- 로그인을 안한 상태 -->
            	<c:if test="${user == null }">
	                <a href="#" class="shop-link">
	                    <img src="<c:url value="/resources/images/common/shop.svg" />" alt="장바구니아이콘" class="white">
	                    <img src="<c:url value="/resources/images/common/shop_black.svg" />" alt="장바구니아이콘" class="black">
	                </a>
	                <script type="text/javascript">
	                	$('.shop-link').click(function(e){
	                		e.preventDefault();
	                		let q = confirm('로그인을 해야합니다. 로그인페이지로 이동하시겠습니까?');
	                		
	                		if(q){
	                			location.href = '<c:url value="/topnav/login" />';
	                		}
	                	});
	                </script>
                </c:if>
                <!-- 로그인한 상태 -->
	            <c:if test="${user != null }">
	            	<a href="<c:url value="/mypage/shopping_list" />">
	                    <img src="<c:url value="/resources/images/common/shop.svg" />" alt="장바구니아이콘" class="white">
	                    <img src="<c:url value="/resources/images/common/shop_black.svg" />" alt="장바구니아이콘" class="black">
	                </a>
	            </c:if>
            </li>
			<!-- 로그인을 안한 상태 -->
            <c:if test="${user == null }">
	            <li><a href="<c:url value="/topnav/login" />">로그인</a></li>
	            <li><a href="<c:url value="/topnav/signup" />">회원가입</a></li>
            </c:if>
            <!-- 로그인한 상태 -->
            <c:if test="${user != null }">
            	<li><a href="<c:url value="/mypage/personal_info" />">마이페이지</a></li>
            	<li><a href="<c:url value="/topnav/logout" />">로그아웃</a></li>
            </c:if>
        </ul>
    </div>
</header>
<div class="search-box">
   <!-- 제품검색처리 : 플레이스 홀더 변경 있습니다.-->
   <form action="<c:url value="/product/search" />" method="get">
       <!-- label의 for와 id의 속성값이 같아야 스크린리더기가 읽어줌 -->
       <!-- 앞으로 label에 class를 away로 붙이면 이건 화면에서 안보이게 하겠다는 뜻! -->
       <label for="search-input" class="away">검색입력창</label>
       <input type="text" id="search-input" name="search" placeholder="제품명을 입력해주세요." />
       <input type="hidden" name="type" value="all">
   </form>
   <!-- 닫기버튼 : a 혹은 button 중 선택가능 -->
   <!-- a태그로 쓸 경우는 임시링크 #을 쓰면 클릭시 자꾸 상단이동하므로 뒤에 의미없는 영문 붙이기(id로 안쓰는)-->
   <a href="#close"><img src="<c:url value="/resources/images/common/close_icon.svg" />" alt="닫기버튼"></a>
</div>
<!-- header 제품 상세페이지 관련 클래스 처리 -->
<script type="text/javascript">
	let url = location.href;
	
	if(url.includes('/product/detail')){
		$('header').addClass('detail');
	}
	
	//이상한 주소를 쳐도 에러페이지가 반환되기 때문에
	let mainContents = $('.main-contents').hasClass('error');
	
	if(url.includes('/error') || mainContents){
		$('header').addClass('error');
	}
</script>
</html>