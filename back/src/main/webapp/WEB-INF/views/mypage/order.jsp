<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/personal_info.css"/> ">
    <link rel="stylesheet" href="<c:url value ="/resources/css/order.css"/>">
	<script src="<c:url value ="/resources/js/sub.js"/>"></script>
</head>
<body>
 <main class="main-banner08">
 	 <div class="main_text_wrap">
		 <h2>나의 주문내역</h2>
		 <div class="indicator">
		     <ul>
		         <li><a href="/index.html"><img src= "<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
		         <li><a href="<c:url value ="/mypage/personal_info"/>">마이페이지</a></li>
		         <li><a href="<c:url value ="/mypage/order"/>">나의 주문내역</a></li>
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
               <li><a href="<c:url value ="/mypage/order"/>"class="active">나의 주문내역</a></li>
               <li><a href="<c:url value ="/mypage/shopping_list"/>">장바구니</a></li>
               <li><a href="<c:url value ="/mypage/user_drop"/>">회원탈퇴</a></li>
             </ul>
         </div>
     </div>
     <div class="right_contents">
         <h2>나의 주문내역</h2>
         <div class="sub_contents">
             <p>
             	 <!-- 여러 상품을 한번에 주문할 수도 있어서 변경했습니다. -->
                 <span class="orderlist">주문내역</span>
                 <span class="orderlist-amount">총 ${ordercount}개의 주문내역이 있습니다.</span>
             </p>
             <table>
                 <thead>
                     <tr>
                         <th>주문번호</th>
                         <th>주문날짜</th>
                         <th>주문상품</th>
                         <th>주문개수</th>
                         <th>총주문금액 </th>
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
						                    ${order.orderlistlist[0].pr_name}
						                </td>
						                <td>${order.orderlistlist[0].orlist_amount}</td>
						                <td class="price">${order.or_total_price}</td>
						                <td>${order.or_os_state}</td>
						            </tr>
						        </c:when>
						        <c:otherwise>
						            <tr>
						                <td rowspan="${order.orderlistlist.size()}">${order.or_num}</td>
						                <td rowspan="${order.orderlistlist.size()}"><fmt:formatDate value="${order.or_date}" pattern="yyyy-MM-dd"/></td>
						                <td>
						                    <img src="<c:url value="/download${order.orderlistlist[0].sp_name}"/>" alt="제품이미지">
						                    ${order.orderlistlist[0].pr_name}
						                </td>
						                <td>${order.orderlistlist[0].orlist_amount}</td>
						                <td rowspan="${order.orderlistlist.size()}" class="price">${order.or_total_price}</td>
						                <td rowspan="${order.orderlistlist.size()}">${order.or_os_state}</td>
						            </tr>
						            <c:forEach items="${order.orderlistlist}" var="ol" varStatus="vs">
						                <c:if test="${vs.index > 0}">
						                    <tr class="merge">
						                        <td>
						                            <img src="<c:url value="/download${ol.sp_name}"/>" alt="제품이미지">
						                            ${ol.pr_name}
						                        </td>
						                        <td>${ol.orlist_amount}</td>
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
                     		<td colspan="6">주문 내역이 없습니다.</td>
                     	</tr>
                     </c:if>
                 </tbody>
             </table>
         </div>
         <ul class="pagination">
			<c:if test="${pm.prev}">
				<!--백엔드에서 주소를 통해서 active를 변경시킴-->
				<!-- 이전버튼 -->
				<li>
					<c:url var="url" value="/mypage/order">
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
					<c:url var="url" value="/mypage/order">
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
					<c:url var="url" value="/mypage/order">
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
		<form action="<c:url value="/mypage/order"/>" method="get">
			<label for="search-announce" class="away">검색입력창</label>
			<input type="text" id="search-announce" placeholder="제품명 혹은 날짜(0000-00-00)를 입력하세요." name="search" value="${pm.cri.search}">
			<!-- 검색처리할 input:hidden -->
			<input type="hidden" name="type" value="${pm.cri.type}">
		</form>
     </div>
 </div>
</body>
</html>