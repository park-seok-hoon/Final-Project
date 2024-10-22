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
			<h2>로그인</h2>
			<div class="indicator">
				<ul>
					<li><a href="<c:url value="/"/>"><img src="<c:url value="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
					<li><a href="<c:url value="/topnav/login"/>">로그인</a></li>
				</ul>
			</div>
		</div>
	</main>
	<div class="title-box">
		<h2>로그인</h2>
		<p>
			반갑습니다.<br>
			스메그 고객님! 로그인해주세요.
		</p>
	</div>
	<div class="main-contents">
		<div class="login-wrap">
			<div class="login-box">
				<form action="<c:url value="/topnav/login"/>" method="post">
					<input type="text" id="insert_id" placeholder="아이디 입력" name="me_id" value="${remember}" required>
					<label for="insert_id" class="away">아이디 입력칸</label>
					<input type="password" id="insert_pw" placeholder="비밀번호 입력" name="me_pw" required>
					<label for="insert_pw" class="away">비밀번호 입력칸</label>
					<button type="submit" id="login_btn" class="btn-hover">로그인</button>
					<div class="login-box-bottom">
						<div class="chk-box">
							<!-- 로그아웃 후 다시 로그인할 때 check on 상태를 유지하기 위한 코드 작성 -->
							<input type="checkbox" id="save_id" name="remember" ${remember != "" ? 'checked' : '' }>                
							<label for="save_id">아이디 저장</label>
							<!-- 모든 input태그는 label태그와 연결되어야 함 -->
							<input type="checkbox" class="form-check-input" value="true" name="autoLogin" id="autoLogin">
							<label for="autoLogin">자동로그인</label>
						</div>
						<ul>
							<li>
								<a href="<c:url value="/topnav/id_search"/>" class="atag_id">아이디 찾기</a>
							</li>
							<li>
								<a href="<c:url value="/topnav/pw_search"/>" class="atag_pw">비밀번호 찾기</a>
							</li>
						</ul>
					</div>
				</form>
				<p class="p2"><span>아직 스메그 회원이 아니신가요?</span></p>
				<a href="<c:url value="/topnav/signup"/>" id="move_signup">회원가입</a>
				<p class="p3"><span>간편 로그인</span></p>
				<a href="javascript:loginWithKakao()" id="kakao_signup">카카오로 시작하기</a>
			</div>
			<div class="video-box">
			<!--자동실행하려면 음소거 해야함 : autoplay muted-->
				<video src="https://www.smegkorea.com//upload/main_promotion/2024041714271840971.mp4" autoplay muted></video>
			</div>
		</div>
	</div>
	<!-- 카카오로그인 -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script type="text/javascript">
		Kakao.init('5ca45955fef8e1cbc29a43c4c9df8a4a'); // 사용하려는 앱의 JavaScript 키 입력
		
		function loginWithKakao() {
			Kakao.Auth.login({
		        success: function (authObj) {
		           Kakao.Auth.setAccessToken(authObj.access_token); // access토큰값 저장
							
		           getInfo(); //동의한 회원정보 가져오기
		        },
		        fail: function (err) {
		           console.log(err);
		        }
	        });
	    }
		function getInfo() {
		    Kakao.API.request({
		      url: '/v2/user/me',
		      success: function (res) {
		        // 이메일, 성별, 닉네임, 프로필이미지
		        var id = res.id;
		        var sns = "kakao";
		        if(!checkMember(sns, id)){
		        	if(confirm("회원이 아닙니다. 가입하시겠습니까?")){
		        		signupSns(sns, id);
		        	}else{
		        		return;
		        	}
		        }
		        snsLogin(sns, id);
		       	location.href = '<c:url value="/"/>';

		      },
		      fail: function (error) {
		          alert('카카오 로그인에 실패했습니다. 관리자에게 문의하세요.' + JSON.stringify(error));
		      }
		    });
		  }
		  function checkMember(sns, id){
			  var res;
			  $.ajax({
					async : false,
					url : `<c:url value="/sns"/>/\${sns}/check/id`, 
					type : 'post', 
					data : {id}, 
					success : function (data){
						res = data;
					}, 
					error : function(jqXHR, textStatus, errorThrown){

					}
				});
			  return res;
		  }
		  function signupSns(sns, id){
			  $.ajax({
					async : false,
					url : `<c:url value="/sns"/>/\${sns}/signup`, 
					type : 'post', 
					data : {id}, 
					success : function (data){
						
					}, 
					error : function(jqXHR, textStatus, errorThrown){
						
					}
				});
		  }
		  function snsLogin(sns, id){
			  $.ajax({
					async : false,
					url : `<c:url value="/sns"/>/\${sns}/login`, 
					type : 'post', 
					data : {id}, 
					success : function (data){
						if(data){
							alert("로그인 되었습니다.");
						}
					}, 
					error : function(jqXHR, textStatus, errorThrown){
						
					}
				});
		  }
	</script>
</body>
</html>