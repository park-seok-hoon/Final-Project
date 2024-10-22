<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="header"></div>

<!-- gnb 카테고리 데이터처리 -->
<script type="text/javascript">
	function test(){
		$.ajax({
			url : '<c:url value="/common/header"/>',
			success : function(data){
				$('#header').html(data);
			}
		})
	}
	test();
</script>