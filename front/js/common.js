//header나 footer와 aside에서 사용할 공통 js

//혹시 변수를 중복해서 쓸수도 있어서 준비구문 작성해서 쓸 예정
//밖에 쓰면 전역변수

//검색창 관련 js
$(document).ready(function(){
    //여기에 쓰면 지역변수
    //header의 검색아이콘을 클릭하면 검색창 보이게 처리
    $('header .search-btn').click(function(){
        $('.search-box').fadeIn(200); //fadeIn(시간) : 문서객체를 나타나게 해주는 메서드
    });

    //x버튼 클릭하면 검색창 안보이게 처리
    //fadeOut(시간) : 문서객체를 사라지게 해주는 메서드
    $('.search-box a').click(function(){
        $('.search-box').fadeOut(200);
    });
});

//gnb 관련 js
$(document).ready(function(){
    //gnb-bg : 높이 처리
    let subHeight = 0;

    $('.sub-nav').each(function(){ //서브네비의 높이를 각각 구해서
        let currentHeight = $(this).outerHeight();

        if(currentHeight > subHeight){ //가장 높이가 큰 것으로 처리
            subHeight = currentHeight;
        }
    });

    //가장 높이가 큰 서브네비와 높이를 같게 처리
    $('.gnb-bg').css('height',subHeight);


    //gnb에 마우스를 올리면 하위메뉴와 배경 보이게 처리, header에 active클래스 처리
    //gnb에 마우스를 내리면 하위메뉴와 배경 안보이게 처리, header에 active클래스 제거
    //hover() : mouseenter와 mouseleave이벤트를 번갈아 실행해주는 메서드
    //addClass('클래스명') : 클래스를 추가하는 메서드
    //removeClass('클래스명') : 클래스를 제거하는 메서드

    $('.gnb').hover(function(){
        //마우스엔터시 코드 작성
        //stop() : 움직임이 다 일어날 때까지 또 발생하지 않게 처리해주는 메서드
        //delay(시간) : 움직임을 지연시키는 메서드
        $('.sub-nav, .gnb-bg').stop().slideDown(300);
        $('header').addClass('active');
    },function(){
        //마우스리브시 코드 작성
        $('.sub-nav, .gnb-bg').stop().slideUp(300);
        $('header').removeClass('active');
    });

    //헤더스크롤
    $(window).scroll(function(){ //스크롤바가 움직일 때
        //세로 스크롤바 상단 좌표를 담는 변수
        //scrollTop() : 스크롤바의 상단 좌표를 컨트롤하는 메서드
        let top = $(window).scrollTop();

        if(top > 0){ //스크롤바를 상단에서 움직였을 때
            $('header').addClass('scroll');
        }else{ //좌표가 다시 0이 되면
            $('header').removeClass('scroll');
        }
    });

    //초기실행
    //trigger('이벤트명') : 해당 이벤트 명령을 강제발생
    $(window).trigger('scroll');
});

//스크롤탑버튼 관련 js
$(document).ready(function(){
    $('.scroll-btn').click(function(e){//e이벤트 객체
        e.preventDefault(); //기본이벤트 제거 - a태그 - 페이지 이동을 막음

        //animate() : 객체의 css에 시간차를 줌
        $('html, body').animate({
            scrollTop: 0 //세로 스크롤바 상단좌표를 0으로 1초동안 처리
        },1000);
    });
});


//상단 장바구니 아이콘 - 백에서는 지우고 백단에서 다시 할것
$(document).ready(function(){
    $('.top-nav li:eq(1) a').click(function(e){//e이벤트 객체
        e.preventDefault(); //기본이벤트 제거 - a태그 - 페이지 이동을 막음

        let q = confirm('로그인이 필요한 페이지입니다. 로그인페이지로 이동하시겠습니까?');

        if(q){
            location.href = '/topnav/login.html';
        }
    });
});