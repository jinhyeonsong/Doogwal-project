<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/template" id="meetingRequestTmpl">
    <@ _.each(crews,function(c){@>
    <li class="meeting_request_item">
        <div class="crew_profile"><!--crew_profile start-->
           	<a href=""><img class="crew_img" src="/img/crew/<@=c.crewCoverImg@>">
            <p class="crew_name"><@= c.crewName@></p></a>
       	</div><!--// crew_profile end -->
       	<div class="meeting_request_detail"><!--meeting_request_detail start -->
            <p class="meeting_name"><a href=""><@= c.meetingName@></a></p>
           	<p class="saemo_short_intro">"<@=c.introduce@>"</p>
           	<p class="meeting_date">시작 날짜: <@=moment(c.startDate).format("YYYY년 MM월 DD일")@></p>
           	<p>수락까지 남은 시간 <span class="countdown_timer"></span></p>
     		</div><!--// meeting_request_detail end -->
       	<div class="btn_box"><!--btn_box start -->
       	   	<button class="accept_btn">수락</button>
        	<button class="decline_btn">거절</button>
        </div><!--// btn_box end -->
		<input type="hidden" name="waitingMeetingAppNo" value="<@=c.no@>" />
		<input type="hidden" name="meetingNo" value="<@=c.meetingNo@>" />	
		<input type="hidden" name="applyCrewNo" value="<@=c.applyCrewNo@>" />
    </li>
    <@})@>
</script>