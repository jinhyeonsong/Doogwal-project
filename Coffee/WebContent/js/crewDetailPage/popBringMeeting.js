//진행중인 밋팅을 붙이는 기능
const ongoingMeetingTmpl = _.template($('#ongoingMeetingTmpl').html());
const $ongoingMeetingList = $('.ongoing_meeting_list');
const $inviteWrap = $("#inviteWrap");
const $bringApplicantNobody = $(".meeting_bring>.crew_applicant_nobody");

function bringMeeting(userNo){
	$.ajax({
	    url:"/ajax/ongoingMeetings.json",
	    type : 'POST',
		data: {"userNo": userNo},
	    dataType : "json",
	    error : function(xhr, error, code) {
	        alert("에러:" + code);
	    },
	    success:function(json) {
			if(Object.keys(json).length==0){
	        	$bringApplicantNobody.show();
				setTimeout(function(){
					$bringApplicantNobody.fadeOut();
				},3000);
			}else{
				$inviteWrap.show();
	        	$ongoingMeetingList.html(ongoingMeetingTmpl({ongoingMeetings : json}));
			}
	    }
	});
}

//-------------------------------------------------

//화면 넘기는 기능
let x = 0;
$(".fa-chevron-right").click(function (e){
    e.preventDefault();
    if(x<0){
    }else{
        x = x-564;
        $(".ongoing_meeting_list").css("transform","translate(" + x + "px,0)");
    }
})//rightBtn end
$(".fa-chevron-left").click(function (e){
    e.preventDefault();
    if(x>=0){
    }else{
        x = x+564;
        $(".ongoing_meeting_list").css("transform","translate(" + x + "px,0)");
    }
})//leftBtn end
//-------------------------------------------------

//밋팅 선택 기능
let idx=1;
const $availablePointsMent = $(".available_points>h2");
const $enterPointsInput = $(".enter_points_input");
$(".ongoing_meeting_list").on("change", '.ongoing_meeting_item',function (e) {
	let crewNo = $(this).children("input").eq(1).val();
    $("#inviteContainer").attr("class","inviteStep"+ ++idx);
	$.ajax({
	    url:"/ajax/ongoingPoint.json",
	    type : 'GET',
		data: {"crewNo": crewNo},
	    dataType : "json",
	    error : function(xhr, error, code) {
	        alert("에러:" + code);
	    },
	    success:function(json) {
			$availablePointsMent.text("현재 "+json.point+" 새모 보유 중 입니다.");
			$enterPointsInput.attr("max", json.point);
	    }
	});
});

$('.prev_btn').on("click",function () {
    $("#inviteContainer").attr("class","inviteStep"+ --idx);
})

//보낼 포인트 선택하면 input에 값 입력 시키기기
$(".point_option ").click(function () {
    const point = $(this).text();
    $(".enter_points_input").val(point);
});
//-------------------------------------------------

//밋팅데려오기 닫기
$("html").click(function(e){
 
    if(!($(e.target).parents("#inviteWrap").hasClass("invite_wrap")||$(e.target).hasClass("meeting_bring"))){
        $inviteWrap.hide();
        $("html").css("overflow-y","scroll");
    }else{
        ;
    }
});
$("#inviteWrap>.close_btn").click(function(){
	$inviteWrap.hide();
    $("html").css("overflow-y","scroll");
})
//---------------------------------------------------------------------------