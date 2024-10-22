//카테고리 추가 js - input:text에 첨부파일 주소 넣기
$(document).ready(function(){
    $("#category-file").on('change',function(){
        //.split('/').pop().split('\\').pop();는 fakepath가 뜨는 것 방지
        let fileName = $("#category-file").val().split('/').pop().split('\\').pop();
        $("#category-file-text").val(fileName);
    });
    $("#category-file2").on('change',function(){
        //.split('/').pop().split('\\').pop();는 fakepath가 뜨는 것 방지
        let fileName = $("#category-file2").val().split('/').pop().split('\\').pop();
        $("#category-file-text2").val(fileName);
    });
});