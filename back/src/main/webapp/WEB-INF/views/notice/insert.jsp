<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value ="/resources/css/sub-common.css"/>">
    <!-- include summernote css -->
    <link rel="stylesheet" href="<c:url value ="/resources/css/summernote-lite.min.css"/>" >
    <link rel="stylesheet" href="<c:url value ="/resources/css/notice.css"/> ">
    <script src="<c:url value="/resources/js/sub.js"/>"></script>
</head>
<body>
 <main class="main-banner04">
 		<div class="main_text_wrap">
	        <h2>Notice</h2>
	        <div class="indicator">
	            <ul>
	                <li><a href="/index.html"><img src="<c:url value ="/resources/images/sub/home.svg"/>"alt="홈 아이콘"></a></li>
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
    	<form action="<c:url value="/notice/insert"/>" method="post" enctype="multipart/form-data">
	        <div class="insert-title-wrap">
            	<!--for와 id값은 같아야 함-->
	            <label for="category-nav" class="away">카테고리 입력</label>
	            <select id="category-nav" name="no_nc_num">
	                <!--selected 속성을 안쓰면 무조건 첫번째 것이 선택-->
	                <!-- 카테고리의 value값이 0이면 데이터 전송방지 -->
	                <option value="0">카테고리 입력</option>
	                <c:forEach items="${categorylist}" var="category">
	                	<option value="${category.nc_num}">${category.nc_name}</option>
	                </c:forEach>
	            </select>
	            <label for="title-input" class="away">제목입력창</label>
	            <!-- 공지사항 notice테이블의 글자 수 20개인데 너무 작아요. 글자 수 커지면 알아서 잘리게 처리할거라 테이블에서 varchar(70)으로 변경 -->
	            <!-- maxlength="70"로 글자 입력도 70글자 이상 입력 못하게 막기 -->
	            <input type="text" id="title-input" placeholder="제목을 입력하세요." name="no_title" maxlength="70" required /> 
	        </div>
        	<textarea id="no_content" name="no_content"></textarea>
        	<!-- 이미지파일명이 들어갈 hidden입력상자를 모아놓는 박스 -->
        	<div class="hidden-box"></div>
			<button type="submit" class="insert-btn btn-hover">공지사항 등록</button>
		</form>
    </div>
    
    <!-- 아래로 안옮기면 자꾸 썸머노트 오류나서 옮겨서 처리 : 제이쿼리를 불러오는 것이 느린 것으로 판단 파일 변경 -->
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> -->
    <!-- include summernote js -->
    <script src="<c:url value="/resources/js/summernote-lite.min.js"/>"></script>
    <!-- include summernote-ko-KR : 한국어처리 -->
	<!-- <script src="<c:url value="/resources/js/summernote-ko-KR.min.js"/>"></script> -->
    <script type="text/javascript">
    	//우린 썸머노트만 해서 DB의 file테이블은 필요 없을 것 같습니다.
	    $(document).ready(function(){
	    	//폼전송방지관련
	    	//서버에 전송하기 전에 제목, 내용 글자수 확인, 카테고리가 0번인지 확인
	    	$("form").submit(function(){
	    		let title = $("[name=no_title]").val();
	    		if(title.length == 0){
	    			alert("제목은 1글자 이상 입력해야 합니다.");
	    			$("[name=no_title]").focus();
	    			return false;
	    		}
	    		let content = $("[name=no_content]").val();
	    		if(content.length == 0){
	    			alert("내용은 1글자 이상 입력해야 합니다.");
	    			$("[name=no_content]").focus();
	    			return false;
	    		}
	    		
	    		let select = $("[name=no_nc_num]").val();
	    		if(select == 0){ 
	    			alert("카테고리를 선택하세요.");
	    			$("[name=no_nc_num]").focus();
	    			return false;
	    		}
	    	});
	    	
	        //썸머노트
	    	$('#no_content').summernote({
	    		//lang: 'ko-KR', //한국어 처리
	    		placeholder: '내용을 입력하세요.',
	    		tabsize: 9,
	    		height: 600,
	    		//썸머노트 DB처리
	    		callbacks: {
	    	 		// 이미지를 업로드할 경우 이벤트를 발생
	    		   	onImageUpload: function(files, editor, welEditable) {
	    		    	sendFile(files[0], this);
	    			},
	    			// 미디어(이미지 포함)을 삭제할 경우 이벤트를 발생
	    			onMediaDelete: function ($target, editor, $editable) {
	    				//이미지 경로를 추출
	    				//여기서 사용하는 경로는 servlet-context.xml에 아래 코드를 적어야 사용가능
	    				//<resources mapping="/download/**" location="file:///D:/uploads/" />
	    	        	var deletedImageUrl = $target.attr('src').replace('<c:url value="/download"/>',"");
	    				//해당 이미지를 서버에서 삭제해달라고 요청(ajax로)
	    		      	removeImg(deletedImageUrl);
	    		    }
	    	 	}
	    	});
	    	
	    	//이미지 파일 업로드
	    	function sendFile(file, editor) {
	    		data = new FormData();
	    		data.append("file", file, file.name);
	    		
	    		console.log(file);
	    		//첨부파일을 ajax로 보내는 예제		
	    		$.ajax({
	    			data: data,
	    		    type: "post",
	    		    url: '<c:url value="/img/upload"/>',
	    	 		cache : false,
	    		    contentType : false,	
	    		    processData : false,
	    		    success : function(data){
	    		    	console.log(data);
	    		    	$(editor).summernote('editor.insertImage', '<c:url value="/download"/>' + data.url, file.name);
	    		    	
	    		    	let fiName = `
                            <input type="hidden" value="\${file.name}" name="originalFile" data-url="\${data.url}" />
                            <input type="hidden" value="\${data.url}" name="file" data-url="\${data.url}" />
                        `;
	    		  
	    		    	$('.hidden-box').append(fiName);

	    		    }
	    		});
	    	}
	    	//업로드된 이미지를 삭제하는 함수
	    	function removeImg(imageName){
	    		data = new FormData()
	    	  	data.append('file', imageName);
	    		console.log(imageName);
	    	
	    	  	$.ajax({
	    	      data: data,
	    	      type: 'POST',
	    	      url: '<c:url value="/img/delete"/>',
	    	      contentType: false,
	    	      processData: false,
	    	      success : function(data){
	    	    	  // 해당 이미지와 관련된 hidden input을 삭제
                      removeHiddenInput(imageName);
	          	  }
	    	  	});
	    	}
	    	
	    	// 삭제된 이미지와 관련된 hidden input을 삭제하는 함수
            function removeHiddenInput(deletedImageUrl) {
                $('.hidden-box').find('input[data-url*="' + deletedImageUrl + '"]').remove();
            }
	    });
    </script>
</body>
</html>