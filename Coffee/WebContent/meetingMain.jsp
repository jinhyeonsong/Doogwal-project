<%@page import="com.doogwal.coffee.dao.SchedulesDAO"%>
<%@page import="com.doogwal.coffee.vo.Meeting"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    //처음 들어갔을 땐 필터 적용 안된거 다 떠있어야 해서 작성함. 오늘 날짜 포함 이후의 밋팅 리스트만 불러옴.
    List<Meeting> meetings = SchedulesDAO.selectMeetingListFromToday();
    
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>밋팅 메인</title>
	<%@ include file="/WEB-INF/template/link.jsp"%>
	<link rel="icon" href="/img/favicon.png" />
    <link rel="stylesheet" href="/css/meetingMain.css" />
    <link rel="stylesheet" href="/css/date-range-picker.css" />
    <link rel="stylesheet" href="/css/iconmonstr-iconic-font.min.css" />

</head>
<body>
<%@ include file="/WEB-INF/template/headerForMain.jsp"%>
    <div class="hero_image"></div>
    <div id="container"><!--container start-->
    <div class="meeting_filters"><!-- meeting_filters start-->
        <ul class="meeting_tab">
            <li class="on"><a href="">밋팅</a></li>
            <li><a href="">정착된 크루</a></li>
        </ul>
        <ul class="search_specifics">
            <li class="meeting_category_filter">
            <button class="category_btn">분류</button>
            <ul class="category_box"><!-- category_box start-->
                <li><a href="/" class="game" data-category-no="1">게임</a></li>
                <li><a href="/" class="art" data-category-no="9">문화/예술</a></li>
                <li><a href="/" class="pet" data-category-no="3">반려동물</a></li>
                <li><a href="/" class="volunteer" data-category-no="4">봉사활동</a></li>
                <li><a href="/" class="social_gathering" data-category-no="5">사교모임</a></li>
                <li><a href="/" class="study" data-category-no="6">스터디</a></li>
                <li><a href="/" class="sports" data-category-no="7">스포츠/레저</a></li>
                <li><a href="/" class="music" data-category-no="8">음악/악기</a></li>
                <li><a href="/" class="outdoor" data-category-no="2">아웃도어</a></li>
         	</ul><!-- category_box end-->
            </li>
            <li class="when"><a href="">언제</a></li>
            <li class="where"><a href="">어디서</a></li>
            <li class="age_filter">
                <button class="age_range_btn">연령대</button>
                <ul class="age_box"><!-- age_box start -->
                    <li><a href="/" class="twenties" data-age="20">20대</a></li>
                    <li><a href="/" class="thirties" data-age="30">30대</a></li>
                    <li><a href="/" class="forties" data-age="40">40대</a></li>
                    <li><a href="/" class="fifties" data-age="50">50대</a></li>
                </ul><!--age_box end -->
            </li>
            <!--<li><a href="">전적</a></li>-->
        </ul>
    </div><!--//meeting_filters end-->
        <div class="meeting_content"><!--meeting_content start-->
            <div class="meeting_title">
                <h2>신청 가능한 밋팅</h2>
            </div>
            <div class="theme_wrap">
            <div class="theme_box">
                <ul class="theme_list">
                <!--나중에 더미데이터 테마 번호 바뀌면 여기 수정해줘야 함 -->
                	<li data-theme-no="500"><a href="">이쁜 달밤 아래에서</a></li>
                    <li data-theme-no="501"><a href="">너희와 있어 즐겁다</a></li>
                    <li data-theme-no="502"><a href="">건강부터 챙기자</a></li>
                    <li data-theme-no="503"><a href="">내일은 없다</a></li>
                    <li data-theme-no="504"><a href="">나가자! 싸우자!</a></li>
                    <li data-theme-no="505"><a href="">그 때처럼 처음처럼</a></li>
                    <li data-theme-no="506"><a href="">움직이기 싫어~</a></li>
                    <li data-theme-no="507"><a href="">주저리 주저리</a></li>
                    <li data-theme-no="508"><a href="">1.2kg1.2kg</a></li>
                    <li data-theme-no="509"><a href="">요즘 그게 유행이래</a></li>
                </ul>
            </div>
                <button class="btn prev fas fa-chevron-circle-left"></button>
                <button class="btn next fas fa-chevron-circle-right"></button>
            </div><!--//theme_wrap end-->
            <ul class="meeting_list"><!--meeting_list start-->
            <%for(Meeting meeting:meetings){ %>
           			<li class="meeting_list_each">
    				<div class="meeting_cover">
        			<a href="/meetingDetail.jsp?meetingNo=<%=meeting.getNo()%>"><img src="/img/meeting/<%=meeting.getImg()%>" width="267" height="160" alt="밋팅커버"/></a>
            		<!--<i class="fas fa-hands"></i>-->
        			</div>
        		<ul class="meeting_info">
            		<li class="saemo_point"><img src="/img/saemoPoint.png" width="20" height="20"/><span><%=meeting.getPoint()%></span></li>
            		<li class="crew_name"><%=meeting.getCrewName()%></li>
            		<li class="meeting_name"><span><%=meeting.getName()%></span> 
            		<%if(meeting.getType()=='M'){ %>
            		<img src="/img/fighting.png" width="20" height="20"/><%}else{%><img src="/img/get_together.png" width="20" height="20"/><%}%></li>
            		<li class="meeting_location"><%=meeting.getPlace()%></li>
        		</ul>
    		</li>
    		<%} %>
            </ul><!--//meeting_list end-->
        </div><!--//meeting_content end-->
<%@ include file="/WEB-INF/template/footer.jsp"%>

    <!--일부러 풋터밑에 팝업창 위치시킴 이렇게 하면 풋터 보더 탑이 팝업창 위로 가로지르지 않음. 또 위치 선정 쉬움.-->
    <div class="pop_where_wrap"><!--pop_where_wrap start-->
        <div class="pop_where_box"><!--pop_where_box start-->
            <div class="pop_where_header_wrap"><!--pop_where_header_wrap start-->
                <div class="pop_where_header_title">
                    <span class="filter_where">어디서</span>
                </div>
                <button name="close_btn" type="button" class="pop_close_button fas fa-times">
                </button>
            </div><!--//pop_where_header_wrap end-->
            <div class="pop_where_container"><!--pop_where_container start-->
                <!-- 시도구군 템플릿 들어가는 자리 -->
            </div><!--//pop_where_container end-->
        </div><!--//pop_where_box start-->
    </div><!--//pop_where_wrap end-->


    <!--새로운 언제 팝업창 html 시작-->
    <div class="pop_when_wrap"><!--pop_when_wrap start-->
        <div class="pop_when_box"><!--pop_when_box start-->
            <div class="pop_when_header_wrap">
                <div class="pop_when_header_title">
                    <span class="filter_when">언제</span>
                </div>
                <button  class="when_close_btn fas fa-times"></button>
            </div>
            <div class="pop_when_container"><!--pop_when_container start-->
                <input type="hidden" name="dates" id="dateRange"/>
            </div><!--//pop_when_container end -->
        </div><!--//pop_when_box end -->
    </div><!--//pop_when_wrap end-->
    <!--//새로운 언제 팝업창 html 끝-->
    
    
    
    <!-- 밋팅 리스트 템플릿 -->
	<script type="text/template" id="meetingListByThemeNoTmpl">
 		<@ _.each(meetingsBytheme,function(meeting) {@>
    	<li class="meeting_list_each">
    		<div class="meeting_cover">
        		<a href=""><img src="/img/meeting/<@=meeting.img@>" width="267" height="160" alt="밋팅커버"/></a>
            	
        	</div>
        	<ul class="meeting_info">
            	<li class="saemo_point"><img src="/img/saemoPoint.png" width="20" height="20"/><span><@=meeting.point@></span></li>
            	<li class="crew_name"><@=meeting.crewName@></li>
            	<li class="meeting_name"><span><@=meeting.name@></span>
				<img src="/img/fighting.png" width="20" height="20"/></li>
            	<li class="meeting_location"><@=meeting.place@></li>
        	</ul>
    	</li>
		<@})@>
	</script>

    <!-- 시도구군 템플릿 -->
    <script type="text/template" id="whereTmpl">
        <ul class="korea_states">
            <@ _.each(sidoList,function(sido) {@>
            <li><a href=""><@=sido.name@></a></li>
            <@}) @>
        </ul>
        <div class="states_specifics"><!--states_specifics start-->
            <@ _.each(gugunList,function(guguns,idx) { @>
            <ul class="specifics_list <@ if(idx==0){ @> on<@ } @>" >
                <@ _.each(guguns,function(gugun) {@>
                <li><a href=""><span class="at"><@=gugun.name@></span> <span><@=gugun.size@></span></a></li>
                <@ })@>
            </ul>
            <@})@>
        </div>
    </script>
    
    
 	
    <script src="/js/jquery.js"></script>
    <script src="/js/moment-with-locales.js"></script>
    <script src="/js/date-range-picker.min.js"></script>
    <script src="/js/underscore-min.js"></script>

<script>

    // 언더스코어는 기본적으로 %을 사용하는데 %는  jsp에서 사용할 수 없기 때문에 % -> @ 로변경하는 코드가 필요함
    _.templateSettings = {interpolate: /\<\@\=(.+?)\@\>/gim,evaluate: /\<\@([\s\S]+?)\@\>/gim,escape: /\<\@\-(.+?)\@\>/gim};

    /*
    
    이 페이지에 필요한 ajax는
    1) 각 필터에 맞게 밋팅(밋팅 목록)
    2) 각 필터에 맞게 크루(크루 목록)
    3) 해당 필터에 맞는 어디서(시도구군 목록)
    4) 각 필터에 맞는 테마(있는 테마 목록)

    그 중 이 예제에서는 어디서만 구현하겠음

    진행순서

    1) ajax 폴더에 where.json 파일로 저장(sidogugun json을 이 페이지에 맞게 변경하여 저장)

    - sidoCd와 code는 우리가 데이터베이스를 만들때는 no로 할 가능성이 높으니까 no로 변경(ctrl+r하면 한번에 변경이 가능)하고 각 구군에 몇 개의 크루가 있는지 개수가 나와야 하므로 size 속성 추가
    - 그리고 각 sido전체가 필요해서 첫번째 객체에 전체 객체를 생성
    - 편리함을 위해서 sidoList와 gugunList를 두개로 나눔
    - ajax로 넘어오는 json은 객체 : 속성은 두개 sidoList, gugunList
    - 각 sidoList와 gugunList는 배열

    3) ajax 구현
    - 우선 sidogugun 템플릿(id를 whereTmpl로 지정했음) 만들기
    - 그리고 getWhereList 함수 만들기
    - ajax 구현순으로 진행
    
     */
     
   //정진하 2021 01 29 분류 드롭박스 + 카테고리 선택에 따른 밋팅 리스트 가져오기 작성함 
     $(".category_box>li>a").click(function(e){
         e.preventDefault();
         const $this = $(this);
         $(".category_btn").text($this.text());
         $(".category_box").hide();
         
         //alert(this.dataset.categoryNo);
         
      		$.ajax({
  			url:"/ajax/bringMeetingListByCategoryNo.json",
  			dataType:"json",
  			type:"GET",
  			data:{"categoryNo":this.dataset.categoryNo},
  			error:function() {
  				alert("서버 점검 중! 잠시 후 다시 시도해주세요~!");
  			},//error end
  			success:function(json) {
  					$meetingList.html(meetingListByThemeNoTmpl({meetingsBytheme:json}));
  			}//success end
  			
  		});//ajax() end
     });
    
     $(".meeting_category_filter").mouseenter(function () {
         $(".category_box").show();
     });
     
   	//연령대 드롭박스
     $(".age_box>li>a").click(function (e) {
         e.preventDefault();
         const $this = $(this);
         alert(this.dataset.age);
         $(".age_range_btn").text($this.text());
         $(".age_box").hide();
         
         $.ajax({
   			url:"/ajax/bringMeetingListByAgeGroup.json",
   			dataType:"json",
   			type:"GET",
   			data:{"ageGroup":this.dataset.age},
   			error:function() {
   				alert("서버 점검 중! 잠시 후 다시 시도해주세요~!");
   			},//error end
   			success:function(json) {
   					$meetingList.html(meetingListByThemeNoTmpl({meetingsBytheme:json}));
   			}//success end
   			
   		});//ajax() end

     });//연령대 필터 클릭 end
     
     
     $(".age_filter").mouseenter(function (e) {
         $(".age_box").show();
     });
   	
     
   //어디에를 누르면 뜨는 where 팝업
   	const $meetingList = $(".meeting_list");
    const meetingListByThemeNoTmpl = _.template($("#meetingListByThemeNoTmpl").html());
    
    
   	//테마 버튼 클릭하면 해당하는 테마의 밋팅 가져옴 
     $(".theme_list>li").click(function(e){
     	e.preventDefault();
     	console.log(this.dataset.themeNo);
     	alert(this.dataset.themeNo);
     	$.ajax({
 			url:"/ajax/bringMeetingListByThemeNo.json",
 			dataType:"json",
 			type:"GET",
 			data:{"themeNo":this.dataset.themeNo},
 			error:function() {
 				alert("서버 점검 중! 잠시 후 다시 시도해주세요~!");
 			},//error end
 			success:function(json) {
 					alert("json여기로 데려오긴 함");
 					$meetingList.html(meetingListByThemeNoTmpl({meetingsBytheme:json}));
 			}//success end
 			
 		});//ajax() end
     	
     });//click() end 
     
     //$(".specifics_list on>li").click(function(e){
    	 //e.preventDefault();
    	 //const where = $(this).text();
     //});

    //언제 팝업창 관련 자바스크립트 영역
    var today = new Date();//오늘 날짜 얻어오기
    var nextMonth = new Date();
    nextMonth.setMonth(today.getMonth()+1,1);//end picker 다음 달로 설정하기

    //date range picker
    const $dateRangePicker = $("#dateRange").daterangepicker({
        //true면 월,년 select dropdown 생김
        "showDropdowns": false,
        "parentEl": ".pop_when_container",
        //인풋 기준으로 데이트 픽커 어떻게 뜨는지 오/왼/센터 설정하는 것
        //위에 말풍선 위치도 그에 맞춰서 바뀜
        "opens" : "center",
        "locale": {
            "format": "YYYY-MM-DD",
            "separator": " - ",
            "applyLabel": "적용",
            "cancelLabel": "취소",
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": [
                "일",
                "월",
                "화",
                "수",
                "목",
                "금",
                "토"
            ],
            "monthNames": [
                "1월",
                "2월",
                "3월",
                "4월",
                "5월",
                "6월",
                "7월",
                "8월",
                "9월",
                "10월",
                "11월",
                "12월"
            ],
            "firstDay": 1
        },
        "startDate": today,
        "endDate": today,
        //선택할 수 있는 가장 빠른 날짜
        "minDate" : today,
        //선택할 수 있는 가장 먼 날짜(오늘 날짜로 부터 1년 뒤로 설정함)
        "maxDate" : new Date(today.getFullYear() + 1, today.getMonth(), today.getDate())
    }, function(start, end, label) {
        console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
    });
    
    
    $(".applyBtn").click(function(){
    	alert("적용 버튼 눌렸음");
    	const dateRange = $(".drp-selected").text();
    	alert(dateRange);
    	
    	$.ajax({
            url:"/ajax/bringMeetingsByDateRange.json",
            dataType:"json",
            data:{"dateRange":dateRange},
            type:"get",
            error:function() {
                alert("해당 서비스 점검중입니다. 나중에 시도해주세요.");
            },
            success : function (json) {
            	alert("json여기로 데려오긴 함");
				$meetingList.html(meetingListByThemeNoTmpl({meetingsBytheme:json}));
            }
        });//ajax end 
    	
    });


    //어디에를 누르면 뜨는 where 팝업
    const $popWhereContainer = $(".pop_where_container");
    const whereTmpl = _.template($("#whereTmpl").html());
    
    
    const $whereFilter = $(".search_specifics .where");
    const $popWhereWrap = $(".pop_where_wrap");
    
    function getWhereList() {

        $.ajax({
            url:"/ajax/where.json",
            dataType:"json",
            type:"get",
            error:function() {
                alert("해당 서비스 점검중입니다. 나중에 시도해주세요.");
            },
            success : function (json) {
                $popWhereContainer.html(whereTmpl(json));
            }
        });

    }//getWhereList end

    //어디서 버튼 누르면 팝업창 뜰 수 있도록 함
    $whereFilter.click(function (e) {
        e.preventDefault();
        getWhereList();
        $popWhereWrap.addClass("on");
        $("html").addClass("on");
    });

    const $popCloseButton = $(".pop_close_button");
    
    //어디서 팝업창 사라지는 함수 선언
    function removeWherePop(){
    	$popWhereWrap.removeClass("on");
        //다시 눌렀을 때 빈 상태에서 다시 시작하게 하기 위함.
        $(".states_specifics>ul").removeClass("on");
        $("html").removeClass("on");
    }//removeWherePop() end 

    //엑스버튼 누르면 어디서 팝업창 꺼지도록
    $popCloseButton.click(function () {
    	removeWherePop();
    });

    //한 지역 누르면 세부 지역 뜨게 하기
    //(변경된 점은 ajax로 만들어진 li에 이벤트리스너를 붙이기 위해서 on 인자 3개짜리 사용!!!!)
    $popWhereContainer.on("click",".korea_states li",function (e) {
        e.preventDefault();
        const sequence = $(this).index();
        $(".states_specifics>ul").removeClass("on");
        $(".states_specifics>ul").eq(sequence).addClass("on");
    });
    
    
    //ajax로 만들어진 li에 이벤트리스너를 붙이기 위해서 on 인자 3개짜리 사용!!!! 
    //위치 정보 보내서 밋팅 리스트 가져오기 위해 작성함.
    $popWhereContainer.on("click",".specifics_list>li .at",function (e) {
        e.preventDefault();
        const locationInfo = $(this).text();
        alert(locationInfo);
        
        $.ajax({
            url:"/ajax/bringMeetingsByUsingLocationInfo.json",
            dataType:"json",
            data:{"locationInfo":locationInfo},
            type:"GET",
            error:function() {
                alert("해당 서비스 점검중입니다. 나중에 시도해주세요.");
            },
            success : function (json) {
            	removeWherePop();
            	alert("json여기로 데려오긴 함");
				$meetingList.html(meetingListByThemeNoTmpl({meetingsBytheme:json}));
            }
        });//ajax end 
        
    });

    let left = 0;
    let idx = 0;
    const $themeNextBtn = $(".next");
    const $themePrevBtn = $(".prev");
    const $themeList = $(".theme_list");
    const $themeWrap = $(".theme_wrap");
    const $meetingTitle = $(".meeting_title");

    //다음 버튼 클릭시 테마 박스 길이만큼 움직이게 함
    $themeNextBtn.click(function () {
       const width = $themeList.children().eq(idx++).width();

        left -= (width+28);

        $themeList.css("left",left);
        if(idx==5){
            $themeNextBtn.hide();
        }
    });//.next click() end
    //이전 버튼 클릭시 테마 박스 길이만큼 움직이고 idx=0이 된 후에는 더이상 움직이지 않도록
    $themePrevBtn.click(function () {
        const width = $themeList.children().eq(--idx).width();
        left += (width+28);
         if(idx !== 5) {
             $themeNextBtn.show();
         }//if end
        if(idx < 0){
            left=0;
            idx=0;
        }
        $themeList.css("left",left);
     });//.prev click() end

    const $meetingTap = $(".meeting_tab");

    //정착된 크루탭 클릭하기
    $meetingTap.children().eq(1).click(function (e) {
        const title = $(this).text();
        e.preventDefault();
        $(".search_specifics").children().eq(1).hide();
        $meetingTitle.text(title).css({
            fontSize: 30+"px",
            color: "#424242"
        });
        $themeWrap.hide();
    });
    //미팅탭 누를 때 신청 가능한 밋팅으로 글씨 바뀌게 하기
    $meetingTap.children().eq(0).click(function (e) {
        e.preventDefault();
        $(".search_specifics").children().eq(1).show();
        $meetingTitle.text("신청 가능한 밋팅").css({
            fontSize: 30+"px",
            color: "#424242"
        });
        $themeWrap.show();
    });

    $(".meeting_tab li").click(function (e) {
        e.preventDefault();
        $(".meeting_tab li").removeClass("on");
        $(this).addClass("on");
    });

    const $whenFilter = $(".search_specifics .when");
    const $popWhenWrap = $(".pop_when_wrap");

    //언제 버튼 누르면 팝업창 뜰 수 있도록 함
    $whenFilter.click(function (e) {
        e.preventDefault();

        $popWhenWrap.addClass("on");

        //스크롤 width 17px 만큼 이동하지 않게하기 위함
        $("html").addClass("on");

        //change the selected date range of that picker
        $dateRangePicker.data('daterangepicker').setStartDate(today);
        $dateRangePicker.data('daterangepicker').setEndDate(today);
        //선택 되어있던 날짜 언제 팝업창 뜰 때 선택 해제되어 있게 하기 위함

        $dateRangePicker.click().show();
    });

    //hide.daterangepicker: Triggered when the picker is hidden
    $dateRangePicker.on("hide.daterangepicker",function(evt,picker) {
        //취소,적용 버튼 누른 후에 언제 팝업창 꺼지게 하기 위함
        //데이트 픽커 날짜 선택 후 안 사라지게 하는 방법은 없어서
        $popWhenWrap.removeClass("on");
        $("html").removeClass("on");
        //console.log(ev.isPropagationStopped());
        console.log("hide.daterangepicker");
        console.log(picker.startDate.format('YYYY-MM-DD'));
        console.log(picker.endDate.format('YYYY-MM-DD'));

    });

    //apply.daterangepicker: Triggered when the apply button is clicked, or when a predefined range is clicked
    $dateRangePicker.on("apply.daterangepicker",function(evt,picker) {

        $popWhenWrap.removeClass("on");
        $("html").removeClass("on");
        //console.log(ev.isPropagationStopped());
        console.log("hide.daterangepicker");
        console.log(picker.startDate.format('YYYY-MM-DD'));
        console.log(picker.endDate.format('YYYY-MM-DD'));

    });

    //cancel.daterangepicker: Triggered when the cancel button is clicked
    $dateRangePicker.on("cancel.daterangepicker",function(evt,picker) {
        $popWhenWrap.removeClass("on");
        $("html").removeClass("on");
    });
    const $whenCloseBtn = $(".when_close_btn");



    $whenCloseBtn.click(function () {
            $popWhenWrap.removeClass("on");
            $("html").removeClass("on");
        });
    
   

</script>

</body>
</html>