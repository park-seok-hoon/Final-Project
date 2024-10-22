<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/personal_info.css"/> ">
</head>
<body>
	<main class="main-banner08">
		<div class="main_text_wrap">
	        <h2>개인정보수정</h2>
	        <div class="indicator">
	            <ul>
	               <li><a href="<c:url value ="/main/index/"/>"><img src= "<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
	                <li><a href="<c:url value ="/mypage/personal_info"/>">마이페이지</a></li>
	                <li><a href="<c:url value ="/mypage/personal_info"/>">개인정보수정</a></li>
	            </ul>
	        </div>
        </div>
    </main>
    <div class="myadmin-contents">
        <div class="left_contents">
            <div class="profile">
                <!-- 이메일이 없다면 카카오 로그인 -->
            	<c:if test="${user.me_email == null}">
            		<div class="first-name">카</div>
	                <div class="profile_text">
	                    <p class="user-name">카카오계정</p>
	                    <p class="user-id">이메일등록안함</p>
	                    <p class="user-phone">전화번호등록안함</p>
	                </div>
            	</c:if>
            	<!-- 이메일이 있다면 일반 로그인 -->
            	<c:if test="${user.me_email != null}">
	                <div class="first-name">${user.me_name.substring(0,1)}</div>
	                <div class="profile_text">
	                    <p class="user-name">${user.me_name}</p>
	                    <p class="user-id">${user.me_email}</p>
	                    <p class="user-phone">${user.me_phone}</p>
	                </div>
                </c:if>
            </div>
            <div class="sub-gnb">
                <ul>
                    <li><a href="<c:url value ="/mypage/personal_info"/>" class="active">개인정보수정</a></li>
                    <li><a href="<c:url value ="/mypage/order"/>">나의 주문내역</a></li>
                    <li><a href="<c:url value ="/mypage/shopping_list"/>">장바구니</a></li>
                    <li><a href="<c:url value ="/mypage/user_drop"/>">회원탈퇴</a></li>
                </ul>
            </div>
        </div>
        <div class="right_contents">
            <h2>개인정보수정</h2>
            <div class="sub_contents">
                <form action="<c:url value="/mypage/personal_info"/>" method="post" id="pw-box">
                    <fieldset class="insert-pw-box">
                        <p class="insert-pw-p">비밀번호를 입력해주세요.</p>
                        <input type="password" id="insert-pw-input" placeholder="비밀번호 입력" name="me_pw">
                        <label for="insert-pw-input" class="away">비밀번호 입력칸</label>
                    </fieldset>
                    <!-- 카카오로만 로그인한 경우 : 이메일이 kakao!이면서 이메일이 비어있는 경우 -->
                    <c:if test="${fn:substring(user.me_id, 0, 6) == 'kakao!' && user.me_email == null}">
	                    <br>
	                    <p>카카오로 로그인한 경우 기본 비밀번호는 0000입니다.<br>개인정보를 수정해야 주문이 가능합니다.</p>
                    </c:if>
                    <button type="submit" id="personal_btn" class="btn-hover">개인정보수정</button>
                </form>
            </div>
        </div>
    </div>
    <!-- 빈문자열인 경우 로그인 안되게 방지 -->
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#pw-box').submit(function(e){
    			e.preventDefault();
    			
    			//비번 문자열 비어있어도 안됨
    			let pwChk = $('#insert-pw-input').val();
    			if(pwChk == ""){
    				alert('비밀번호를 입력해주세요.');
    				return false;
    			}
    			
    			$('#pw-box').unbind('submit').submit();
    		});
    	});
    </script>
</body>
</html>