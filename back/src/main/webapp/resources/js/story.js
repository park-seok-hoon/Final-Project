//story
$(document).ready(function(){
    //초기실행에 안보이게 처리
    $('.story-tab .tab-contents > div').fadeOut(0);
    $('.story-tab .tab-contents > div').first().fadeIn(0);

    $('.story-tab a').click(function(e){ //e는 이벤트 객체
        //임시링크 #줘서 클릭할 때마다 위로 올라가는 현상을 방지
        e.preventDefault(); //기본이벤트 제거

        //모든 a태그의 active클래스 제거 후
        $('.story-tab a').removeClass('active');

        //클릭한 a태그에만 active클래스 추가
        $(this).addClass('active');

        //클릭한 a태그의 부모의 인덱스번호를 담는 변수
        let index = $(this).parent().index();

        //모든 div태그가 안보였다가
        $('.story-tab  .tab-contents > div').fadeOut(0);

        //클릭한 a태그의 부모와 인덱스번호가 같은 div태그만 보이게 처리
        //eq(n) : n번째 문서객체를 선택하는 메서드
        $('.story-tab  .tab-contents > div').eq(index).fadeIn(0);
    });
});