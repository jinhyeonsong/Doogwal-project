<%@page import="com.doogwal.coffee.vo.CrewMember"%>
<%@page import="com.doogwal.coffee.dao.CrewMembersDAO"%>
<%@page import="com.doogwal.coffee.vo.User"%>
<%@page import="com.doogwal.coffee.vo.Crew"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%
	CrewMember[] userCrews = new CrewMember[3];
	for(int i=0;i<3;i++){
		
		userCrews[i] = (CrewMember)session.getAttribute("userCrewList"+i);
		if(userCrews[i]==null){
			System.out.println("NULL");
		}else{
			System.out.println(userCrews[i].getCrewNo());
		}
		//System.out.println(userCrews[i].getCoverImg());
	}
	
	
	User loginUser = (User)session.getAttribute(User.LOGIN);
	
%>
<div id="header"><!--header start-->
    <div class="inner">
        <div class="header_logo_search"><!--header_left start-->
            <a href="/main.jsp"><img src="img/logo.png" alt="saemo logo" title="saemo logo" /></a>
            <form class="header_search"><!--header_search-->
                <fieldset><!--fieldset-->
                    <legend class="screen_out">검색</legend>
                    <input placeholder="검색어를 입력하세요." maxlength="10" />
                    <button type="submit"><i class="fas fa-search"></i></button>
                </fieldset><!--//fieldset-->
            </form><!--//header_search -->
        </div><!--//header_left end-->
        <div class="header_crew_list_meeting_status"><!--header_right start-->
            <div class="header_crew_list"><!--header_crew_list-->
                <ul>
                	<%for(int i=0;i<userCrews.length;i++){ %>
                		<%if(userCrews[i]!=null){ %>
                    		<li><a href="/crewDetailPage.jsp?crewNo=<%=userCrews[i].getCrewNo() %>&crewOrder=<%=i%>"><img class="header_crew_list_on" src="/img/crew/<%=userCrews[i].getCoverImg() %>" width="40" height="40" /></a></li>
                   		<%}else{ %>
                   			<li><a href="/create_crew.jsp"><i class="fas fa-plus-circle"></i></a></li>
                   		<%} %>
                   	<%} %>
                </ul>
            </div><!--//header_crew_list -->
            <div class="header_meeting_home"><a href="meetingMain.jsp"><i class="far fa-handshake"></i></a></div>
            <div class="header_status">
            <%if(loginUser==null || userCrews[0] == null){ %>
            <a href="/">
            <i class="fas fa-user-circle"></i></a>
            <%}else{ %>
            <a href="/meetingMain.jsp">
            <img src="/img/profile/<%=userCrews[0].getProfileImg() %>" width="40" height="40"/></a>
            <%} %>
            </div>
            <div class="header_status_dropbox">
                <h3 class="screen_out">내메뉴</h3>
                <ul>
            <%if(loginUser==null){ %>
            		<li><a href="/loginForm.jsp">로그인하기</a></li>
            <%}else{ %>
            		<li><a href="/myPage.jsp">마이페이지</a></li>
                 	<li><a href="/logout.do">로그아웃</a></li>
            <%}%>
            	</ul>
            </div>
            
        </div><!--//header_right end-->
    </div><!--// inner end-->
</div><!--//header end-->
<script>

const $headerStatus = $('.header_status');
const $headerStatusDropbox = $('.header_status_dropbox');
/*header Status Dropbox start*/

$headerStatus.click(function (e) {
	e.preventDefault();
    $headerStatusDropbox.toggleClass("show");
});
</script>

<div id="container"><!--container start-->