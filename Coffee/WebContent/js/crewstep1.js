const $li1 = $( '.category_item:nth-child(3n+1)' );
const $li2 = $( '.category_item:nth-child(3n+2)' );
const $li3 = $( '.category_item:nth-child(3n)' );
/*step1 start*/
$li1.hover(function (e) {
    //this라는 키워드가 있음 : 그 요소
    // this는 순수 자바스크립트 요소 객체 (jQuery 객체가 아님)
    // 순수 자바스크립트객체 => jquery객체로 변경
    // HOW? $(this)
    //hover 취소
    if($(this).children().eq(0).hasClass("on")){
        // on 클래스 제거
        $(this).children().eq(0).removeClass("on");

        $(this).css({
            "height":"110px"
        });
        $(this).next().next().css({
            "height":"110px"
        });
        $(this).next().css({
            "height":"110px"
        });
        $(this).children().eq(2).css({
            "height":"0"
        });
    }
    //hover 선택
    else{
        // 클릭한 요소의 on 클래스 추가
        $(this).children().eq(0).addClass("on");
        let len = $(this).children().next().next().children().next().children().length;
        let add=0;
        if(len>5) {
          add+=30;
        }
        console.log(add+130);
        $(this).css({
            "height": add+130+"px"
        });
        $(this).next().next().css({
            "height": add+130+"px"
        });
        $(this).next().css({
            "height": add+130+"px"
        });
        $(this).children().eq(2).css({
            "height": "100px"
        });
    }
});//#$li1.hover() end

$li2.hover(function (e) {
    //this라는 키워드가 있음 : 그 요소
    // this는 순수 자바스크립트 요소 객체 (jQuery 객체가 아님)
    // 순수 자바스크립트객체 => jquery객체로 변경
    // HOW? $(this)
    //hover 취소
    // console.log($(this).children().index());

    if($(this).children().eq(0).hasClass("on")){
        // on 클래스 제거
        $(this).children().eq(0).removeClass("on");
        $(this).css({
            "height":"110px"
        });
        $(this).next().css({
            "height":"110px"
        });
        $(this).before().css({
            "height":"110px"
        });
        $(this).children().eq(2).css({
            "height":"0"
        });
        $('.category_detail_box').removeClass('move_center');
    }
    //hover 선택
    else{
        // 클릭한 요소의 on 클래스 추가
        $(this).children().eq(0).addClass("on");
        let len = $(this).children().next().next().children().next().children().length;
        let add=0;
        if(len>5) {
            add+=30;
        }
        console.log(add+130);
        $(this).css({
            "height": add+130+"px"
        });
        $(this).next().css({
            "height": add+130+"px"
        });
        $(this).before().css({
            "height": add+130+"px"
        });
        $(this).children().eq(2).css({
            "height":"100px"
        });

        $('.category_detail_box').addClass('move_center');

    }
});//#$li2.hover() end

$li3.hover(function (e) {
    //this라는 키워드가 있음 : 그 요소
    // this는 순수 자바스크립트 요소 객체 (jQuery 객체가 아님)
    // 순수 자바스크립트객체 => jquery객체로 변경
    // HOW? $(this)
    //hover 취소
    // console.log($(this).children().index());

    if($(this).children().eq(0).hasClass("on")){
        // on 클래스 제거
        $(this).children().eq(0).removeClass("on");
        $(this).css({
            "height":"110px"
        });
        $(this).before().before().css({
            "height":"110px"
        });
        $(this).before().css({
            "height":"110px"
        });
        $(this).children().eq(2).css({
            "height":"0"
        });
        $('.category_detail_box').removeClass('move_right');
    }
    //hover 선택
    else{
        // 클릭한 요소의 on 클래스 추가
        $(this).children().eq(0).addClass("on");
        let len = $(this).children().next().next().children().next().children().length;
        let add=0;
        if(len>5) {
            add+=30;
        }
        $(this).css({
            "height": add+130+"px"
        });
        $(this).before().before().css({
            "height": add+130+"px"
        });
        $(this).before().css({
            "height": add+130+"px"
        });
        $(this).children().eq(2).css({
            "height": add+130+"px"
        });
        $('.category_detail_box').addClass('move_right');
    }
});//#$li3.hover() end
/*step1 end*/

//step2로 넘어감과 동시에 카테고리 값을 step2에 넘김
$(".category_detail_item").change(function(e){

    const val = $('.category_detail_item input[type="radio"]:checked').val();
    if(val>=1 &&val<=3){
        categoryPath="게임";
    }else if(val>=4 && val<=7){
        categoryPath="아웃도어여행"
    }else if(val==8){
        categoryPath="반려동물"
    }else if(val==9){
        categoryPath="봉사활동"
    }else if(val==10){
        categoryPath="사교모임"
    }else if(val>=11 && val<=13){
        categoryPath="스터디"
    }else if(val >=14 && val<=23){
        categoryPath="운동스포츠"
    }else if(val>=24 && val<=29){
        categoryPath="취미"
    }else{
        categoryPath="문화예술"
    }
    // src="img/category1.jpg"
    $crewImageSelectedImg.attr("src","img/"+categoryPath+"/1.jpg");
    $('.crew_image_item img').each(function (index,item) {
        $(this).attr("src","img/"+categoryPath+"/"+(index+1)+".jpg");
        $(this).attr("data-src","img/"+categoryPath+"/"+(index+1)+".jpg");
    })
    changeStep();
});

