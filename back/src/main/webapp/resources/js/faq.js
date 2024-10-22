//faq slide
$(document).ready(function(){
    //초기실행에서 $('.faq-a')에서 안보이게 처리
    $('.faq-a').slideUp(0);

    //faq-q를 클릭하면 active클래스 처리와 slideDown처리
    $('.q-title').click(function(){
        //hasClass() : 해당 클래스를 갖고 있다면 true, 안갖고 있다면 false를 반환

        let has = $(this).parent().hasClass('active');

        if(has){ //active클래스를 갖고 있다면
            $(this).parent().removeClass('active'); 
            $(this).parent().next().stop().slideUp(300);
        }else{ //active클래스를 갖고 있지 않다면
            $('.faq-q').removeClass('active'); //열려 있던 것을 제거하기 위해 모두 제거
            $('.faq-a').stop().slideUp(300);

            //클릭한 것만 처리
            $(this).parent().addClass('active');
            $(this).parent().next().stop().slideDown(300);
        }

    });
});