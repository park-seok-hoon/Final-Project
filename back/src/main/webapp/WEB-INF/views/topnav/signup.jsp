<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/topnav.css"/>">
	<!-- 아이디 찾기 비동기 함수 : C태그때문에 밖으로 뺌, js문서에 쓰면 에러남-->
    <script type="text/javascript">
	    function idCheckDup(){
			let id = $('[name=me_id]').val();
			//입력된 아이디를 가져옴
			let obj = {
				id : id
			}
			let result = false;
			//서버에 아이디를 전송해서 사용 가능/불가능 처리
			$.ajax({
				async : false,
				url : '<c:url value="/topnav/id/check/dup" />', 
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
    </script>
	<!-- 유효성검사도 signup.js에서 할것 -->
	<script src="<c:url value="/resources/js/signup.js"/>"></script>
</head>
<body>
    <main class="main-banner07">
    	<div class="main_text_wrap">
	        <h2>회원가입</h2>
	        <div class="indicator">
	            <ul>
	                <li><a href="<c:url value="/"/>"><img src="<c:url value="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
	                <li><a href="<c:url value="/topnav/signup.jsp"/>">회원가입</a></li>
	            </ul>
	        </div>
        </div>
    </main>
    <div class="title-box">
        <h2>회원가입</h2>
        <p>
            스메그의 제품을 구입하려면 회원가입이 필요합니다.<br>
            스메그 서비스를 회원가입을 통해 누려 보세요.
        </p>
    </div>
    <div class="main-contents">
        <form action="<c:url value="/topnav/signup"/>" method="post" id="signupform">
            <!--fieldset : 폼구역을 나누는 태그-->
            <fieldset class="signup-top">
                <!--legend : 폼구역 이름을 작성하는 태그-->
                <legend>개인정보 입력</legend>
                <p>필수 항목입니다.</p>
                <div class="form-row">
                    <label for="signup-name" class="label-title">이름</label>
                    <!-- required 속성만 써도 입력값 없으면 폼데이터 전송안됨 -->
                    <input type="text" id="signup-name" placeholder="이름을 입력해주세요." name="me_name" maxlength="10" required>
                </div>
                <label class="error" id="signup-name-error" for="signup-name"></label>
                <div class="form-row">
                    <div class="label-title">성별</div>
                    <div class="gender-wrap">
                        <!--라디오는 name이 같아야 한세트로 인식해서 둘중 하나만 체크-->
                        <input type="radio" id="signup-male" name="me_gender" value="남자">
                        <label for="signup-male">남자</label>
                        <input type="radio" id="signup-female" name="me_gender" value="여자" checked>
                        <label for="signup-female">여자</label>
                    </div>
                </div>
                <div class="form-row">
                    <div class="label-title">생년월일</div>
                    <div class="birth-wrap">
                        <div class="left_wrap">
                                <!--옵션태그는 동적(JS)으로 만들 예정-->
                            <select id="signup-year" name="year"></select>
                            <label for="signup-year">년</label>
                            <select id="signup-month" name="month"></select>
                            <label for="signup-month">월</label>
                            <select id="signup-date" name="day"></select>
                            <label for="signup-date">일</label>
                        </div>
                        <div class="right_wrap">
                            <input type="radio" name="me_calendar" id="solar" value="양력" checked>
                            <label for="solar">양력</label>
                            <input type="radio" name="me_calendar" id="lunar" value="음력">
                            <label for="lunar">음력</label>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <label for="signup-id" class="label-title">아이디</label>
                    <div class="id-wrap">
                        <input type="text" id="signup-id" placeholder="6~15 사이의 영문 혹은 영문과 숫자 조합" name="me_id" required>
                        <!--폼 데이터전송은 맨 밑의 회원가입만 하는 것, 그래서 버튼타입으로 처리-->
                        <button type="button" id="idchk-btn">중복확인</button>
                    </div>
                </div>
                <div class="error-text error-text01">아이디는 6~15 사이의 영문 혹은 영문과 숫자 조합입니다.</div>
                <div class="form-row">
                    <label for="signup-pw" class="label-title">비밀번호</label>
                    <input type="password" id="signup-pw" placeholder="영문, 숫자, 특수문자(.!@$%^*+=) 조합 8~16자리" name="me_pw" required>
                </div>
                <div class="error-text error-text02">비밀번호는 영문, 숫자, 특수문자(.!@$%^*+=)조합이고, 8~16사이입니다.</div>
                <div class="form-row">
                    <label for="signup-pw2" class="label-title" >비밀번호 확인</label>
                    <input type="password" id="signup-pw2" placeholder="비밀번호를 한번 더 입력해주세요." name="me_pw2" required>
                </div>
                <div class="error-text error-text03">비밀번호와 같게 입력하세요.</div>
                <div class="form-row">
                    <label for="signup-phone" class="label-title">휴대폰 번호</label>
                    <input type="text" id="signup-phone" placeholder="- 줄 포함해서 작성 ex) 010-0000-0000" name="me_phone" required>
                </div>
                <div class="error-text error-text04">휴대폰번호는 - 줄 포함해서 작성하세요. ex) 010-0000-0000</div>
                <div class="form-row">
                    <label for="signup-email01" class="label-title">이메일</label>
                    <div class="email-wrap">
                        <input type="text" id="signup-email01" name="first_email" required>
                        <span class="at">@</span>
                        <input type="text" id="signup-email02" required>
                        <label for="signup-email02" class="away">이메일사이트주소입력</label>
                        <select id="url-select" name="second_email">
                            <option value="#">직접입력</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="naver.com">naver.com</option>
                            <option value="hanmail.net">hanmail.net</option>
                        </select>
                        <label for="url-select" class="away">주소선택상자</label>
                    </div>
                </div>
                <div class="form-row address-form">
                    <div class="label-title">주소</div>
                    <div class="address-wrap">
                        <!--모든 input, select, textarea태그는 label태그와 연결되어야 함-->
                        <input type="text" id="sample2_postcode" readonly name="me_postcode" required>
                        <label for="sample2_postcode" class="away">우편번호입력상자</label>
                        <button type="button" onclick="sample2_execDaumPostcode()" id="post-btn">우편번호 입력</button>
                        <input type="text" id="sample2_address" readonly name="me_address" required>
                        <label for="sample2_address" class="away">주소입력상자</label>
                        <input type="text" id="sample2_detailAddress" placeholder="상세주소를 입력하세요." name="me_detail_address">
                        <label for="sample2_detailAddress" class="away">상세주소입력상자</label>
                        
                        <input type="hidden" id="sample2_extraAddress" required>
                    </div>
                </div>
                <!--버튼클릭하면 화면에 뜨는 팝업창태그 쓰기-->
                <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
                    <img src="http://t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
                </div>
                <script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                <script src="<c:url value="/resources/js/post.js"/>"></script>
            </fieldset>
            <fieldset class="signup-bottom">
                <legend>약관동의</legend>
                <div class="chk-row">
                    <input type="checkbox" id="clause-all-chk">
                    <label for="clause-all-chk">약관전체 동의</label>
                </div>
                <div class="chk-row">
                    <input type="checkbox" id="clause-chk01">
                    <label for="clause-chk01">이용약관 동의(필수)</label>
                    <a href="#">자세히 보기</a>
                </div>
                <div class="iframe-box">
                    <!--외부 페이지를 현재 페이지로 가져오는 태그-->
                    <!--frameborder="0"은 웹표준에러라 css에서 할것-->
                    <iframe src="<c:url value="/resources/topnav/clause01.html"/>" width="796" height="396"></iframe>
                </div>
                <div class="chk-row">
                    <input type="checkbox" id="clause-chk02">
                    <label for="clause-chk02">개인정보 수집 및 이용동의(필수)</label>
                    <a href="#">자세히 보기</a>
                </div>
                <div class="iframe-box">
                    <iframe src="<c:url value="/resources/topnav/clause02.html"/>" width="796" height="396"></iframe>
                </div>
                <div class="chk-row">
                    <input type="checkbox" id="clause-chk03">
                    <label for="clause-chk03">만 14세 미만 가입 제한(필수)</label>
                    <span class="text">만 14세 미만 미성년자는 회원가입을 할 수 없습니다.</span>
                </div>
                <!--회원가입 버튼은 서버에 데이터 전송해야 하므로 submit처리-->
                <button type="submit" id="signup-btn" class="btn-hover">회원가입</button>
            </fieldset>
        </form>
    </div>
</body>
</html>