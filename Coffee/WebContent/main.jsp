<%@page import="com.doogwal.coffee.vo.Crew"%>
<%@page import="com.doogwal.coffee.dao.SchedulesDAO"%>
<%@page import="com.doogwal.coffee.vo.Gathering"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.doogwal.coffee.dao.CrewsDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
			List<Gathering> gatherings = SchedulesDAO.selectUpcomingGatheringList();
			List<Crew> crews = CrewsDAO.selectCrewsRecruiting();
			//요일 오늘 날짜 기준으로 얻어내기 위함
			Calendar cal = Calendar.getInstance();
			int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);//1부터 7까지의 숫자로 일-토 나타냄.
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신선한 모임이 펼쳐진다!</title>
    <%@ include file="/WEB-INF/template/link.jsp"%>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="icon" href="/img/favicon.png" />
    <style>
    .crews_recruiting_new_members_item {
    font-size: 10px;
    }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/template/headerForMain.jsp"%>
<div class="hero_img_box"><!-- hero_img_box start-->
    <div class="catch_phrase"><!--catch_phrase start -->
        <h1>신선한 모임이 펼쳐진다</h1>
    </div><!--//catch_phrase end-->
</div><!--//hero_img_box end -->
<div id="container"><!-- container start-->
    <div class="category_box"><!-- category_box start -->
        <ul class="category_list"><!-- category_list start -->
            <li><a href="/searchPage.jsp?priorNo=1"><i class="fas fa-gamepad"></i><p>게임</p></a></li>
            <li><a href="/searchPage.jsp?priorNo=9"><i class="fas fa-pallet"></i><p>문화/예술</p></a></li>
            <li><a href="/searchPage.jsp?priorNo=3"><i class="fas fa-dog"></i><p>반려동물</p></a></li>
            <li><a href="/searchPage.jsp?priorNo=4"><i class="fas fa-people-carry"></i><p>봉사활동</p></a></li>
            <li><a href="/searchPage.jsp?priorNo=5"><i class="fas fa-users"></i><p>사교모임</p></a></li>
            <li><a href="/searchPage.jsp?priorNo=6"><i class="fas fa-book-open"></i><p>스터디</p></a></li>
            <li><a href="/searchPage.jsp?priorNo=7"><i class="fas fa-futbol"></i><p>스포츠/레저</p></a></li>
            <li><a href="/searchPage.jsp?priorNo=8"><i class="fas fa-guitar"></i><p>음악/악기</p></a></li>
            <li><a href="/searchPage.jsp?priorNo=2"><i class="fas fa-campground"></i><p>아웃도어</p></a></li>
        </ul><!--//category_list end-->
    </div><!--//category_box end-->
    <div id="content"><!-- content start-->
        <div class="crews_with_upcoming_meeting_box"><!--crews_with_upcoming_meeting_box start -->
            <h2>좋겠다!! 곧 모임이 있는 크루들</h2>
            <button class="upcoming_next_btn fas fa-chevron-left"></button>
            <button class="upcoming_prev_btn fas fa-chevron-right"></button>
            <div class="upcoming_meeting_list_box"><!--upcoming_meeting_list_box start-->
                <ul class="upcoming_meeting_list"><!--upcoming_meeting_list start-->
                <%
                
                for(Gathering gathering:gatherings){
                	String whichDay = "";

        			switch(dayOfWeek)
        				{
        				case 1: whichDay="일";
        				break;
        				case 2: whichDay="월";
        				break;
        				case 3: whichDay="화";
        				break;
        				case 4: whichDay="수";
        				break;
        				case 5: whichDay="목";
        				break;
        				case 6: whichDay="금";
        				break;
        				case 7: whichDay="토";
        				break;
        				}
                	%>
                    <li class="upcoming_meeting_item"><p><%=whichDay%></p><a href="/crewDetailPage.jsp?crewNo=<%=gathering.getCrewNo()%>"><img src="/img/crew/<%=gathering.getCrewCoverImg()%>"/>
                    <div class="virtual"></div><p class="crew_name"><%=gathering.getCrewName()%></p>
                    <p class="meeting_name"><%=gathering.getName() %></p></a></li>
                 <%++dayOfWeek; if(dayOfWeek==8){dayOfWeek=1;}}//for each end  %>  
                </ul><!--//upcoming_meeting_list end-->
            </div><!--//upcoming_meeting_list_box end -->
        </div><!--//crews_with_upcoming_meeting_box end -->
        <div class="crews_recruiting_new_members_wrap"><!-- crews_recruiting_new_members_wrap start-->
            <div class="crews_recruiting_new_members_top"><!-- crews_recruiting_new_members_top start-->
                <h2 class="title">모집 중인 크루</h2>
                <a href="/searchPage.jsp"><h3 class="see_more_btn">더보기</h3></a>
            </div><!--//crews_recruiting_new_members_top end -->
            <div class="crews_recruiting_new_members_box"><!-- crews_recruiting_new_members_box start-->
                <ul class="crews_recruiting_new_members_list"><!-- crews_recruiting_new_members_list start-->
                <%int j=1; for(Crew crew:crews){ System.out.println(crew);%>
                    <li class="crews_recruiting_new_members_item"><a href="/crewDetailPage.jsp?crewNo=<%=crew.getNo()%>"><img src="/img/crew/<%=crew.getCoverImg()%>" width="247.5" height="180"/>
                    <p><%=crew.getName()%></p><p><%=crew.getIntro() %></p></a></li>
                <%++j; if(j==9){break;}}//for each end %> 
                </ul><!--//crews_recruiting_new_members_list start-->
            </div><!--//crews_recruiting_new_members_box end -->
        </div><!--//crews_recruiting_new_members_wrap end -->
    </div><!-- //content end-->
<%@ include file="/WEB-INF/template/footer.jsp"%>
<script src="js/jquery.js"></script>
<script>
    const $upcomingNextBtn = $(".fa-chevron-right");
    const $upcomingPrevBtn = $(".fa-chevron-left");
    const $upcomingMeetingList = $(".upcoming_meeting_list");
    let x = 0;

    $upcomingNextBtn.click(function (){
        x = x -1055;
        $upcomingMeetingList.css("transform","translate(" + x + "px,0)");

        $upcomingPrevBtn.css("display","block");
        $upcomingNextBtn.css("display","none");
    });//click() end

    $upcomingPrevBtn.click(function (){
        x = x +1055;
        $upcomingMeetingList.css("transform","translate(" + x + "px,0)");
        $upcomingNextBtn.css("display","block");
        $upcomingPrevBtn.css("display","none");
    });//click() end


</script>
</body>
</html>
