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
        
        //스타일 변경 처리 - 삭제 - 스크롤위치로 알아서 들어가게 처리

        let index = $(this).parent().index();

        let pos = $('.detail-info > div').eq(index).offset().top;

        $('html, body').animate({
            scrollTop: pos
        },900);
    });
    
    //스크롤시 active처리
    $(window).scroll(function(){
    	let winTop = $(window).scrollTop();
    	
    	$('.detail-info > div').each(function(index){
    		let pos = $(this).offset().top;
    		 
    		if(winTop >= pos){
    			$('.detail-nav a').removeClass('active');
    			$('.detail-nav li').eq(index).find('a').addClass('active');
    		}
    	});
    	
    	let firstTop = $('.detail-info > div').first().offset().top;
    	
    	if(winTop < firstTop){
    		$('.detail-nav a').removeClass('active');
    	}
    });
});


//count 개수 처리
$(document).ready(function(){
	// + 버튼 클릭시
	$('.count-box .plus-btn').click(function(){
		let count = $('.count-box .count').text();
		
		if(count >= 10){
			alert('10개 이상 구매할 수 없습니다.');
			return false;
		}
		
		$('.count-box .count').text(++count);
	});
	
	// - 버튼 클릭시
	$('.count-box .minus-btn').click(function(){
		let count = $('.count-box .count').text();
		
		if(count <= 1){
			alert('최소 한개는 구매해야 합니다.');
			return false;
		}
		
		$('.count-box .count').text(--count);
	});
});