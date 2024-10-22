//서브페이지가 공통으로 사용하는 js문서

//변수 겹치는 현상을 방지하기 위해 준비구문 씀

//서브 선택상자 : 프론트에서 썼던 js는 삭제


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
