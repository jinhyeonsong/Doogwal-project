<%@page import="com.doogwal.coffee.dao.CrewsDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.doogwal.coffee.dao.ApplyCrewsDAO"%>
<%@page import="com.doogwal.coffee.vo.ApplyCrew"%>
<%@page import="com.doogwal.coffee.dao.CrewHistorysDAO"%>
<%@page import="com.doogwal.coffee.vo.CrewHistory"%>
<%@page import="com.doogwal.coffee.dao.RulesDAO"%>
<%@page import="com.doogwal.coffee.vo.Rule"%>
<%@page import="com.doogwal.coffee.dao.PreparationsDAO"%>
<%@page import="com.doogwal.coffee.vo.Preparation"%>
<%@page import="com.doogwal.coffee.dao.ThemesDAO"%>
<%@page import="com.doogwal.coffee.vo.Theme"%>
<%@page import="com.doogwal.coffee.dao.CategoriesDAO"%>
<%@page import="com.doogwal.coffee.vo.Category"%>
<%@page import="com.doogwal.coffee.dao.MeetingsDAO"%>
<%@page import="com.doogwal.coffee.vo.Meeting"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>밋팅 디테일</title>
    <%@ include file="/WEB-INF/template/link.jsp" %>
    <link rel="stylesheet" href="css/tui-chart.min.css" />
    <link rel="stylesheet" href="css/meetinghistory.css" />
    <%
	// http://localhost/meetingDetail.jsp?meetingNo=7000
	int meetingNo = Integer.parseInt(request.getParameter("meetingNo"));
    Meeting meetings = MeetingsDAO.selectDetailOne(meetingNo);
   
    // 대결인지 친목인지
    char type = meetings.getType();
    String typeStr;
    if(type=='F') typeStr = "대결";
    else typeStr = "친목";
    
    Category category = CategoriesDAO.selectOne(meetings.getCategoryNo());
    Theme theme = ThemesDAO.selectOne(meetings.getThemeNo());
    List<Preparation> preparations = PreparationsDAO.selectList(meetingNo);
    List<Rule> rules = RulesDAO.selectList(meetingNo);
    Crew crew = CrewsDAO.select(meetings.getCrewNo());
    int crewNo = meetings.getCrewNo();
    System.out.println(crewNo);
    
    String point;
    if(meetings.getType()=='F'){
    	point = "-"+meetings.getPoint()+"P 신청하기";
    }
    else{ 
    	point = "신청하기";
    }
    List<CrewHistory> crewhistorys= CrewHistorysDAO.selectList(meetings.getCrewNo());
    
    %>
</head>

<body>
<%@ include file="/WEB-INF/template/header.jsp"  %>
<%

// 외부접속자가 임원일때: 1
// 외부접속자가 회원이면: 0
int flag = 0;

// 밋팅 만든 크루의 임원진이면: 1
int myCrew = 0;

// 밋팅 만든 크루의 회원이면:1
int myCrewM = 0;
                		
for(CrewMember cm : userCrews){
    if(cm!=null){
    	if(cm.getRole()!='M'){flag=1;}//flag가 1이면 운영진
    	if((cm.getCrewNo()==meetings.getCrewNo())&&(cm.getRole()!='M')){myCrew=1;}//자기가 속한 크루이면서 임원진일 때
    	if((cm.getCrewNo()==meetings.getCrewNo())&&(cm.getRole()=='M')){myCrewM=1;}//자기가 속한 크루이면서 회원일 때
	}//else end  
}//for end


List<ApplyCrew> applycrews = ApplyCrewsDAO.selectList(meetingNo);

// 밋팅을 신청한 크루의 갯수
int applycrewcount = 0;

// 자기가 속한 외부 크루가 밋팅을 신청하면:1 
int applycrewmycrewcount = 0;

// 자기가 만든 밋팅이면서 수락한게 있으면: 1()
int applymycrew=0;

for(ApplyCrew applycrew : applycrews){
	if(applycrew.getClass()!=null){
		for(CrewMember cm : userCrews){
			if(cm==null){
				break;
			}
			
			else if(cm.getCrewNo()==applycrew.getApplyCrewNo()){
				applycrewmycrewcount=1;
			}//자기가 속한 크루가 신청하였을 때
			if(applycrew.getAcceptance()=='A'){
				applymycrew=1;
			}//승락한 크루가 있을 경우
		}
		applycrewcount++;
	}	
}
%>
    <div id="content">
        <!-- content -->
        <div class="classificationl_box">
            <!--classificationl_box-->
            <i class="fas fa-arrow-left"></i>
            <div><%=typeStr%></div>
            <div><%=category.getNameParents() %></div>
            <div><%=category.getName() %></div>
            <div><%=theme.getTheme() %></div>
        </div>
        <!--//classificationl_box-->
        <div class="description_box">
            <h2 class="meeting_name"><%=meetings.getName() %></h2>
            <div class="description_contents">
                <div class="description_contents_img_box">
                    <h3 class="description_meeting_time"><%=meetings.getStartDateDetail() %></h3>
                    <img src="<%=meetings.getImg() %>" width="400" height="200">

                </div>
                <!--//sdescription_contents_child1-->
                <div class="description_contents_child2">
                    <h3 class="description_meeting_address"><%=meetings.getAddress() %></h3>
                    <div class="map_wrap">
                        <div id="map" class="local_map"></div>
                        <div class="custom_zoomcontrol radius_border">
                            <span onclick="zoomIn()"><img
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png"
                                    alt="확대"></span>
                            <span onclick="zoomOut()"><img
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png"
                                    alt="축소"></span>
                        </div>
                    </div>

                </div>
                <!--//description_contents_child2-->
                <div class="description_contents_apply">
                    <img src="<%=crew.getCoverImg() %>" width="100" height="100">
                    <div><%=crew.getName() %></div>

                    <%if(applycrewcount<3){ %>

                    <%if(flag==1&&myCrew==0){ %>
                    <!-- 운영진이지만 나의 크루가 아닐때 -->
                    <%if(applycrewmycrewcount==0){ %>
                    <!-- 자기 크루가 신청하지 않았을 때 -->
                    <div class="btn_apply"><%=point %></div>
                    <div class="time_remaining">수락까지 남은 시간 <br><span class="remain_time"></span></div>
                    <%} %>
                    <%if(applycrewmycrewcount==1){ %>
                    <!-- 자기가 속한 크루가 이미 신청을 했을 경우 -->
                    <div class="application_deadline">신청 완료</div>
                    <%} %>
                    <%} %>
                    <!-- end 운영진이지만 나의 크루가 아닐때 -->

                    <%if(flag==0&&myCrewM==0){ %>
                    <!-- 회원이며 나의 크루가 아닐 때 -->
                    <%if(applycrewmycrewcount==0){ %>
                    <!-- 자기가 속한 크루가 만든 밋팅이 아닐 경우 -->
                    <div class="application_deadline">운영진만 신청 가능</div>
                    <%} %>

                    <%if(applycrewmycrewcount==1){ %>
                    <!-- 자기가 속한 크루가 이미 신청을 했을 경우 -->
                    <div class="application_deadline">신청 완료</div>
                    <%} %>
                    <%} %>
                    <!-- end 회원이며 나의 크루가 아닐 때 -->

                    <%if((myCrewM==1||myCrew==1)&&(applymycrew==0)){ %>
                    <!-- 자기가 속한 크루일 때 -->
                    <div class="application_deadline">신청 받는 중....</div>
                    <%} %>
                    <%if((myCrewM==1||myCrew==1)&&(applymycrew==1)){ %>
                    <!-- 자기가 속한 크루일 때 -->
                    <div class="application_deadline">밋팅 성사</div>
                    <%} %>

                    <%} %>
                    <!-- if제일 큰 부모 -->

                    <%if(applycrewcount>=3){ %>
                    <!-- 3개 이상의 크루가 신청 시  -->
                    <%if(applycrewmycrewcount==0&&(applymycrew==0)){ %>
                    <div class="application_deadline">밋팅 성사 대기중....</div>
                    <%} %>
                    <%if(applycrewmycrewcount==1&&(applymycrew==0)){ %>
                    <div class="application_deadline">밋팅 성사 대기중....</div>
                    <%} %>
                    <%if(applycrewmycrewcount==1&&(applymycrew==1)){ %>
                    <div class="application_deadline">밋팅 성사</div>
                    <%} %>
                    <%if(applycrewmycrewcount==0&&(applymycrew==1)){ %>
                    <div class="application_deadline">밋팅 성사</div>
                    <%} %>

                    <%} %>
                    <!--end 3개 이상의 크루가 신청 시  -->
                </div>
                <!--//description_contents_child3-->
            </div>
            <!--//description_contents-->
        </div>
        <!--//description-->

        <div class="section_second">
            <div class="rule_box">
                <div class="section_second_subtitle">규칙</div>
                <ul>
                    <% for(Rule rule : rules){ %>
                    <li>
                        <i class="far fa-check-square"></i>
                        <span class=""><%=rule.getRule() %></span>
                    </li>
                    <%}%>  
                </ul>
            </div><!--//rule_box-->
            <div class="materials_box">
                <div class="section_second_subtitle">준비물</div>
                <ul>
                <% for(Preparation preparation : preparations){ %>
                    <li>
                        <i class="far fa-check-square"></i>
                        <span class=""><%=preparation.getPreparation() %></span>
                    </li>
                    <%}%>                  
                </ul>
            </div><!--//materials_box-->
        </div><!--//section_second-->

        <div class="section_third">
            <div class="section_third_title">신청한 크루</div>
            <ul id="applyCrewList">
            </ul>
        	<%	
        	if(myCrew==1&&applymycrew==0){ //나의 크루이면서 임원일 때
       		 %>
                    <div class="choosing_btn">고르기</div>
                    <%} %>
            </div>
            <!--//section_third-->

            <div class="section_fourth">
                <div class="history_crew_name"><%=crew.getName() %></div><span> 히스토리</span>
                <div class="history_box_main">
                    <div class="battle_history">
                        <%	
				    int win = 0;
				    int lose = 0;
				    int draw = 0;
				    for(CrewHistory crewhistory : crewhistorys){  
				    	if(crewhistory.getType()=='W'){win++;}
	                    else if(crewhistory.getType()=='L'){lose++;}
	                    else if(crewhistory.getType()=='D'){draw++;}
				    } %>
                        <div class="battle_total">대결 <%=win %>승 <%=draw %>무 <%=lose %>패</div>
                        <button class="battle_view_more">대결 더 보기</button>
                        <ul>
                            <%
                    String resultStr;
                    int count = 0;
                    for(CrewHistory crewhistory : crewhistorys){                    	
                    if(crewhistory.getType()=='W'){resultStr="승";}
                    else if(crewhistory.getType()=='L'){resultStr="패";}
                    else{resultStr="후기 기다리는 중";}
                    if(count<3){ //3개의 크루만 보여주기
                    %>
                            <li class="crew_battle_history_content">
                                <img src="<%=crewhistory.getCoverImg() %>">
                                <div>
                                    <p><%=crewhistory.getMeetingName() %></p>
                                    <p><%=crewhistory.getCrewName()%></p>
                                    <p><%=crewhistory.getStartDateDetail()%></p>
                                </div>

                                <%if(crewhistory.getType()=='W'||crewhistory.getType()=='L') {%>
                                <div class="match_result"><%=resultStr %></div>
                                <%} %>
                                <%if(crewhistory.getType()=='D'||crewhistory.getType()=='B') {%>
                                <div class="waiting_for_the_review"><%=resultStr %></div>
                                <%} %>
                            </li>
                            <%}count++;} %>
                        </ul>
                    </div>
                    <!--//battle_history-->
                    <div class="amity_history">
                        <div class="amity_total">친목</div>
                        <button class="amity_view_more">친목 더 보기</button>
                        <div id="chart-area"></div>
                    </div>
                </div>
                <!--//history_box-->
            </div>
            <!--//section_fourth-->

        </div>
        <!--//content -->
        <div id="meetingRequestPop">
            <div id="popWrap">
                <div id="popContainer">
                    <!--popContainer-->
                    <form>
                        <div class="times"><i class="fas fa-times"></i></div>
                        <div class="guide">
                            <p>상대 크루에게 한 마디 해주세요</p>
                        </div>
                        <textarea maxlength="30" cols="30" id="contentInputField" class="content_input_field"
                            placeholder="내용을 꼭 입력해주세요.(최대30자)"></textarea>
                        <div class="counting_characters">(0/30)자</div>
                        <ul>
                <%        		
				for(CrewMember cm : userCrews){
				    if(cm==null){;}
				    else{
				    	if((cm.getRole()!='M')){
				    		 Crew toapplycrew = CrewsDAO.select(cm.getCrewNo());
				%>
                            <li>
                                <label class="box-radio-input" for="cp_item1">
                                    <input type="radio" name="cp_item" id="cp_item1" value="<%=toapplycrew.getNo() %>">
                                    <div class="crew_box">
                                        <div class="icon_check"><i class="fas fa-check"></i></div>
                                        <img src="<%=toapplycrew.getCoverImg() %>">
                                        <p><%=toapplycrew.getName() %></p>
                                    </div>
                                </label></li>
                            <%}//if end
			  }//else end
			  }//for end %>
                        </ul>
                        <button class="meeting_request_confirm_btn" type="button">확인</button>
                    </form>
                </div>
                <!--//popContainer-->
            </div>
        </div>
        <!--//meetingRequestPop end -->
        <%@ include file="/WEB-INF/template/footer.jsp" %>
<script type="text/template" id="applyCrewTmpl">
<@ 
let acc = 0;
_.each(crew,function(c){
if(c.acceptance=='A'){acc=1;}
})@>
<@ _.each(crew,function(c){
if(c.type==null) c.type = "";
let type = c.type;
let typeArray = type.split(',');
let idx = 0;
let win = 0;
let lose = 0;
let draw = 0;
while(idx<typeArray.length)
{
	if(typeArray[idx]=='W') {win++; idx++;}
    else if(typeArray[idx]=='L') {lose++; idx++;}
 	else if(typeArray[idx]=='D') {draw++; idx++;}
	else idx++;
}
let total = win+"승 "+draw+"무 "+lose+"패";
@>
    <li>
        <input type="radio" id="<@=c.applyCrewNo@>" value="<@=c.applyCrewNo@>" name="check_crew" <@if(c.acceptance=='A'){@> checked <@}@> <@if(acc==1){@> disabled <@}@> >
        <label for="<@=c.applyCrewNo@>">
            <div>
                <img src="<@=c.coverImg@>">
                <p><@=c.name@></p>
            </div>
            <div>
                <p><@=c.introduce@></p>
                <p><@=total@></p>
            </div>
        </label>
    </li>
    <@})@>
</script>
<script>
    /*템플릿 시작*/
    //% -> @ 으로
    _.templateSettings = {
        interpolate: /\<\@\=(.+?)\@\>/gim,
        evaluate: /\<\@([\s\S]+?)\@\>/gim,
        escape: /\<\@\-(.+?)\@\>/gim
    };
</script>
<%@ include file="/WEB-INF/template/meetingHistory.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9461990ea008279ad054cf44109aa103&libraries=services">
</script>
<script>
    //--------------------------------------------------------------------------------주소 찾기 . 지도 보이기
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng( <%= meetings.getLat() %> , <%= meetings.getLng() %> ), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };
    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng( <%= meetings.getLat() %> , <%= meetings.getLng() %> ),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                var addr = data.address; // 최종 주소 변수
                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                //---------------------------------------------------------------------주소 우회
                document.getElementById("addressContent").innerHTML = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function (results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }

    // 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
    function zoomIn() {
        map.setLevel(map.getLevel() - 1);
    }

    // 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
    function zoomOut() {
        map.setLevel(map.getLevel() + 1);
    }
    //end 주소 찾기 . 지도 보이기


    const applyCrewsTmpl = _.template($('#applyCrewTmpl').html());
    const $applyCrewList = $('#applyCrewList');

    $.ajax({
        url: "/ajax/applyCrewList.json",
        type: 'GET',
        data: {
            no: <%= meetingNo %>
        },
        error: function (xhr, error, code) {
            alert("에러:" + code);
        },
        success: function (json) {
            console.log(json);
            $applyCrewList.html(applyCrewsTmpl({
                crew: json
            }));
        }
    });


    $(".btn_apply").click(function () {
        $("#meetingRequestPop").addClass("appear");
        $html.addClass("on");
    });

    $(".times").click(function () {

        $("#meetingRequestPop").removeClass("appear");
        $html.removeClass("on");

    }); //click() end

    $(".meeting_request_confirm_btn").click(function () {
        let val = $('.content_input_field').val();
        if (val.length < 1) {
            $(".content_input_field").css("border-color", "rgb(255, 91, 51)")
            $('.counting_characters').text("입력해주세요!!").css("color", "rgb(255, 91, 51)");
        }

        if ($("input:radio[name=cp_item]:checked").length < 1) {
            alert("신청할 크루를 선택하세요");
        }

        var crewNo = $(":input:radio[name=cp_item]:checked").val();
        var introduce = $("textarea#contentInputField").val();

        if ((val.length > 1) && ($("input:radio[name=cp_item]:checked").length == 1)) { //ajax 추가 


            $.ajax({
                url: "/ajax/toApplyCrew",
                type: 'GET',
                data: {
                    introduce: introduce,
                    crewNo: crewNo,
                    meetingNo: <%= meetingNo %>
                },
                error: function (xhr, error, code) {
                    alert("에러:" + code);
                },
                success: function () {
                    $.ajax({
                        url: "/ajax/applyCrewList.json",
                        type: 'GET',
                        data: {
                            no: <%= meetingNo %>
                        },
                        error: function (xhr, error, code) {
                            alert("에러:" + code);
                        },
                        success: function (json) {
                            console.log(json);
                            $applyCrewList.html(applyCrewsTmpl({
                                crew: json
                            }));
                        }
                    });

                    $("#meetingRequestPop").removeClass("appear");
                    $html.removeClass("on");

                    $(".btn_apply").hide();
                    $(".time_remaining").hide();

                    const $apply = $("<div class='application_deadline'>신청 완료<div>");
                    $apply.appendTo(".description_contents_apply");
                } //success
            }); //ajax
        } //if문
    });


    $(".choosing_btn").click(function () {
        var radioVal = $('input[name="check_crew"]:checked').val();
        $.ajax({
            url: "/ajax/meetingApplicationUpdate",
            type: 'GET',
            data: {
                crewNo: radioVal,
                meetingNo: <%= meetingNo %>
            },
            error: function (xhr, error, code) {
                alert("에러:" + code);
            },
            success: function () {
                $.ajax({
                    url: "/ajax/applyCrewList.json",
                    type: 'GET',
                    data: {
                        no: <%= meetingNo %>
                    },
                    error: function (xhr, error, code) {
                        alert("에러:" + code);
                    },
                    success: function (json) {
                        console.log(json);
                        $applyCrewList.html(applyCrewsTmpl({
                            crew: json
                        }));
                    }
                });

                $(".choosing_btn").hide();
                $(".application_deadline").text("밋팅 성사");
            } //success
        }); //ajax
    })

    //시간 차이 보여줌 1초마다 차이가 줄어듦
    //let meetingDue = 미팅시간-3일
    let tid;
    var stDate = new Date().getTime();
    var edDate = new Date('<%=meetings.getRegDate()%>').getTime(); // 종료날짜
    var RemainDate = edDate - stDate;
    setInterval(function () {
        tid = displaytime();
    }, 1000); // 신청까지 남은시간 end
    function displaytime() {
        var day = Math.floor(RemainDate / (1000 * 60 * 60 * 24));
        var hours = Math.floor((RemainDate % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var miniutes = Math.floor((RemainDate % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((RemainDate % (1000 * 60)) / 1000);

        m = day + "일 " + hours + "시간 " + miniutes + "분 " + seconds + "초"; // 남은 시간 text형태로 변경

        if (RemainDate < 0) {
            // 시간이 종료 되었으면..
            clearInterval(tid); // 타이머 해제
            m = "";
            $(".choosing_btn").hide();
            $(".btn_apply").hide();
            $(".application_deadline").text("기간 만료");
            $(".time_remaining").text("기간 만료").css({
                "margin-top": "20px",
                "font-size": "30px",
                "font-weight": "900",
                "color": "red"
            });
        } else {
            RemainDate = RemainDate - 1000; // 남은시간 -1초
        }
        // text 표시
        $(".remain_time").text(m);

    } //displayTime() end
    
  //밋팅 history chart 시작
    var container = document.getElementById('chart-area');
    var data = {
        categories: ["매너", "실력", "화목", "의욕", "단합"],
        series: [
            {
                // name: 'Budget',
                data: [25/50, 23/50, 22/50, 11/50, 20/50]
            }
        ]
    };
    var options = {
        chart: {
            title: '',
            width: 500,
            height: 480
        },
        series: {
            showDot: false,
            showArea: false
        },
        plot: {
            type: 'circle',
            hideLine: true// whether hide line or not

        },
        legend: {
            visible: false
        },
        chartExportMenu: {
            visible: false
        },
        yAxis:{
            min:0,
            max:1
        }
    };

    var theme = {
        series: {
            colors: [
                '#424242'
            ]
        }
    };// For apply theme

    tui.chart.registerTheme('myTheme', theme);
    options.theme = 'myTheme';
    // 생성자()
    const chart = tui.chart.radialChart(container, data, options);
    chart.on('afterShowTooltip', function(params) {
        chart.hideTooltip();
    });
    chart.on('beforeHideTooltip', function(params) { /* 3 */
        chart.hideTooltip();
    });
    //밋팅 history chart end
    
    
    /*밋팅 신청하기 자바스크립트 시작*/
    //textarea 내에 글자수 세기
    $('.content_input_field').keyup(function (e) {
        let val = $('.content_input_field').val();
        val = val.substr(0, 30);
        $('.content_input_field').val(val);
        $('.counting_characters').text("(" + val.length + " / 30자)").css("color", "black");
        if (val.length > 1) {
            if ($("input:radio[name=cp_item]:checked").length == 1) {
                $(".meeting_request_confirm_btn").css("background-color", "rgb(255, 91, 51)");
            }
        } else {
            $(".meeting_request_confirm_btn").css("background-color", "#424242");
        }
    });

    //end textarea 내에 글자수 세기
    $('.content_input_field').blur(function (e) {
        let val = $('.content_input_field').val();
        if (val.length > 1) {
            $(".content_input_field").css("border-color", "rgb(190, 190, 190)")
            if ($("input:radio[name=cp_item]:checked").length == 1) {
                $(".meeting_request_confirm_btn").css("background-color", "rgb(255, 91, 51)");
            }
        } else {
            $(".content_input_field").css("border-color", "rgb(255, 91, 51)")
        }
    });
	
    $(".box-radio-input").click(function () {
        let val = $('.content_input_field').val();
        if (val.length > 1) {
            $(".meeting_request_confirm_btn").css("background-color", "rgb(255, 91, 51)");
        } else {
            $(".meeting_request_confirm_btn").css("background-color", "#424242");
        }
    })
    
    
</script>
</body>

</html>