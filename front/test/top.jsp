<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/product_insert.css"/>">
	<script src="<c:url value ="/resources/js/product_insert.js"/>"></script>
</head>
<body>
    <main class="main-banner09">
        <h2>상품등록</h2>
        <div class="indicator">
            <ul>
           	  <li>
                  <a href="<c:url value ="/index"/>">
                      <img src="<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘">
                  </a>
              </li>
              <li><a href="<c:url value ="/admin/user_list"/> ">관리자</a></li>
              <li><a href="<c:url value ="/admin/insert"/>">상품등록</a></li>
            </ul>
        </div>
    </main>
    <div class="myadmin-contents">
        <div class="left_contents">
            <div class="profile">
                <div class="first-name">관리자</div>
                    <div class="profile_text">
                        <p class="user-name">관리자님</p>
                    </div>
            </div>
            <div class="sub-gnb02">
                <ul>
                    <li><a href="<c:url value ="/admin/user_list"/>">회원리스트 보기/강퇴</a></li>
                    <li><a href="<c:url value ="/admin/category"/>">카테고리 관리</a></li>
                    <li><a href="<c:url value ="/admin/insert"/>" class="active">상품등록</a></li>
                    <li><a href="<c:url value ="/admin/update_list"/>">상품수정</a></li>
                    <li><a href="<c:url value ="/admin/delete"/>">상품삭제</a></li>
                    <li><a href="<c:url value ="/admin/order_list"/> ">고객주문내역</a></li>
                </ul>
            </div>
        </div>
        <div class= "right_contents">
            <h2>상품등록</h2>
            <div class="sub_contents">
                <form action="#">
                    <div class="title-wrap">
                        <h3>■ 기본 상품 정보</h3>
                        <p>모든항목은 필수 입력입니다.</p>
                    </div>
                    <fieldset>
                     <!--legend는 fieldset의 자손으로만 써야해서 css날릴 예정-->
                     <legend>기본 상품 정보</legend>
                     <div class="form-row form-top">
                         <div class="title">상태</div>
                         <div class="chk-box">
                             <input type="checkbox" id="state-chk">
                             <label for="state-chk">품절</label>
                         </div>
                    </div>
                     <div class="form-row">
                         <label for="product-code" class="title">상품코드</label>
                         <input type="text" id="product-code" placeholder="최대20글자까지 입력가능합니다.">
                         <p class="error-text">상품코드는 중복될 수 없습니다.</p>
                      </div>
                      <div class="form-row form-row4">
                          <div class="input-box">
                              <label for="product-name" class="title">상품명</label>
                              <input type="text" id="product-name" placeholder="최대20글자까지 입력가능합니다.">
                          </div>
                          <div class="input-box">
                                <label for="product-price" class="title2">가격</label>
                                <input type="text" id="product-price" placeholder="숫자로만 입력하세요." class="right">
                          </div>
                      </div>
                      <div class="form-row">
                           <div class="title">분류</div>
                           <select id="category-box">
                               <option value="#">카테고리분류</option>
                               <option value="SPECIAL">SPECIAL</option>
                               <option value="BIG PRODUCT">BIG PRODUCT</option>
                               <option value="SMALL PRODUCT">SMALL PRODUCT</option>
                           </select>
                            <label for="category-box" class="away">카테고리분류 선택</label>
                            <select id="product-box">
                                <!--백단에서 가져와야 함-->
                                <option value="#">제품분류</option>
                                <option value="SPECIAL">전기포트</option>
                                <option value="BIG PRODUCT">토스트기</option>
                                <option value="SMALL PRODUCT">믹서기</option>
                            </select>
                            <label for="product-box" class="away">제품분류 선택</label>
                        </div>
                        <div class="form-row form-bottom">
                            <label for="product-content" class="title">제품설명</label>
                            <textarea id="product-content" rows="5" placeholder="제품에 대한 설명을 작성하세요.(300~400글자로 작성해주세요.)"></textarea>
                        </div>
                    </fieldset>
                    <div class="title-wrap">
                        <h3>■ 상품이미지 정보</h3>
                        <p>모든항목은 필수 입력입니다.</p>
                    </div>
                    <fieldset>
                       <!--legend는 fieldset의 자손으로만 써야해서 css날릴 예정-->
                       <legend>상품이미지 정보</legend>
                       <div class="form-row form-top">
                           <div class="title">상세 이미지(1장)</div>
                           <input type="text" id="product-detail-file" readonly>
                           <label for="product-detail-file" class="away">첨부파일 주소입력</label>
                           <input type="file" id="product-detail">
                           <label for="product-detail">첨부파일</label>
                       </div>
                       <div class="form-row form-none">
                           <div class="title">슬라이드(3장)</div>
                           <input type="text" id="product-slide01-file" readonly>
                           <label for="product-slide01-file" class="away">첨부파일 주소입력</label>
                           <input type="file" id="product-slide01">
                           <label for="product-slide01">첨부파일</label>
                       </div>
                       <div class="form-row form-none">
                           <div class="title"></div>
                           <input type="text" id="product-slide02-file" readonly>
                           <label for="product-slide02-file" class="away">첨부파일 주소입력</label>
                           <input type="file" id="product-slide02">
                           <label for="product-slide02">첨부파일</label>
                       </div>
                        <div class="form-row form-bottom">
                            <div class="title"></div>
                            <input type="text" id="product-slide03-file" readonly>
                            <label for="product-slide03-file" class="away">첨부파일 주소입력</label>
                            <input type="file" id="product-slide03">
                            <label for="product-slide03">첨부파일</label>
                        </div>
                    </fieldset>
                    <div class="title-wrap">
                        <h3>■ 상품고시내용</h3>
                        <p>모든항목은 필수 입력입니다.</p>
                    </div>
                    <fieldset>
                        <!--legend는 fieldset의 자손으로만 써야해서 css날릴 예정-->
                        <legend>상품고시내용</legend>
                        <div class="form-row form-top">
                            <label for="notification01" class="title">KC인증필 유무</label>
                            <input type="text" id="notification01" class="notification">
                        </div>
                        <div class="form-row">
                            <label for="notification02" class="title">소비전력</label>
                            <input type="text" id="notification02" class="notification">
                        </div>
                        <div class="form-row">
                            <label for="notification03" class="title">에너지소비효율등급</label>
                            <input type="text" id="notification03" class="notification">
                        </div>
                        <div class="form-row">
                            <label for="notification04" class="title">출시년월</label>
                            <input type="text" id="notification04" class="notification">
                        </div>
                        <div class="form-row">
                            <label for="notification05" class="title">수입자 표기</label>
                            <input type="text" id="notification05" class="notification">
                        </div>
                        <div class="form-row">
                            <label for="notification06" class="title">제조국</label>
                            <input type="text" id="notification06" class="notification">
                        </div>
                        <div class="form-row">
                            <label for="notification07" class="title">크기, 용량, 형태</label>
                            <input type="text" id="notification07" class="notification">
                        </div>
                        <div class="form-row">
                            <label for="notification08" class="title">품질보증기준</label>
                            <input type="text" id="notification08" class="notification">
                        </div>
                        <div class="form-row">
                            <label for="notification09" class="title">A/S책임자전화번호</label>
                            <input type="text" id="notification09" class="notification">
                        </div>
                        <div class="form-row form-bottom">
                            <label for="notification10" class="title">추가설치비용</label>
                            <input type="text" id="notification10" class="notification">
                        </div>
                    </fieldset>
                    <button type="submit" id="product-insert-btn" class="btn-hover">상품추가</button>
                </form>
            </div>
        </div>
    </div>   
</body>
</html>