<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/main.css" />">
<script src="<c:url value="/resources/js/main.js" />"></script>
</head>
<body>
	<!-- 여긴 notice부분만 제외하고 모두 가져옵니다. -->
	<div class="popup">
		<div class="popup-wrap">
			<div class="popup-img">
				<img src="<c:url value="/resources/images/main/popup_top_img.png" />" alt="팝업상단이미지">
			</div>
		<div class="popup-text">
			<h3>NOTICE</h3>
			<p class="first-text">
			    본 사이트는 상업적 목적이 아닌 개인 포트폴리오 용도로 만들어 졌습니다. 홈페이지의 일부 내용과 이미지 등은 그 출처가 따로 있음을 밝힙니다.<br>
			    본 사이트는 스프링과 JSP를 이용한 백엔드 작업을 처리한 백엔트 포트폴리오입니다. 반응형웹과 모바일웹은 지원하지 않습니다.<br>
			    <br>
			    <strong>TEAM : PSH, SGJ, OSN, LSJ</strong>
			</p>
			<h3>SMEG SITE</h3>
			<p>
			    QR코드를 스캔하면 실제 SMEG사이트로<br>
			    이동하실 수 있습니다.
			</p>
			<img src="<c:url value="/resources/images/main/qrcode.jpg" />" alt="스메그큐알코드" class="qr-code">
		</div>
		<ul class="btn">
		    <li><a href="<c:url value="#" />" class="today-btn">오늘 하루 안보기</a></li>
		    <li><a href="<c:url value="#" />" class="close-btn">닫기</a></li>
		</ul>
		</div>
	</div>
	<main>
		<div class="swiper"><!--스와이퍼의 모든 것을 담는 태그-->
			<div class="swiper-wrapper"><!--슬라이드 전체를 묶는 태그-->
				<div class="swiper-slide"><!--슬라이드 한개한개-->
					<img src="<c:url value="/resources/images/main/main01.jpg" />" alt="메인이미지">
					<div class="main-text-wrap">
						<p>그레이 컬러, 심플한 디자인과 다양한 기능 리니아 인덕션</p>
						<h3>Linea Induction</h3>
						<!--jsp에서 페이지이동처리-->
						<a href="<c:url value="/product/detail?pr_code=SIM1643D" />">자세히보기</a>
					</div>
				</div>
				<div class="swiper-slide"><!--슬라이드 한개한개-->
					<img src="<c:url value="/resources/images/main/main02.jpg" />" alt="메인이미지">
					<div class="main-text-wrap">
						<p>와인셀러를 더한 프리미엄 냉장고</p>
						<h3>The New FAB Series</h3>
						<!--jsp에서 페이지이동처리-->
						<a href="<c:url value="/product/detail?pr_code=SCV115A" />">자세히보기</a>
					</div>
				</div>
				<div class="swiper-slide"><!--슬라이드 한개한개-->
					<img src="<c:url value="/resources/images/main/main03.jpg" />" alt="메인이미지">
					<div class="main-text-wrap">
						<p>스매그와 미드 센추리 모던</p>
						<h3>Mid - Century Modern</h3>
						<!--jsp에서 페이지이동처리-->
						<a href="<c:url value="/product/detail?pr_code=FAB28RDRB5" />">자세히보기</a>
					</div>
				</div>
			</div>
			<!--버튼-->
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>
	</main>
	<div class="smeg-intro">
		<div class="inner-wrap">
			<h2>SMEG, 기술에 ITALY 스타일을 더하다</h2>
			<p>
			    스메그는 이탈리아에 4개의 공장을 가지고 있습니다. 이곳의 검증된 연구실들은 소재에 대한 깊은 이해와 예술의 경지에 이른 최첨단 기술력으로 현대 생활에서 필요한 것들을 분석하고 내구성, 안전성, 편의성 및 에너지 효율 그리고 사용자가 즐거움을 느낄 수 있는 감정을 제품에 표현합니다.<br>
			    전체 생산 공정에서 반복적으로 진행되는 엄격한 품질 테스트는 고객과의 신뢰를 절대적으로 생각하는 스메그의 마음가짐을 잘 보여줍니다. 더 나아가, 스메그의 모든 제품은 최신 인터페이스와 다양한 프로그래밍 솔루션을 도입하여 보다 쉽고 단순하게 사용자의 다양한 니즈를 충족시켜줍니다.
			</p>
			<a href="<c:url value="/smeg/history" />">View More</a>
		</div>
	</div>
	<div class="smeg-special">
	    <div class="tab-contents"><!--탭컨텐츠들을 묶을 태그-->
		    <div class="dng"><img src="<c:url value="/resources/images/main/special_banner01.jpg"  />" alt="스페셜배너"></div>
		    <div class="fiat"><img src="<c:url value="/resources/images/main/special_banner02.jpg" />" alt="스페셜배너"></div>
		    <div class="disney"><img src="<c:url value="/resources/images/main/special_banner03.jpg" />" alt="스페셜배너"></div>
		    <div class="cocacola"><img src="<c:url value="/resources/images/main/special_banner04.jpg" />" alt="스페셜배너"></div>
		</div>
		<ul class="tab-btn"><!--탭버튼들을 묶을 태그-->
			<li>
				<div class="btn active">
					<h3>D&amp;G</h3>
					<p>SMEG와 D&amp;G, 서로의 감성과 크리에이티브를 결합하다.</p>
					<a href="<c:url value="/product/list/1/1" />" class="arrow">View More</a>
				</div>
			</li>
			<li>
				<div class="btn">
					<h3>FIAT</h3>
					<p>스메그와 피아트는 이탈리아 인디펜던트 그룹와 함께 이 프로젝트를 완성하다.</p>
					<a href="<c:url value="/product/list/1/2" />" class="arrow">View More</a>
				</div>
			</li>
			<li>
				<div class="btn">
					<h3>DISNEY</h3>
					<p>스메그와 디즈니가 콜라보레이션을 통해 가족에 대한 사랑을 전하다.</p>
					<a href="<c:url value="/product/list/1/3" />" class="arrow">View More</a>
				</div>
			</li>
			<li>
				<div class="btn">
					<h3>COCACOLA</h3>
					<p>시간이 흘러도 변함 없이 사랑받는 클래식, 아이코닉한 아이템으로 대표되는 두 브랜드의 만남.</p>
					<a href="<c:url value="/product/list/1/4" />" class="arrow">View More</a>
				</div>
			</li>
		</ul>
	</div>
	<div class="best-product">
		<h2>SMEG BEST PRODUCT</h2>
		<div class="swiper">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<div class="img-wrap"><img src="<c:url value="/resources/images/main/best_banner01.jpg" />" alt="베스트상품이미지"></div>
					<div class="text-wrap">
						<h3>대형가전</h3>
						<h4>냉장고 유니언잭</h4>
						<p>세계적으로 사랑받는 스테디셀러 50’s Retro Style 냉장고는 다채로운 컬러와 광택, 부드러운 곡선 디자인으로 컬러 냉장고의 시대를 열었습니다.</p>
						<a href="<c:url value="/product/detail?pr_code=FAB5RDUJ5" />">View More</a>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="img-wrap"><img src="<c:url value="/resources/images/main/best_banner02.jpg" />" alt="베스트상품이미지"></div>
					<div class="text-wrap">
						<h3>소형가전</h3>
						<h4>핸드믹서 레드</h4>
						<p>9단계의 속도 조절과 강력한 터보 기능,<br>
						    LED 디스플레이가 적용되어 더욱 편리한 베이킹 필수품</p>
						<a href="#" onclick="alert('핸드믹서는 곧 출시될 예정입니다.'); return false;">View More</a>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="img-wrap"><img src="<c:url value="/resources/images/main/best_banner03.jpg" />" alt="베스트상품이미지"></div>
					<div class="text-wrap">
						<h3>소형가전</h3>
						<h4>토스트기 파스텔그린</h4>
						<p>4구의 빵 투입구로 한 번에 4장의 식빵 등을 구워 낼 수 있습니다. 다인 가구 뿐만 아니라 게스트하우스, 카페 등에서 폭 넓은 활용이 가능합니다. </p>
						<a href="<c:url value="/product/detail?pr_code=TSF01PGEU" />" >View More</a>
					</div>
				</div>
				<div class="swiper-slide">
					<div class="img-wrap"><img src="<c:url value="/resources/images/main/best_banner04.jpg" />" alt="베스트상품이미지"></div>
					<div class="text-wrap">
						<h3>대형가전</h3>
						<h4>빅토리아 인덕션 실버</h4>
						<p>빅토리아 인덕션은 내구성이 강하고 70년의 빌트인 기술력을 바탕으로 뛰어난 품질과 제품 안정성을 자랑합니다. 빅토리아 라인의 특징적인 디테일이 돋보이는 모델입니다.</p>
						<a href="<c:url value="/product/detail?pr_code=SI964XM" />" >View More</a>
					</div>
				</div>
			</div>
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>
	</div>
	<div class="smeg-notice">
		<h2>SMEG NOTICE</h2>
		<a href="<c:url value="/notice/list"/>" class="more">View More</a>
		<ul>
			<!-- 공지사항 최신 리스트를 DB에서 가져옴 - 그 중 이미지 파일이 있는 것만, CSS도 변경있음, 기존이미지는 리소스에서 삭제 -->
			<c:forEach items="${noticelist}" var="notice">
				<li>
					<c:url value="/notice/detail" var="url">
						<c:param name="page" value="1"/>
						<c:param name="type" value="all"/>
						<c:param name="noNum" value="${notice.no_num}"/>
					</c:url>
					<a href="${url}">
							<!-- filelist는 여러 개일 수 있으므로 첫번째배열값만 가져오게 처리 : ${notice.filelist[0].fi_name} -->
							<img src="<c:url value="/download${notice.filelist[0].fi_name}" />" alt="${notice.no_title} 관련이미지">
							<h3>${notice.no_title}</h3>
							<p>${notice.no_content_html}</p>
							<span class="date"><fmt:formatDate value="${notice.no_date}" pattern="yyyy-MM-dd"/></span>
							<br>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>
			