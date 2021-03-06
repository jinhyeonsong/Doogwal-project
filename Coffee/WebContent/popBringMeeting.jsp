<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="inviteWrap" class="invite_wrap"><!-- inviteWrap -->
	<div class="close_btn"><i class="fas fa-times"></i></div>
	<div id="inviteContainer" class="inviteStep1"><!-- inviteContainer -->
	    <form action="/bringMeeting.doo" method="post"><!-- form -->
	        <fieldset>
	            <!--레이아웃은 다 id 선택자로 -->
	            <div class="ongoing_meeting_pop step_box"><!--ongoingMeetingPop start-->
	                <h1>진행중인 밋팅 목록</h1>
	                <div class="ongoing_meeting_box"><!--ongoing_meeting_box start-->
	                    <button class="fas fa-chevron-left"></button>
	                    <button class="fas fa-chevron-right"></button>
	                    <ul class="ongoing_meeting_list"><!-- ongoing_meeting_list -->
	                    
	                    </ul><!-- //ongoing_meeting_list -->
	                </div><!--//ongoing_meeting_box end-->
	            </div><!--//ongoingMeetingPop end-->
	            <div class="point_meeting_pop step_box">
	                <div class="pop_title_box"><!-- pop_title_box start -->
	                    <h1>데려올 때 보낼 세모</h1>
	                </div><!--// pop_title_box end -->
	                <div class="available_points"><!-- available_points start -->
	                    <h2></h2>
	                </div><!--// available_points end-->
	                <div class="spending_points_box"><!-- spending_points_box start-->
	                    <div class="enter_points">
	                        <input class="enter_points_input" name="point" type="number" min="1" />
	                        <!-- 새모 max 값 지정 필요(jsp로 현재 보유 새모 가져올 수 있음)-->
	                    </div>
	                    <ul class="point_options">
	                        <li class="point_option">486</li>
	                        <li class="point_option">1004</li>
	                        <li class="point_option">8282</li>
	                        <li class="point_option">5959</li>
	                        <!-- label이 input을 포함했을 때는 id를 굳이 주지 않아도 됨
	                        <label>부터 </label>까지는 li요소로 변경 input요소x(486, 1004 등
	                        값을 가져오는 기능만 하기때문에 li로, 사용자가 직접 값을 입력하는 기능은x)
	                        <a>요소도 넣고(자바스크립트에서 e.prevent default로 막기)
	                        -->
	                    </ul>
	                    <div class="point_submit_button"><!-- button start -->
	                        <button class="prev_btn" type="button">이전</button>
	                        <button type="submit">데려오기</button>
	                        <input type="hidden" name="bringCrewNo" value="<%=crewNo%>" />
	                    </div><!--// button end -->
	                </div><!--// spending_points_box end-->
	            </div><!--// point_meeting_pop end-->
	        </fieldset>
	    </form><!-- //form -->
	</div><!-- //inviteContainer -->
</div><!-- //inviteWrap -->

