//bring meeting 수락창 뜨게 하기
const $bringMeetingRequestWrap = $("#bringMeetingRequestWrap");
const $bringMeetingItem = $(".meeting_apply_item.bring_mark");

const $bringMeetingImg = $(".bring_meeting_information_box>img");
const $bringMeetingCrew = $(".enlarge_bring_meeting_crew");
const $bringMeetingName = $(".enlarge_bring_meeting_name");
const $bringMeetingStartDate = $(".enlarge_bring_meeting_start_date");
const $bringMeetingLocation = $(".enlarge_bring_meeting_location");
const $bringMeetingPoint = $(".income_point_box>span");
const $bringMeetingAppsNo = $(".enlarge_bring_meeting_apps_no");
const $bringMeetingNo = $(".enlarge_bring_meeting_no");
const $bringMeetingCrewNo = $(".enlarge_bring_meeting_crew_no");

$bringMeetingItem.click(function(e){
	if(crewRank=='C' || crewRank=='O'){	
		$bringMeetingImg.attr("src", $(this).find("img").attr("src"));
		$bringMeetingCrew.text($(this).find(".bring_meeting_crew").val());
		$bringMeetingName.text($(this).find(".bring_meeting_name").val());
		$bringMeetingStartDate.text($(this).find(".bring_meetingStart_date").val());
		$bringMeetingLocation.text($(this).find(".bring_meeting_address").val());
		$bringMeetingPoint.text($(this).find(".bring_meeting_introduce").val());
		$bringMeetingAppsNo.val($(this).find(".bring_meeting_apps_no").val());
		$bringMeetingNo.val($(this).find(".bring_meeting_no").val());
		$bringMeetingCrewNo.val($(this).find(".bring_meeting_crew_no").val());
		
		$bringMeetingRequestWrap.show();
		$("html").css("overflow-y","hidden");
		return false;
	}
})
//-----------------------------------------------------------------------

//bring meeting 수락창 닫기
$("html").click(function(e){
    if(!($(e.target).parents("#bringMeetingRequestContainer").hasClass("bring_meeting_request_container")||$(e.target).hasClass("meeting_apply_item"))){
        $bringMeetingRequestWrap.hide();
        $("html").css("overflow-y","scroll");
    }else{
        ;
    }
});
$("#popRegisterWrap>.close_btn").click(function(){
	$bringMeetingRequestWrap.hide();
    $("html").css("overflow-y","scroll");
})
//------------------------------------------------------------------------------

//밋팅 데려오기 수락하기
const $bringMeetingAcceptBtn = $(".bring_meeting_accept_btn");

$bringMeetingAcceptBtn.click(function(){
	if(confirm("수락하시겠습니까??")==true){
		$.ajax({
	        url:"/acceptMeeting.doo",
	        type : 'POST',
	        data : {"meetingAppNo": $bringMeetingAppsNo.val(),
					"meetingNo":  $bringMeetingNo.val(),
					"applyCrewNo": $bringMeetingCrewNo.val()},
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
//-----------------------------------------------------------------

//밋팅 거절하기
const $bringMeetingRejectBtn = $(".bring_meeting_reject_btn");
$bringMeetingRejectBtn.click(function(){
	if(confirm("거절하시겠습니까?")==true){
		$.ajax({
	        url:"/rejectMeeting.doo",
	        type : 'POST',
	        data : {"meetingAppNo": $bringMeetingAppsNo.val()},
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
