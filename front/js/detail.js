//detail slider
$(document).ready(function(){
    var swiper = new Swiper(".slide-wrap .swiper", {
        pagination: {
            el: ".slide-wrap .swiper-pagination",
            clickable: true,
        },
    });
});

//detail-nav
$(document).ready(function(){
    $('.detail-nav a').click(function(e){
        e.preventDefault();

        let index = $(this).parent().index();

        let pos = $('.detail-info > div').eq(index).offset().top;

        $('html, body').animate({
            scrollTop: pos
        },900);
    });
});