<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/order_list.css"/>">
    <script src="<c:url value ="/resources/js/sub.js"/>"></script>
</head>
<body>
	<main class="main-banner09">
		<div class="main_text_wrap">
	        <h2>고객주문내역</h2>
	        <div class="indicator">
	            <ul>
	                <li>
	                	<a href="<c:url value ="/index"/>">
	                		<img src="<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘">
	                	</a>
	                </li>
	                <li><a href="<c:url value ="/admin/user_list"/> ">관리자</a></li>
	                <li><a href="<c:url value ="/admin/order_list"/>">상품삭제</a></li>
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
                    <li><a href="<c:url value ="/admin/insert"/>" >상품등록</a></li>
                    <li><a href="<c:url value ="/admin/update_list"/>">상품수정</a></li>
                    <li><a href="<c:url value ="/admin/delete"/>" >상품삭제</a></li>
                    <li><a href="<c:url value ="/admin/order_list"/>" class="active">고객주문내역</a></li>
                </ul>
            </div>
       </div>
        <div class="right_contents">
           <h2>고객주문내역</h2>
        	 <div class="sub_contents">
                <div class="product_title">
                    <p>
                    	<!-- 한 주문에 여러 상품이 있을 수 있어서 주문내역으로 변경하겠습니다. -->
                        <span class="orderlist">주문 내역</span>
                        <span class="orderlist-amount">총 ${ordercount}개의 상품이 있습니다.</span>
                    </p>
             	</div>
                <table>
               		<thead>
                        <tr>
                            <th>주문번호</th>
                            <th>주문날짜</th>
                            <th>주문상품</th>
                            <th>주문개수</th>
                            <th>주문고객</th>
                            <th>총주문금액</th>
                            <th>주문상태</th>
                        </tr>
                	</thead>
                	<tbody>
	                	 <!-- 주문리스트가 있는 경우 -->
	                 	 <c:if test="${orderlist.size() != 0}">
	                 	 	 <c:forEach items="${orderlist}" var="order">
							    <c:choose>
							        <c:when test="${order.orderlistlist.size() == 1}">
							            <tr>
							                <td>${order.or_num}</td>
							                <td><fmt:formatDate value="${order.or_date}" pattern="yyyy-MM-dd"/></td>
							                <td>
							                    <img src="<c:url value="/download${order.orderlistlist[0].sp_name}"/>" alt="제품이미지">
							                    <span class="name-text">${order.orderlistlist[0].pr_name}</span>
							                </td>
							                <td>${order.orderlistlist[0].ol_amount}</td>
							                <td>${order.or_me_name}</td>
							                <td class="price">${order.or_total_price}</td>
							                <td>
							                	<!-- 선택상자 추가 -->
							                	<select name="select" data-or-num="${order.or_num}">
							                		<c:forEach items="${orderstatelist}" var="os">
							                			<option value="${os.os_state}" <c:if test="${os.os_state == order.or_os_state}">selected</c:if>>${os.os_state}</option>
							                		</c:forEach>
							                	</select>
							                </td>
							            </tr>
							        </c:when>
							        <c:otherwise>
							            <tr>
							                <td rowspan="${order.orderlistlist.size()}">${order.or_num}</td>
							                <td rowspan="${order.orderlistlist.size()}"><fmt:formatDate value="${order.or_date}" pattern="yyyy-MM-dd"/></td>
							                <td>
							                    <img src="<c:url value="/download${order.orderlistlist[0].sp_name}"/>" alt="제품이미지">
							                    <span class="name-text">${order.orderlistlist[0].pr_name}</span>
							                </td>
							                <td>${order.orderlistlist[0].ol_amount}</td>
							                <td rowspan="${order.orderlistlist.size()}">${order.or_me_name}</td>
							                <td rowspan="${order.orderlistlist.size()}" class="price">${order.or_total_price}</td>
							                <td rowspan="${order.orderlistlist.size()}">
							                	<!-- 선택상자 추가 -->
							                	<select name="select" data-or-num="${order.or_num}">
							                		<c:forEach items="${orderstatelist}" var="os">
							                			<option value="${os.os_state}" <c:if test="${os.os_state == order.or_os_state}">selected</c:if>>${os.os_state}</option>
							                		</c:forEach>
							                	</select>
							                </td>
							            </tr>
							            <c:forEach items="${order.orderlistlist}" var="ol" varStatus="vs">
							                <c:if test="${vs.index > 0}">
							                    <tr class="merge">
							                        <td>
							                            <img src="<c:url value="/download${ol.sp_name}"/>" alt="제품이미지">
							                            <span class="name-text">${ol.pr_name}</span>
							                        </td>
							                        <td>${ol.ol_amount}</td>
							                    </tr>
							                </c:if>
							            </c:forEach>
							        </c:otherwise>
							    </c:choose>
							</c:forEach>
	                 	 </c:if>
	                 	 <!-- 주문리스트가 없는 경우 -->
	                 	 <c:if test="${orderlist.size() == 0}">
	                 	 	<tr>
	                 	 		<td colspan="7">고객주문내역이 없습니다.</td>
	                 	 	</tr>
	                 	 </c:if>
	                </tbody>		
	            </table>
	            <ul class="pagination">
					<c:if test="${pm.prev}">
						<!--백엔드에서 주소를 통해서 active를 변경시킴-->
						<!-- 이전버튼 -->
						<li>
							<c:url var="url" value="/admin/order_list">
								<c:param name="page" value="${pm.startPage - 1}"/>
								<c:param name="search" value="${pm.cri.search}"/>
								<c:param name="type" value="${pm.cri.type}"/>
							</c:url>
							<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_prev.svg"/>" alt="이전으로"></a>
						</li>
					</c:if>
					<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
					<c:set var="active" value="${pm.cri.page == i ?'active':'' }"/>
						<li>
							<c:url var="url" value="/admin/order_list">
								<c:param name="page" value="${i}"/>
								<c:param name="search" value="${pm.cri.search}"/>
								<c:param name="type" value="${pm.cri.type}"/>
							</c:url>
							<a href="${url}" class="${active}">${i}</a>
						</li>
					</c:forEach>
					<!-- 다음버튼 -->
					<c:if test="${pm.next}">
						<li class="page-item">
							<c:url var="url" value="/admin/order_list">
								<c:param name="page" value="${pm.endPage + 1}"/>
								<c:param name="search" value="${pm.cri.search}"/>
								<c:param name="type" value="${pm.cri.type}"/>
							</c:url>
							<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_next.svg"/>" alt="다음으로"></a>
						</li>
					</c:if>
				</ul>
		        <!-- 검색처리 -->
		        <!-- placeholder 길어서 CSS에서 크기 변경-->
				<form action="<c:url value="/admin/order_list"/>" method="get">
					<label for="search-announce" class="away">검색입력창</label>
					<input type="text" id="search-announce" placeholder="제품명 / 주문날짜 / 고객명 입력하세요." name="search" value="${pm.cri.search}">
					<!-- 검색처리할 input:hidden -->
					<input type="hidden" name="type" value="${pm.cri.type}">
				</form>
				<!-- 주문상태 변경 추가 : CSS도 추가되었음 -->
				<button class="state-update-btn btn-hover">주문상태 변경</button>
         </div>
     </div>
   </div>
   
   <!-- 주문 상태 변경 처리 -->
   <script type="text/javascript">
		$(".state-update-btn").click(function(){
			let os_state = [];
			let or_num = [];
			//현재 선택상자에 선택된 요소의 값을 가져와서 배열에 추가
			$('select[name="select"]').each(function(){
				let os = $(this).val();
				os_state.push(os);
				
				let on = $(this).data('or-num');
				or_num.push(on);
			})
			$.ajax({
				async : true, //비동기 : true(비동기), false(동기)
				url : '<c:url value="/admin/order/state/update"/>', 
				type : 'post' ,
				data : { os_state : os_state, or_num : or_num}, 
				success : function (data){
					if(data){
						alert('주문상태를 변경했습니다.')
					}else{
						alert("주문상태를 변경하지 못했습니다.")
					}
					location.reload()
				}, 
				error : function(jqXHR, textStatus, errorThrown){
	
				}
			});
		});
	</script>
</body>
</html>