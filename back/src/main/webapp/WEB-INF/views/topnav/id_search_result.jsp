<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/topnav.css"/>">
</head>
<body>
	<main class="main-banner07">
		<div class="main_text_wrap">
			<h2>아이디 찾기</h2>
			<div class="indicator">
				<ul>
					<li><a href="<c:url value="/"/>"><img src="<c:url value="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
					<li><a href="<c:url value="/topnav/id_search"/>">아이디 찾기</a></li>
				</ul>
			</div>
		</div>
	</main>
	<div class="title-box search-info">
		<h2>아이디 찾기</h2>
		<div class="search-wrap">
			<ul>
				<li><a href="<c:url value="/topnav/id_search"/>" class="active">아이디찾기</a></li>
				<li><a href="<c:url value="/topnav/pw_search"/>">비밀번호찾기</a></li>
			</ul>
		</div>
	</div>
	<div class="main-contents">
		<div class="login-wrap">
			<div class="login-box">
         		<p class="p1">회원님의 아이디는 ${id}입니다. 로그인하세요.</p>          
                <form action="<c:url value="/topnav/id_search_result"/>" method="post">
                    <label for="search-id" class="away">아이디입력</label>
                    <input type="text" id="search-id" placeholder="아이디를 입력하세요." name="me_id" value=${id} required>
                    <label for="search-pw" class="away">비밀번호 입력</label>
                    <input type="password" id="search-pw" placeholder="비밀번호를 입력하세요." name="me_pw" required>
                    <button type="submit" id="search-btn" class="btn-hover">로그인</button>
                    <p class="p2"><span>아직 스메그 회원이 아니신가요?</span></p>
                	<button type="submit" id="signup-btn" class="btn-hover">회원가입</button>
                </form>
            </div>
			<div class="video-box">
				<!--자동실행하려면 음소거 해야함 : autoplay muted-->
				<video src="https://www.smegkorea.com//upload/main_promotion/2024041714271840971.mp4" autoplay muted></video>
			</div>
		</div>
	</div>
</body>
</html>