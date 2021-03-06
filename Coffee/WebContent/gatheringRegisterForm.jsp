<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>font awesome 아이콘 사용</title>
<%@ include file="/WEB-INF/template/link.jsp" %>
    <style>
        #header{
            position: fixed;
            background-color: white;
            z-index: 2;
        }
        #container{
            position: relative;
        }
        #footer{
            margin-top: 200px;
        }
        #content{
            width: 1080px;
            margin: auto;
        }
        table{
            border: 1px solid #bebebe;
        }
        .form_title{
            font-size: 40px;
            text-align: center;
            margin: 30px 0;
        }
        .first_td{ /*각 열의 첫번째 행*/
            width: 200px;
            height: 100px;
            font-size: 30px;
            border-bottom: 1px solid #bebebe;
            text-align: center;
            line-height: 100px;
            background-color: #dcdcdc;
        }
        .second_td{/*두번 째 td*/
            width: 850px;
            padding-left: 60px;
            border-bottom: 1px solid #bebebe;
            vertical-align: middle;
        }
        .input_style1{ /*<input> 모임이름,장소,회비,준비물 */
            width: 230px;
            height: 14px;
            margin-right: 10px;
            font-size: 20px;
            /*box-sizing: border-box;*/
            padding: 8px 10px;
        }
        .detail_input textarea,.add_box_input,.input_style1:focus{/*<input> 포커스시 보더*/
            outline-color: #ff6333;
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
        .counting_characters{/*글자 수 카운티 글*/
            font-size: 20px;
            vertical-align: bottom;
        }
        .detail_input textarea{/*글자 수 카운티 글*/
            width: 250px;
            height: 60px;
            vertical-align: middle;
            resize: none;
            margin-right: 10px;
        }
        .create_end_btn{/*<button>모임 만들기*/
            width: 200px;
            height: 50px;
            background-color: rgb(255, 91, 51);
            border-radius: 8px;
            border: none;
            outline: none;
            color: white;
            font-size: 30px;
            position: absolute;
            top: 850px;
            left: 50%;
            margin-left: -100px;
        }
        .create_end_btn:hover{/*버튼 오버시*/
            box-shadow: 0 2px 5px 0 rgb(255, 91, 51), 0 2px 10px 0 rgb(255, 91, 51);
            cursor: pointer;
        }
        .local_map{/*지도 공간*/
            background-color: #bebebe;
            width: 431px;
            height: 303px;
            position: absolute;
            left: 60%;
            top: 402px;
        }
        .check_date,.span_one{/*<checkbox> 하루종일, '원'*/
            vertical-align: bottom;
            font-size: 20px;
        }
        .each_preparation{/*준비물 추가된 박스*/
            width: 210px;
            height: 30px;
            background-color: #FFAB40;
            font-size: 20px;
            text-align: center;
            line-height: 30px;
            border-radius: 8px;
            color: white;
            display: inline-block;
            position: relative;
            float: left;
            border: 1px solid #FF9100;
        }
        .each_preparation:nth-child(2){/*준비물 박스마다 간격*/
            margin-left: 4px;
        }
        .each_preparation a{/*준비물 추가된 박스안에 있는 'x'*/
            margin-left: 10px;
        }
        .each_preparation a:hover{/*준비물 추가된 박스 오버시*/
            cursor: pointer;
            box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);
        }
        .preparation_box{/*각 준비물 박스를 담는 부모*/
            float: right;
            width: 431px;
        }
        .add_box_input{/*준비물 input*/
            width: 180px;
            height: 14px;
            float: left;
            padding: 8px 10px;
        }
        .add_btn{ /*준비물 input 옆 '추가' 버튼*/
            display: inline-block;
            width: 50px;
            height: 34px;
            border: none;
            font-size: 20px;
            font-weight: 700;
            color: white;
            text-align: center;
            line-height: 36px;
            background-color: #FF9100;
            border-bottom-right-radius: 8px;
            border-top-right-radius: 8px;
            margin-left: -1px;
        }
        .add_btn:hover{ /*준비물 input 옆 '추가' 버튼 오버시*/
            cursor: pointer;
            box-shadow:1px 1px 1px 1px #999;
        }
        .not_required{/*지도에서 필요없는 것들*/
            display: none;
        }
        .my_address_label{ /*<input>주소 라벨 */
            display: inline-block;
            width: 390px;
            height: 40px;
            border: 1px solid #bebebe;
            vertical-align: middle;
            font-size: 20px;
            text-align: center;
            line-height: 40px;
        }
        .my_address_label:hover{ /*<input>주소 라벨 오버시 */
            cursor: pointer;
            box-shadow:1px 1px 1px 1px #999;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/template/header.jsp" %>
<%
	//http://localhost/gatheringRegisterForm.jsp?no=501
	String noStr = request.getParameter("no");
	//형변환
	int no = Integer.parseInt(noStr);
%>
    <!-- content -->
    <div id="content">

        <form action="/gatheringRegister.coffee" method="POST">
        <input type="hidden" name="crewNo" value="<%=no%>">
            <div class="form_title"><h1>모임 개설하기</h1></div>
            <table>
                <tr>
                    <td class="first_td">모임 이름</td>
                    <td class="second_td">
                        <input type="text" maxlength="10" class="input_style1 v1" id="nameGathering" name="name" >
                        <span class="counting_characters v1_v">(0/10자)</span>
                    </td>
                </tr>
                <tr>
                    <td class="first_td">날짜</td>
                    <td class="second_td">
                        <input type="date" class="date_input" id="date" name="date">
                        <input type="time" class="input_time" id="startTime" name="startTime">
                        <span class="">~</span>
                        <input type="time" class="input_time" id="endTime" name="endTime">
                        <label class="check_date"><input type="checkbox" class="checkbox_date" name="allDay">하루종일</label>
                    </td>
                </tr>
                <tr class="local_input">
                    <td class="first_td">장소</td>
                    <td class="second_td">
                        <div class="not_required">
                            <input type="text" id="sample5_address" placeholder="주소">
                            <input id="address_content" type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
                            <input type="hidden" id="address_hidden" name="address">
                            <input type="hidden" id="location_hidden" name="location">
                        </div>
                        <label for="address_content" class="my_address_label" id="addressContent">주소 찾기</label>
                    </td>
                </tr>
                <tr class="detail_input">
                    <td class="first_td">상세</td>
                    <td class="second_td">
                        <textarea maxlength="100" class="v2" id="meetingDetail" name="description"></textarea>
                        <span class="counting_characters v2_v">(0/100자)</span>
                    </td>
                </tr>
                <tr>
                    <td class="first_td">회비</td>
                    <td class="second_td">
                        <input type="number" class="input_style1" value="0" id="fee" name="fee">
                        <span class="span_one">원</span>
                    </td>
                </tr>
                <tr>
                    <td class="first_td">준비물</td>
                    <td class="second_td">
                        <input placeholder="최대 2개" maxlength="10" class="add_box_input v3">
                        <a class="add_btn">추가</a>
                        <span class="counting_characters v3_v">(0/10자)</span>
                        <div class="preparation_box"></div>
                        <input type="hidden" name="preparation" id="preparation">
                    </td>
                </tr>
                <div id="map" class="local_map"></div>
            </table>
            <input type="button"  class="create_end_btn" value="모임만들기">
        </form>
    </div>
    <!-- //content -->
	<%@ include file="/WEB-INF/template/footer.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9461990ea008279ad054cf44109aa103&libraries=services"></script>
<script src="js/jquery.js"></script>
<script>
    //textarea 내에 글자수 세기
    $('.v1').keyup(function (e) {

        let val = $('.v1').val();
        val = val.substr(0, 10);
        $('.v1').val(val);
        $('.v1_v').text("(" + val.length + " / 10자)");
    });
    $('.v2').keyup(function (e) {

        let val = $('.v2').val();
        val = val.substr(0, 100);
        $('.v2').val(val);
        $('.v2_v').text("(" + val.length + " / 100자)");
    });
    $('.v3').keyup(function (e) {
        let val = $('.v3').val();
        val = val.substr(0, 10);
        $('.v3').val(val);
        $('.v3_v').text("(" + val.length + " / 10자)");
        if (e.keyCode == 13) {
            createbox();
        }
    });
    //end textarea 내에 글자수 세기
    //--------------------------------------------------------------------------------주소 찾기 . 지도 보이기
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };
    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });
    let mapnum = 0;  //유효성 검사 데이터
    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                //---------------------------------------------------------------------주소 우회
                document.getElementById("address_hidden").value = addr;
                document.getElementById("addressContent").innerHTML = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용
                        // -------------------------------------------------------------------해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // alert(coords);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                        // alert(coords);//-----------------------------------------------------주소 중요
                        mapnum++
                        document.getElementById("location_hidden").value = coords;
                    }
                });
            }
        }).open();
    }
    //end 주소 찾기 . 지도 보이기
    //--------------------------------------------------준비물 추가

    $(".add_btn").click(createbox);
    let countnumber = 0;
    function createbox(){
        const value = $(".add_box_input").val();
        $(".add_box_input").val("").focus();
        const $a = $("<a class='delete_btn'>").append($("<i class='fas fa-times'>"));
        const $span = $("<span class='eq_num'>").text(value);
        $("<div class='each_preparation'>").append($span,$a)
            .appendTo(".preparation_box");
        $('.v3_v').text("(0/10자)");
        countnumber++;
        if(countnumber==2){
            $(".add_box_input").attr("disabled",true);
            $(".add_btn").css({"pointer-events":"none",
                "background-color":"#bebebe"});
            $('.v3_v').text("");
        }
    }
    $(document).on("click",".delete_btn",function () {//동적으로 추가된 것은 이렇게 변경해야 이벤트 적용됨
        $(this).parent().remove();
        countnumber--;
        $(".add_box_input").attr("disabled",false);
        $(".add_btn").css({"pointer-events":"auto",
            "background-color":"#FF9100"});
        $('.v3_v').text("(0/10자)");
    });

    $(".checkbox_date").click(function () {
        if($(this).prop("checked")==true){
        	$("#startTime").val("00:00");
        	$("#endTime").val("23:59");
            $(".input_time").prop("disabled",true);
        }else{
            $(".input_time").prop("disabled",false);
        }
    });

    $(".create_end_btn").click(function () {

        if ($("#nameGathering").val() === "") {
            alert("모임 이름을 작성해주세요");
            return false;
        }//모임이름

        if ($(".date_input").val()===""){
         alert("날짜를 정해주세요.");
            return false;
        }
        if
        (($("input:checkbox[name=allDay]:checked").length<1) && (($("#startTime").val()==="")||($("#endTime").val()==="")))
        {
            alert("날짜에서 시간을 설정해주세요.");
            return false;
        }
        if(mapnum<1){
            alert("장소를 선택하세요");
            return false;
        }
       if($("#meetingDetail").val() ===""){
            alert("상세내용을 적어주세요");
           return false;
        }
        if($("#fee").val() ===""){
            alert("회비를 적어주세요!");
            return false;
        }
      else {   
            $nu = $(".eq_num").eq(0);
            $nn = $(".eq_num").eq(1)

            var materials = new Array();
            materials[0] = $nu.text();
            materials[1] = $nn.text();
            document.getElementById("preparation").value = materials;
            $(".create_end_btn").attr("type", "submit");
        }
      return true;
    });


</script>
</body>
</html>