//메인이미지 슬라이더
$(document).ready(function(){
    //"" 내부에 CSS선택자 써주면 됨
    var swiper = new Swiper("main .swiper", {
        //자동실행
        autoplay: {
            delay: 5000, //5초마다 한번씩 변화
            disableOnInteraction: false,
        },
        //이전다음버튼
        navigation: {
            nextEl: "main .swiper-button-next",
            prevEl: "main .swiper-button-prev",
        },
        loop: true, //무한반복
    });
});

//smeg-special
$(document).ready(function(){
    $('.smeg-special .btn').click(function(){ 
        //모든 .btn의 active클래스 제거 후
        $('.smeg-special .btn').removeClass('active');

        //클릭한 .btn에만 active클래스 추가
        $(this).addClass('active');

        //클릭한 .btn의 부모의 인덱스번호를 담는 변수
        let index = $(this).parent().index();

        //모든 div태그가 안보였다가
        $('.smeg-special .tab-contents > div').stop().fadeOut(500);

        //클릭한 .btn의 부모와 인덱스번호가 같은 div태그만 보이게 처리
        //eq(n) : n번째 문서객체를 선택하는 메서드
        $('.smeg-special .tab-contents > div').eq(index).stop().fadeIn(500);
    });
});

//best-product
$(document).ready(function(){
    var swiper = new Swiper(".best-product .swiper", {
        navigation: {
            nextEl: ".best-product .swiper-button-next",
            prevEl: ".best-product .swiper-button-prev",
        },
        loop: true, //무한루프
        slidesPerView: 'auto', //슬라이드 보여야할 개수, auto를 주면 슬라이드 폭과 창사이즈를 고려해서 맞춰줌
        spaceBetween: 100, //슬라이드 사이 여백
    });
});


//popup
$(document).ready(function(){
    function setCookie(name, value, expiredays){
        
        var todayDate = new Date();
        
        todayDate.setDate(todayDate.getDate() + expiredays);
        
        document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + todayDate.toGMTString() + ';'
    }
    
    $('.popup .today-btn').click(function(e){
        e.preventDefault();

        setCookie('exCookie','done',1);
        $('.popup').stop().fadeOut(0);
    });

    $('.popup .close-btn').click(function(e){
        e.preventDefault();
        $('.popup').stop().fadeOut(0);
    });

    var cookieData = document.cookie;
    
    if(cookieData.indexOf('exCookie=done') < 0){
        $('.popup').fadeIn(0);
        
    }else{
        $('.popup').fadeOut(0);
    }
});