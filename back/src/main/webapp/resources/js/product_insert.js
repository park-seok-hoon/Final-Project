//상품등록 js - input:text에 첨부파일 주소 넣기
$(document).ready(function(){
    $("#product-detail").on('change',function(){
        //.split('/').pop().split('\\').pop();는 fakepath가 뜨는 것 방지
        let fileName = $("#product-detail").val().split('/').pop().split('\\').pop();
        $("#product-detail-file").val(fileName);
    });
    $("#product-slide01").on('change',function(){
        let fileName = $("#product-slide01").val().split('/').pop().split('\\').pop();
        $("#product-slide01-file").val(fileName);
    });
    $("#product-slide02").on('change',function(){
        let fileName = $("#product-slide02").val().split('/').pop().split('\\').pop();
        $("#product-slide02-file").val(fileName);
    });
    $("#product-slide03").on('change',function(){
        let fileName = $("#product-slide03").val().split('/').pop().split('\\').pop();
        $("#product-slide03-file").val(fileName);
    });
});

//폼데이터 유효성 검사
$(document).ready(function(){
	//코드 중복 방지처리
	let codeChkResult = false;
	//idCheckDup()함수는 주소에 C태그 써야해서 jsp로 옮김
	$('[name=pr_code]').on('input',function(){
		codeCheckDup();
		if(!codeCheckDup()){
			$(this).find('+ .error-text').html('상품코드는 중복될 수 없습니다.');
			$(this).find('+ .error-text').removeClass('active');
			codeChkResult = false;
		}else{
			$(this).find('+ .error-text').html('사용가능한 코드입니다.');
			$(this).find('+ .error-text').addClass('active');
			codeChkResult = true;
		}
	});
	
	//폼데이터가 전송되었을 때
	$('#product-form').submit(function(e){
		e.preventDefault(); //데이터 전송 방지 - 데이터가 잘들어왔을지 알 수 없으므로
		
		//모든 입력요소가 입력되었는지 확인 - val()확인
		let input01 = $('[name=pr_code]').val();
		let input02 = $('[name=pr_name]').val();
		let input03 = $('[name=pr_price]').val();
		let input04 = $('[name=pr_ca_num]').val(); //이건 선택상자, 값이 #아 아닐때로 찾아야 함
		let input05 = $('[name=pr_explain]').val();
		let input06 = $('#product-detail-file').val();
		let input07 = $('#product-slide01-file').val();
		let input08 = $('#product-slide02-file').val();
		let input09 = $('#product-slide03-file').val();
		let input10 = $('[name=pr_kc]').val();
		let input11 = $('[name=pr_elec]').val();
		let input12 = $('[name=pr_energy]').val();
		let input13 = $('[name=pr_date]').val();
		let input14 = $('[name=pr_maker]').val();
		let input15 = $('[name=pr_nation]').val();
		let input16 = $('[name=pr_size]').val();
		let input17 = $('[name=pr_guarantee]').val();
		let input18 = $('[name=pr_AS]').val();
		let input19 = $('[name=pr_extraprice]').val();
		
		
		//상품코드가 사용가능하고, 모든 입력요소 비어 있는 상태가 아니라면 전송
		if(input01 != '' && input02 != '' && input03 != '' && input04 != '#' && input05 != '' && input06 != '' && input07 != '' && input08 != '' && input09 != '' && input10 != '' && input11 != '' && input12 != '' && input13 != '' && input14 != '' && input15 != '' && input16 != '' && input17 != '' && input18 != '' && input19 != '' && codeChkResult){
			$('#product-form').unbind('submit').submit();
		}else{
			if(!codeChkResult){
				alert('상품코드가 중복되지 않게 작성해주세요.');
				return false;
			}else if(input04 == '#'){
				alert('제품분류와 카테고리분류를 정확하게 선택해주세요.');
				return false;
			}else{
				alert('모든 데이터를 입력하세요.');
				return false;
			}
		}
	});
});