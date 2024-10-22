<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css" />" >
	<link rel="stylesheet" href="<c:url value="/resources/css/store.css" />" >
	<script src="<c:url value="/resources/js/store.js"/>"></script>
</head>

<body>
	<main class="main-banner06">
		<div class="main_text_wrap">
			<h2>Store</h2>
			<div class="indicator">
				<ul>
					<li><a href="<c:url value="/"/>"><img src="<c:url value="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
					<li><a href="<c:url value="/notice/list"/>">SERVICE</a></li>
					<li><a href="<c:url value="/service/store"/>">매장안내</a></li>
				</ul>
			</div>
		</div>
	</main>
	<div class="title-box">
		<h2>매장안내</h2>
        <p>
			스메그가 입점한 백화점이나 쇼핑몰, 플래그쉽을<br>
			잘 찾아갈 수 있도록 안내를 합니다.
		</p>
    </div>
	<div class="main-contents">
		<div class="map-box">
			<iframe src="<c:url value="/resources/service/store01.html"/>" width="580" height="800" name="map-iframe"></iframe>
		</div>
		<div class="store-list">
			<ul>
				<li>
					<a href="<c:url value="/resources/service/store01.html"/>" class="active" target="map-iframe">
						<h3>서울 : 스메그 청담 플래그십</h3>
						<p class="phone">02-413-9500</p>
						<p class="address">서울 강남구 압구정로 437 지하1층~1층</p>
					</a>
				</li>
				<li>
					<a href="<c:url value="/resources/service/store02.html"/>" target="map-iframe">
						<h3>서울 : 스메그 푸드서비스 스토어</h3>
						<p class="phone">02-413-9500</p>
						<p class="address">서울 강남구 압구정로 437 지하1층</p>
					</a>
				</li>
				<li>
					<a href="<c:url value="/resources/service/store03.html"/>" target="map-iframe">
						<h3>서울 : 신세계백화점 강남점</h3>
						<p class="phone">02-3479-1498</p>
						<p class="address">서울 서초구 신발포로 176 신세계백화점 강남점 신관9층 (수입가전 코너)</p>
					</a>
				</li>
				<li>
					<a href="<c:url value="/resources/service/store04.html"/>" target="map-iframe">
						<h3>서울 : 롯데백화점 본점(명동)</h3>
						<p class="phone">02-772-3824</p>
						<p class="address">서울 중구 남대문로 81 롯데백화점 본점 8층</p>
					</a>
				</li>
				<li>
					<a href="<c:url value="/resources/service/store05.html"/>" target="map-iframe">
						<h3>경기: 신세계백화점 경기점</h3>
						<p class="phone">031-695-1435</p>
						<p class="address">경기 용인시 수지구 포은대로 536 6층</p>
					</a>
				</li>
				<li>
					<a href="<c:url value="/resources/service/store06.html"/>" target="map-iframe">
						<h3>대구 : 신세계백화점 대구점</h3>
						<p class="phone">053-661-6696</p>
						<p class="address">대구광역시 동구 동부로149(신천동) 신세계백화점 대구점 7층</p>
					</a>
				</li>
				<li>
					<a href="<c:url value="/resources/service/store07.html"/>" target="map-iframe">
						<h3>대구 : 현대백화점 대구점</h3>
						<p class="phone">053-245-3736</p>
						<p class="address">대구광역시 중구 달구벌대로 2077 현대백화점 대구점 7층</p>
					</a>
				</li>
				<li>
					<a href="<c:url value="/resources/service/store08.html"/>" target="map-iframe">
						<h3>부산 : 신세계백화점 센텀시티점</h3>
						<p class="phone">051-745-2576</p>
						<p class="address">부산광역시 해운대구 센텀남대로 35 신세계백화점 센텀시티점 7층</p>
					</a>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>