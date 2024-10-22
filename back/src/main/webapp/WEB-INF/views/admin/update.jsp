<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/product_insert.css"/>">
	<script src="<c:url value ="/resources/js/product_update.js"/>"></script>
</head>
<body>
  <main class="main-banner09">
       <div class="main_text_wrap">
	       <h2>상품수정</h2>
	       <div class="indicator">
	           <ul>
	             <li><a href="<c:url value ="/resources/index"/>"><img src="<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
	             <li><a href="<c:url value ="/admin/user_list"/> ">관리자</a></li>
	             <li><a href="<c:url value ="/admin/update_list"/>">상품수정</a></li>
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
                     <li><a href="<c:url value ="/admin/insert"/>">상품등록</a></li>
                    <li><a href="<c:url value ="/admin/update_list"/>" class="active">상품수정</a></li>
                    <li><a href="<c:url value ="/admin/delete"/>">상품삭제</a></li>
                    <li><a href="<c:url value ="/admin/order_list"/> ">고객주문내역</a></li>
                </ul>
            </div>
        </div>
        <div class="right_contents">
            <h2>상품수정</h2>
            <div class="sub_contents">
                <form action="<c:url value="/admin/update"/>" method="post" enctype="multipart/form-data">	<!-- enctype이 추가가 안되어 있으면 파일이 null값으로 뜸 -->
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
                                <input type="checkbox" id="state-chk" name="pr_ps_state" <c:if test="${product.pr_ps_state == '품절'}">checked</c:if>>
                                <label for="state-chk">품절</label>
                            </div>
                        </div>
                        <div class="form-row">
                            <label for="product-code" class="title">상품코드</label>
                            <input type="text" id="product-code" maxlength="20" value="${product.pr_code}" readonly name="pr_code" required>
                            <p class="error-text">상품코드는 수정할 수 없습니다.</p>
                        </div>
                        <div class="form-row form-row4">
                            <div class="input-box">
                                <label for="product-name" class="title">상품명</label>
                                <input type="text" id="product-name" maxlength="30" value="${product.pr_name}" name="pr_name" required>
                            </div>
                            <div class="input-box">
                                <label for="product-price" class="title2">가격</label>
                                <input type="text" id="product-price" maxlength="20" value="${product.pr_price}" class="right" name="pr_price" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="title">분류</div>
                            <select id="category-box">
                                <option value="#">카테고리분류</option>
                                <c:forEach items="${grouplist}" var="group">
                               		<option value="${group.gr_num}" <c:if test="${group.gr_name == gr_name}">selected</c:if>>${group.gr_name}</option>
                                </c:forEach>
                            </select>
                            <label for="category-box" class="away">카테고리분류 선택</label>
                            <select id="product-box" name="pr_ca_num"><!-- 이거 빠져있던데 처리해야 합니다. -->
                                <!--백단에서 가져와야 함-->
                                
                            </select>
                            <label for="product-box" class="away">제품분류 선택</label>
                        </div>
                        <div class="form-row form-bottom">
                            <label for="product-content" class="title" name="pr_explain">제품설명</label>
                            <textarea id="product-content" rows="5" maxlength="400" name="pr_explain" required>${product.pr_explain}</textarea>
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
                            <input type="text" id="product-detail-file" value="${product.pr_pic_ori_name}" name="file_detail_value" readonly required>
                            <label for="product-detail-file" class="away">첨부파일 주소입력</label>
                            <input type="file" id="product-detail"  name="file_detail">
                            <label for="product-detail">첨부파일</label>
                        </div>
                        <!-- 마지막 테두리 없어지는 것 삼항연산자 통해서 클래스 처리 -->
                        <c:forEach items="${product.slidelist}" var="pictures" varStatus="vs">
						    <div class="form-row ${vs.last ? 'form-bottom' : 'form-none'}">
						        <div class="title">
						            <c:if test="${vs.index == 0 }">슬라이드(3장)</c:if>
						        </div>
						        <input type="text" id="product-slide${vs.index + 1}-file" value="${pictures.sp_ori_name}" name="slide_pictures_value" readonly required>
						        <label for="product-slide${vs.index + 1}-file" class="away">첨부파일 주소입력</label>
						        <input type="file" id="product-slide${vs.index + 1}" name="slide_pictures">
						        <label for="product-slide${vs.index + 1}">첨부파일</label>
						    </div>
						</c:forEach>
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
                            <input type="text" id="notification01" class="notification" maxlength="50" value="${product.pr_kc}" name="pr_kc" required>
                        </div>
                        <div class="form-row">
                            <label for="notification02" class="title">소비전력</label>
                            <input type="text" id="notification02" class="notification" maxlength="50" value="${product.pr_elec}" name="pr_elec" required>
                        </div>
                        <div class="form-row">
                            <label for="notification03" class="title">에너지소비효율등급</label>
                            <input type="text" id="notification03" class="notification" maxlength="50" value="${product.pr_energy}" name="pr_energy" required>
                        </div>
                        <div class="form-row">
                            <label for="notification04" class="title">출시년월</label>
                            <input type="text" id="notification04" class="notification" maxlength="50" value="${product.pr_date}" name="pr_date" required>
                        </div>
                        <div class="form-row">
                            <label for="notification05" class="title">수입자 표기</label>
                            <input type="text" id="notification05" class="notification" maxlength="100" value="${product.pr_maker}" name="pr_maker" required>
                        </div>
                        <div class="form-row">
                            <label for="notification06" class="title">제조국</label>
                            <input type="text" id="notification06" class="notification" maxlength="100" value="${product.pr_nation}" name="pr_nation" required>
                        </div>
                        <div class="form-row">
                            <label for="notification07" class="title">크기, 용량, 형태</label>
                            <input type="text" id="notification07" class="notification" maxlength="100" value="${product.pr_size}" name="pr_size" required>
                        </div>
                        <div class="form-row">
                            <label for="notification08" class="title">품질보증기준</label>
                            <input type="text" id="notification08" class="notification" maxlength="10" value="${product.pr_guarantee}" name="pr_guarantee" required>
                        </div>
                        <div class="form-row">
                            <label for="notification09" class="title">A/S책임자전화번호</label>
                            <input type="text" id="notification09" class="notification" maxlength="50" value="${product.pr_AS}" name="pr_AS" required>
                        </div>
                        <div class="form-row form-bottom">
                            <label for="notification10" class="title">추가설치비용</label>
                            <input type="text" id="notification10" class="notification" maxlength="50" value="${product.pr_extraprice}" name="pr_extraprice" required>
                        </div>
                    </fieldset>
                    <button type="submit" id="product-update-btn" class="btn-hover">상품수정</button>
                </form>
            </div>
        </div>
    </div>
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
							if(tmp.ca_name == '${ca_name}'){
								str += `<option value="\${tmp.ca_num}" selected>\${tmp.ca_name}</option>`;
							}else{
								str += `<option value="\${tmp.ca_num}">\${tmp.ca_name}</option>`;
							}
						}
						$("#product-box").html(str);			
					}, 
					error : function(jqXHR, textStatus, errorThrown){
							
					}
				});
			}
		});
		
		//초기 실행에도 실행이 되도록 change이벤트 강제발생
		$("#category-box").trigger('change');
	</script>
</body>
</html>