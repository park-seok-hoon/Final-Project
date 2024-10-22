<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-userlist.css"/>">
    <script src="<c:url value="/resources/js/sub.js"/>"></script>
</head>
<body>
	<main class="main-banner09">
		<div class="main_text_wrap">
	       <h2>회원리스트 보기/강퇴</h2>
	       <div class="indicator">
	           <ul>
	               <li><a href="/index.html"><img src="<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
	               <li><a href="<c:url value ="/admin/user_list"/> "> 관리자 </a></li>
	               <li><a href="<c:url value ="/admin/user_list"/> "> 회원리스트 보기/강퇴</a></li>
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
                    <li><a href="<c:url value ="/admin/user_list"/>"class="active">회원리스트 보기/강퇴</a></li>
                    <li><a href="<c:url value ="/admin/category"/>">카테고리 관리</a></li>
                     <li><a href="<c:url value ="/admin/insert"/>">상품등록</a></li>
                    <li><a href="<c:url value ="/admin/update_list"/>">상품수정</a></li>
                    <li><a href="<c:url value ="/admin/delete"/>">상품삭제</a></li>
                    <li><a href="<c:url value ="/admin/order_list"/> ">고객주문내역</a></li>
                </ul>
            </div>
        </div>
        <div class="right_contents">
            <h2>회원리스트 보기/강퇴</h2>
            <div class="sub_contents">
                <ul class="top-title">
                    <li>스메그 회원</li>
                    <li>총 ${memberCount}명의 회원이 있습니다.</li>
                </ul>
                <table>
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="all-check"></th>
                            <th>아이디</th>
                            <th>회원명</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>생년월일</th>
                            <th>주소</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<!-- 테이블 CSS고정되어 있어서 CSS수정 필요 -->
                    	<!-- 리스트가 있는 경우 -->
                    	<c:if test="${memberlist.size() != 0}">
                    		<c:forEach items="${memberlist}" var="member" varStatus="vs">
                    			<tr>
		                            <td><input type="checkbox" id="chk${vs.index + 1}" name="check" value="${member.me_id}"></td>
		                            <td>${member.me_id}</td>
		                            <td>${member.me_name}</td>
		                            <td>${member.me_email}</td>
		                            <td>${member.me_phone}</td>
		                            <td>${member.me_birth}</td>
		                            <td>${member.me_address} <span>${member.me_detail_address}</span></td>
		                        </tr>
                    		</c:forEach>
                    	</c:if>
                    	<!-- 리스트가 없는 경우 -->
                    	<c:if test="${memberlist.size() == 0}">
                    		<tr>
                    			<td colspan="7">회원이 없습니다.</td>
                    		</tr>
                    	</c:if>
                    </tbody>		
                </table>
                <ul class="pagination">
					<c:if test="${pm.prev}">
						<!--백엔드에서 주소를 통해서 active를 변경시킴-->
						<!-- 이전버튼 -->
						<li>
							<c:url var="url" value="/admin/user_list">
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
							<c:url var="url" value="/admin/user_list">
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
							<c:url var="url" value="/admin/user_list">
								<c:param name="page" value="${pm.endPage + 1}"/>
								<c:param name="search" value="${pm.cri.search}"/>
								<c:param name="type" value="${pm.cri.type}"/>
							</c:url>
							<a href="${url}"><img src="<c:url value="/resources/images/product/pagination_next.svg"/>" alt="다음으로"></a>
						</li>
					</c:if>
				</ul>
				<!-- 회원강퇴만 있습니다. -->
				<div class="btn-wrap">
                    <a href="#" class="user-drop-btn btn-hover">회원강퇴</a>
                </div>   
				<!-- 검색처리 -->
				<form action="<c:url value="/admin/user_list"/>" method="get">
					<!-- label의 for와 id의 속성값이 같아야 스크린리더기가 읽어줌 -->
					<!-- 앞으로 label에 class를 away로 붙이면 이건 화면에서 안보이게 하겠다는 뜻! -->
					<label for="search-announce" class="away">검색입력창</label>
					<input type="text" id="search-announce" placeholder="검색어를 입력해주세요." name="search" value="">
					<!-- 검색처리할 input:hidden -->
					<input type="hidden" name="type" value="all">
				</form>
            </div>
        </div>
    </div>
    
    <!-- 체크한 개수만큼 회원강퇴 -->
    <script type="text/javascript">
	    $(".user-drop-btn").click(function(e){
	    	e.preventDefault();
	    	
			let arr = [];
			//현재 체크박스에 체크된 요소의 값을 가져와서 배열에 추가
			$('input[name="check"]:checked').each(function(){
				//체크된 체크 박스의 부모요소에서 faq_num 값을 가져와 배열에 추가?
				let me_id = $(this).val();
				arr.push(me_id);
			})
			$.ajax({
				async : true, //비동기 : true(비동기), false(동기)
				url : '<c:url value="/admin/user/drop"/>', 
				type : 'post' ,
				data : { arr : arr}, 
				success : function (data){
					if(data){
						alert('선택한 회원을 모두 강퇴시켰습니다.')
					}else{
						alert("선택한 회원을 강퇴시키지 못했습니다.")
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