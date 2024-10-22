//리스트 active변경
$(document).ready(function(){
    //store-list가 갖은 a태그를 클릭하면
    //모든 a태그의 active클래스를 제거후(removeClass())
    //클릭한 a태그만 active클래스를 추가(addClass())
    $('.store-list a').click(function(){
        //이렇게 선택하면 모든 a
        $('.store-list a').removeClass('active');

        //클릭한 a만 선택할 때는
        $(this).addClass('active');
    });
});