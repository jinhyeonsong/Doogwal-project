<%@page import="com.doogwal.coffee.servlet.ajax.GetSearchCrewList"%>
<%@page import="com.doogwal.coffee.vo.FellowshipCrew"%>
<%@page import="com.doogwal.coffee.dao.CrewsDAO"%>
<%@page import="com.doogwal.coffee.vo.MatchCrew"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.doogwal.coffee.dao.SchedulesDAO"%>
<%@page import="java.util.concurrent.ScheduledExecutorService"%>
<%@page import="com.doogwal.coffee.dao.FellowshipsDAO"%>
<%@page import="com.doogwal.coffee.vo.Fellowship"%>
<%@page import="com.doogwal.coffee.vo.Meeting"%>
<%@page import="com.doogwal.coffee.dao.RecordsDAO"%>
<%@page import="com.doogwal.coffee.vo.MatchRecord"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	
	//밋팅디테일에 있는 크루번호를 얻어옴

	//밋팅을 주최한 크루의 승/무/패
	MatchRecord matchRecord = RecordsDAO.selectMatchRecord(crewNo);
	 
	//밋팅히스토리 총 대결 수 
	Map<String,Object> map = SchedulesDAO.selectHistoryCount(crewNo);
	
	//밋팅히스토리 대결 탭 크루 목록 코드
	List<MatchCrew> matchCrews = CrewsDAO.selectMatchHistoryList(crewNo);
	System.out.println(matchCrews.size());
	
	//밋팅히스토리 친목 탭 크루 목록 코드
	List<FellowshipCrew> fellowshipCrews = CrewsDAO.selectFellowshipHistoryList(crewNo);
	
%>


<!--/////////////////////////////////////////////////////////  -->

<div id="meetingHistoryPopWrap">
    <!--meetingHistoryPopWrap start -->
    <div id="meetingHistoryPop">
        <button class="close_btn">
            <i class="fas fa-times"></i>
        </button>
        <div class="select_box"></div>
        <ul class="history_box_list">
            <li class="match_tab"><input type="radio" name="history_" id="match_connect" checked> <label
                    for="match_connect">대결(<%=map.get("MATCHCOUNT") %>)</label>
                <div class="history_content">
                    <!-- history_content start-->
                    <div class="title">
                        <!-- title start-->
                        <h1>밋팅 히스토리</h1>
                        <h2>
                            대결<span class="record_total">
                                <%=matchRecord.getWin() %>승
                                <%=matchRecord.getDraw() %>무
                                <%=matchRecord.getLose() %>패</span>
                        </h2>
                    </div>
                    <!--// title end-->
                    <ul class="crew_match_list">
                        <%for(MatchCrew matchCrew : matchCrews){ 
                        	System.out.println("매치크루 1");
                        %>
                        <li class="crew_detail_item">
                            <!--crew_detail_box start -->
                            <div class="crew_image">
                                <!--crew_image start -->
                                <a href=""><img src="<%=matchCrew.getCrewImg()%>"></a>
                            </div>
                            <!--// crew_image end -->
                            <div class="meeting_detail">
                                <!-- meeting_detail start -->
                                <p><%=matchCrew.getCrewName() %></p>
                                <p><%=matchCrew.getMeetingName() %></p>
                                <p><%=matchCrew.getMeetingDate() %></p>
                            </div>
                            <!--// meeting_detail end -->
                            <p class="match_record"><%=matchCrew.getWin() %>승
                                <%=matchCrew.getDraw() %>무
                                <%=matchCrew.getLose() %>패</p>
                                <%// 내 크루이고 난 임원이고 아직 후기 생성 전 1/2 임원
                                // for 문에서 조건에 부합하면 1
                                int matchFlag=0;
                                for(CrewMember cm : userCrews){
                        			if(cm==null){
                        				break;
                        			}
                        			// 상대 away 크루가 후기 남기기
                        			if(cm.getRole()=='C' && cm.getCrewNo() == matchCrew.getAwayCrewNo() && matchCrew.getAwayType()=='B'){%>
                       				<button class="write_match_review_btn">후기</button>
                       				<input type="hidden" name="rivalCrewNo" value="<%= matchCrew.getHomeCrewNo() %>"/>
                       				<input type="hidden" name="myCrewNo" value="<%= cm.getCrewNo() %>"/>
                       				<input type="hidden" name="meetingNo" value="<%=matchCrew.getNo() %>"/>
                       				<input type="hidden" name="<%=matchCrew.getHomeType() %>"/>
                        			<% 
                        				matchFlag=1;
                        				break;
                        			}else if(cm.getRole()=='C' && cm.getCrewNo() == matchCrew.getAwayCrewNo() && matchCrew.getAwayType()!='B'){
                        				%><button class="write_match_review_btn <%=matchCrew.getAwayType() %>" disabled><%=matchCrew.getAwayType() %></button><%
                        				matchFlag=1;
                        				break;
                        			}
                        		}
                                // 밋팅 만든이 home 크루가 후기 남기기
                                if((myCrew==1)&& matchCrew.getHomeType()=='B'){%>
                                	<button class="write_match_review_btn">후기</button>
                                	<input type="hidden" name="rivalCrewNo" value="<%= matchCrew.getAwayCrewNo() %>"/>
                                	<input type="hidden" name="myCrewNo" value="<%= matchCrew.getHomeCrewNo() %>"/>
                                	<input type="hidden" name="meetingNo" value="<%=matchCrew.getNo() %>"/>
                                	<input type="hidden" name="myCrew1"/>
                                <%}
                                // 1/2회원 3임원,회원
                                else if(matchCrew.getHomeType()=='B' && matchFlag==0){%>
                                	<button class="write_match_review_btn" disabled>대기중</button>
                                <% }else if( matchCrew.getHomeType()!='B' && matchFlag==0){%>
	                            <button class="write_match_review_btn <%=matchCrew.getHomeType() %>" disabled><%=matchCrew.getHomeType() %></button>
                                <%} %>
                        </li>
                        <%} %>
                    </ul>
                </div>
                <!--// history_content end-->
            </li>

            <li class="community_gathering_tab"><input type="radio" name="history_" id="community_gathering_connect">
                <label for="community_gathering_connect">친목(<%=map.get("FELLOWSHIPCOUNT") %>)</label>
                <div class="history_content">
                    <!-- history_content start-->
                    <div class="title">
                        <!-- title start-->
                        <h1>밋팅 히스토리</h1>
                    </div>
                    <!--// title end -->
                    <ul class="crew_gathering_list">
                        <%for(FellowshipCrew fellowshipCrew : fellowshipCrews){ %>
                        <li class="crew_detail_item">
                            <!--crew_detail_box start -->
                            <div class="crew_image">
                                <!--crew_image start -->
                                <a href=""><img src="<%=fellowshipCrew.getCrewImg()%>"></a>
                            </div>
                            <!--// crew_image end -->
                            <div class="meeting_detail">
                                <!-- meeting_detail start -->
                                <p><%=fellowshipCrew.getCrewName() %></p>
                                <p><%=fellowshipCrew.getMeetingName() %></p>
                                <p><%=fellowshipCrew.getMeetingDate() %></p>
                            </div>
                            	 <%// 내 크루이고 난 임원이고 아직 후기 생성 전 1/2 임원
                                // for 문에서 조건에 부합하면 1
                                int fellowFlag=0;
                                for(CrewMember cm : userCrews){
                        			if(cm==null){
                        				break;
                        			}
                          			 // 상대 away 크루가 후기 남기기
                        			if(cm.getRole()=='C' && cm.getCrewNo() == fellowshipCrew.getAwayCrewNo() && fellowshipCrew.getAwayType()=='B'){%>
                       				<button class="write_fellowship_review_btn">후기</button>
                       				<input type="hidden" name="rivalCrewNo" value="<%= fellowshipCrew.getHomeCrewNo() %>"/>
                       				<input type="hidden" name="myCrewNo" value="<%= cm.getCrewNo() %>"/>
                       				<input type="hidden" name="meetingNo" value="<%=fellowshipCrew.getNo() %>"/>
                       				<input type="hidden" name="<%=fellowshipCrew.getAwayType() %>"/>
                        			<% 
                        				fellowFlag=1;
                        				break;
                        			}else if(cm.getRole()=='C' && cm.getCrewNo() == fellowshipCrew.getAwayCrewNo() && fellowshipCrew.getAwayType()!='B'){
                        				%><button class="read_fellowship_review_btn">후기 읽기</button>
                        				<input type="hidden" name="rivalCrewNo" value="<%= fellowshipCrew.getHomeCrewNo() %>"/>
	                       				<input type="hidden" name="meetingNo" value="<%=fellowshipCrew.getNo() %>"/>
	                       				<input type="hidden" name="cm">
                        				<%
                    					fellowFlag=1;
                        				break;
                        			}
                        		}
                                // 밋팅 만든이 home 크루가 후기 남기기
                                if((myCrew==1)&& fellowshipCrew.getHomeType()=='B'){%>
                                	<button class="write_fellowship_review_btn">후기</button>
                                	<input type="hidden" name="rivalCrewNo" value="<%= fellowshipCrew.getAwayCrewNo() %>"/>
                                	<input type="hidden" name="myCrewNo" value="<%= fellowshipCrew.getHomeCrewNo() %>"/>
                                	<input type="hidden" name="meetingNo" value="<%=fellowshipCrew.getNo() %>"/>
                                	<input type="hidden" name="myCrew1"/>
                                <%}
                                // 1/2회원 3임원,회원
                                else if(fellowshipCrew.getHomeType()=='B' && fellowFlag==0){%>
                                	<button class="write_fellowship_review_btn" disabled>대기중</button>
                                <% }else if(fellowshipCrew.getHomeType()!='B' && fellowFlag==0){%>
	                            <button class="read_fellowship_review_btn">후기 읽기</button>
	                            <input type="hidden" name="rivalCrewNo" value="<%= fellowshipCrew.getHomeCrewNo() %>"/>
                   				<input type="hidden" name="meetingNo" value="<%=fellowshipCrew.getNo() %>"/>
                   				<input type="hidden" name="notcm">
                                <%} %>
                        </li>
                        <%} %>
                    </ul>
                </div>
                <!--// history_content end-->
            </li>
        </ul>
    </div>
</div>
<!--// meetingHistoryPopWrap end -->

<div class="review_pop_wrap"><!-- review_pop_wrap start-->
</div><!--// review_pop_wrap end -->
<div class="write_community_gathering_review_wrap"><!-- write_community_gathering_review_wrap start-->
</div><!-- write_community_gathering_review_wrap end-->
<div class="write_match_review_wrap"><!-- write_match_review_wrap start -->
</div><!--// write_match_review_wrap end -->


<script src="js/jquery.js"></script>
<script src="js/underscore-min.js"></script>
<script src="js/tui-chart-all.min.js"></script>

<!--친목후기읽기 템플릿 -->
<script type="text/template" id="readFellowshipReviewTmpl">
    <div class="community_gathering_review_box"><!--community_gathering_review_box start-->
        <span class="prev_btn"><i class="fas fa-arrow-left"></i></span>
        <span class="time_crew_wrote_the_review"><@=moment(review.meetingDate).format("YYYY년 MM월 DD일 HH:mm:ss")@>작성</span>
        <form class="community_gathering_review_form">
            <div class="crew_profile"><!-- crew_profile start-->
            <img src="<@= review.crewImg@>">
            <p><@= review.crewName@></p>
        	</div><!--// crew_profile end -->
            <div class="fellowship_write_review_check_list"><!-- check_list start-->
                <label><input type="checkbox" <@if(review.manner=='T'){ @>checked="checked"<@}@> disabled>상대팀의 매너가 좋았나요?</label>
                <label><input type="checkbox" <@if(review.competence=='T'){ @>checked="checked"<@}@> disabled>상대팀의 실력이 좋았나요?</label>
                <label><input type="checkbox" <@if(review.harmony=='T'){ @>checked="checked"<@}@> disabled>상대팀은 화목했나요?</label>
                <label><input type="checkbox" <@if(review.eagerness=='T'){ @>checked="checked"<@}@> disabled>상대팀은 의욕적이었나요?</label>
                <label><input type="checkbox" <@if(review.unity=='T'){ @>checked="checked"<@}@> disabled>상대팀은 단합이 좋았나요?</label>
            </div><!--// check_list end-->
            <div class="fellowship_review_message_box"><!-- send_message_box start -->
                <p class="fellowship_review_message_box_title">상대 크루에게 한 마디 해주세요</p>
                <textarea class="type_comment" disabled><@= review.review@></textarea>
            </div><!--// send_message_box end -->
        </form>
    </div><!--// community_gathering_review_box end-->
</script>

<!--대결후기쓰기 템플릿 -->
<script type="text/template" id="writeMatchReviewTmpl">
    <div class="match_review_box"><!--match_review_box start -->
    <span class="match_review_prev_btn"><i class="fas fa-arrow-left"></i></span>
    <form class="match_review_form" action="/matchReviewWrite.do" method="get">
		<input type="hidden" name="rateecrewNo" value="<@=write_match_review.no@>"/>
		<input type="hidden" name="ratercrewNo" value="<@=raterCrewNo@>"/>
		<input type="hidden" name="meetingNo" value="<@= meetNo@>" />
        <div class="check_box_for_match_result"><!--check_box_for_match_result start-->
            <input type="radio" name="match_result" id="win" value="W">
            <label for="win" class="result_option">승</label>
            <input type="radio" name="match_result" id="draw" value="D">
            <label for="draw"  class="result_option">무</label>
            <input type="radio" name="match_result" id="lose" value="L">
            <label for="lose" class="result_option">패</label>
            <!-- label을 input 앞에다 사용하면 적용이 안됨..-->
        </div><!--// check_box_for_match_result end -->
        <div class="crew_profile"><!-- crew_profile start-->
            <img src="<@= write_match_review.coverImg@>">
            <p><@= write_match_review.name@></p>
        </div><!--// crew_profile end -->
        <div class="match_check_list"><!-- check_list start-->
        <label><input type="checkbox" name="review" value="1">상대팀 매너가 좋았나요?</label>
        <label><input type="checkbox" name="review" value="2">상대팀 실력이 좋았나요?</label>
        <label><input type="checkbox" name="review" value="3">상대팀 화목했나요?</label>
        <label><input type="checkbox" name="review" value="4">상대팀은 의욕적이었나요?</label>
        <label><input type="checkbox" name="review" value="5">상대팀은 단합이 좋았나요?</label>
        </div><!--// check_list end -->
        <button class="confirm_btn" type="submit">확인</button>
    </form>
</div><!--//match_review_box end -->
</script>

<!--친목후기쓰기 템플릿 -->
<script type="text/template" id="writeFellowshipReviewTmpl">
    <div class="community_gathering_review_box">
    <span class="fellowship_review_prev_btn"><i class="fas fa-arrow-left"></i></span>
    <form class="community_gathering_review_form" action="/fellowshipReviewWrite.do" method="post">
		<input type="hidden" name="rateecrewNo" value="<@=writeFellowshipReview.no@>"/>
		<input type="hidden" name="ratercrewNo" value="<@=raterCrewNo@>"/>
		<input type="hidden" name="meetingNo" value="<@= meetNo@>" />
        <div class="crew_profile"><!-- crew_profile start-->
        <img src="<@= writeFellowshipReview.coverImg@>">
        <p><@= writeFellowshipReview.name@></p>
        </div><!--//crew_profile end-->
        <div class="check_list"><!-- check_list start-->
		<label><input type="checkbox" name="review" value="1">상대팀 매너가 좋았나요?</label>
        <label><input type="checkbox" name="review" value="2">상대팀 실력이 좋았나요?</label>
        <label><input type="checkbox" name="review" value="3">상대팀 화목했나요?</label>
        <label><input type="checkbox" name="review" value="4">상대팀은 의욕적이었나요?</label>
        <label><input type="checkbox" name="review" value="5">상대팀은 단합이 좋았나요?</label>
        </div><!--// check_list end-->
        <div class="fellowship_send_message_box"><!-- fellowship_send_message_box start -->
            <p class="send_message_box_title">상대 크루에게 한 마디 해주세요</p>
             <textarea class="type_comment" placeholder="내용을 입력해주세요.(최대 20자)" name="review_text"></textarea>
             <p class="word_counter">(0/30자)</p>
        </div><!--// fellowship_send_message_box end -->
         <button class="confirm_btn" type="submit">확인</button>
    </form>
</div><!--community_gathering_review_box end-->
</script>


<script>
	// 평가하는 크루 번호
    let raterCrewNo=0;
	// 미팅번호 -> MannersDAO
    let meetNo = 0;
    /*밋팅 신청하기 자바스크립트 끝*/

    /*템플릿 시작*/
    // % -> @ 으로
    _.templateSettings = {
        interpolate: /\<\@\=(.+?)\@\>/gim,
        evaluate: /\<\@([\s\S]+?)\@\>/gim,
        escape: /\<\@\-(.+?)\@\>/gim
    };

    const readFellowshipReviewTmpl = _.template($('#readFellowshipReviewTmpl').html());
    const writeMatchReviewTmpl = _.template($('#writeMatchReviewTmpl').html());
    const writeFellowshipReviewTmpl = _.template($('#writeFellowshipReviewTmpl').html());

	const $reviewPopWrap = $('.review_pop_wrap');
    const $crewMatchList = $('.crew_match_list');
    const $crewGatheringList = $('.crew_gathering_list');
    const $readFellowshipReviewPopWrap = $('.read_fellowship_review_pop_wrap');
    const $writeReviewPopWrap = $('.write_match_review_wrap');
    const $writeGatheringReviewPopWrap = $('.write_community_gathering_review_wrap');
    const $closeBtn = $(".close_btn");
    const $battleViewMoreBtn = $(".battle_view_more");
    const $html = $("html");
    /*친목후기 읽기 start*/
    let review;
    const $meetingHistoryPopWrap = $('#meetingHistoryPopWrap');


    /*더보기 버튼 눌렀을 때 팝업 뜨게 하기*/
    $battleViewMoreBtn.click(function (e) {
        e.preventDefault();
        $meetingHistoryPopWrap.addClass("appear");
        $html.addClass("on");
    });
    /*더보기 버튼 눌렀을 때 팝업 뜨게 하기*/

    /*팝업 닫기버튼*/
    $closeBtn.click(function () {
        $meetingHistoryPopWrap.removeClass("appear");
        $html.removeClass("on");
    });
    /*팝업 닫기버튼*/
    
    /*리뷰 읽기 닫기 start*/
    $reviewPopWrap.on("click", '.prev_btn', function (e) {
        if (!$reviewPopWrap.hasClass("appear")) {
            $reviewPopWrap.addClass("appear");
            $meetingHistoryPopWrap.toggleClass("appear");
        } else {
            $reviewPopWrap.removeClass("appear");
            $meetingHistoryPopWrap.toggleClass("appear");
        }
    });
    /*리뷰 읽기 닫기 end*/
    
    
	
    /*친목후기 읽기 end*/

    /*대결후기쓰기 템플릿 불러오기 start*/
    let writeMatchReview;
    $meetingHistoryPopWrap.on("click", '.write_match_review_btn', function (e) {
    	
    	const $this = $(this);
    	// 평가 받는 크루 번호
    	const crewNo = $this.next().val();
		
    	// 평가하는 크루 번호
    	raterCrewNo = $this.next().next().val();
    	
    	// 미팅 번호
    	meetNo = $this.next().next().next().val();
    	console.log($writeReviewPopWrap.hasClass("appear"));
        if (!$writeReviewPopWrap.hasClass("appear")) {
            $writeReviewPopWrap.addClass("appear");
            $meetingHistoryPopWrap.toggleClass("appear");
            $.ajax({
                url: "/ajax/get_write_match_review.json",
                type: 'GET',
                data:{
                	crewNo:crewNo
                },
                dataType: "json",
                error: function (xhr, error, code) {
                    alert("에러:" + code);
                },
                success: function (json) {
                    console.log(json);
                    writeMatchReview = json
                    $writeReviewPopWrap.html(writeMatchReviewTmpl({
                        write_match_review: json
                    }));
                }
            });
        } else {
            $writeReviewPopWrap.removeClass("appear");
            $meetingHistoryPopWrap.toggleClass("appear");
        }
    });
    /*대결후기쓰기 템플릿 불러오기 end*/
    
    /*대결후기쓰기 닫기 start*/
    $writeReviewPopWrap.on("click", '.match_review_prev_btn', function (e) {
        if (!$writeReviewPopWrap.hasClass("appear")) {
            $writeReviewPopWrap.addClass("appear");
            $meetingHistoryPopWrap.toggleClass("appear");
        } else {
            $writeReviewPopWrap.removeClass("appear");
            $meetingHistoryPopWrap.toggleClass("appear");
        }
    });
    /*대결후기쓰기 닫기 end*/


    /*친목후기 쓰기 템플릿 불러오기 start*/
    let writeFellowshipReview;
    $meetingHistoryPopWrap.on("click", '.write_fellowship_review_btn', function (e) {
    	const $this = $(this);
    	// 평가 받는 크루 번호
    	const crewNo = $this.next().val();
    	
    	// 평가하는 크루 번호
    	raterCrewNo = $this.next().next().val();
    	
    	// 미팅번호
    	meetNo = $this.next().next().next().val();
    	
    	
        if(!$writeGatheringReviewPopWrap.hasClass("appear")) {
            $writeGatheringReviewPopWrap.addClass("appear");
            $meetingHistoryPopWrap.toggleClass("appear");

            $.ajax({
                url:"/ajax/get_write_fellowship_review.json",
                type : 'POST',
                dataType : "json",
                data:{
                	crewNo:crewNo
                },
                error : function(xhr, error, code) {
                    alert("에러:" + code);
                },
                success:function(json) {
                    console.log(json);
                    writeFellowshipReview = json
                    $writeGatheringReviewPopWrap.html(writeFellowshipReviewTmpl({writeFellowshipReview:json}));
                }
            });
        } else {
            $writeGatheringReviewPopWrap.removeClass("appear");
            $meetingHistoryPopWrap.toggleClass("disappear");
        }
    });
    /*친목후기 쓰기 템플릿 불러오기 end*/
    
    /*친목후기 쓰기 닫기 start*/
    $(document).on("click", '.fellowship_review_prev_btn', function (e) {
        if (!$writeGatheringReviewPopWrap.hasClass("appear")) {
            $writeGatheringReviewPopWrap.addClass("appear");
            $meetingHistoryPopWrap.toggleClass("appear");
        } else {
            $writeGatheringReviewPopWrap.removeClass("appear");
            $meetingHistoryPopWrap.toggleClass("appear");
        }
    }); 
    /*친목후기 쓰기 닫기 end*/

    /*친목 후기 읽기 템플릿 불러오기 start*/
    $meetingHistoryPopWrap.on("click",'.read_fellowship_review_btn',function(e){
    	e.preventDefault();
    	const $this = $(this);
    	// 평가 받는 크루 번호
    	const crewNo = $this.next().val();
    	// 미팅번호
    	meetNo = $this.next().next().val();
    	
        if(!$reviewPopWrap.hasClass("appear")) {
            $reviewPopWrap.addClass("appear");
            $meetingHistoryPopWrap.toggleClass("appear");

            $.ajax({
                url:"/ajax/get_review.json",
                type : 'POST',
                dataType : "json",
                data:{
                	crewNo:crewNo,
                	meetNo:meetNo
                },
                error : function(xhr, error, code) {
                    alert("에러:" + code);
                },
                success:function(json) {
                    console.log(json);
                    let review = json
                    $reviewPopWrap.html(readFellowshipReviewTmpl({review:json}));
                }
            });
        } else {
            $reviewPopWrap.removeClass("appear");
            $meetingHistoryPopWrap.toggleClass("disappear");
        }
    	
    });
    /*친목 후기 읽기 템플릿 불러오기 end*/
    
    //친목 후기 textarea 카운트
    $(document).on("keyup", ".type_comment", function (e) {
        let val = $('.type_comment').val();
        val = val.substr(0, 30);
        $('.type_comment').val(val);
        $('.word_counter').text(val.length + "자/최대30자");

    }); //on() end
</script>