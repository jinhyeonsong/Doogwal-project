<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/template" id="ongoingMeetingTmpl">
    <@ _.each(ongoingMeetings,function(o){@>
    <li class="ongoing_meeting_item">
            <input id="meetItem<@=o.seq@>" type="radio" name="meetingNo" value="<@=o.meetingNo@>" />
            <label for="meetItem<@=o.seq@>">
            	<img src="/img/meeting/<@=o.img@>" width="156" height="156"/>
            	<div class="crew_name"><p><@=o.crewName@></p></div>
       		 	<div class="meeting_name"><p><@=o.meetingName@></p></div>
        		<div class="meet_check"><i class="fas fa-check"></i></div>
   			</label>
			<input type="hidden" name="organizeCrewNo" value="<@=o.crewNo@>" />
    </li>
    <@})@>
</script>