<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/notice.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/faq.css"/>">
<script src="<c:url value="/resources/js/sub.js"/>"></script>
<script src="<c:url value="/resources/js/faq.js"/>"></script> 
</head>
<body>
	<main class="main-banner04">
		<div class="main_text_wrap">
			<h2>FAQ</h2>
			<div class="indicator">
				<ul>
					<li><a href="<c:url value="/"/>"><img src="<c:url value="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
					<li><a href="<c:url value="/notice/list"/>">SERVICE</a></li>
					<li><a href="<c:url value="/faq/list"/>">FAQ</a></li>
				</ul>
			</div>
		</div>
	</main>
	 <div class="title-box">
		<h2>FAQ</h2>
		<p>
			스메그의 자주 묻는 질문 페이지입니다.<br>
			평소 고객님들이 자주하는 질문을 정리해놓았습니다.
		</p>
	</div>
	<div class="main-contents">
		<!-- list가 있는 경우 -->
		<c:if test="${list.size() > 0 }">
			<c:forEach items="${list }" var="faq" varStatus="vs">
				<section class="faq-q">
					<!-- 로그인하고 권한이 ADMIN이어야 체크박스 보이게 처리 -->
					<c:if test="${user != null && user.me_authority == 'ADMIN'}">
						<div class="q-check"><input type="checkbox" name="check" value="${faq.fa_num}"></div>
					</c:if>
					<div class="q">Q</div>
					<p class="q-title">${faq.fa_q }</p>
					<a href="<c:url value="#"/>" class="active"></a>
				</section>
				<div class="faq-a">
					<!-- 로그인하고 권한이 ADMIN이어야 체크박스 보이게 처리 -->
					<c:if test="${user != null && user.me_authority == 'ADMIN'}">
						<div class="blank1"></div>
					</c:if>
					<div class="a">A</div>
					<p class="a-contents">
						${faq.fa_a }
					</p>
					<div class="blank2"></div>
				</div> 
			</c:forEach>
		</c:if>
		<!-- list가 없는 경우 -->
		<c:if test="${list.size() == 0 }">
			<div class="list-blank">
				<img src="<c:url value="/resources/images/sub/data_empty.svg" />" alt="빈공간 아이콘">
				<c:if test="${param.search == null}">
					<p>FAQ 데이터가 없습니다.</p>
				</c:if>
				<c:if test="${param.search != null}">
					<p>검색한 "${param.search}" 관련 FAQ 데이터가 없습니다.</p>
				</c:if>
				<!-- 로그인하고 권한이 ADMIN만 보이게 처리 -->
				<c:if test="${user != null && user.me_authority == 'ADMIN' && param.search == null}">
					<p>FAQ데이터를 추가해주세요.</p>
				</c:if>
			</div>
		</c:if>
		<ul class="pagination">
			<c:if test="${pm.prev}">
				<!--백엔드에서 주소를 통해서 active를 변경시킴-->
				<!-- 이전버튼 -->
				<li>
					<c:url var="url" value="/faq/list">
						<c:param name="page" value="${pm.startPage - 1}"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="type" value="${pm.cri.type}"/>
						<c:param name="order" value="${pm.cri.order}"/>
					</c:url>
					<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_prev.svg"/>" alt="이전으로"></a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			<c:set var="active" value="${pm.cri.page == i ?'active':'' }"/>
				<li>
					<c:url var="url" value="/faq/list">
						<c:param name="page" value="${i}"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="type" value="${pm.cri.type}"/>
						<c:param name="order" value="${pm.cri.order}"/>
					</c:url>
					<a href="${url}" class="${active}">${i}</a>
				</li>
			</c:forEach>
			<!-- 다음버튼 -->
			<c:if test="${pm.next}">
				<li class="page-item">
					<c:url var="url" value="/faq/list">
						<c:param name="page" value="${pm.endPage + 1}"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="type" value="${pm.cri.type}"/>
						<c:param name="order" value="${pm.cri.order}"/>
					</c:url>
					<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_next.svg"/>" alt="다음으로"></a>
				</li>
			</c:if>
		</ul>
		<!-- 로그인하고 권한이 ADMIN이어야 보이게 처리 -->
        <c:if test="${user != null && user.me_authority == 'ADMIN'}">
			<div class="btn-wrap">
				<a href="<c:url value="/faq/insert"/>"class="btn-hover">FAQ 등록</a>
				<a href="javascript:void(0);" class="btn-hover btn_delete">선택 삭제</a>
			</div>    
		</c:if>
		<!-- 검색처리 -->
		<form action="<c:url value="/faq/list"/>" method="get">
			<!-- label의 for와 id의 속성값이 같아야 스크린리더기가 읽어줌 -->
			<!-- 앞으로 label에 class를 away로 붙이면 이건 화면에서 안보이게 하겠다는 뜻! -->
			<label for="search-announce" class="away">검색입력창</label>
			<input type="text" id="search-announce" placeholder="검색어를 입력해주세요." name="search" value="${pm.cri.search}">
			<!-- 검색처리할 input:hidden -->
			<input type="hidden" name="type" value="all">
		</form>
	</div>
	<script type="text/javascript">
		$(".btn_delete").click(function(){
			let arr = [];
			//현재 체크박스에 체크된 요소의 값을 가져와서 배열에 추가
			$('input[name="check"]:checked').each(function(){
				//체크된 체크 박스의 부모요소에서 faq_num 값을 가져와 배열에 추가?
				let faq_num = $(this).val();
				arr.push(faq_num);
			})
			if(arr.length > 0){
				$.ajax({
					async : true, //비동기 : true(비동기), false(동기)
					url : '<c:url value="/faq/delete"/>', 
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
			}else{
				alert('삭제하려면 체크박스를 선택해주세요.');
			}
		});
	</script>
</body>
</html>