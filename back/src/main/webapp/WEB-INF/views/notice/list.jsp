<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/notice.css"/> ">
    <script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
	<script src="<c:url value="/resources/js/common.js"/>"></script>
    <script src="<c:url value ="/resources/js/sub.js"/>"></script>
</head>
<body>
	<main class="main-banner04">
		<div class="main_text_wrap">
	      <h2>Notice</h2>
	      <div class="indicator">
	           <ul>
	               <li><a href="/index.html"><img src="<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘"/></a></li>
	               <li><a href="/service/notice.html">SERVICE</a></li>
	               <li><a href="/service/notice.html">공지사항</a></li>
	           </ul>
	       </div>
         </div>
    </main>
    <div class="title-box">
        <h2>공지사항</h2>
        <p>
			스메그의 공지사항 안내 페이지입니다.<br>
			공지사항은 신제품, 매장, 이슈, 안내 카테고리로 나뉩니다.
        </p>
    </div>
    <div class="main-contents">
    	<c:if test="${user != null && user.me_authority == 'ADMIN'}">
        	<table>
        </c:if>
        <c:if test="${user == null || (user != null && user.me_authority == 'USER')}">
        	<table class="user">
        </c:if>
            <thead>
                <tr>
                	<!-- 로그인하고 권한이 ADMIN이어야 체크박스 보이게 처리 -->
					<c:if test="${user != null && user.me_authority == 'ADMIN'}">
                    	<th><input type="checkbox" id="all-check"></th>
                    </c:if>
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>날짜</th>
                    <!-- 로그인하고 권한이 ADMIN이어야 조회수 보이게 처리 -->
                    <c:if test="${user != null && user.me_authority == 'ADMIN'}">
                    	<th>조회수</th>
                    </c:if>
                </tr>
            </thead>
			<tbody>
				<!-- list가 있는 경우 -->
				<c:if test="${list.size() > 0 }">
					<c:forEach items="${list}" var="notice" varStatus="status">
		                <tr>
		                	<!-- 로그인하고 권한이 ADMIN이어야 체크박스 보이게 처리 -->
							<c:if test="${user != null && user.me_authority == 'ADMIN'}">
		                    	<td><input type="checkbox" id="chk${status.index + 1}" class="chks" value="${notice.no_num}"></td>
		                    </c:if>
		                    <td>${pm.totalCount - status.index - pm.cri.pageStart}</td>
		                    <td>
			                    <c:url value="/notice/list" var="url">
    								<c:param name="type" value="category"/>
								    <c:param name="search" value="${notice.no_nc_num}"/>
								</c:url>
								<a href="${url}">${notice.no_nc_name}</a>
		                    </td>
		                    <td>
		                    	<c:url value="/notice/detail" var="url">
									<c:param name="page" value="${pm.cri.page}"/>
									<c:param name="type" value="${pm.cri.type}"/>
									<c:param name="search" value="${pm.cri.search}"/>
									<c:param name="noNum" value="${notice.no_num}"/>
								</c:url>
								<a href="${url}">${notice.no_title}</a>
		                    </td>
		                    <td><fmt:formatDate value="${notice.no_date}" pattern="yyyy-MM-dd"/></td>
		                    <!-- 로그인하고 권한이 ADMIN이어야 조회수 보이게 처리 -->
		                    <c:if test="${user != null && user.me_authority == 'ADMIN'}">
		                    	<td>${notice.no_view}</td>
		                    </c:if>
		                </tr>
	                </c:forEach>
                </c:if>
                <!-- list가 없는 경우 -->
				<c:if test="${list.size() == 0 }">
					<tr>
						<td colspan="6">게시글이 없습니다.</td>
					</tr>
				</c:if>
            </tbody>		
		</table>  
        <ul class="pagination">
			<c:if test="${pm.prev}">
				<!--백엔드에서 주소를 통해서 active를 변경시킴-->
				<!-- 이전버튼 -->
				<li>
					<c:url var="url" value="/notice/list">
						<c:param name="page" value="${pm.startPage - 1}"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="type" value="${pm.cri.type}"/>
						<c:param name="order" value="${pm.cri.order2}"/>
					</c:url>
					<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_prev.svg"/>" alt="이전으로"></a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			<c:set var="active" value="${pm.cri.page == i ?'active':'' }"/>
				<li>
					<c:url var="url" value="/notice/list">
						<c:param name="page" value="${i}"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="type" value="${pm.cri.type}"/>
						<c:param name="order" value="${pm.cri.order2}"/>
					</c:url>
					<a href="${url}" class="${active}">${i}</a>
				</li>
			</c:forEach>
			<!-- 다음버튼 -->
			<c:if test="${pm.next}">
				<li class="page-item">
					<c:url var="url" value="/notice/list">
						<c:param name="page" value="${pm.endPage + 1}"/>
						<c:param name="search" value="${pm.cri.search}"/>
						<c:param name="type" value="${pm.cri.type}"/>
						<c:param name="order" value="${pm.cri.order2}"/>
					</c:url>
					<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_next.svg"/>" alt="다음으로"></a>
				</li>
			</c:if>
		</ul>
		<!-- 로그인하고 권한이 ADMIN이어야 버튼 보이게 처리 -->
		<c:if test="${user != null && user.me_authority == 'ADMIN'}">
			<!-- list가 있는 경우 -->
			<c:if test="${list.size() > 0 }">
				<div class="btn-wrap">
		            <a href="<c:url value ="/notice/insert/"/>" class="btn-hover">공지사항 등록</a>
		            <a href="#" class="btn-hover btn_delete">선택 삭제</a>
		        </div>  
			</c:if>
			<!-- list가 없는 경우 : 버튼이 좀 더 내려가야 함-->
			<c:if test="${list.size() == 0 }">
				<div class="btn-wrap empty">
		            <a href="<c:url value ="/notice/insert/"/>" class="btn-hover">공지사항 등록</a>
		            <a href="#" class="btn-hover btn_delete">선택 삭제</a>
		        </div>    
			</c:if>
		</c:if>
        <!-- 검색처리 -->
		<form action="<c:url value="/notice/list"/>" method="get">
			<!-- label의 for와 id의 속성값이 같아야 스크린리더기가 읽어줌 -->
			<!-- 앞으로 label에 class를 away로 붙이면 이건 화면에서 안보이게 하겠다는 뜻! -->
			<label for="search-announce" class="away">검색입력창</label>
			<input type="text" id="search-announce" placeholder="검색어를 입력해주세요." name="search" value="">
			<!-- 검색처리할 input:hidden -->
			<input type="hidden" name="type" value="all">
		</form>
    </div>
    
    <!-- 삭제관련 비동기 처리 -->
    <script type="text/javascript">
		$(".btn_delete").click(function(){
			let arr = [];
			//현재 체크박스에 체크된 요소의 값을 가져와서 배열에 추가
			$('.chks:checked').each(function(){
				//체크된 체크 박스의 부모요소에서 faq_num 값을 가져와 배열에 추가?
				let no_num = $(this).val();
				console.log(no_num);
				arr.push(no_num);
			})
			if(arr.length > 0){
				$.ajax({
					async : true, //비동기 : true(비동기), false(동기)
					url : '<c:url value="/notice/delete"/>', 
					type : 'post' ,
					data : { arr : arr}, 
					success : function (data){
						if(data){
							alert('삭제 완료');
						}else{
							alert("실패");
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