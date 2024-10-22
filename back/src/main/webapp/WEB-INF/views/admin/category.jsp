<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/myadmin-common.css"/>">
    <link rel="stylesheet" href="<c:url value ="/resources/css/category.css"/>">
    <script src="<c:url value ="/resources/js/category.js"/>"></script>
</head>
<body>
	<main class="main-banner09">
		<div class="main_text_wrap">
		 	<h2>카테고리관리</h2>
		   	<div class="indicator">
		         <ul>
		              <li><a href="<c:url value ="/index"/>"><img src="<c:url value ="/resources/images/sub/home.svg"/>" alt="홈 아이콘"></a></li>
		              <li><a href="<c:url value ="/admin/user_list"/> "> 관리자 </a></li>
		              <li><a href="<c:url value ="/admin/category"/> "> 카테고리 관리</a></li>
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
                    <li><a href="<c:url value ="/admin/category"/>" class="active">카테고리 관리</a></li>
                    <li><a href="<c:url value ="/admin/insert"/>">상품등록</a></li>
                    <li><a href="<c:url value ="/admin/update_list"/>">상품수정</a></li>
                    <li><a href="<c:url value ="/admin/delete"/>">상품삭제</a></li>
                    <li><a href="<c:url value ="/admin/order_list"/> ">고객주문내역</a></li>
               </ul>
           </div>
      </div>
      <div class="right_contents">
	      <h2>카테고리 관리</h2>
	      <div class="sub_contents">
	         <h3>■ 카테고리 수정/삭제</h3>
               <div class="category-wrap">
                   <h4>큰메뉴 그룹:</h4>
                   <!--라디오는 name이 같아야 한세트로 인식해서 둘중 하나만 체크-->
                   <c:forEach items="${grouplist}" var="group" varStatus="vs">
                   	<input type="radio" id="category_${group.gr_name}" value="${group.gr_num}" name="category" ${vs.index == 0 ? 'checked' : ''}>
					<label for="category_${group.gr_name}">${group.gr_name}</label>
                   </c:forEach>
               </div>
               <table>
                   <thead>
                       <tr>
                           <th>번호</th>
                           <th>카테고리명</th>
                           <th>선택</th>
                       </tr>
                   </thead>
                   <tbody class="table-box">
	                   	<!-- 프론트보다 CSS가 많이 바뀌었습니다. 그대로 복사해와야 합니다. -->
	                   	<!-- category.js도 변경되었습니다. -->
	                    <!-- 비동기적으로 동적으로 변경 -->

                   </tbody>		
               </table>
            <div class="insert">
                <h3>■ 카테고리등록</h3>
                <form action="<c:url value="/admin/categoryInsert"/>" method="post" enctype="multipart/form-data">
                	<div class="form-row">
                		<span class="title-label">▩ 그룹 선택 :</span>
						<div class="radio-box">
							<c:forEach items="${grouplist}" var="group" varStatus="vs">
			                   	<input type="radio" id="category2_${group.gr_name}" value="${group.gr_num}" name="ca_gr_num" ${vs.index == 0 ? 'checked' : ''}>
								<label for="category2_${group.gr_name}">${group.gr_name}</label>
			                </c:forEach>
						</div>                		
                	</div>
                    <div class="form-row">
                        <label for="category-name-insert" class="title-label">▩ 카테고리명 입력 :</label>
                        <input type="text" id="category-name-insert" placeholder="카테고리명을 입력하세요." name="ca_name" required>
                    </div>
                    <div class="form-row">
                        <label for="category-explain-insert" class="title-label">▩ 카테고리설명 입력 :</label>
                        <textarea id="category-explain-insert" placeholder="카테고리설명을 입력하세요." name="ca_explain" required></textarea>
                    </div>
                    <div class="form-row">
                        <label for="category-file-text-insert" class="title-label" required>▩ 카테고리이미지 입력 : </label>
                        <input type="text" id="category-file-text-insert" placeholder="1920 x 600사이즈로 이미지를 추가해주세요." readonly>
                        <input type="file" id="category-file-insert" name="category_file_insert">
                        <label for="category-file-insert">첨부파일</label>
                    </div>
                    <div class="form-row">
                        <button type="submit" id="category-btn" class="btn-hover">카테고리등록</button>
                    </div>
                </form>
            </div>
	      </div>
   	  </div>
    </div>
    
    <!-- 카테고리 리스트 비동기 처리 -->
    <script type="text/javascript">
	    $(document).on('change','[name="category"]',function(){
	    	let obj = $('[name="category"]:checked').val();

			$.ajax({
				async : true, //비동기 : true(비동기), false(동기)
				url : '<c:url value="/admin/categoryList2"/>', 
				method : "post", 
				data : {"obj" : obj}, 
				success : function (data){
					let str='';

					$.each(data.categorylist, function(index, category) {
						let i = index + 1;
						let ca_name = category.ca_name;
						let ca_num = category.ca_num;
						let ca_explain = category.ca_explain;
						let ca_pic_ori_name = category.ca_pic_ori_name;
						let url = "<c:url value="/admin/categoryUpdate"/>";
						
						str += `<tr>`;
						str += `
							<td>\${i}</td>
							<td>
								<form action=\${url} id="category-update-form${i}" method="post" enctype="multipart/form-data">
									<div class="form-row">
										<label for="category-name\${i}" class="title-label">▩ 카테고리명 : </label>
										<input type="text" id="category-name\${i}" class="category-name" value="\${ca_name}" name="ca_name" required>
										<input type="hidden" name="ca_num" value="\${ca_num}">
									</div>
									<div class="form-row">
										<label for="category-explain\${i}" class="title-label">▩ 카테고리설명 : </label>
										<textarea id="category-explain\${i}" rows="4" name="ca_explain" required>\${ca_explain}</textarea>
									</div>
									<div class="form-row">
										<label for="category-file-text\${i}" class="title-label">▩ 카테고리이미지 : </label>
										<input type="text" id="category-file-text\${i}" class="category-file-text" value="\${ca_pic_ori_name}" name="past_ca_pic_ori_name" readonly required>
										<input type="file" id="category-file\${i}" name="category_file_update">
										<label for="category-file\${i}">첨부파일</label>
									</div>
									<div class="form-row">
										<button class="btn-hover btn-update" data-form-id="${i}">수정완료</button>
									</div>
								</form>
							</td>
							<td>
								<button class="update-btn btn-hover">수정</button>
								<a href="<c:url value="/category/delete?caNum=\${ca_num}" />" class="delete-btn">삭제</a>
							</td>
						`;
						
						str += `</tr>`;
					});
					
					$(".table-box").html(str);	
				}, 
				error : function(jqXHR, textStatus, errorThrown){
						
				}
			});
	    });
	    $('[name="category"]').trigger('change');
	    
	    //수정버튼을 누르면 해당 td에 active클래스 처리
	    $(document).on('click','.update-btn',function(){
	    	$('.sub_contents table td:nth-child(2)').removeClass('active'); //모든 active제거후
	    	$(this).parent().prev().addClass('active'); //수정버튼 누른 것만 active처리
	    });
	    
	    //삭제버튼 클릭시 관련 상품삭제 안내
	    $(document).on('click','.delete-btn',function(e){
	    	e.preventDefault();
	    	let q = confirm('카테고리를 삭제하면 관련 제품이 모두 삭제됩니다. 삭제하시겠습니까?');
	    	let href = $(this).attr('href');
	    	if(q){
	    		location.href = href;
	    	}else{
	    		alert('삭제를 취소하였습니다.');
	    	}
	    });
    </script>
    
</body>
</html>