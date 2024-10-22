<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/topnav.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/spin.css"/>">
	<!-- 스피너JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/spin.js/2.3.2/spin.js"></script>
</head>
<body>
	<main class="main-banner07">
		<div class="main_text_wrap">
			<h2>비밀번호 찾기</h2>
			<div class="indicator">
				<ul>
					<li><a href="<c:url value="/"/>"><img src="<c:url value="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
					<li><a href="<c:url value="/topnav/pw_search"/>">비밀번호 찾기</a></li>
				</ul>
			</div>
		</div>
	</main>
	<div class="title-box search-info">
		<h2>비밀번호 찾기</h2>
		<div class="find-pw-title">
			<ul>
				<li><a href="<c:url value="/topnav/id_search"/>">아이디 찾기</a></li>
				<li><a href="<c:url value="/topnav/pw_search"/>" class="active">비밀번호 찾기</a></li>
			</ul>
		</div>
	</div>
	<div class="main-contents">
		<div class="login-wrap">
			<div class="login-box">
				<p class="p1">회원가입시 등록한 아이디와 이메일주소를 입력하세요.</p>
				<!-- 주소를 전송하면 데이터가 전송되면서 페이지 이동됨 - 비동기로 처리 -->
				<form action="#">
					<label for="pw-putid" class="away">아이디 입력</label>
					<input type="text" id="pw-putid" placeholder="아이디를 입력하세요." name="id" required>
					<label for="pw-putemail" class="away">이메일 입력</label>
					<input type="email" id="pw-putemail" placeholder="이메일 주소를 입력하세요." name="email" required>
					<button type="button" class="findpw-btn btn-hover">비밀번호 찾기</button>
					<div id="spinner"></div>
					<script>
						const opts = {
						    lines: 12, // 선 개수
						    length: 50, // 각 선의 길이
						    width: 9, // 선 굵기
						    radius: 45, // 안쪽 원의 반지름
						    scale: 0.4, // 스피너의 전체 크기
						    corners: 1, // 코너 라운드(0..1)
						    speed: 1.2, // Rounds per second
						    rotate: 37, // 초당 회진 수
						    animation: 'spinner-line-fade-quick', // 라인의 CSS 애니메이션 이름
						    direction: 1, // 1: 시계 방향, -1: 시계 반대 방향
						    color: '#000000', //CSS 색상 
						    fadeColor: 'transparent', // CSS 색상 
						    top: '50%', // Top position 
						    left: '50%', // Left position 
						    shadow: '0 0 1px transparent', // 그림자
						    zIndex: 2000000000, //  z-index
						    className: 'spinner', // 스피너에 할당할 CSS 클래스
						    position: 'fixed', // positioning
						};
					
						const target = document.getElementById('spinner');
						const spinner = new Spinner(opts).spin(target);
					</script>
				</form>
				<p class="p2"><span>아직 스메그 회원이 아니신가요?</span></p>
				<a href="<c:url value="/topnav/signup"/>" class="signup-btn1">회원가입</a>
			</div>
			<div class="video-box">
				<video src="https://www.smegkorea.com//upload/main_promotion/2024041714271840971.mp4" autoplay muted></video>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		$('#spinner').hide(0);
		$('.findpw-btn').click(function(){
			//아이디를 가져옴(데이터 생성)
			let obj = {
				id : $('[name=id]').val(),
				email : $('[name=email]').val()
			}
			$('#spinner').show();
			//서버로 전송
			$.ajax({
				async : true,
				url : '<c:url value="/topnav/pw_search"/>', 
				type : 'post', 
				data : obj,
				dataType : "json", 
				success : function (data){
					console.log(data.result);
					if(data.result){
						alert("새 비번이 이메일로 전송됐습니다.");
						$('[name=id]').val('');
						$('[name=email]').val('');
						$('#spinner').hide();
						location.href = '<c:url value="/topnav/login"/>';
					}else{
						alert("가입된 회원이 아니거나 이메일이 잘못됐습니다.");
						$('#spinner').hide();
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
	
				}
			});
		})
	</script>
</body>
</html>