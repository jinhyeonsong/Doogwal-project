<%@page import="com.doogwal.coffee.dao.PreparationsDAO"%>
<%@page import="com.doogwal.coffee.vo.Preparation"%>
<%@page import="java.util.List"%>
<%@page import="com.doogwal.coffee.dao.SchedulesDAO"%>
<%@page import="com.doogwal.coffee.dao.GatheringsDAO"%>
<%@page import="com.doogwal.coffee.vo.Gathering"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 //http://localhost/gathering.jsp?no=500
	//파라미터 no를 얻기
	String noStr = request.getParameter("no");
	//형변환
	int no = Integer.parseInt(noStr);

	Gathering gathering = GatheringsDAO.selectOne(no);
	Gathering schedule = SchedulesDAO.selectOne(no);
	List<Preparation> preparations = PreparationsDAO.selectList(no);
	
	String date = String.valueOf(schedule.getStartDate());
	String[] timeToken = date.split(" ");
	String endTime = String.valueOf(schedule.getEndDate());
	String[] endTimeToken = endTime.split(" ");
	
%>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>font awesome 아이콘 사용</title>
<%@ include file="/WEB-INF/template/link.jsp" %>
    <style>
        #header{
            z-index: 10;
            background-color: white;
            position: fixed;
        }
        #container{
            position: relative;
        }
        #footer{
            margin-top: 200px;
        }
        /*12-18*/
        #content{
            width: 1080px;
            margin: auto;
        }
        .form_title{ /*"모임 개설하기*/
            font-size: 40px;
            text-align: center;
            margin: 30px 0;
        }
        .first_td{ /*각 열의 첫번째 행*/
            width: 200px;
            height: 100px;
            font-size: 30px;
            text-align: center;
            line-height: 100px;
            background-color: #3EB39D;
            color: white;
            border-bottom: 1px solid #bebebe;
        }
        .second_td{/*두번 째 td*/
            width: 850px;
            padding-left: 60px;
            border:1px solid #bebebe;
            vertical-align: middle;
        }
        .input_time{ /*<input> 시간  */
            width: 150px;
            height: 30px;
            vertical-align: middle;
        }
        .date_input{ /*<input> 날자 */
            height: 30px;
            width: 150px;
            margin-right: 30px;
        }
        .local_input input{/*주소, 상제주소*/
            display: block;
            margin-top: 6px;
        }
        .local_map{/*지도 공간*/
            background-color: #bebebe;
            width: 431px;
            height: 303px;
            position: absolute;
            left: 60%;
            top: 402px;
        }
        .check_date{/*<checkbox> 하루종일, '원'*/
            vertical-align: bottom;
            font-size: 20px;
        }
        /*------------------------------------------12-19*/
        .meet_name{/* <p>모임 이름*/
            font-size: 40px;
            font-weight: 900;
        }
        .meet_content{ /* <p>모임 상세*/
            width: 340px;
            height: 90px;
            font-size: 18px;
            line-height: 24px;
        }
        .dues{ /* <p>가격(1234원) */
            font-size: 20px;
        }
        .materials_item{ /* <p> 각 준비물 */
            font-size: 20px;
            margin: 10px 0;
        }
        /*-----------------------------12-20참석여부 box*/
        .attendance_status_box{ /* 참석여부 공간 */
            width: 1078px;
            height: 440px;
            border: 1px solid rgb(190, 190, 190);
            border-top: none;
            position: relative;
        }
        .attend_box{ /* 참석 공간 */
            width: 538px;
            height: 440px;
            float: left;
            border-right: 1px solid black;
            /*background-color: #bebebe;*/
            padding-top: 30px;
            padding-left: 30px;
            box-sizing: border-box; /*padding을 주면 div가 커진다 이 문제를 해결하기 위해서 넣음*/
        }
        .attend_btn:hover{ /* 참석 버튼 오버시 */
            cursor: pointer;
        }
        .attend_title,.no_attend_title{/* 참석,불참 버튼 */
            width: 100px;
            height: 100px;
            background-color: #bebebe;
            border-radius: 50%;
            text-align: center;
            line-height: 100px;
            font-size: 40px;
            font-weight: 900;
            color: white;
            display: inline-block;
            margin-bottom: 30px;
        }
        .attend_box input[type="radio"]{/* 참석 버튼에서 radio 안보이게 두기*/
            display: none;
        }
        .attendees,.non_attendees{ /* "X명" */
            margin-left: 50px;
            font-size: 30px;
            font-weight: 500;
        }
        .attend_box ul{ /* 프로필 사진 공간 */
            width: 478px;
            height: 280px;
            /*background-color: #bebebe;*/
            padding-left: 36px;
            box-sizing: border-box; /*padding을 주면 div가 커진다 이 문제를 해결하기 위해서 넣음*/
        }
        .attend_box ul:hover{ /* 프로필 사진 공간 오버시 펼쳐지기 */
            width: 890px;
            /*width: 1020px;*/
            padding-left: 0;
            background-color: #FF6333;
            border-radius: 8px;
            position: absolute;
        }
        .attend_box ul:hover img{ /* 프로필 사진 공간 오버시 펼쳐지기 */
            margin-left: 8px;
        }
        .attendees_img{ /* 프로필 사진 */
            width: 80px;
            height: 80px;
            border-radius: 50%;
            float: left;
            margin-left: -36px;
            margin-top: 10px;
        }
        /*---------------------미참석 공간-------------------*/
        .no_attend_box{ /* 미참석 공간 */
            width: 539px;
            height: 440px;
            float: left;
            /*background-color: #bebebe;*/
            padding-top: 30px;
            padding-left: 30px;
            padding-right: 30px;
            box-sizing: border-box; /*padding을 주면 div가 커진다 이 문제를 해결하기 위해서 넣음*/
        }
        .no_attend_box input[type="radio"]{/* 참석 버튼에서 radio 안보이게 두기*/
            display: none;
        }
        .no_attend_btn:hover{ /* 미참석 버튼 오버시 */
            cursor: pointer;
        }
        .no_attend_box ul{ /* 불참 프로필 사진 공간 */
            width: 478px;
            height: 280px;
            /*background-color: #bebebe;*/
            padding-left: 36px;
            box-sizing: border-box; /*padding을 주면 div가 커진다 이 문제를 해결하기 위해서 넣음*/
        }
        .no_attend_box ul:hover{ /* 프로필 사진 공간 오버시 펼 쳐지기 */
            width: 890px;
            /*width: 1020px;*/
            padding-left: 0;
            background-color: #FFAB40;
            border-radius: 8px;
            float: right;
        }
        .no_attend_box ul:hover img{ /* 프로필 사진 공간 오버시 펼쳐지기 */
            margin-left: 8px;
        }
        .attend_btn input[type="radio"]:checked+.attend_title{/*참석여부에 따른 버튼 색*/
            background-color: #3EB39D;
        }
        .no_attend_btn input[type="radio"]:checked+.no_attend_title{/*참석여부에 따른 버튼 색*/
            background-color: #3EB39D;
        }
        .attendees_img.my_img{/*나의 사진 강조*/
            border: 5px solid #3EB39D;
            width: 70px;
            height: 70px;
        }
        /*    12-24*/
        .not_required{/*지도에서 필요없는 것들*/
            display: none;
        }
        .my_address_label{ /*<input>주소 라벨 */
            display: inline-block;
            width: 350px;
            height: 40px;
            border: 1px solid #bebebe;
            vertical-align: middle;
            font-size: 20px;
            text-align: center;
            line-height: 40px;
            pointer-events: none;
        }
        .my_address_label:hover{ /*<input>주소 라벨 오버시 */
            cursor: pointer;
            box-shadow:1px 1px 1px 1px #999;
        }
        .local_map{/*지도 공간*/
            background-color: #bebebe;
            width: 431px;
            height: 303px;
            position: absolute;
            left: 60%;
            top: 402px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/template/header.jsp" %>
<%
int number=0;
for(CrewMember cm : userCrews){
    if(cm!=null){
    	if(cm.getCrewNo()==schedule.getCrewNo()){number=cm.getNo();}
    	System.out.println(cm.getCrewNo());
    	System.out.println(schedule.getCrewNo());
    	System.out.println(number);
	}//else end  
}//for end 
%>
    <!-- content -->
    <div id="content">

        <div class="form_title"><h1>모임 상세</h1></div>
        <table>
            <tr>
                <td class="first_td">모임 이름</td>
                <td class="second_td">
                    <p class="meet_name"><%=schedule.getName()%></p>
                </td>
            </tr>
            <tr>
                <td class="first_td">날짜</td>
                <td class="second_td">
                    <input type="date" class="date_input" disabled value="<%=timeToken[0]%>">
                    <input type="time" class="input_time" disabled value="<%=timeToken[1]%>">
                    <span class="">~</span>
                    <input type="time" class="input_time" disabled value="<%=endTimeToken[1]%>">
                    <!--<label class="check_date"><input type="checkbox" disabled>하루종일</label>-->
                </td>
            </tr>
            <tr class="local_input">
                <td class="first_td">장소</td>
                <td class="second_td">
                    <div class="not_required">
                        <input type="text" id="sample5_address" placeholder="주소">
                        <input id="address_content" type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
                    </div>
                    <label for="address_content" class="my_address_label" id="addressContent"><%=schedule.getAddress()%></label>
                </td>
            </tr>
            <tr class="detail_input">
                <td class="first_td">상세</td>
                <td class="second_td">
                    <p class="meet_content">
               <%=schedule.getDescription()%>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="first_td">회비</td>
                <td class="second_td">
                    <p class="dues"><%=gathering.getFee()%>원</p>
                </td>
            </tr>
            <tr>
                <td class="first_td">준비물</td>
                <td class="second_td">
                <% for( Preparation preparation : preparations) { %>
                    <p class="materials_item"><i class="far fa-check-square"></i><%=preparation.getPreparation()%></p>
                    <%} %>
                </td>
            </tr>
            <div id="map" class="local_map"></div>
        </table>
        <!---------------------------------------참석 불참석 공간---------------------------------------->
        <div class="attendance_status_box">
            <div class="attend_box">
                <label class="attend_btn">
                    <input type="radio" name="attendance_radio" class="attendance_radio">
                    <div class="attend_title">참석</div>
                </label>
                <span class="attendees"></span>
                <ul class="attendees_list">

                </ul>
            </div>
            <div class="no_attend_box">
                <label class="no_attend_btn">
                    <input type="radio" name="attendance_radio" class="no_attendance_radio">
                    <div class="no_attend_title">불참</div>
                </label>
                <span class="non_attendees"></span>
                <ul class="not_attendees_list">

                </ul>
            </div>
        </div>
    </div>
    <!-- //content -->
<%@ include file="/WEB-INF/template/footer.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9461990ea008279ad054cf44109aa103&libraries=services"></script>
<script src="js/jquery.js"></script>
<script>
    //--------------------------------------------------------------------------------주소 찾기 . 지도 보이기
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(<%=schedule.getLat()%>, <%=schedule.getLng()%>), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };
    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(<%=schedule.getLat()%>, <%=schedule.getLng()%>),
        map: map
    });
    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수
                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                //---------------------------------------------------------------------주소 우회
                document.getElementById("addressContent").innerHTML = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
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
    //end 주소 찾기 . 지도 보이기
    $.ajax({
        url:"/ajax/attendanceList.json",//요청하는 서버주소
        type:"GET", //클라이언트 -> 서버 GET, POST
        data: {no:<%=no%>,
        number:<%=number%>,
		type:"X"},
        //dataType:"json", //서버->클라이언트 데이터타입
        error:function(xhr,code,type) {
            alert("서버 점검중!");
        },
        success:function(json) {

            const list = json;
            const adnumber = list.filter(function (element) {
                return element.attendance=="Y";
            });
            $(".attendees").text(adnumber.length+"명");
            $(".non_attendees").text(list.length-adnumber.length+"명");
            $(list).each(function () {
                 if(this.attendance==="Y"){
                     const $img = $("<img class='attendees_img'>").attr("src","img/profile/"+this.profileImg);
                     $("<li>").append($img).appendTo('.attendees_list');
                 }
                 if(this.attendance==="N"){
                     const $img = $("<img class='attendees_img'>").attr("src","img/profile/"+this.profileImg);
                     $("<li>").append($img).appendTo('.not_attendees_list');
                 }
                 if(this.memberNo===507){//자기의 참석여부                	 
                     if (this.attendance==="Y"){
                         $(".attendance_radio").prop("checked",true);
                     }else {
                         $(".no_attendance_radio").prop("checked",true);
                     }
                 }
            });//each() end
        }//success end
    });//$.ajax() end
            
            //---------------------------------------------------------버튼 클릭 시
            $(".no_attend_btn").click(function () {      
            	
                $.ajax({
                    url:"/ajax/attendanceList.json",//요청하는 서버주소
                    type: "GET", //클라이언트 -> 서버 GET, POST
                    data: {no:<%=no%>,
                    	number:<%=number%>,
                    		type:"N"},
                    error: function (xhr, code, type) {
                        alert("서버 점검중!");
                    },
                    success: function (json) {

                        const list = json;
                        const adnumber = list.filter(function (element) {
                            return element.attendance == "Y";
                        });
                        $(".attendees").text(adnumber.length + "명");
                        $(".non_attendees").text(list.length - adnumber.length + "명");
                        $(".not_attendees_list").empty();
                        $(".attendees_list").empty();
                        $(list).each(function () {
                            if (this.attendance === "Y") {
                                const $img = $("<img class='attendees_img'>").attr("src", "img/profile/"+this.profileImg);
                                $("<li>").append($img).appendTo('.attendees_list');
                            }
                            if (this.attendance === "N") {
                                const $img = $("<img class='attendees_img'>").attr("src", "img/profile/"+this.profileImg);
                                $("<li>").append($img).appendTo('.not_attendees_list');
                            }
                                if (this.memberNo === 507) {//자기의 참석여부
                                if (this.attendance === "N") {
                                    $(".no_attendance_radio").prop("checked", true);
                                } else {
                                    $(".attendance_radio").prop("checked",true);
                                }
                            } 
                        });//each() end
                    }//success() end
                });//ajax() end
            })//$(".no_attend_btn").click() end

            $(".attend_btn").click(function () {
                $.ajax({
                	 url:"/ajax/attendanceList.json",//요청하는 서버주소
                    type: "GET", //클라이언트 -> 서버 GET, POST
                    data: {no:<%=no%>,
                    	number:<%=number%>,
                 		type:"Y"},
                    error: function (xhr, code, type) {
                        alert("서버 점검중!");
                    },
                    success: function (json) {

                        const list = json;
                        const adnumber = list.filter(function (element) {
                            return element.attendance == "Y";
                        });
                        $(".not_attendees_list").empty();
                        $(".attendees_list").empty();
                        $(".attendees").text(adnumber.length + "명");
                        $(".non_attendees").text(list.length - adnumber.length + "명");
                        $(list).each(function () {
                            if (this.attendance === "Y") {
                                const $img = $("<img class='attendees_img'>").attr("src", "img/profile/" +this.profileImg);
                                $("<li>").append($img).appendTo('.attendees_list');
                            }
                            if (this.attendance === "N") {
                                const $img = $("<img class='attendees_img'>").attr("src", "img/profile/" +this.profileImg);
                                $("<li>").append($img).appendTo('.not_attendees_list');
                            }
                            if (this.memberNo === 507) {//자기의 참석여부
                                if (this.attendance === "Y") {
                                    $(".attendance_radio").prop("checked", true);
                                } else {
                                    $(".no_attendance_radio").prop("checked",true);
                                }
                            }
                        });//each() end 
                    }//success() end
                });//ajax() end
            })//$(".attend_btn").click() end
            // ---------------------------------------------------------버튼 클릭 시
 

</script>
</body>
</html>
