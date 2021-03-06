
const $popReportedPostWrap = $('.pop_reported_post_wrap');
const $popReportedTmpl = _.template($('#popReportedTmpl').html());
let reportArr = [];
//신고리스트 열기
$memberList.on("click",'.declaration_box span',function(e){
	const $this = $(this);
	const reportedMemNo = $this.parent().next().next().val();
	$('#popMemberListWrap').css('display','none');
	$popReportedPostWrap.toggleClass('on');
	$.ajax({
		url:"/ajax/reportCrewMemberPost.json",
   		type:"post",
		data: {
			"crewMemberNo": reportedMemNo
		}, 
    	error:function(xhr,code,type) {
        	alert("신고 불러오기 오류");
    	},
    	success:function(json) {
			console.log(json);
			$popReportedPostWrap.append($popReportedTmpl({reportPost:json}));
            let firstFlag=false;
            // margin 조정
            $('.crewReportWrap').each(function() {
                const $this = $(this);
                // 첫번째는 보여줌
                if(!firstFlag){
                    $(this).addClass("on_reported_post");
                    firstFlag=true;
                }
                reportArr.push(false);
                const height = $this.height();
                console.log(height);
                $this.css("marginTop",-(height*0.5));
            });
            // margin 조정
            reportArr[0] = true;
		}
	});
	
});
//신고리스트 열기

 // 팝업 닫기
$popReportedPostWrap.on('click','.report_close',function (e) {
     $popReportedPostWrap.toggleClass('on');
     $('#popMemberListWrap').css('display','block');
     let $that = $(this).next().next().next();
     console.log(reportArr.length);
     while(reportArr.length>0){
         let $that = $(this).next().next().next();
         $that.remove();
         reportArr.pop();
     }
 });

 let popReportIdx = 0;
 /*우로 넘기기*/
 $popReportedPostWrap.on('click','.right_icon',function (e) {
     for(let i=0;i<reportArr.length;i++){
         reportArr[i] = false;
     }
     reportArr[++popReportIdx] = true;
     if(popReportIdx==reportArr.length-1){
         $(this).css("display","none");
     }
     if(popReportIdx!=0){
         $leftBtn.css("display","block");
     }
     console.log(popReportIdx);
     reportPopChange(popReportIdx);
 });
 /*우로 넘기기*/

 /*좌로 넘기기*/
 $popReportedPostWrap.on('click','.left_icon',function (e) {
     for(let i=0;i<reportArr.length;i++){
         reportArr[i] = false;
     }
     reportArr[--popReportIdx] = true;
     if(popReportIdx!=reportArr.length-1){
         $rightBtn.css("display","block");
     }
     if(popReportIdx==0){
         $(this).css("display","none");
     }
     console.log(popReportIdx);
     reportPopChange(popReportIdx);
 });
 /*좌로 넘기기*/

 //
 function reportPopChange(popReportIdx){
	 console.log(reportArr);
     for(let i=0;i<reportArr.length;i++){
         if(reportArr[i]){
             $('.crewReportWrap').eq(i).addClass('on_reported_post');
         }else{
             console.log($('.crewPostWrap:nth-child('+i+')'));
             $('.crewReportWrap').eq(i).removeClass('on_reported_post');
         }
     }
 }
