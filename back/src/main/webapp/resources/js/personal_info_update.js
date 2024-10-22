//개인정보 수정에만 적용할 js

//생년월일 옵션처리
$(document).ready(function(){
    //년 옵션태그 처리
    let today = new Date(); //오늘날짜를 생성해줌
    let todayYear = today.getFullYear(); //오늘의 년도만 담는 변수

    let yearOption = '';
    for(let i=todayYear;i>=1900;i--){
        yearOption += '<option>' + i + '</option>';
    }
    $('#signup-year').html(yearOption);


    //월 옵션태그 처리
    let monthOption = '';
    for(let i=1;i<=12;i++){ 
        monthOption += '<option>' + i + '</option>';
    }
    $('#signup-month').html(monthOption);

    //변경될 일자를 담는 배열
    let dates = [31,28,31,30,31,30,31,31,30,31,30,31];

    //해당년도가 윤년이면 29일로 처리
    //윤달 계산 4년마다 29일, 100년는 28일, 400년 째는 29일
    //근데 이건 초기 실행
    if(todayYear % 400 == 0 || (todayYear % 4 == 0 && todayYear % 100 != 0)){
        dates[1] = 29;
    }


    //초기실행
    //일 옵션태그 처리
    //일관련 옵션태그를 담을 변수 - 초기에는 빈문자열 처리
    let dateOption = '';

    //반복문을 통해 31번 처리
    for(let i=1;i<=31;i++){ //현재는 1일~31일
        dateOption += '<option>' + i + '</option>';
    }

    //옵션태그를 select에 문자열로 처리
    //html() : 문서객체의 텍스트를 컨트롤하는 메서드(문자열이 태그면 태그인식)
    $('#signup-date').html(dateOption);

    //월과 년도 선택상자가 바뀔때마다 윤년 계산
    //월 선택상자가 바뀔 때마다 일자가 변경
    $('#signup-month, #signup-year').change(function(){
        //선택상자가 변경될때의 value값을 담는 변수
        let monthValue = $('#signup-month').val(); //값의 유형이 문자
        let yearValue = $('#signup-year').val(); //값의 유형이 문자

        //윤년은 2월만 해당
        if(monthValue == 2 && (yearValue % 400==0 || (yearValue % 4==0 && yearValue % 100 != 0))){
            dates[1] = 29;
        }else{
            dates[1] = 28;
        }


        //dateOption을 비우고 시작
        dateOption = '';

        //value값은 1부터 시작하고, 배열의 인덱스번호는 0부터 시작하기 때문에 v+1로 처리
        for(let i=1;i<=dates[monthValue-1];i++){
            dateOption += '<option>' + i + '</option>';
        }
        $('#signup-date').html(dateOption);
    });
    
    //선택상자 값 체크되게 처리
    // 데이터 속성으로 설정된 초기 값을 사용하여 선택된 옵션을 설정
    function setSelectedOptions() {
        $('#signup-year').val($('#signup-year').data('info'));
        $('#signup-month').val($('#signup-month').data('info'));
        $('#signup-date').val($('#signup-date').data('info'));
    }

    // 페이지 로드 시 초기 선택 설정
    setSelectedOptions();

});


//이메일 주소 선택 js
$(document).ready(function(){
    //url-select의 값이 변경되면 해당 값이 signup-email02의 값으로 처리
    //단, #이 아닐 때만 처리
    $('#url-select').change(function(){
        let urlValue = $(this).val(); //선택상자가 선택한 옵션의 value값을 담는 변수
        if(urlValue != '#'){ //선택한 value값이 #이 아니라면
            $('#signup-email02').val(urlValue); //입력상자에 value값을 처리
        }else{ //값이 #이면
            $('#signup-email02').val(''); //입력상자에 value값을 빈문자열 처리
        }
    });
});



//유효성검사
$(document).ready(function(){
	//정규식처리
	//1. 아이디
	$('#signup-id').on('input',function(){
		//아이디정규식
		let regex = /^[a-zA-Z0-9]{6,15}$/;
		let v = $(this).val();
		
		if(!regex.test(v)){
			$(this).parents('.form-row').find('+ .error-text').show(0);
		}else{
			$(this).parents('.form-row').find('+ .error-text').hide(0);
		}
	});
	//2. 비밀번호
	$('#signup-pw').on('input',function(){
		//비밀번호정규식
		let regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[.!@$%^*+=])[A-Za-z\d.!@$%^*+=]{8,16}$/;
		let v = $(this).val();
		
		if(!regex.test(v)){
			$(this).parents('.form-row').find('+ .error-text').show(0);
		}else{
			$(this).parents('.form-row').find('+ .error-text').hide(0);
		}
		
		
		//비밀번호 확인
		let pwValue = $('#signup-pw2').val();
		
		if(pwValue != v && pwValue != ''){
			$('#signup-pw2').parents('.form-row').find('+ .error-text').show(0);
		}else{
			$('#signup-pw2').parents('.form-row').find('+ .error-text').hide(0);
		}
	});
	//3. 비밀번호 확인 - 비밀번호와 같아야 함
	$('#signup-pw2').on('input',function(){
		//비밀번호 확인
		let pwValue = $('#signup-pw').val();
		let v = $(this).val();
		
		if(pwValue != v){
			$(this).parents('.form-row').find('+ .error-text').show(0);
		}else{
			$(this).parents('.form-row').find('+ .error-text').hide(0);
		}
	});
	//4. 휴대전화
	$('#signup-phone').on('input',function(){
		//휴대전화 정규식
		let regex = /^010-\d{4}-\d{4}$/;
		let v = $(this).val();
		
		if(!regex.test(v)){
			$(this).parents('.form-row').find('+ .error-text').show(0);
		}else{
			$(this).parents('.form-row').find('+ .error-text').hide(0);
		}
	});
	
	//5. 아이디 중복검사 - 변경이라 하지 않음
	

	//폼데이터가 전송되었을 때
	$('#signupform').submit(function(e){
		e.preventDefault(); //데이터 전송 방지 - 데이터가 잘들어왔을지 알 수 없으므로
		
		//모든 조건이 맞아야 처리
		//1. 약관동의 전체가 체크 : 약관 동의도 없음
		
		
		//2. 모든 에러창이 안보여야 처리
		let error01 = $('.error-text01').is(':hidden');
		let error02 = $('.error-text02').is(':hidden');
		let error03 = $('.error-text03').is(':hidden');
		let error04 = $('.error-text04').is(':hidden');
		
		
		//3. 모든 입력창의 데이터가 빈문자열이 아니어야 처리
		let input01 = $('#signup-name').val();
		let input02 = $('#signup-id').val();
		let input03 = $('#signup-pw').val();
		let input04 = $('#signup-pw2').val();
		let input05 = $('#signup-phone').val();
		let input06 = $('#signup-email01').val();
		let input07 = $('#signup-email02').val();
		let input08 = $('#sample2_postcode').val();
		let input09 = $('#sample2_address').val();
		let input10 = $('#sample2_detailAddress').val();
		
		
		//모든 조건이 맞으면 데이터 전송
		if(error01 && error02 && error03 && error04 && input01 != '' && input02 != '' && input03 != '' && input04 != '' && input05 != '' && input06 != '' && input07 != '' && input08 != '' && input09 != '' && input10 != ''){
			//현재 이벤트 핸들러를 잠시 해제한 후 폼을 제출하는 것이 좋습니다. 이렇게 하면 이벤트 핸들러가 한 번만 실행되고 더 이상 호출되지 않습니다.
			$('#signupform').unbind('submit').submit();
		}else{
			if(!error01 || !error02 || !error03 || !error04){
				alert('회원정보를 규칙에 맞게 입력하세요');
				return false;
			}
			if(input01 == '' || input02 == ''|| input03 == '' || input04 == '' || input05 == '' || input06 == '' || input07 == '' || input08 == '' || input09 == '' || input10 == '' ){
				alert('모든 데이터를 입력하세요.');
				return false;
			}
		}
	});
});







