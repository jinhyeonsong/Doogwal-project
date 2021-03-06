//템플릿 가져다 붙이기
const $meetingRequestList = $('.meeting_request_list');
const meetingRequestTmpl = _.template($("#meetingRequestTmpl").html());

$.ajax({
    url:"/ajax/meetingRequestList.json",
    type : 'POST',
	data: {"crewNo": crewNo},
    dataType : "json",
    error : function(xhr, error, code) {
        alert("에러:" + code);
    },
    success:function(json) {

        $meetingRequestList.html(meetingRequestTmpl({crews : json}));
		const $countDownTimer = $(".countdown_timer");
        tikTokTime(json, $countDownTimer);
    }
});
//---------------------------------------------------------------------------

//밋팅대기자 목록 열기, 닫기
const $popMeetingRequestWrap = $("#popMeetingRequestWrap");
const $meetingWatingListBtn = $(".meeting_wating_list_btn");
const $meetingApplicantNobody = $(".meeting_wating_list_btn").siblings(".crew_applicant_nobody");

$meetingWatingListBtn.click(function(){
	
	if($meetingRequestList.children().length==0){
		$meetingApplicantNobody.show();
		setTimeout(function(){
			$meetingApplicantNobody.fadeOut();
		},3000);
	}else{
		$popMeetingRequestWrap.show();
		$("html").css("overflow-y","hidden");
	}
});

$("html").click(function(e){

    if(!($(e.target).parents("#popMeetingRequestWrap").hasClass("pop_meeting_request_wrap")||$(e.target).hasClass("meeting_wating_list_btn"))){
        $popMeetingRequestWrap.hide();
        $("html").css("overflow-y","scroll");
    }else{
        ;
    }
});

$("#popMeetingRequestWrap>.close_btn").click(function(){
	$popMeetingRequestWrap.hide();
    $("html").css("overflow-y","scroll");
})
//---------------------------------------------------------------------------

//밋팅 수락하기
$meetingRequestList.on("click",".accept_btn",function(){
	if(confirm("수락하시겠습니까??")==true){
		$.ajax({
	        url:"/acceptMeeting.doo",
	        type : 'POST',
	        data : {"meetingAppNo": $(this).parents(".meeting_request_item").children("input").eq(0).val(),
					"meetingNo":  $(this).parents(".meeting_request_item").children("input").eq(1).val(),
					"applyCrewNo":  $(this).parents(".meeting_request_item").children("input").eq(2).val()},
	        error : function(xhr, error, code) {
	            alert("에러:" + code);
	        },
	        success:function() {
	            alert("완료되었습니다.")
				location.reload();
	        }
	    });
	}
});
//---------------------------------------------------------------------------

//밋팅 거절하기
$meetingRequestList.on("click",".decline_btn",function(){
	if(confirm("거절하시겠습니까?")==true){
		$.ajax({
	        url:"/rejectMeeting.doo",
	        type : 'POST',
	        data : {"meetingAppNo": $(this).parents(".meeting_request_item").children("input").eq(0).val()},
	        error : function(xhr, error, code) {
	            alert("에러:" + code);
	        },
	        success:function() {
	            alert("완료되었습니다.")
				location.reload();
	        }
	    });
	}
});
//---------------------------------------------------------------------------
