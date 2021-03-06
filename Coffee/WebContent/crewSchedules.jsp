<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="calendar_box"><!--calendar_box start 이게 다 감싸는 거임-->
    <ul class="calendar_tab"><!--calendar_tab start-->
      <li><a href="">일정 캘린더</a></li>
      <li><a href="">일정 전체보기</a></li>
    </ul><!--//calendar_tab start-->
    <div class="calendar_wrap"><!--calendar_wrap start-->
      <div class="box_for_full_calendar">
        <div id="calendar"></div><!--일단 템플릿 밖으로 빼봄-->
      </div>
      <div class="daily_schedule_box"><!--daily_schedule_box start-->
          <!--여기에 일별 일정 리스트 탬플릿 붙임-->
      </div><!--//daily_schedule_box end-->
      <ul id="allSchedulesList">
        <!--모든 일정 리스트 템플릿 들어갈자리-->
      </ul>
	</div><!--//calendar_wrap end-->
</div><!--//calendar_box end-->

