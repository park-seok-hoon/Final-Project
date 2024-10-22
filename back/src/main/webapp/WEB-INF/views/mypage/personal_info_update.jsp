<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/personal_info_update.css"/> ">
    <script src="<c:url value ="/resources/js/personal_info_update.js"/>"></script>
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
                <form action="<c:url value="/mypage/personal_info_update"/>" method="post">
                    <p>필수 항목입니다.</p>
                    <div class="form-row">
                        <label for="signup-name" class="label-title">이름</label>
                        <input type="text" id="signup-name" name="me_name" value="${user.me_name}" <c:if test="${user.me_name != null}">readonly</c:if> required>
                    </div>
                    <div class="form-row">
                        <div class="label-title">성별</div>
                        <div class="gender-wrap">
                            <!--라디오는 name이 같아야 한세트로 인식해서 둘중 하나만 체크-->
                            <input type="radio" id="signup-male" name="me_gender" value="남자" <c:if test="${user.me_gender == '남자' || user.me_gender == null}">checked</c:if>>
							<label for="signup-male">남자</label>
							<input type="radio" id="signup-female" name="me_gender" value="여자" <c:if test="${user.me_gender == '여자'}">checked</c:if>>
				        	<label for="signup-female">여자</label>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="label-title">생년월일</div>
                        <div class="birth-wrap">
                            <div class="left_wrap">
                                <select id="signup-year" name="year" data-info="${user.useryear}" value="${user.useryear}" required>
                                    <!--옵션태그는 동적(JS)으로 만들 예정-->
                                </select>
                                <label for="signup-year">년</label>
                                <select id="signup-month" name="month" data-info="${user.usermonth}" value="${user.usermonth}" required></select>
                                <label for="signup-month">월</label>
                                <select id="signup-date" name="day" data-info="${user.userday}" value="${user.userday}" required></select>
                                <label for="signup-date">일</label>
                            </div>
                            <div class="right_wrap">
                                <input type="radio" name="me_calendar" id="solar" value="양력" <c:if test="${user.me_calendar == '양력' || user.me_calendar == null}">checked</c:if>>
                                <label for="solar">양력</label>
                                <input type="radio" name="me_calendar" id="lunar" value="음력" <c:if test="${user.me_calendar == '음력'}">checked</c:if>>
                                <label for="lunar">음력</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <label for="signup-id" class="label-title">아이디</label>
                        <div class="id-wrap">
                        	<!-- 변경에 따라 CSS도 변경 -->
                            <input type="text" id="signup-id" name="me_id" value="${user.me_id}" required readonly>
                            <span class="text">아이디는 변경 불가능합니다.</span>
                        </div>
                    </div>
                    <div class="form-row">
                        <label for="signup-pw" class="label-title">비밀번호</label>
                        <input type="password" id="signup-pw" name="me_pw" placeholder="영문, 숫자, 특수문자(.!@$%^*+=) 조합 8~16자리" required>
                    </div>
                    <div class="form-row">
                        <label for="signup-pw2" class="label-title">비밀번호 확인</label>
                        <input type="password" id="signup-pw2" placeholder="비밀번호를 한번 더 입력해주세요." required>
                    </div>
                    <div class="form-row">
                        <label for="signup-phone" class="label-title">휴대폰 번호</label>
                        <input type="text" id="signup-phone" name="me_phone" value="${user.me_phone}">
                    </div>
                    <div class="form-row">
                        <label for="signup-email01" class="label-title">이메일</label>
                        <div class="email-wrap">
                            <input type="text" id="signup-email01" name="first_email" value="${user.first_email != null ? user.first_email : ''}" required>
                            <span class="at">@</span>
                            <input type="text" id="signup-email02" name="second_email" value="${user.second_email != null ? user.second_email : ''}" required>
                            <label for="signup-email02" class="away">이메일사이트주소입력</label>
                            <select id="url-select">
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
                            <input type="text" id="sample2_postcode" name ="me_postcode" value="${user.me_postcode}" required>
                            <label for="sample2_postcode" class="away">우편번호입력상자</label>
                            <button type="button" onclick="sample2_execDaumPostcode()" id="post-btn">우편번호 변경</button>
                            <input type="text" id="sample2_address" value="${user.me_address}" name="me_address" required>
                            <label for="sample2_address" class="away">주소입력상자</label>
                            <input type="text" id="sample2_detailAddress" name ="me_detail_address" value="${user.me_detail_address}" required>
                            <label for="sample2_detailAddress" class="away">상세주소입력상자</label>
                            <input type="hidden" id="sample2_extraAddress" value="${user.me_detail_address}">
                        </div>
                    </div>
                    <!--버튼클릭하면 화면에 뜨는 팝업창태그 쓰기-->
                    <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
                        <img src="http://t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
                    </div>
                    <script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                    <script src="<c:url value ="/resources/js/post.js"/>"></script>
                    <button type="submit" id="personal_btn" class="btn-hover">개인정보수정</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>