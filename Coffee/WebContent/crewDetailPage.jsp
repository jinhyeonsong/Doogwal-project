<%@page import="com.doogwal.coffee.vo.MeetingWeApplied"%>
<%@page import="com.doogwal.coffee.vo.PageVO"%>
<%@page import="com.doogwal.coffee.vo.Post"%>
<%@page import="com.doogwal.coffee.dao.PostsDAO"%>
<%@page import="com.doogwal.coffee.dao.MeetAppsDAO"%>
<%@page import="com.doogwal.coffee.dao.BoardsDAO"%>
<%@page import="com.doogwal.coffee.vo.Board"%>
<%@page import="com.doogwal.coffee.dao.QuestionsDAO"%>
<%@page import="com.doogwal.coffee.vo.Question"%>
<%@page import="com.doogwal.coffee.vo.CrewMember"%>
<%@page import="java.util.List"%>
<%@page import="com.doogwal.coffee.dao.AttendancesDAO"%>
<%@page import="com.doogwal.coffee.vo.Attendance"%>
<%@page import="com.doogwal.coffee.vo.Gathering"%>
<%@page import="com.doogwal.coffee.dao.SchedulesDAO"%>
<%@page import="com.doogwal.coffee.dao.MeetingsDAO"%>
<%@page import="com.doogwal.coffee.vo.Meeting"%>
<%@page import="com.doogwal.coffee.dao.CrewsDAO"%>
<%@page import="com.doogwal.coffee.vo.Crew"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="icon" href="/img/favicon.png" />
    <%@ include file="/WEB-INF/template/link.jsp" %>
    <!-- 박형우 디테일 관련 css -->
    <link rel="stylesheet" href="/css/crewDetailPage/crewDetailPage.css" />
    <link rel="stylesheet" href="/css/crewDetailPage/crewDetailPost.css" />
    <link rel="stylesheet" href="/css/crewDetailPage/popSaemoHistory.css" />
    <link rel="stylesheet" href="/css/crewDetailPage/popCrewSignUp.css" />
    <link rel="stylesheet" href="/css/crewDetailPage/popBringMeeting.css" />
    <link rel="stylesheet" href="/css/crewDetailPage/popCrewMemberList.css" />
    <link rel="stylesheet" href="/css/crewDetailPage/popMeetingMakingForm.css" />
	<link rel="stylesheet" href="/css/crewDetailPage/popMeetingRequestList.css" />
	<link rel="stylesheet" href="/css/crewDetailPage/popBringMeetingRequestForm.css" />
    
	<!-- //박형우 디테일 관련 css -->
	
	<!-- 주성호 포스트 관련 css -->
	<link rel="stylesheet" href="/css/crewDetailPage/crewDetailPost.css" />
    <link rel="stylesheet" href="/css/quill.core.css" />
    <link rel="stylesheet" href="/css/quill.snow.css"/>
    <link rel="stylesheet" href="/css/crewDetailPage/popWritePost.css" />
    <link rel="stylesheet" href="/css/crewDetailPage/popReport.css" />
    <link rel="stylesheet" href="/css/crewDetailPage/enlargePost(image).css"/>
    <link rel="stylesheet" href="/css/crewDetailPage/reportedPost.css" />
    <!-- 주성호 포스트 관련 css -->
    
    <!-- 정진하 일정 관련 css -->
    <link rel="stylesheet" href="/css/crewDetailPage/calendar.css" />
    <link rel="stylesheet" href="/css/crewDetailPage/crewDetailSchedule.css" />
    <!-- //정진하 일정 관련 css -->
	
	<link rel="stylesheet" href="/css/tui-date-picker.min.css"/>
    <link rel="stylesheet" href="/css/tui-time-picker.min.css"/>
<style>
	html{
		width:100%;
		height:100%;
		background-color: #EEF0F3;
	}
	body{
		width:100%;
		height:100%;
	}
	#container{
		height:100%;
	}	
    #header{
        position: fixed;
        z-index: 10;
    }
     /* 바디에 스크롤 막는 방법 */    
	.not_scroll{
	    position: fixed;
	    overflow: hidden;
	    width: 100%;
	    height: 100%
	}
	.appear{
		display:block;
	}
</style>
</head>
<body>
<%@ include file="/WEB-INF/template/header.jsp" %>
<%
	//크루 컬럼을 다 가진 crew객체 생성
	int crewNo = Integer.parseInt(request.getParameter("crewNo"));
	Crew crew = CrewsDAO.selectCrewAllInformation(crewNo);
	
	//upcomming event에 쓸 객체 생성
	Meeting upcommingMeeting = SchedulesDAO.selectUpcommingMeeting(crewNo);
	Gathering upcommingGathering = SchedulesDAO.selectUpcommingGathring(crewNo);
	
	//가입 조건을 기술할 객체 생성
	List<Question> joinConditions = QuestionsDAO.selectJoinConditions(crewNo);
	
	//크루 게시판을 가져오는 객체 생성
	List<Board> boards = BoardsDAO.selectBoards(crewNo);

	//우리가 신청한 밋팅 가져오는 객체 생성
	List<MeetingWeApplied> weApplyMeetings = MeetAppsDAO.weApplymeetingList(crewNo);
	
	//해당 크루 전체글의 상위 고정 게시글을 가져오는 객체 생성
	List<Post> precedenceFixingPosts = PostsDAO.selectTopContents(boards.get(0).getNo());
	
	//현재 방문한 크루의 크루원인지 판단하고 맞다면 크루원으로써의 정보 객체 생성
	CrewMember myMemberInCrew;
	// -1로 초기화 해야함. postTmpl.jsp / detailPostsTmpl.jsp와 연결
	int crewOrder=-1;
	int crewMemberNo;
	try{
		crewOrder = Integer.parseInt(request.getParameter("crewOrder"));
		myMemberInCrew = userCrews[crewOrder];
		crewMemberNo = myMemberInCrew.getNo(); 
	}catch(Exception e){
		crewOrder = -1;
		myMemberInCrew = null;
		crewMemberNo = -1;
	}
	
	//외부 사용자가 운영진급이 되는지 확인하는 플래그
	int somewhereCaptainFalg = 0;
	for(CrewMember cm : userCrews){
		if(cm==null){;}
		else if(cm.getRole()!='M'){somewhereCaptainFalg=1;}
	}
	
	//시작 보드는 무조건 전체글일테니, 그 번호 저장
	int boardNo = boards.get(0).getNo();
	
	/*페이지 처리 start*/
	//현재 페이지 번호
	int pageNo = 1;
	
	//한 페이지에 보여지는 게시물수 
	int numPage = 2;
	
	PageVO pageVO = new PageVO(pageNo,numPage,crewNo);
	/*페이지 처리 end*/
%>
<%@ include file="/popSaemoHistory.jsp" %>
<%@ include file="/popCrewSignUp.jsp" %>
<%@ include file="/popSaemoHistory.jsp" %>
<%@ include file="/popBringMeeting.jsp" %>
<%@ include file="/popCrewMemberList.jsp" %>
<%@ include file="/popMeetingMakingForm.jsp" %>
<%@ include file="/popMeetingRequestList.jsp" %>
<%@ include file="/popBringMeetingRequestForm.jsp" %>

    <div id="boardPlusContainer" class="board_plus_container"><!--boardPlusContainer-->
    	<div class="close_btn"><i class="fas fa-times"></i></div>
        <div class="board_plus_title_box"><!--board_plus_title_box-->
            <div class="board_plus_title"><!--board_plus_title-->
                <span>게시판 추가하기</span><span class="board_number"></span>
            </div><!--//board_plus_title-->
        </div><!--//board_plus_title_box-->
        <div class="board_plus_contents_box"><!--board_plus_contents_box-->
            <div class="board_plus_contents"><!--board_plus_contents-->
                <form action="/plusBoard.doo" method="post">
                    <span>이름 :</span><input id="boardName" name="boardName" placeholder="최대 5자" maxlength="5"/>
                    <input type="hidden" name="crewNo" value="<%=crewNo %>" />
                    <button>추가</button>
                </form>
            </div><!--//board_plus_contents-->
        </div><!--//board_plus_contents_box-->
    </div><!--//boardPlusContainer-->
    <div id="crewDetailHeader"><!-- crewDetailHeader -->
        <div class="crew_detail_header_box"><!--crew_detail_header_box-->
            <div class="crew_detail_board_box"><!-- crew_detail_box -->
                <ul class="crew_detail_board_list"><!-- crew_detail_list -->
                	<%int boardSeq = 0; %>
                	<%for(Board board : boards){ %>
                		<%if(++boardSeq!=2){ %>
                		<li class="crew_detail_board_item <%if(boardSeq>2){%>new_board<%}%>"><input id="boardItem<%=boardSeq %>" name="boardItem" type="radio" value="<%=board.getNo()%>" seqen="<%=boardSeq %>"
                		onclick="changePrecedencePost(this.value); getPost(this.value); changeBoard(this.id);" <%if(boardSeq==1){%>checked="true"<%} %>/>
                		<%}else{ %>
                		<li class="crew_detail_board_item"><input id="boardItem<%=boardSeq %>" name="boardItem" type="radio" value="<%=board.getNo()%>" 
                		onclick="ScheduleFormOpen(); changeBoard(this.id);" />
                		<%} %>
                	<label for="boardItem<%=boardSeq %>"><%=board.getName() %></label></li>        
                    <%} %>        
                    <%if(myMemberInCrew!=null && myMemberInCrew.getRole()!='M'){ %>
                    <li class="crew_detail_board_item board_adding">+</li>                   
                    <%} %>
                </ul><!-- //crew_detail_list -->
            </div><!-- //crew_detail_box -->
            <%if(myMemberInCrew!=null && myMemberInCrew.getRole()!='M'){ %>
            <div class="crew_operator_function_box"><!-- crew_operator_function_box -->
                <ul class="crew_operator_function_list"><!-- crew_operator_function_list -->
                    <li class="crew_operator_function_item"><button class="make_gathring_btn" onclick="location.href='gatheringRegisterForm.jsp?no=<%=crewNo%>'">모임만들기</button></li><!--
                    --><li class="crew_operator_function_item"><button class="make_meeting_btn">밋팅만들기</button></li><!--
                    --><li class="crew_operator_function_item"><button class="meeting_wating_list_btn">밋팅대기자목록</button><span class="crew_applicant_nobody"><i class="far fa-grin-beam-sweat"></i>에구구 신청자가 없네여....</span></li><!--
                    --><li class="crew_operator_function_item"><button class="registe_wating_list_btn">가입대기자목록</button><span class="crew_applicant_nobody"><i class="far fa-grin-beam-sweat"></i>에구구 신청자가 없네여....</span></li>
                </ul><!-- //crew_operator_function_list -->
            </div><!-- //crew_operator_function_box -->
            <%} %>
        </div><!--//crew_detail_header_box-->
    </div><!-- //crewDetailHeader -->
    <div id="crewDetailContainerWrap"><!--crewDetailContainerWrap-->
        <div id="crewDetailContainer"><!--crewDetailContainer-->
            <div id="crewInformationSideBar"><!-- crew_information_side_bar -->
                <div class="crew_information_box"><!-- crew_information_box -->
                    <img src="/img/crew/<%=crew.getCoverImg() %>" />
                    <div class="crew_name_box">
                        <span class="crew_name"><%=crew.getName() %></span>
                        <span class="crew_member_number">(크루원 <%=crew.getCurPop() %>명)</span>
                    </div>
                    <span class="crew_introduction"><%=crew.getIntro() %></span>
                </div><!-- //crew_information_box -->              
                <div class="meeting_information_box"><!-- meeting_information -->
               		<%if(myMemberInCrew==null && somewhereCaptainFalg==1){ %>
                    <a href="javascript: void(0)" class="meeting_bring" onclick="bringMeeting(<%=loginUser.getNo()%>)"><i class="far fa-grin-tongue-squint"></i>밋팅 데려오기<span class="crew_applicant_nobody"><i class="far fa-grin-beam-sweat"></i>진행중인 밋팅이 없는뎅....</span></a>
                    <%} %>
                    <a href="" class="meeting_history"><i class="fas fa-history"></i>밋팅 히스토리</a>
                </div><!-- //meeting_information -->               
                <div class="crew_sex_ratio_box"><!-- crew_sex_ratio_box -->
                    <div class="sex_ratio_male_image_box" data-male-number="<%=(int)crew.getGenderRate()%>"><!--sex_ratio_male_image_box-->
                        <img src="/img/sexRatioImgMale.png" width="260" height="260" />
                    </div><!--//sex_ratio_male_image_box-->
                    <div class="sex_ratio_female_image_box" data-female-number="<%=(int)(crew.getCurPop()-crew.getGenderRate())%>"><!--sex_ratio_female_image_box-->
                        <img src="/img/sexRatioImgFemale.png" width="260" height="260" />
                    </div><!--//sex_ratio_female_image_box-->
                </div><!-- //crew_sex_ratio_box -->
                <div class="saemo_point_box"><!-- seamo_point_box -->
                    <img src="/img/saemoPoint.png" width="40" height="40" />
                    <p class="saemo_point"><%=crew.getPoint() %></p>
                </div><!-- //seamo_point_box -->
            </div><!--//crewInformationSideBar-->
            <div id="crewPostContainer"><!--crewPostContainer-->
                <div id="fixedPostContainer"><!--fixedPostContainer-->
                    <div class="crew_upcomming_event_box"><!--crew_upcomming_event_box-->
                    	<%if(upcommingMeeting==null&&upcommingGathering==null){ %>
                        <span class="upcomming_event_name">아무 스케쥴도 없습니다</span>
                        <%}else if(upcommingGathering==null){ %>
                        <span class="upcomming_event_name"><%=upcommingMeeting.getName() %></span>
                        <span class="upcomming_event_spot"><%=upcommingMeeting.getAddress() %> / <%=upcommingMeeting.getStartDate() %></span>
                        <%}else{ 
                        	int attendanceCount = AttendancesDAO.selectYAttendanceCount(upcommingGathering.getNo()); 
                        	List<CrewMember> attendanceYCrewMembers = AttendancesDAO.selectYAttendanceList(upcommingGathering.getNo());
                        %>
                        <span class="upcomming_event_name"><a href="/gathering.jsp?no=<%=upcommingGathering.getNo()%>"><%=upcommingGathering.getName() %></a></span>
                        <span class="upcomming_event_spot"><%=upcommingGathering.getAddress() %> / <%=upcommingGathering.getStartDate() %></span>
                        <span class="upcomming_event_participants"><%=attendanceCount%>명 참여 중</span>
                        <!-- width: 4+33*n , height: 35*n 이와 같이 계산해서 .upcomming_event_participants_list_box 스타일에 적어주어야 한다. -->
                        <div class="upcomming_event_participants_list_box" style="width: 
                        <%if(attendanceCount>6){%><%=202%><%}else{%><%=4+attendanceCount*33%><%}%>px; height: <%=35+(attendanceCount/6)*35%>px"><!--upcomming_event_participants_list_box-->
                            <ul class="upcomming_event_participants_list"><!--upcomming_event_participants_list-->
                            	<%for(CrewMember yCrewMember : attendanceYCrewMembers){ %>
                            	<li><img src="img/profile/<%=yCrewMember.getProfileImg() %>" width="30px" height="30px"></li>
                            	<%} %>
                            </ul><!--//upcomming_event_participants_list-->
                        </div><!--//upcomming_event_participants_list_box-->
                        <%} %>
                    </div><!--//crew_upcomming_event_box-->
                    <%if(myMemberInCrew==null){ %>
                    <div class="crew_qualification_condition_box"><!--crew_qualification_condition_box-->
                        <div class="crew_qualification_condition_title"><span>가입 조건</span></div>
                        <div class="condition_box"><!--condition_box-->
                            <ol class="condition_list"><!--condition_list-->
                            	<%int conditionSeq = 0; %>
                            	<%for(Question condition : joinConditions){ %>
                            	<li><%=++conditionSeq+condition.getQuest() %></li>
                            	<%} %>                               
                            </ol><!--//condition_list-->
                            <div class="view_more">...더 보기</div>
                            <div class="crew_join"><a href="/userAnswer.jsp?crewNo=<%=crewNo%>">크루 가입하기</a></div>
                        </div><!--//condition_box-->
                    </div><!--crew_qualification_condition_box-->
                    <%} %>
                    <div class="precedence_fixing_post_box"><!--precedence_fixing_post_box-->
                        <ul class="precedence_fixing_post_list"><!-- precedence_fixing_post_list -->
                          	<%for(Post precedenceFixingPost : precedenceFixingPosts){ %>
	                       	<li class="precedence_fixing_post_item">
						    	<div class="precedence_fixing_post_before_icon"><i class="fas fa-grip-lines-vertical"></i></div>
						    	<div class="precedence_fixing_post"><%=precedenceFixingPost.getContents()%></div>
						   	 	<div class="precedence_fixing_post_after_icon"><i class="fas fa-caret-right"></i></div>
						    </li>
						    <%} %>
                        </ul><!-- //precedence_fixing_post_list -->
                    </div><!--//precedence_fixing_post_box-->
                    <%if(myMemberInCrew!=null){ %>
                    <div class="posting_box"><!--posting_box-->
                        <a class="posting_btn"><span>크루원들은 당신의 얘기를 기다리고 있어요<i class="fas fa-feather-alt"></i></span></a>
                    </div><!--//posting_box-->
                    <%} %>
                </div><!--//fixedPostContainer-->
                <%if(crewOrder != -1){ %>
                <div class="post_variable_box"><!--post_variable_box-->
                </div><!--//post_variable_box-->
                <%@ include file="/crewSchedules.jsp" %>
                <%}else{ %>
                <div class="stranger_post_box">
    				<img src="img/logo_version_white.png" />
    				<p>크루원이 된다면 글을 볼 수 있습니다.</p>
				</div>
                <%} %>
            </div><!--//crewPostContainer-->
            <div id="crewFunctionBar"><!--crewFunctionBar-->
                <div class="chatting_box"><!--chatting_box-->
                    <span>채팅</span>
                    <div class="current_chatting_box"><!--current_chatting_box-->
                        <a class="current_chatting" href=""><!--current_chatting-->
                            <img src="/img/crew/<%=crew.getCoverImg() %>" />
                            <span class="chatting_box_crew_name">크루명</span>
                            <span class="chatting_text">어쩌구저쩌구</span>
                        </a><!--//current_chatting-->
                    </div><!--current_chatting-->
                </div><!--//chatting_box-->
                <div class="meeting_apply_box"><!--meeting_apply_list-->
                    <dl class="meeting_apply_list"><!--meeting_apply_list-->
                        <dt>신청목록(<%=weApplyMeetings.size() %>)</dt>
                        <%for(MeetingWeApplied meeting : weApplyMeetings){ %>
                        <dd class="meeting_apply_item <%if(meeting.getAcceptance()=='A'){%>comfirm_mark<%}else if(meeting.getAcceptance()=='B'){%>bring_mark<%}%>"><!--meeting_basket_item-->
                            <a href="">
                                <img src="/img/meeting/<%=meeting.getImg() %>" width="40px" height="40px" />
                                <span class="apply_item_crew_name"><%=meeting.getCrewName() %></span>
                                <span class="apply_item_meeting_name"><%=meeting.getSchedulesName() %></span>
                            </a>
                            <div class="bring_meeting_hidden_values_box">
		                        <input type="hidden" class="bring_meeting_crew" value="<%=meeting.getCrewName()%>" />
		                        <input type="hidden" class="bring_meeting_name" value="<%=meeting.getSchedulesName()%>" />
		                        <input type="hidden" class="bring_meetingStart_date" value="<%=meeting.getStartDate()%>" />
		                        <input type="hidden" class="bring_meeting_address" value="<%=meeting.getAddress()%>" />
		                        <input type="hidden" class="bring_meeting_introduce" value="<%=meeting.getIntroduce()%>" />
		                        <input type="hidden" class="bring_meeting_apps_no" value="<%=meeting.getMeetAppsNo()%>" />
		                        <input type="hidden" class="bring_meeting_no" value="<%=meeting.getMeetingsNo()%>" />
		                        <input type="hidden" class="bring_meeting_crew_no" value="<%=meeting.getApplyCrewNo()%>" />                      
                       		</div>
                        </dd><!--//meeting_basket_item-->
                        <%} %>                         
                    </dl><!--//meeting_apply_list-->
                </div><!--//meeting_apply_list-->
            </div><!--//crewFunctionBar-->
        </div><!--//crewDetailContainer-->
    </div><!--//crewDetailContainerWrap-->
	
	<div class="pop_write_wrap">
  	</div><!-- //pop_write_wrap -->
	<div class="pop_update_wrap">
  	</div><!-- //pop_write_wrap update-->
	<div class="pop_post_detail_wrap">
	</div>	
	<div id="reportBoxWrap"><!--reportBoxWrap-->
	</div>	
	<div class="post_detail_image_warp"><!--postDetailImageWarp-->
	</div><!--//postDetailImageWarp-->
	
	<div class="pop_reported_post_wrap"><!--popReportedPostWrap-->
	    <div class="report_close report_icon"><i class="fas fa-times"></i></div>
	    <div class="right_icon report_icon"><i class="fas fa-chevron-right"></i></div>
	    <div class="left_icon report_icon"><i class="fas fa-chevron-left"></i></div>
	</div>

</div><!-- //container -->

<script><!--자바스크립트에 jsp 변수를 보내기 위한 스크립트-->
//크루 번호
const crewNo = <%=crewNo%>;
//크루 카테고리 번호
const crewCategoryNo = <%=crew.getCategoryNo()%>;
//해당 크루 내에서 자신의 랭크
<%if(myMemberInCrew!=null){%>
const crewRank = '<%=myMemberInCrew.getRole()%>';	
<%}else{%>
const crewRank = 'S';
<%}%>
//해당 크루 내에서 자신의 크루원 번호
<%if(myMemberInCrew!=null){%>
const crewMemberNo = <%=myMemberInCrew.getNo() %>;
<%}else{%>
const crewMemberNo = -1;
<%}%>

//현재 크루 게시판 페이지
let boardNo = <%=boardNo%>;
//언더스코어는 기본적으로 %을 사용하는데 %는  jsp에서 사용할 수 없기 때문에 % -> @ 로변경하는 코드가 필요함
_.templateSettings = {interpolate: /\<\@\=(.+?)\@\>/gim,evaluate: /\<\@([\s\S]+?)\@\>/gim,escape: /\<\@\-(.+?)\@\>/gim};
</script>


<!-- 주성호 포스트 관련 템플릿 -->
<%@ include file="/WEB-INF/template/crewDetailPage/postsTmpl.jsp" %>
<%@ include file="/WEB-INF/template/crewDetailPage/detailPostsTmpl.jsp" %>
<%@ include file="/WEB-INF/template/crewDetailPage/popWriteTmpl.jsp" %>
<%@ include file="/WEB-INF/template/crewDetailPage/replyTmpl.jsp" %>
<%@ include file="/WEB-INF/template/crewDetailPage/popUpdateTmpl.jsp" %>
<%@ include file="/WEB-INF/template/crewDetailPage/reportTmpl.jsp" %>
<%@ include file="/WEB-INF/template/crewDetailPage/detailImageTmpl.jsp" %>
<%@ include file="/WEB-INF/template/crewDetailPage/popReportedTmpl.jsp" %>
<!-- //주성호 포스트 관련 템플릿 -->

<!-- 박형우 디테일 관련 템플릿 -->
<%@ include file="/WEB-INF/template/crewDetailPage/ongoingMeetingTmpl.jsp" %>
<%@ include file="/WEB-INF/template/crewDetailPage/qualificationTmpl.jsp" %>
<%@ include file="/WEB-INF/template/crewDetailPage/meetingRequestTmpl.jsp" %>
<%@ include file="/WEB-INF/template/crewDetailPage/precedenceFixingPostTmpl.jsp" %>
<!-- //박형우 디테일 관련 템플릿 -->

<!-- 정진하 일정 관련 템플릿 -->
<%@ include file="/WEB-INF/template/crewDetailPage/scheduleListTmpl.jsp" %>
<!-- //정진하 일정 관련 템플릿 -->

<!-- 주성호 포스트 관련 js -->
<!--  quill Editor js가 CrewDetailPost.js 위에 오도록 할것! -->
<script src="js/quill.core.js"></script>
<script src="js/quill.min.js"></script>
<script src="/js/moment-with-locales.js"></script>
<script src="/js/crewDetailPage/crewDetailPage.js"></script>
<script src="/js/crewDetailPage/crewDetailPost.js"></script>

<script src="/js/tui-date-picker.min.js"></script>
<script src="/js/tui-time-picker.min.js"></script>
<!-- //주성호 포스트 관련 js -->

<!-- 박형우 디테일 관련 js -->
<script src="/js/crewDetailPage/popSaemoHistory.js"></script>	
<script src="/js/crewDetailPage/popCrewSignUp.js"></script>
<script src="/js/crewDetailPage/popBringMeeting.js"></script>
<script src="/js/crewDetailPage/popCrewMemberList.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=70794a76a110afe1608244fb91d2b83d&libraries=services"></script>
<script src="/js/crewDetailPage/popMeetingMakingForm.js"></script>
<script src="/js/crewDetailPage/popMeetingRequestList.js"></script>
<script src="/js/crewDetailPage/popBringMeetingRequestForm.js"></script>
<!-- //박형우 디테일 관련 js -->

<script src="/js/crewDetailPage/popReported.js"></script>

<!-- 정진하 일정 관련 js -->
<script src="/js/main.js"></script>
<script src='/js/locales-all.js'></script>
<script src="/js/crewDetailPage/crewSchedules.js"></script>
<!--  //정진하 일정 관련 js -->


<!--  popCrewMemberList.js -->
<script>
</script>
</body>
</html>