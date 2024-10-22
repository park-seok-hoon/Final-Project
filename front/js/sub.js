//서브페이지가 공통으로 사용하는 js문서

//변수 겹치는 현상을 방지하기 위해 준비구문 씀
//서브 선택상자
$(document).ready(function(){
    //초기실행 - 처음에 처리되어야 할 명령
    //선택상자에 option태그가 동적으로 처리되어야 함

    //1. SPECIAL인 경우 담을 태그를 담는 변수
    //jsp로 넘어가면 주소 변경해야 함
    let special = `
        <option value="/special/dng.html">SMEG × D&G</option>
        <option value="/special/fiat.html">SMEG × FIAT</option>
        <option value="/special/disney.html">SMEG × DISNEY</option>
        <option value="/special/cocacola.html">SMEG × COCACOLA</option>
    `;

    //2. BIG PRODUCT인 경우 담을 태그를 담는 변수
    let big = `
        <option value="/big/refrigerator.html">냉장고</option>
        <option value="/big/wineseller.html">와인셀러</option>
        <option value="/big/dishwasher.html">식기세척기</option>
        <option value="/big/oven.html">오븐/인덕션</option>
    `;

    //3. SMALL PRODUCT인 경우 담을 태그를 담는 변수
    let small = `
        <option value="/small/electricpot.html">전기포트</option>
        <option value="/small/toaster.html">토스트기</option>
        <option value="/small/mixer.html">믹서기</option>
    `;

    //첫번째 선택상자가 변경되었을 때 - 해당 선택값에 맞게 변경
    $('#first-nav').change(function(){
        //선택된 value값을 담는 변수 선언
        let value = $(this).val(); //문자열이 담김

        //두번째 선택상자 안에 html태그로 처리
        //eval()은 문자열이 아닌 변수로 바로 적용하기 위해 사용
        $('#second-nav').html(eval(value));
    });

    //초기실행에도 옵션 들어가게 처리
    //초기실행때도 첫번째 선택상자의 change이벤트가 처리되게 처리
    $('#first-nav').trigger('change');

    //두번째 박스의 옵션처리
    //첫번째 박스에 선택된 value
    let firstValue = $('#first-nav').val(); //val() - value값을 컨트롤하는 메서드
    //main의 클래스가 뭔지 담는 변수
    let mainClass = $('main').attr('class');

    if(firstValue == 'special'){
        switch(mainClass){
            case 'product1':
                $('#second-nav').find('option').eq(0).prop('selected', true);
                break;
            case 'product2':
                $('#second-nav').find('option').eq(1).prop('selected', true);
                break;
            case 'product3':
                $('#second-nav').find('option').eq(2).prop('selected', true);
                break;
            case 'product4':
                $('#second-nav').find('option').eq(3).prop('selected', true);
                break;
        }
    }else if(firstValue == 'big'){
        switch(mainClass){
            case 'product5':
                $('#second-nav').find('option').eq(0).prop('selected', true);
                break;
            case 'product6':
                $('#second-nav').find('option').eq(1).prop('selected', true);
                break;
            case 'product7':
                $('#second-nav').find('option').eq(2).prop('selected', true);
                break;
            case 'product8':
                $('#second-nav').find('option').eq(3).prop('selected', true);
                break;
        }

    }else if(firstValue == 'small'){
        switch(mainClass){
            case 'product9':
                $('#second-nav').find('option').eq(0).prop('selected', true);
                break;
            case 'product10':
                $('#second-nav').find('option').eq(1).prop('selected', true);
                break;
            case 'product11':
                $('#second-nav').find('option').eq(2).prop('selected', true);
                break;
        }
    }



    //두번째 박스 변경하면 페이지 주소가 바뀌게 처리
    $('#second-nav').change(function(){
        //선택된 value값을 담는 변수
        let value = $(this).val();

        //주소표시줄 주소가 변경되게 처리
        //assign(url) : 주소표시줄의 주소를 변경하는 메서드
        location.assign(value);
    });
});


//원화기호, 쉼표처리 자바스크립트
$(document).ready(function(){
    //price마다 모두 줘야해서 each() : 문서객체마다 명령을 각각 처리
    $('.price').each(function(){
        //자신의 텍스트문자열을 담는 변수
        let price = $(this).text(); //text() : 문서객체의 텍스트컨텐츠를 컨트롤하는 메서드

        //특수문자로 쓰는 이유는 글꼴따라서 원화기호를 역슬래시로 처리하기 때문
        let newPrice = '&#8361; ' + price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

        $(this).html(newPrice); //텍스트컨텐츠를 변경
    });
});

//게시판 모두 체크 기능 처리
$(document).ready(function(){
    //모두 체크를 체크하면, tbody의 모든 체크박스 체크, 그렇지 않으면 미체크
    //prop() : 태그의 속성을 컨트롤하는 메서드
    //prop('checked') : 해당 태그의 체크 여부를 true/false로 반환
    //prop('checked',true) : 해당 태그의 체크를 true로 처리
    //prop('checked',false) : 해당 태그의 체크를 false로 처리
    $('.main-contents #all-check').change(function(){ //모두 체크관련의 값이 변경되면
        //모두 체크의 체크상태를 담는 변수
        let chk = $(this).prop('checked');

        if(chk){ //true면 = 체크되었다면
            //메인컨텐츠가 갖은 tbody태그가 가진 input 중 체크박스만 선택
            $('.main-contents tbody input[type="checkbox"]').prop('checked',true);
        }else{ //false면 = 체크가 안되었다면
            $('.main-contents tbody input[type="checkbox"]').prop('checked',false);
        }
    });

    //tbody의 체크박스가 변경된다면
    $('.main-contents tbody input[type="checkbox"]').change(function(){
        //체크박스가 10개인데 일단 개수를 담는 변수 선언
        let chkCount = $('.main-contents tbody input[type="checkbox"]').length;

        //그럼 체크된 것의 개수가 10개가 아니면 올체크가 미체크, 그렇지 않으면 체크
        //각각의 체크박스의 체크된 숫자를 담는 변수 선언
        let count = 0; //현재는 0개
        //each() : 문서객체가 여러 개일 때 각각 처리하는 메서드
        $('.main-contents tbody input[type="checkbox"]').each(function(){
            //각각의 체크된 상태 값을 true/false로 담는 변수
            let chk = $(this).prop('checked');
            if(chk){ //만약에 체크되었다면
                count++; //count변수 값을 1씩 증가
            }
        });

        if(count != chkCount){ //체크된 것이 10개가 아니라면
            $('.main-contents #all-check').prop('checked',false);
        }else{ //그렇지 않다면
            $('.main-contents #all-check').prop('checked',true);
        }
    });
});

//게시판 모두 체크 기능 처리
$(document).ready(function(){
    //모두 체크를 체크하면, tbody의 모든 체크박스 체크, 그렇지 않으면 미체크
    //prop() : 태그의 속성을 컨트롤하는 메서드
    //prop('checked') : 해당 태그의 체크 여부를 true/false로 반환
    //prop('checked',true) : 해당 태그의 체크를 true로 처리
    //prop('checked',false) : 해당 태그의 체크를 false로 처리
    $('.myadmin-contents #all-check').change(function(){ //모두 체크관련의 값이 변경되면

        //모두 체크의 체크상태를 담는 변수
        let chk = $(this).prop('checked');

        if(chk){ //true면 = 체크되었다면
            //메인컨텐츠가 갖은 tbody태그가 가진 input 중 체크박스만 선택
            $('.myadmin-contents tbody input[type="checkbox"]').prop('checked',true);
        }else{ //false면 = 체크가 안되었다면
            $('.myadmin-contents tbody input[type="checkbox"]').prop('checked',false);
        }
    });

    //tbody의 체크박스가 변경된다면
    $('.myadmin-contents tbody input[type="checkbox"]').change(function(){
        //체크박스가 10개인데 일단 개수를 담는 변수 선언
        let chkCount = $('.myadmin-contents tbody input[type="checkbox"]').length;

        //그럼 체크된 것의 개수가 10개가 아니면 올체크가 미체크, 그렇지 않으면 체크
        //각각의 체크박스의 체크된 숫자를 담는 변수 선언
        let count = 0; //현재는 0개
        //each() : 문서객체가 여러 개일 때 각각 처리하는 메서드
        $('.myadmin-contents tbody input[type="checkbox"]').each(function(){
            //각각의 체크된 상태 값을 true/false로 담는 변수
            let chk = $(this).prop('checked');
            if(chk){ //만약에 체크되었다면
                count++; //count변수 값을 1씩 증가
            }
        });

        if(count != chkCount){ //체크된 것이 10개가 아니라면
            $('#all-check').prop('checked',false);
        }else{ //그렇지 않다면
            $('#all-check').prop('checked',true);
        }
    });
});


//제품상세페이지 넘기는 관련 - jsp에서는 없앨것
$(document).ready(function(){
    $('ul.products a').click(function(e){
        e.preventDefault();

        let q = confirm('상세페이지는 백엔드에서 제작할 예정입니다. 한개만 예시로 만들었는데 보시겠습니까?');

        if(q){
            location.href = '/small/toaster_detail.html';
        }
    });
});