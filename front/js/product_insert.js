//연혁 js - input:text에 첨부파일 주소 넣기
$(document).ready(function(){
    $("#product-detail").on('change',function(){
        //.split('/').pop().split('\\').pop();는 fakepath가 뜨는 것 방지
        let fileName = $("#product-detail").val().split('/').pop().split('\\').pop();
        $("#product-detail-file").val(fileName);
    });
    $("#product-slide01").on('change',function(){
        let fileName = $("#product-slide01").val().split('/').pop().split('\\').pop();
        $("#product-slide01-file").val(fileName);
    });
    $("#product-slide02").on('change',function(){
        let fileName = $("#product-slide02").val().split('/').pop().split('\\').pop();
        $("#product-slide02-file").val(fileName);
    });
    $("#product-slide03").on('change',function(){
        let fileName = $("#product-slide02").val().split('/').pop().split('\\').pop();
        $("#product-slide03-file").val(fileName);
    });
});