<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" href="<c:url value="/resources/css/sub-common.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/notice.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/faq_insert.css"/>">
	<script src="<c:url value="/resources/js/sub.js"/>"></script>
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
		<form action="<c:url value="/faq/insert"/>" method="post" id="faq-insert">
			<div>
				<label for="insert-q" class="away">faq 질문입력창</label>
				<input type="text" id="insert-q" placeholder="질문을 입력하세요." name ="fa_q">
			</div>
			<div>
				<label for="insert-a" class="away">faq 답변입력창</label>
				<textarea type="text" id="insert-a" placeholder="답변을 입력하세요." name ="fa_a"></textarea>
			</div>
			<button type="submit" id="insert-qa" class="btn-hover">FAQ 등록</button>
		</form>
	</div>
	<script type="text/javascript">
		//enter => <br>
		$("#faq-insert").submit(function(){
			var text = $('#faq-insert textarea').val();
			// 문자열에서 줄 바꿈 문자(\n)을 <br>로 바꿉니다.
			text = text.replace(/(?:\r\n|\r|\n)/g, '<br>');
			$('#faq-insert textarea').val(text);
		})
	</script>
</body>
</html>