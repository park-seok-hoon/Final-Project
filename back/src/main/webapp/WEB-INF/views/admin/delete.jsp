<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/product_delete.css"/>">
	<script src="<c:url value ="/resources/js/sub.js"/>"></script>
</head>
<body>
	<main class="main-banner09">
		<div class="main_text_wrap">
			<h2>상품삭제</h2>
			<div class="indicator">
				<ul>
					<li><a href="<c:url value ="/index"/>"><img src="<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
					<li><a href="<c:url value ="/admin/user_list"/> ">관리자</a></li>
					<li><a href="<c:url value ="/admin/delete"/>">상품삭제</a></li>
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
                <li><a href="<c:url value ="/admin/delete"/>" class="active">상품삭제</a></li>
                <li><a href="<c:url value ="/admin/order_list"/>">고객주문내역</a></li>
            </ul>
        </div>
     </div>
     <div class="right_contents">
          <h2>상품삭제</h2>
          <div class="sub_contents">
              <div class="product_title">
                  <p>
                      <span>스메그 상품</span>
                      <span>총 ${totalCount}개의 상품이 있습니다.</span>
                  </p>
                  <!-- 폼태그를 추가해서 비동기가 아닌 동기적으로 그룹 선택할때마다 페이지가 변경되게 처리했습니다. -->
                  <form action="<c:url value="/admin/delete"/>" method="get" id="group-form">
	                  <select id="product" name="group">
	                      <option value="#">제품분류</option>
	                      <c:forEach items="${grouplist}" var="group">
		                      	<!-- 검색한 적이 있다면 옵션태그 선택되도록 처리 -->
		                      	<option value="${group.gr_num}" <c:if test="${pm.cri.group == group.gr_num}">selected</c:if>>${group.gr_name}</option>
	                      </c:forEach>
	                  </select>
	                  <label for="product" class="away">제품분류 선택상자</label>
	                  <input type="hidden" value="group" name="type">
	                  <input type="hidden" value="${pm.cri.search}" name="search">
                  </form>
                </div>
                <table>
	                <thead>
	                    <tr>
	                        <th><input type="checkbox" id="all-check"></th>
	                        <th>제품분류</th>
	                        <th>카테고리</th>
	                        <th>제품코드</th>
	                        <th>제품이름</th>
	                        <th>가격</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<!-- productlist가 있는 경우 -->
						<c:if test="${productlist.size() > 0 }">
							<c:forEach items="${productlist}" var="product" varStatus="vs">
								<tr>
									<td><input type="checkbox" id="chk${vs.index + 1}" name="check" value="${product.pr_code}"></td>
			                        <td>${product.pr_ca_name}</td>
			                        <td>${product.pr_gr_name}</td>
			                        <td>${product.pr_code}</td>
			                        <td>${product.pr_name}</td>
			                        <td class="price">${product.pr_price}</td>
			                    </tr>
		                    </c:forEach>
						</c:if>
	                    <!-- productlist가 없는 경우 -->
	                    <c:if test="${productlist.size() == 0 }">
	                    	<tr>
								<td colspan="6">등록된 상품이 없습니다.</td>
							</tr>
	                    </c:if>
	                </tbody>		
	            </table>
                <ul class="pagination">
					<c:if test="${pm.prev}">
						<!--백엔드에서 주소를 통해서 active를 변경시킴-->
						<!-- 이전버튼 -->
						<li>
							<c:url var="url" value="/admin/delete">
								<c:param name="page" value="${pm.startPage - 1}"/>
								<c:param name="search" value="${pm.cri.search}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<!-- 그룹에 따라 검색되도록 Criteria에도 group변수 추가 -->
								<c:param name="group" value="${pm.cri.group}"/>
							</c:url>
							<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_prev.svg"/>" alt="이전으로"></a>
						</li>
					</c:if>
					<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
					<c:set var="active" value="${pm.cri.page == i ?'active':'' }"/>
						<li>
							<c:url var="url" value="/admin/delete">
								<c:param name="page" value="${i}"/>
								<c:param name="search" value="${pm.cri.search}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="group" value="${pm.cri.group}"/>
							</c:url>
							<a href="${url}" class="${active}">${i}</a>
						</li>
					</c:forEach>
					<!-- 다음버튼 -->
					<c:if test="${pm.next}">
						<li class="page-item">
							<c:url var="url" value="/admin/delete">
								<c:param name="page" value="${pm.endPage + 1}"/>
								<c:param name="search" value="${pm.cri.search}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="group" value="${pm.cri.group}"/>
							</c:url>
							<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_next.svg"/>" alt="다음으로"></a>
						</li>
					</c:if>
				</ul>
                <div class="btn-wrap">
                    <a href="#" class="btn-hover btn_delete">선택 삭제</a>
                </div> 
            	<!-- 검색처리 -->
				<form action="<c:url value="/admin/delete"/>" method="get">
					<label for="search-announce" class="away">검색입력창</label>
					<input type="text" id="search-announce" placeholder="제품명 혹은 제품코드를 입력하세요." name="search" value="${pm.cri.search}">
					<!-- 검색처리할 input:hidden -->
					<input type="hidden" name="type" value="${pm.cri.type}">
					<input type="hidden" name="group" value="${pm.cri.group}">
				</form>
            </div>
        </div>
    </div>
    
    <!-- 선택상자 변경하면 해당 그룹의 상품이 조회되도록 처리 -->
    <script type="text/javascript">
    	//선택상자의 데이터가 변경되어도, 폼데이터를 전송하는 것은 아니므로 change이벤트를 통해서 데이터를 전송
    	$('#product').change(function(){
    		let v = $(this).val();
    		
    		if(v != '#'){ //value값이 #이 아닐때, 즉 제품분류를 선택한 경우가 아니라면
    			//폼데이터 전송
    			//unbind('submit') : 데이터 전송이 무한루프에 빠지는 것을 방지
    			$('#group-form').unbind('submit').submit();
    		}
    	});
    </script>
    
    <!-- 삭제관련 비동기 처리 -->
    <script type="text/javascript">
		$(".btn_delete").click(function(){
			let arr = [];
			//현재 체크박스에 체크된 요소의 값을 가져와서 배열에 추가
			$('tbody input[name="check"]:checked').each(function(){
				//체크된 체크 박스의 부모요소에서 faq_num 값을 가져와 배열에 추가?
				let pr_code = $(this).val();
				arr.push(pr_code);
			})
			$.ajax({
				async : true, //비동기 : true(비동기), false(동기)
				url : '<c:url value="/admin/delete"/>', 
				type : 'post' ,
				data : { arr : arr}, 
				success : function (data){
					if(data){
						alert('삭제 완료')
					}else{
						alert("실패")
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