//연혁 js
$(document).ready(function(){
    $(window).scroll(function(){ //스크롤바를 이동할 때
        //스크롤바의 상단 좌표를 담는 변수
        let sTop = $(window).scrollTop();

        //각각의 .year-box에 명령을 한번에 처리
        $('.year-box').each(function(){
            //각각의 .year-box의 상단 좌표를 담는 변수
            let top = $(this).offset().top;

            if(sTop > top - 400){ //스크롤바 위치가 year-box의 상단 좌표보다 400만큼 위에 있을 때
                $(this).addClass('active');
                $('.year-text').removeClass('active');
                $(this).find('.year-text').addClass('active');
            }
        });
    });
});