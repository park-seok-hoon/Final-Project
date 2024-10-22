<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/product.css"/>">
    <script src="<c:url value="/resources/js/sub.js"/>"></script>
</head>
<body class="product">
	<main class="product${category.ca_num}">
		<!-- 형태가 바뀌어서 sub-common.css가 대폭 변경 -->
		<img src="<c:url value="/download${category.ca_pic_name}" />" alt="${category.ca_name}의 메인이미지" class="main_img">
		<!-- 이미지 때문에 앱솔루트 한번에 줘야 해서 묶음 -->
		<div class="main_text_wrap">
			<c:if test="${category.ca_num >= 1 && category.ca_num <=4}">
			<h2>SMEG × ${category.ca_name}</h2>
			</c:if>
			<c:if test="${category.ca_num > 4}">
				<h2>${category.ca_name}</h2>
			</c:if>
	        
	        <div class="indicator">
	            <ul>
	                <li><a href="<c:url value="/"/>"><img src="<c:url value="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
	                <li><a href="<c:url value="/product/list/${group.gr_num}/${minCategory.ca_num}"/>">${group.gr_name}</a>
	                </li>
	                <li><a href="<c:url value="/product/list/${group.gr_num}/${category.ca_num}"/>">${category.ca_name}</a></li>
	            </ul>
	        </div>
		</div>
    </main>
    <div class="nav-select">
        <!--inner-wrap은 배경색이나 배경이미지가 100%인데 컨텐츠는 가운데 오게할 때 자주 쓰는 실무 클래스 용어-->
        <div class="inner-wrap">
            <!--for와 id값은 같아야 함-->
            <label for="first-nav" class="away">큰메뉴 선택상자</label>
            <select id="first-nav">
                <c:forEach items="${grouplist}" var="group">
           			<option value="${group.gr_num}">${group.gr_name}</option>
                </c:forEach>
            </select>
            <label for="second-nav" class="away">작은메뉴 선택상자</label>
            <select id="second-nav">
                <!--html이라면 고정된 값을 넣겠지만, 큰메뉴를 뭘 선택했냐에 따라 달라져야 하므로 제이쿼리로 옵션처리-->
            </select>
        </div>
    </div>
    <div class="title-box">
        <c:if test="${category.ca_num >= 1 && category.ca_num <=4}">
			<h2>SMEG × ${category.ca_name}</h2>
		</c:if>
		<c:if test="${category.ca_num > 4}">
			<h2>${category.ca_name}</h2>
		</c:if>
        <p>
            ${category.ca_explain}
        </p>
    </div>
    <div class="main-contents">
    	<ul class="products">
    		<!-- 제품리스트가 있는 경우 -->
    		<c:if test="${productList.size() != 0}">
	    		<c:forEach items="${productList}" var="product">
	    			<li>
	    				<!-- 이미지 크기 땜에 CSS처리 -->
	    				<a href="<c:url value="/product/detail?pr_code=${product.pr_code}" />">  <!-- productDetail 작업 후 수정 필요 내역 -->
	    					<img src="<c:url value="/download${product.slidelist[0].sp_name}"/>" alt="${product.pr_name}">
	    					<div class="text-wrap">
	    						<h3>${product.pr_name}</h3>
								<p class="code">${product.pr_code}</p>
								<p class="price">${product.pr_price}</p>
								<c:if test="${product.pr_ps_state == '품절'}">
									<p class="sold-out">품절</p>
								</c:if>
	    					</div>
	    				</a>
	    			</li>
	    		</c:forEach>
    		</c:if>
    		<!-- 제품리스트가 없는 경우 -->
    		<c:if test="${productList.size() == 0}">
    			<li class="list-blank">
    				<img src="<c:url value="/resources/images/sub/data_empty.svg" />" alt="빈공간 아이콘">
    				<br>
    				<br>
    				<p>등록된 상품이 없습니다.</p>
    			</li>
    		</c:if>
    	</ul>
    	<ul class="pagination">
    		<c:if test="${pm.prev}">
				<li><a href="<c:url value='/product/list/${group.gr_num}/${category.ca_num}?page=${pm.startPage-1}'/>"><img src="<c:url value='/resources/images/product/pagination_prev.svg'/>" alt="이전으로"></a></li>
			</c:if>
    
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="pageNum">
				<!-- 페이지 번호를 돌며 링크를 생성 -->
				<c:choose>
					<c:when test="${pageNum == pm.cri.page}">
						<!-- 현재 페이지일 경우 -->
						<li><a href="#" class="active">${pageNum}</a></li>
						</c:when>
					<c:otherwise>
						<!-- 현재 페이지가 아닐 경우 -->
						<li><a href="<c:url value='/product/list/${group.gr_num}/${category.ca_num }?page=${pageNum}'/>">${pageNum}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
    
			<c:if test="${pm.next}">
				<li><a href="<c:url value='/product/list/${group.gr_num}/${category.ca_num }?page=${pm.endPage+1}'/>"><img src="<c:url value='/resources/images/product/pagination_next.svg'/>" alt="다음으로"></a></li>
			</c:if>
    	</ul>
    </div>
    
    <!-- 카테고리 선택상자 관련 비동기 처리 -->
    <script type="text/javascript">
		$("#first-nav").change(function(){
			let obj = $("#first-nav").val();
			$.ajax({
				async : true, //비동기 : true(비동기), false(동기)
				url : '<c:url value="/product/categoryList"/>', 
				method : "get", 
				data : {"obj" : obj}, 
				success : function (data){
					let str='';
					for(let tmp of data.categorylist){
						str += `<option value="\${tmp.ca_num}"`;
		                if ("${category.ca_num}" == tmp.ca_num) {
		                    str += ' selected';
		                }
		                str += `>\${tmp.ca_name}</option>`;
					}
					$("#second-nav").html(str);			
				}, 
				error : function(jqXHR, textStatus, errorThrown){
						
				}
			});
		});

		$(document).on('change',"#second-nav",function(){
			let gr_num = $("#first-nav").val();
			let ca_num = $("#second-nav").val();
			location.href = `<c:url value="/product/list"/>/\${gr_num}/\${ca_num}`;
			
		});
		$("#first-nav").val('${group.gr_num}');
		$("#first-nav").trigger('change');
		$("#second-nav").val('${category.ca_num}');
	</script>
</body>
</html>