<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/shopping_list.css"/>">
    <!-- 게시판 모두 체크 기능 처리 - 체크 후 개수 처리 때문에 따로 처리 -->
    <script src="<c:url value ="/resources/js/shopping_list.js"/>"></script>
</head>
<body>
	<main class="main-banner08">
		<div class="main_text_wrap">
	        <h2>장바구니</h2>
	        <div class="indicator">
	            <ul>
	             <li><a href="/index.html"><img src= "<c:url value ="/resources/images/sub/home.svg"/>"alt="홈 아이콘"></a></li>
	                <li><a href="<c:url value ="/mypage/personal_info"/>">마이페이지</a></li>
	                <li><a href="<c:url value ="/mypage/shopping_list"/>">장바구니</a></li>
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
                    <li><a href="<c:url value ="/mypage/shopping_list"/>" class="active">장바구니</a></li>
                    <li><a href="<c:url value ="/mypage/user_drop"/>">회원탈퇴</a></li>
                </ul>
            </div>
        </div>
        <div class="right_contents">
            <h2>장바구니</h2>
            <div class="sub_contents">
                <div class="sub_title1">
                    <div class="basket-front">
                        장바구니 상품 
                    </div>
                    <div class="basket-back">
                        총 ${basketlist.size()}개의 상품이 있습니다.
                    </div>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th><input type="checkbox" class="all-check chk-type" id="all-check"></th>
                            <th>상품정보</th>
                            <th>수량옵션</th>
                            <th>상품금액</th>
                            <th>배송비</th>
                            <th>선택</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<!-- basketlist리스트가 있는 경우 -->
                    	<c:if test="${basketlist.size() != 0}">
                    		<c:forEach items="${basketlist}" var="basket" varStatus="bs">
							    <c:forEach items="${basket.productlist}" var="product" varStatus="ps">
							        <tr>
							            <td>
							            	<input 
							            		type="checkbox"
							            		class="chk${bs.index + 1}_${ps.index + 1} chk-type" 
							            		name="check" 
							            		value="${basket.ba_num}"
							            		data-pr-code="${product.pr_code}"
							            	>
							            </td>
							            <td class="basket-pic">
							                <img src="<c:url value="/download${product.pr_sp_name}"/>" alt="${product.pr_name} 이미지" />
							                <span class="text">${product.pr_name}</span>
							            </td>
							            <td class="count-box">
							            	<!-- 버튼 추가돼서 CSS변경 -->
							            	<button type="button" class="plus-btn">+</button>
							            	<span class="basket-amount">${basket.ba_amount}</span>
							            	<button type="button" class="minus-btn">-</button>
							            </td>
							            <td class="price">${product.pr_price * basket.ba_amount}</td>
							            <td>
							            	무료
							            	<!-- 원개 가격을 담을 input -->
							            	<input type="hidden" value="${product.pr_price}" class="origin-price" />
							            </td>
							            <td>
							            	<!-- button에서 a태그 바꿔서 CSS변경 -->
							                <a href="#" class="direct-buy btn-hover" data-pr-code="${product.pr_code}" data-ba-num="${basket.ba_num}">바로구매</button>
							                <a href="<c:url value="/mypage/basket/delete/one?ba_num=${basket.ba_num}" />" class="direct-delete">삭제</button>
							            </td>
							        </tr>
							    </c:forEach>
							</c:forEach>
                    	</c:if>
                    	<!-- basketlist리스트가 없는 경우 -->
                    	<c:if test="${basketlist.size() == 0}">
                    		<tr>
	                    		<td colspan="6">장바구니 제품이 없습니다.</td>
	                    	</tr>
                    	</c:if>
                    </tbody>
                </table>
                <button class="delete-select-btn">선택상품 삭제</button>
                <!-- 주문 건수 동적 처리 -->
                <button class="order-count-btn btn-hover"><span class="count-text">0</span>건 주문하기</button>
            </div>
        </div>
    </div>
    
    <!-- 한개 바로구매 스크립트 처리 : 수량이 달라질 수 있어서 다시 처리해야 함 -->
    <script type="text/javascript">
    	$(document).on('click','.direct-buy',function(){
    		//카카오로 로그인한 경우 개인정보 수정페이지로 보냄
	 		if(${user != null} && ${user.me_email == null}){
	 			let q = confirm('카카오로그인한 경우 구매를 할수 없습니다. 개인정보 페이지로 이동하시겠습니까?');
	 			
	 			let url = `<c:url value="/mypage/personal_info" />`;
	 			if(q){
	 				//해당 주소로 넘김
		 			location.href = url;
	 			}
	 			return false;
	 		}
    		let prCode = $(this).data('pr-code');
 			let baAmount = $(this).parents('tr').find('.basket-amount').text();
 			let baNum =  $(this).data('ba-num');
 			let url = `<c:url value="/mypage/basket/order/one?pr_code=\${prCode}&ba_amount=\${baAmount}&ba_num=\${baNum}" />`;
 			

 			//해당 주소로 넘김
 			location.href = url;
    	});
    </script>
    
    <!-- 선택삭제 스크립트 -->
    <script type="text/javascript">
		$(".delete-select-btn").click(function(){
			let arr = [];
			//현재 체크박스에 체크된 요소의 값을 가져와서 배열에 추가
			$('tbody input[name="check"]:checked').each(function(){
				//체크된 체크 박스에서 ba_num 값을 가져와 배열에 추가
				let ba_num = $(this).val();
				arr.push(ba_num);
			})
			//제품리스트가 1개 이상일 때만 처리
			if(arr.length > 0){
				$.ajax({
					async : true, //비동기 : true(비동기), false(동기)
					url : '<c:url value="/mypage/basket/delete/all"/>', 
					type : 'post' ,
					data : { arr : arr }, 
					success : function (data){
						if(data){
							alert('삭제를 완료했습니다.');
						}else{
							alert('삭제를 실패했습니다.');
						}
						location.reload();
					}, 
					error : function(jqXHR, textStatus, errorThrown){
		
					}
				});
			}else{
				alert('삭제할 품목을 선택하지 않았습니다.');
			}
		});
	</script>
	
	<!-- 선택 주문 스크립트 -->
    <script type="text/javascript">
    	//정규표현식 - 원화기호 쉼표 빼는 함수
	    function extractNumberFromString(str) {
	        return parseInt(str.replace(/\D/g, ''), 10);
	    }
    
	    $(".order-count-btn").click(function(){
	    	//카카오로 로그인한 경우 개인정보 수정페이지로 보냄
	 		if(${user != null} && ${user.me_email == null}){
	 			let q = confirm('카카오로그인한 경우 구매를 할수 없습니다. 개인정보 페이지로 이동하시겠습니까?');
	 			
	 			let url = `<c:url value="/mypage/personal_info" />`;
	 			if(q){
	 				//해당 주소로 넘김
		 			location.href = url;
	 			}
	 			return false;
	 		}
	    	
	    	let arr1 = [];
			let arr2 = [];
			let arr3 = [];
			
			//체크된 값에 같은 tr에 있는 금액을 전부 더해줌
			let totalPrice = 0;
			
			//현재 체크박스에 체크된 요소의 값을 가져와서 배열에 추가
			$('tbody input[name="check"]:checked').each(function(){
				//체크된 체크 박스에서 ba_num 값을 가져와 배열에 추가
				let ba_num = $(this).val();
				arr1.push(ba_num);
				
				//체크된 체크 박스에서 pr_code 값을 가져와 배열에 추가
				let pr_code = $(this).data('pr-code');
				arr2.push(pr_code);
				
				let ba_amount = $(this).parents('tr').find('.basket-amount').text();
				arr3.push(ba_amount);
				
				let curretPrice = $(this).parents('tr').find('.price').text();
				
				let price = extractNumberFromString(curretPrice);
				
				totalPrice += Number(price);
			});
			
			if(arr1.length > 0 && arr2.length > 0 && arr3.length > 0){
				$.ajax({
					async : true, //비동기 : true(비동기), false(동기)
					url : '<c:url value="/mypage/basket/order/all" />', 
					type : 'post' ,
					data : { arr1 : arr1, arr2 : arr2, arr3 : arr3, total : totalPrice}, 
					success : function (data){
						if(data){
							alert('주문을 완료했습니다.');
						}else{
							alert('주문을 실패했습니다.');
						}
						location.reload();
					}, 
					error : function(jqXHR, textStatus, errorThrown){
		
					}
				});
			}else{
				alert('주문할 품목을 선택하지 않았습니다.');
			}
	    });
    </script>
</body>
</html>