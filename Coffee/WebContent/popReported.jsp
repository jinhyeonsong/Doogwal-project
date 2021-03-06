<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
 <%@ include file="/WEB-INF/template/link.jsp" %>
    <link rel="stylesheet" href="css/crewDetailPost.css" />
    <link rel="stylesheet" href="css/reportedPost.css" />
</head>
<body>
<%@ include file="/WEB-INF/template/header.jsp" %>
<%
	//http://localhost/popReported.jsp?crewOrder=0
	String crewOrderStr = request.getParameter("crewOrder");
	int crewOrder = Integer.parseInt(crewOrderStr); 
	int crewNo = userCrews[crewOrder].getCrewNo(); 
	int crewMemberNo = userCrews[crewOrder].getNo();	
%>
<button class="test">버튼</button>
<div class="pop_reported_post_wrap"><!--popReportedPostWrap-->
    <div class="report_close report_icon"><i class="fas fa-times"></i></div>
    <div class="right_icon report_icon"><i class="fas fa-chevron-right"></i></div>
    <div class="left_icon report_icon"><i class="fas fa-chevron-left"></i></div>
</div>
<%@ include file="/WEB-INF/template/footer.jsp" %>
<script type="text/template" id="popReportedTmpl">
    <@ _.each(reportPost,function(c){@>
    <div class="crewPostWrap"><!--crewPostWrap-->
        <div class="postingUserInformationContainer"><!--postingUserInformationContainer-->
            <!-- -----------------------postUserInfo------------------------------ -->
            <div class="posting_user_profile"><img src="<@=c.userMember.profile @>" /></div>
            <span class="posting_user_name"><@=c.userMember.name @></span>
            <span class="posting_date"><@= moment(c.regdate).format("YYYY년 MM월 DD일 HH:mm:ss")@></span>
            <!-- -----------------------postUserInfo------------------------------ -->
        </div><!--//postingUserInformationContainer-->
        <div class="postingContentsContainer"><!--postingContentsContainer-->
            <p class="posting_text"><@=c.contents@></p>
        </div><!--//postingContentsContainer-->
        <div class="reportReasonContainer"><!--commentContainer-->
            <div class="report_title_box"><span>신고내용</span></div>
            <ul class="report_reason_list"><!--commented_list-->
                <@ _.each(c.report,function(r){@>
                <li class="report_reason_item"><!--report_reason_item-->
                    <span class="reporting_date"><@=r.regdate@></span>
                    <span class="reporting_reason"><@=r.type @></span>
                    <div class="reporting_user_profile"><img src="<@=r.profileImg @>" /></div>
                </li><!--//report_reason_item-->
                <@})@>
            </ul><!--//commented_list-->
        </div><!--//commentContainer-->
        <!--//crewPostWrap--></div>
    <@})@>
</script>
<script src="js/jquery.js"></script>
<script src="js/underscore-min.js"></script>
<script src="js/moment-with-locales.js"></script>
<script>
    _.templateSettings = {interpolate: /\<\@\=(.+?)\@\>/gim,evaluate: /\<\@([\s\S]+?)\@\>/gim,escape: /\<\@\-(.+?)\@\>/gim};
   const $popReportedPostWrap = $('.pop_reported_post_wrap');
   const $popReportedTmpl = _.template($('#popReportedTmpl').html());
   const $test = $('.test');

   let reportArr = [];
   // 팝업 열기
   $test.on('click',function (e) {
        $popReportedPostWrap.toggleClass('on');
        $.ajax({
           url:"/ajax/reportCrewMemberPost.json",
           type:'get',
           dataType:'json',
           data:{
        	   crewMemberNo:1000
           },
           error : function(xhr, error, code) {
                alert("에러:" + code);
           },
           success:function (json){
               $popReportedPostWrap.append($popReportedTmpl({reportPost:json}));
               let firstFlag=false;
               // margin 조정
               $('.crewPostWrap').each(function() {
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
    })

    // 팝업 닫기
    $popReportedPostWrap.on('click','.report_close',function (e) {
        $popReportedPostWrap.toggleClass('on');
        let $that = $(this).next().next().next();
        console.log(reportArr.length);
        while(reportArr.length>0){
            let $that = $(this).next().next().next();
            $that.remove();
            reportArr.pop();
        }
    });

    const $rightBtn = $(".right_icon");
    const $leftBtn = $(".left_icon");
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
        reportPopChange(popReportIdx);
    });
    /*좌로 넘기기*/

    //
    function reportPopChange(popReportIdx){
        for(let i=0;i<reportArr.length;i++){
            if(reportArr[i]){
                $('.crewPostWrap').eq(i).addClass('on_reported_post');
            }else{
                console.log($('.crewPostWrap:nth-child('+i+')'));
                $('.crewPostWrap').eq(i).removeClass('on_reported_post');
            }
        }
    }

</script>
</body>
</html>