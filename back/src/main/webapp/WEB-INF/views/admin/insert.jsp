<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/product_insert.css"/>">
    <!-- 상품코드 중복방지 비동기 처리 : C태그처리해야해서 여기에 작성, js문서에 c태그 쓰면 에러 -->
    <script type="text/javascript">
	    function codeCheckDup(){
			let code = $('[name=pr_code]').val();
			//입력된 상품코드를 가져옴
			let obj = {
				code : code
			}
			let result = false;
			//서버에 상품코드를 전송해서 사용 가능/불가능 처리
			$.ajax({
				async : false,
				url : '<c:url value="/admin/code/check/dup" />', 
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
	<script src="<c:url value ="/resources/js/product_insert.js"/>"></script>
</head>
<body>
    <main class="main-banner09">
    	<div class="main_text_wrap">
	        <h2>상품등록</h2>
	        <div class="indicator">
	            <ul>
	           	  <li><a href="<c:url value ="/index"/>"><img src="<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
	              <li><a href="<c:url value ="/admin/user_list"/> ">관리자</a></li>
	              <li><a href="<c:url value ="/admin/insert"/>">상품등록</a></li>
	            </ul>
	        </div>
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
        <div class="right_contents">
            <h2>상품등록</h2>
            <div class="sub_contents">
                 <form action="<c:url value="/admin/insert"/>" id="product-form"  method="post" enctype="multipart/form-data">
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
                             <input type="checkbox" id="state-chk" name="pr_ps_state" value="품절">
                             <label for="state-chk">품절</label>
                         </div>
                    </div>
                     <div class="form-row">
                         <label for="product-code" class="title">상품코드</label>
                         <!-- 입력하지 않으면 폼데이터가 넘어가지 않게 모든 입력요소에 required처리 -->
                         <!-- 모든 input에 maxlength처리해서 글자수가 달라서 에러가 발생되는 것을 방지 -->
                         <input type="text" id="product-code" placeholder="최대20글자까지 입력가능합니다." maxlength="20" name="pr_code" required>
                         <p class="error-text">상품코드는 중복될 수 없습니다.</p>
                      </div>
                      <div class="form-row form-row4">
                          <div class="input-box">
                              <label for="product-name" class="title">상품명</label>
                              <input type="text" id="product-name" placeholder="최대20글자까지 입력가능합니다." maxlength="30" name="pr_name" required>
                          </div>
                          <div class="input-box">
                                <label for="product-price" class="title2">가격</label>
                                <input type="text" id="product-price" placeholder="숫자로만 입력하세요." class="right" maxlength="20" name="pr_price" required>
                          </div>
                      </div>
                      <div class="form-row">
                           <div class="title">분류</div>

                           <!--c:foreach로 서버에서 보낸 그룹 리스트를 보고 옵션 태그를 구성해야 함.  -->
							
                           <select id="category-box">
                               <option value="#">카테고리분류</option>
                               <!-- grouplist 반복처리 -->
                               <!-- 박스크기가 글자보다 작아서 CSS변경 -->
                               <c:forEach items="${grouplist}" var="group">
                               		<option value="${group.gr_num}">${group.gr_name}</option>
                               </c:forEach>
                           </select>
                           <label for="category-box" class="away">카테고리분류 선택</label>
                           <select id="product-box" name="pr_ca_num">
                               <!--그룹선택에 따라 다르게 오도록 비동기 처리-->
                               <!-- 처음엔 제품분류가 있게 처리 -->
                               <option value="#">제품분류</option>
                               <option value="#">카테고리먼저선택</option>
                           </select>
                           <label for="product-box" class="away">제품분류 선택</label>
                        </div>
                        <div class="form-row form-bottom">
                            <label for="prod
                            uct-content" class="title">제품설명</label>
                            <!-- 최대 글자수는 400으로 막기 maxlength="400" -->
                            <textarea id="product-content" rows="5" placeholder="제품에 대한 설명을 작성하세요.(300~400글자로 작성해주세요.)" maxlength="400" name="pr_explain" required></textarea>

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
                           <input type="text" id="product-detail-file" readonly required>
                           <label for="product-detail-file" class="away">첨부파일 주소입력</label>
                           <input type="file" id="product-detail" name="file_detail">
                           <label for="product-detail">첨부파일</label>
                       </div>
                       <div class="form-row form-none">
                           <div class="title">슬라이드(3장)</div>
                           <input type="text" id="product-slide01-file" readonly required>
                           <label for="product-slide01-file" class="away">첨부파일 주소입력</label>
                           <input type="file" id="product-slide01" name="slide_pictures">
                           <label for="product-slide01">첨부파일</label>
                       </div>
                       <div class="form-row form-none">
                           <div class="title"></div>
                           <input type="text" id="product-slide02-file" readonly required>
                           <label for="product-slide02-file" class="away">첨부파일 주소입력</label>
                           <input type="file" id="product-slide02" name="slide_pictures">
                           <label for="product-slide02">첨부파일</label>
                       </div>
                       <div class="form-row form-bottom">
                           <div class="title"></div>
                           <input type="text" id="product-slide03-file" readonly required>
                           <label for="product-slide03-file" class="away">첨부파일 주소입력</label>
                           <input type="file" id="product-slide03" name="slide_pictures">
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
                            <input type="text" id="notification01" class="notification" maxlength="50" name="pr_kc" required>
                        </div>
                        <div class="form-row">
                            <label for="notification02" class="title">소비전력</label>
                            <input type="text" id="notification02" class="notification" maxlength="50" name="pr_elec" required>
                        </div>
                        <div class="form-row">
                            <label for="notification03" class="title">에너지소비효율등급</label>
                            <input type="text" id="notification03" class="notification" maxlength="50" name="pr_energy" required>
                        </div>
                        <div class="form-row">
                            <label for="notification04" class="title">출시년월</label>
                            <input type="text" id="notification04" class="notification" maxlength="50" name="pr_date" required>
                        </div>
                        <div class="form-row">
                            <label for="notification05" class="title">수입자 표기</label>
                            <input type="text" id="notification05" class="notification" maxlength="100" name="pr_maker" required>
                        </div>
                        <div class="form-row">
                            <label for="notification06" class="title">제조국</label>
                            <input type="text" id="notification06" class="notification" maxlength="100" name="pr_nation" required>
                        </div>
                        <div class="form-row">
                            <label for="notification07" class="title">크기, 용량, 형태</label>
                            <input type="text" id="notification07" class="notification" maxlength="100" name="pr_size" required>
                        </div>
                        <div class="form-row">
                            <label for="notification08" class="title">품질보증기준</label>
                            <input type="text" id="notification08" class="notification" maxlength="10" name="pr_guarantee" required>
                        </div>
                        <div class="form-row">
                            <label for="notification09" class="title">A/S책임자전화번호</label>
                            <input type="text" id="notification09" class="notification" maxlength="50" name="pr_AS" required>
                        </div>
                        <div class="form-row form-bottom">
                            <label for="notification10" class="title">추가설치비용</label>
                            <input type="text" id="notification10" class="notification" maxlength="50" name="pr_extraprice" required>
                        </div>
                    </fieldset>
                    <button type="submit" id="product-insert-btn" class="btn-hover">상품추가</button>
                </form>
            </div>
        </div>
    </div>
------
<script type="text/javascript">
$("#category-box").change(function(){
	
	let obj = $("#category-box").val();
	
	$.ajax({
		async : true, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/admin/categoryList"/>', 
		method : "get", 
		data : {"obj" : obj}, 
		success : function (data){
			let str='';
			
			for(let tmp of data.category){
					str += `<option value="\${tmp.ca_num}">\${tmp.ca_name}</option>`
			}
			$("#product-box").html(str);			
		}, 
		error : function(jqXHR, textStatus, errorThrown){
				
		}
	});
});
</script>

-------
    <!-- 카테고리 선택상자 관련 비동기 처리 -->
    <script type="text/javascript">
		$("#category-box").change(function(){
			let obj = $("#category-box").val();
			
			//처음 값이 카테고리 분류를 선택한 것이 아니라면
			if(obj != '#'){
				$.ajax({
					async : true, //비동기 : true(비동기), false(동기)
					url : '<c:url value="/admin/categoryList"/>', 
					method : "get", 
					data : {"obj" : obj}, 
					success : function (data){
						let str='';
						
						//처음 제품분류는 한번만 처리라 for문 밖에 처리
						str += `<option value="#">제품분류</option>`;
						
						for(let tmp of data.categorylist){
							str += `<option value="\${tmp.ca_num}">\${tmp.ca_name}</option>`
						}
						$("#product-box").html(str);			
					}, 
					error : function(jqXHR, textStatus, errorThrown){
							
					}
				});
			}
		});
	</script>

</body>
</html>
