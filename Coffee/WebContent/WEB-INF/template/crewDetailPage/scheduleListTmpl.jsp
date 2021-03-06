<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 일별 일정 리스트 템플릿 -->
<!-- 일별 일정 리스트 및 일정 캘린더 템플릿 시작 -->
<script type="text/template" id="dailySchedulesListTmpl">
    <div class="daily_schedule_header">
      <span><@=date@>일 <em><@=day@></em></span>
    </div>
    <ul id="dailySchedulesList">
      <@ _.each(dailySchedules, function(daily){ @>
      <li class="daily_schedule_item">
        <dl>
		<div class="schedule_info">
          <dt class="schedule_title screen_out">일정명</dt>
          <dd><a href=""><@=daily.title@></a></dd>
          <dt class="schedule_time screen_out">시작시간</dt>
          <dd><@=daily.startDateStr@> 시작</dd>
          <@ if(!(daily.participantsTotal==0 && daily.nonParticipantsTotal==0)){ @>
          <dt class="schedule_rsvp screen_out">참여여부</dt>
          <dd>참석 <@=daily.participantsTotal@></dd>
          <dd>불참석 <@=daily.nonParticipantsTotal@></dd>
          <@} else{} @>
		</div>
		<@ if(daily.type=='M'||daily.type=='F'){ @>
        <div class="other_crew_info">
          <dt class="other_crew_img screen_out">밋팅사진</dt>
          <dd><img src="/img/crew/<@=daily.applyCrewImg@>"/></dd>
          <dt class="other_crew screen_out">상대크루</dt>
          <dd><@=daily.applyCrewName@></dd>
          <dt class="saemo_point screen_out">새모포인트</dt>
          <dd><img src="/img/saemoPoint.png" width="20" height="20" /><@=daily.point@></dd>
        </div>
        <@} else{} @>
        </dl>
      </li>
      <@})@>
    </ul>
</script><!--// 일별 일정 리스트 템플릿 끝 -->

<!-- 모든 일정 리스트 템플릿 시작 -->
<script type="text/template" id="allSchedulesListTmpl">
    <@ _.each(allSchedules, function(all){@>
    <li class="all_schedule_item">
      <dl>
        <div class="schedule_info">
          <dt class="schedule_title screen_out">일정명</dt>
          <dd><a href=""><@=all.title@></a></dd>
          <dt class="schedule_time screen_out">시작시간</dt>
          <dd><@=all.startDateStr@> 시작</dd>
          <@ if(!(all.participantsTotal==0 && all.nonParticipantsTotal==0)){ @>
          <dt class="schedule_rsvp screen_out">참여여부</dt>
          <dd>참석 <@=all.participantsTotal@></dd>
          <dd>불참석 <@=all.nonParticipantsTotal@></dd>
          <@} else{} @>
		</div>
        <@ if(all.type=='M'||all.type=='F'){ @>
        <div class="other_crew_info">
          <dt class="other_crew_img screen_out">밋팅사진</dt>
          <dd><img src="/img/crew/<@=all.applyCrewImg@>"/></dd>
          <dt class="other_crew screen_out">상대크루</dt>
          <dd><@=all.applyCrewName@></dd>
          <dt class="saemo_point screen_out">새모포인트</dt>
          <dd><img src="/img/saemoPoint.png" width="20" height="20" /><@=all.point@></dd>
        </div>
        <@} else{} @>
      </dl>
    </li>
    <@})@>
</script><!--// 모든 일정 리스트 템플릿 끝 -->