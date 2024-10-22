//카테고리 추가 js - input:text에 첨부파일 주소 넣기
$(document).ready(function(){
    $(document).on('change','[name="category_file_update"]',function(){
        //.split('/').pop().split('\\').pop();는 fakepath가 뜨는 것 방지
        let fileName = $(this).val().split('/').pop().split('\\').pop();
        $(this).prev().val(fileName);
    });
    $("#category-file-insert").on('change',function(){
        //.split('/').pop().split('\\').pop();는 fakepath가 뜨는 것 방지
        let fileName = $("#category-file-insert").val().split('/').pop().split('\\').pop();
        $("#category-file-text-insert").val(fileName);
    });
});