//회원가입에만 적용할 js

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


//약관의 a태그 클릭 시 보이게 처리 + a태그 글자도 닫기로 변경
$(document).ready(function(){
    $('.chk-row a').click(function(e){ //이벤트 객체 생성
        e.preventDefault(); //기본이벤트 제거 - a태그는 페이지 이동이 기본이벤트
        //임시링크 #인 경우 위로 올라가지 못하게 처리

        //이때 iframe-box는 두개라 선택을 잘해줘야 함
        //내 부모의 동생을 보이거나 안보이게 처리해야함
        //parent() : 문서객체의 부모
        //next() : 문서객체의 동생 요소 선택
        //slideToggle() : slideDown()과 slideUp()을 번갈아 실행하는 메서드
        $(this).parent().next().slideToggle('slow');

        //toggleClass() : 클래스를 추가/제거를 반복하는 메서드
        $(this).toggleClass('active');

        //hasClass() : 해당 클래스를 갖고 있다면 true를 반환, 그렇지 않다면 false를 반환
        if($(this).hasClass('active')){
            $(this).html('닫기'); //글자를 닫기로 변환
        }else{
            $(this).html('자세히 보기'); //글자를 자세히 보기로 변환
        }
    });
});


//모두 체크 관련 js
$(document).ready(function(){
    //clause-all-chk의 값이 변경되었을 때 체크되었다면 아래 3개도 체크, 미체크되었다면 아래 3개도 미체크
    $('#clause-all-chk').change(function(){
        //현재 올체크의 체크값을 담는 변수
        let chk = $(this).prop('checked');

        if(chk){ //체크가 되었다면
            //3개 체크박스를 한번에 선택
            //$('선택자1, 선택자2, 선택자3') : 쉼표는 한번만 열고 닫게 처리
            $('#clause-chk01, #clause-chk02, #clause-chk03').prop('checked',true);
        }else{ //체크되어 있지 않다면
            $('#clause-chk01, #clause-chk02, #clause-chk03').prop('checked',false);
        }
    });

    //아래 3개 체크박스가 변경되었을 때, 3개가 모두 체크되었다면 clause-all-chk도 체크, 아니라면 미체크
    $('#clause-chk01, #clause-chk02, #clause-chk03').change(function(){
        //이번에는 3개의 체크상태를 각각 담기
        let chk01 = $('#clause-chk01').prop('checked');
        let chk02 = $('#clause-chk02').prop('checked');
        let chk03 = $('#clause-chk03').prop('checked');

        if(chk01 && chk02 && chk03){ //3개다 체크가 되었다면
            $('#clause-all-chk').prop('checked',true);
        }else{ //체크가 한개라도 안되어 있다면
            $('#clause-all-chk').prop('checked',false);
        }
    });
});