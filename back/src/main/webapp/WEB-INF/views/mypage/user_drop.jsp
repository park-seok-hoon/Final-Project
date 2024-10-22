<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/user_drop.css"/>">
</head>
<body>
  <main class="main-banner08">
  	<div class="main_text_wrap">
	     <h2>개인정보수정</h2>
	     <div class="indicator">
	         <ul>
				<li><a href="/index.html"><img src= "<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
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
             <li><a href="<c:url value ="/mypage/personal_info"/>">개인정보수정</a></li>
             <li><a href="<c:url value ="/mypage/order"/>">나의 주문내역</a></li>
             <li><a href="<c:url value ="/mypage/shopping_list"/>">장바구니</a></li>
             <li><a href="<c:url value ="/mypage/user_drop"/>" class="active">회원탈퇴</a></li>
             </ul>
         </div>
     </div>
    <div class="right_contents">
         <h2>회원탈퇴</h2>
         <div class="sub_contents">
             <div class="right-box">
                 <form action="<c:url value="/mypage/user_drop" />" method="post" id="user-drop-box">
                 	 <p class="top-p1">■ 회원탈퇴 시 안내 사항</p>  
	                 <p class="top-p2">
	                     회원 탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.<br>
	                     사용하고 계신 아이디는 탈퇴할 경우 재사용 및 복구가 불가능합니다.<br>
	                     <br>
	                     <br>
	                     탈퇴 후 회원정보 및 서비스 이용기록은 모두 삭제됩니다.<br>
	                     삭제되는 기록 : 이름, 아이디, 주소, 전화번호, 이메일주소, 상품구매내역 등<br>
	                     <br>
	                     <br>
	                     구매한 상품 내역도 모두 삭제되니 주의바랍니다.
	                 </p>  
	                 <input type="checkbox" class="top-chk" id="top-chk">
	                 <label for="top-chk" class="top-chk">회원 탈퇴 시 유의사항을 확인했습니다.</label>
	                 <p class="bot-p1">■ 무엇이 불편하였나요?</p>
	                 
	                 <div class="bot-checkgroup">
	                     <input type="checkbox" class="bot-chk1">
	                     <label for="bot-chk1">고객서비스(상담)불만</label>
	                     <input type="checkbox" class="bot-chk2">
	                     <label for="bot-chk2">배송 서비스 불만</label>
	                     <input type="checkbox" class="bot-chk3">
	                     <label for="bot-chk3">상품 품질 불만</label>
	                     <input type="checkbox" class="bot-chk4">
	                     <label for="bot-chk4">기타 불만</label>
	                 </div>
	                 <textarea id="bot-textarea" cols="30" rows="10" placeholder="불만사항을 입력해주세요."></textarea>
	                 <label for="bot-textarea" class="away">불만사항입력상자</label>
	                 <div class="bot-pwbox">
	                     <label for="bot-pw">비밀번호 입력 :</label>
	                     <input type="password" class="bot-pw" id="bot-pw" name="bot-pw" placeholder="비밀번호 입력">
	                 </div>
	                 <button type="submit" class="bot-outbtn btn-hover">회원 탈퇴</button>
                 </form>                                           
             </div>
         </div>
     </div>
 </div>
 
 <!-- 유효성 검사 -->
 <script type="text/javascript">
 	 //비밀번호 찾기 관련 비동기 함수
 	 function pwCheckDup(){
			let pw = $('[name=bot-pw]').val();
			//입력된 비밀번호를 가져옴
			let obj = {
				pw : pw
			}
			let result = false;
			//서버에 아이디를 전송해서 사용 가능/불가능 처리
			$.ajax({
				async : false,
				url : '<c:url value="/mypage/pw/check/dup" />', 
				type : 'get', 
				data : obj, 
				dataType : "json", 
				success : function (data){
					result = data.result;
					console.log(result);
				}, 
				error : function(jqXHR, textStatus, errorThrown){
		
				}
			});
			return result;
	 }
 
 	 //이벤트가 바로 전송되어서 JavaScript가 HTML 요소를 완전히 로드한 후에 실행되도록 $(document).ready() 함수를 추가
	 $(document).ready(function(){
	 	$('#user-drop-box').submit(function(e){
			e.preventDefault(); //기본이벤트 제거 - 데이터 전송방지
			
			//관리자인 경우 탈퇴 못하게 처리
			let authority = '${user.me_authority}';
			if(authority == 'ADMIN'){
				alert('관리자는 탈퇴할 수 없습니다.');
				return false;
			}
			
			//회원 탈퇴 시 유의사항 체크
			let topChk = $('#top-chk').prop('checked');
			if(!topChk){
				alert('회원 탈퇴시 유의사항을 체크해주세요.');
				return false;
			}
			
			//불만 사항 중 하나라도 체크
			let count = 0;
			$('.bot-checkgroup input[type="checkbox"]').each(function(){
				let chk = $(this).prop('checked');
				if(chk){
					count++;
				}
			});
			
			//체크를 하나라도 안했다면
			if(count == 0){
				alert('불만사항을 하나라도 체크해주세요.');
				return false;
			}
			
			//글자를 하나라도 입력하지 않았다면
			let textCount = $('#bot-textarea').val();
			if(textCount.length < 1 || textCount == ''){
				alert('입력상자에 한글자이상 입력하세요. 없으면 없음이라고 작성해주세요.');
				$('#bot-textarea').focus();
				return false;
			};
			
			//비밀번호 체크는 비동기로 가져와야 함 - 암호화되었기 때문
			let userPass = pwCheckDup();
			if(!userPass){
				alert('비밀번호가 틀립니다. 다시 입력해주세요.');
				$('#bot-pw').focus();
				return false;
			};
			
			//모든 유효성에 문제가 없다면 데이터를 전송
			$('#user-drop-box').unbind('submit').submit();
		});
	 });
 </script>
</body>
</html>