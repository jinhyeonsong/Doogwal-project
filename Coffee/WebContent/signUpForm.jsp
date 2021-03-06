<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%session.removeAttribute("agreement");%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
   	<%@ include file="/WEB-INF/template/link.jsp"%>
    <link rel="stylesheet" href="css/signUpForm.css" />
    <link rel="icon" href="/img/favicon.png" />
    <style>
    #content{
    	font-family: 'NIXGONM-Vb', sans-serif;
    }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/template/header.jsp"%>
    
    <div id="content"><!-- content -->
        <div class="sign_up_head"><h1>SAEMO 회원가입</h1></div><!--상단 진행 상태-->
        <div class="sign_up_list">
            <div class="vertical_line"></div>
            <div class="sign_up_item"><div class="sign_up_circle"><i class="far fa-check-circle"></i></div><p class="sign_up_subtitle">약관 동의</p></div>
            <div class="sign_up_item"><div class="sign_up_circle circle_color"><i class="fas fa-clipboard-list"></i></div><p class="sign_up_subtitle font_weight_up">정보 입력</p></div>
            <div class="sign_up_item"><div class="sign_up_circle"><i class="fas fa-id-badge"></i></div><p class="sign_up_subtitle">가입 완료</p></div>
        </div><!--//상단 진행 상태-->
        <div class="group_join_writing"><!--group_join_writing-->
            <div><span class="asterisk">*</span><span>&nbsp표시는 필수 입력사항입니다.</span></div>
            <div class="group_join_box"><!--group_join_table-->
                <form method="post" action="/signUp.do">
                    <table class="sign_up_table">
                        <tr class="user_name_row">
                            <td class="form_name data_title">
                                <span class="asterisk">*</span> 이름
                            </td>
                            <td class="new_user_name data_content">
                                <input class="basic_info_input" id="userName" name="userName" maxlength="12">
                                <span class="required_space" id="nameRequiredSpace">필수입력 공간입니다.</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_email data_title"><span class="asterisk">*</span> 이메일(아이디)</td>
                            <td class="new_user_email data_content">
                                <input type="email" class="basic_info_input" id="userEmail" name="userEmail">
                                <span class="required_space" id="emailRequiredSpace">필수입력 공간입니다.</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_password data_title"><span class="asterisk">*</span> 비밀번호</td>
                            <td class="new_user_pwd data_content">
                                <input type="password" class="basic_info_input" id="userPassword" name="userPassword">
                                <p class="password_instruction1">비밀번호는 영문, 숫자를 포함하여 8~20자로 구성해주세요.</p>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_pwd_confirmation data_title"><span class="asterisk">*</span> 비밀번호 확인</td>
                            <td class="new_user_pwd_confirmation data_content">
                                <input type="password" class="basic_info_input" id="confirmPassword" name="confirmPassword">
                                <p class="password_instruction2">비밀번호를 한번 더 입력해주세요.</p>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_mobile data_title">
                                <span class="asterisk">*</span> 휴대전화
                            </td>
                            <td class="new_user_mobile data_content">
                                <input class="basic_info_input" id="userPhoneNumber" name="userPhoneNumber">
                                <span class="required_space" id="phoneRequiredSpace">필수입력 공간입니다.</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_gender data_title">
                                <span class="asterisk">*</span> 성별
                            </td>
                            <td class="new_user_gender data_content">
                                <label class="user_gender"><input type="radio" name="checkedGender" value="M">남자</label>
                                <label class="user_gender"><input type="radio" name="checkedGender" value="F" >여자</label>
                                <span class="required_space" id="genderRequiredSpace">필수입력 공간입니다.</span>
                            </td>
                        </tr>
                        <tr><!--생년월일 입력 테이블-->
                            <td class="form_birth_date data_title"><span class="asterisk">*</span> 생년월일</td>
                            <td class="new_user_birth_date data_content">
                                <label>
                                    <input type="text" id="year" name="year"
                                           maxlength="4"
                                           autocomplete="off"
                                           title="태어난 년도를 입력"
                                           placeholder="년(4자리)"/></label>
                                <label>
                                    <input type="text" id="month" name="month"
                                           maxlength="2"
                                           autocomplete="off"
                                           title="태어난 월을 입력"
                                           placeholder="월"/>
                                </label>
                                <label>
                                    <input type="text" id="date"
                                           name="date"
                                           autocomplete="off"
                                           title="태어난 일을 입력"
                                           maxlength="2"
                                           placeholder="일"/>
                                </label>
                                <span class="required_space" id="birthDateRequiredSpace"></span>
                            </td>
                        </tr><!--//생년월일 입력 테이블-->
                        <tr><!--주소 입력 테이블-->
                            <td class="form_address data_title"><span class="asterisk">*</span> 주소</td>
                            <td class="new_user_address data_content">
                                <label for="myAddress" id="addressContent" class="my_address_label">주소 찾기</label><br>
                                <input type="hidden" name="userAddress" id="userAddress">
                                <div class="not_required">
                                    <input type="text" id="sample4_postcode" placeholder="우편번호">
                                    <input id="myAddress" type="button" onclick="searchUserAddress()">
                                    <input type="text" id="sample4_roadAddress" placeholder="도로명주소">
                                    <input type="text" id="sample4_jibunAddress" placeholder="지번주소">
                                    <span id="guide" style="color:#999;display:none"></span>
                                    <input type="text" id="sample4_detailAddress" placeholder="상세주소">
                                    <input type="text" id="sample4_extraAddress" placeholder="참고항목" >
                                </div>
                            </td>
                        </tr><!--//주소 입력 테이블-->
                        <tr><!--이메일 수신여부 테이블-->
                            <td class="form_email_reception data_title">이메일 수신</td>
                            <td class="new_user_email_reception data_content">
                                <label><input type="radio" name="chk_email_reception" value="Y">수신</label>
                                <label><input type="radio" name="chk_email_reception" value="N" checked="checked">미수신</label>
                            </td>
                        </tr><!--//이메일 수신여부 테이블-->
                        <tr>
                            <td class="form_sms_reception data_title">SMS 수신</td>
                            <td class="new_user_sms_reception data_content">
                                <label><input type="radio" name="chk_sms_reception" value="Y">수신</label>
                                <label><input type="radio" name="chk_sms_reception" value="N" checked="checked">미수신</label>
                            </td>
                        </tr>
                    </table>
                    <a href="/index.jsp" class="btn_cancel">취소</a>
                    <input type="submit" class="btn_join" value="가입하기" name="joinFormComplete">
                </form>
            </div><!--//group_join_table-->
        </div><!--//group_join_writing-->
    </div>
    <!-- //content -->
<%@ include file="/WEB-INF/template/footer.jsp"%>
<script src="js/jquery.js"></script>
<script src="js/moment-with-locales.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //가입하기 버튼
    const $btnJoin = $(".btn_join");
    //주소 검색
    function searchUserAddress() {
        new daum.Postcode({
            oncomplete: function(data) {

                console.log(data);
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                //---------------------------------------------------------------------주소 받는 것을 우회시킴
                document.getElementById("addressContent").innerHTML = roadAddr;
                $("#userAddress").val(roadAddr);
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").text = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
                $("#addressContent").css("border","none");
            }
        }).open();
    }
    //end 주소 검색
    const $userName = $("#userName");

    $nameRequiredSpace =  $("#nameRequiredSpace");
    $userName.blur(function () {
        if($userName.val()===""){
            $nameRequiredSpace.css("display","inline-block");
            $btnJoin.attr("type","button");
        }else{
            $nameRequiredSpace.css("display","none");
            $userName.css("border","1px solid #bebebe");
            $btnJoin.attr("type","submit");
        }
    })//이름 유효성 검사

    $emailRequiredSpace =  $("#emailRequiredSpace");
    function emailCheck( email ) {
        var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        return (email != '' && email != 'undefined' && regex.test(email));
    }
    const $userEmail = $("#userEmail");
    $userEmail.blur(function () {
        var email = $userEmail.val();
        if ( ! emailCheck(email) ) {
            $emailRequiredSpace.text("이메일 형식이 아닙니다.").css("display","inline-block");
            $btnJoin.attr("type","button");
        }else {
            $emailRequiredSpace.css("display", "none");
            $btnJoin.attr("type","submit");
            $userEmail.css("border","1px solid #bebebe");
        }
    })//이메일 유효성 검사

	//비밀번호 유효성 검사
    function checkPassword(str) {
        var reg_pwd = /^.*(?=.{8,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
        if (!reg_pwd.test(str)){
            return false;
        }else {
            return true;
        }
    }

    const $pwdInstruction1 = $(".password_instruction1");
    const $pwdInstruction2 = $(".password_instruction2");
    const $userPassword = $("#userPassword");
    const $confirmPassword = $("#confirmPassword");

    $userPassword.blur(function () {
        var str = $userPassword.val();
        if ( ! checkPassword(str) ) {
            $btnJoin.attr("type","button");
            $pwdInstruction1.text("사용 불가능한 비밀번호 입니다.").css({"color": "#ff6333", "line-height": "30px"});
        }else{
            $btnJoin.attr("type","submit");
            $userPassword.css("border","1px solid #bebebe");
            $pwdInstruction1.text("사용 가능한 비밀번호 입니다.").css({"color":"#2962FF","line-height":"30px"});
        }//if~else end
        if ($confirmPassword.val()!="") {
            var pw1 = $userPassword.val();
            var pw2 = $confirmPassword.val();
            if (pw1 == pw2) {
                $btnJoin.attr("type", "submit");
                $pwdInstruction2.text("비밀번호가 일치합니다.").css({"color": "#2962FF", "line-height": "30px"});
            } else {
                $btnJoin.attr("type", "button");
                $pwdInstruction2.text("비밀번호가 일치하지 않습니다.").css({
                    "color": "#ff6333",
                    "line-height": "30px"
                });
            }//if~else end
        }//if end
    });//비밀번호 유효성 검사

    $userPassword.focus(function () {
        $pwdInstruction1.text("비밀번호는 영문, 숫자를 포함하여 8~20자로 구성해주세요").css({"color":"#424242","line-height":"normal"});
    })//비밀번호 도움글

    $confirmPassword.blur(function () {
        var pw1 = $userPassword.val();
        var pw2 = $confirmPassword.val();
        if(pw1==pw2){
            $btnJoin.attr("type","submit");
            $confirmPassword.css("border","1px solid #bebebe");
            $pwdInstruction2.text("비밀번호가 일치합니다.").css({"color":"#2962FF","line-height":"30px"});
        }else {
            $btnJoin.attr("type","button");
            $pwdInstruction2.text("비밀번호가 일치하지 않습니다.").css({"color":"#ff6333","line-height":"30px"});
        }//if~else end
    })//비밀번호 확인

    function checkPhoneNumber(str) {
    	//2021 02 03 정진하 유효성 검사 수정함!!
        var reg_phoneNum = /^01(?:0|1|[6-9])\d{3,4}\d{4}$/;
        	// /^[A-Za-z0-9]{6,12}$/;//숫자와 문자 포함 형태의 6~12자리 이내의 암호 정규식
        if(!reg_phoneNum.test(str)){
            return false;
        }else {
            return true;
        }//if~else end
    }

    const $userPhoneNumber = $("#userPhoneNumber");

    $userPhoneNumber.blur(function () {
        var str = $userPhoneNumber.val();
        $phoneRequiredSpace = $("#phoneRequiredSpace");
        if ( ! checkPhoneNumber(str) ) {
            $btnJoin.attr("type","button");
            $phoneRequiredSpace.text("핸드폰 번호를 적어주세요.").css("display","inline-block");
        }else{
            $phoneRequiredSpace.css("display","none");
            $btnJoin.attr("type","submit");
            $userPhoneNumber.css("border","1px solid #bebebe");
        }//if~else end
    });//폰번호 유효성 검사

    //year
    const $year = $("#year");
    //month
    const $month = $("#month");
    //date
    const $date = $("#date");
    //birth msg
    const $birthMsg = $("#birthDateRequiredSpace");

    //년월일이 제대로 되었는지 확인하는 함수
    function checkBirthDate() {

        const year = $year.val();
        const month = $month.val();
        const date = $date.val();

        const birth = moment([year,month-1,date]);

        if(year>0 && birth<=moment() && birth.isValid()) {

            $birthMsg.text("아주 좋은 생년월일입니다.").css("display","inline-block").css("color","#2962FF");

        }else {
            $birthMsg.text("제대로 된 생년월일을 입력해주세요.").css("display","inline-block");
        }//if~else end
        
    }//checkBirthDate() end

    $year.keyup(checkBirthDate);
    $month.keyup(checkBirthDate);
    $date.keyup(checkBirthDate);


    //signUpForm input 요소 비워져 있을 때 서브밋 버튼 클릭하면 비워진 input 요소 색깔 변하도록
    $btnJoin.click(function () {
        let num = 0;
        if($("#userName").val()===""){
            $("#userName").css("border","1px solid #ff6333");
            $("#nameRequiredSpace").css("display","inline");
            $btnJoin.attr("type","button");
            num++;
        }
        if($("#userEmail").val()===""){
            $("#userEmail").css("border","1px solid #ff6333");
            $("#emailRequiredSpace").css("display","inline");
            $btnJoin.attr("type","button");
            num++;
        }
        if($("#userPassword").val()===""){
            $("#userPassword").css("border","1px solid #ff6333");
            $btnJoin.attr("type","button");
            num++;
        }
        if($year.val()===""){
            $year.css("border","1px solid #ff6333");
            $btnJoin.attr("type","button");
            num++;
        }
        if($month.val()===""){
            $month.css("border","1px solid #ff6333");
            $btnJoin.attr("type","button");
            num++;
        }
        if($date.val()===""){
            $date.css("border","1px solid #ff6333");
            $btnJoin.attr("type","button");
            num++;
        }
        if($("#confirmPassword").val()===""){
            $("#confirmPassword").css("border","1px solid #ff6333");
            $btnJoin.attr("type","button");
            num++;
        }
        if($("#userPhoneNumber").val()===""){
            $("#userPhoneNumber").css("border","1px solid #ff6333");
            $("#phoneRequiredSpace").css("display","inline");
            $btnJoin.attr("type","button");
            num++;
        }
        if($("#sample4_roadAddress").val()===""){
            $("#addressContent").css("border-color","#ff6333");
            num++;
        }
        if($(':radio[name="checkedGender"]:checked').length < 1){
        $("#genderRequiredSpace").css("display","inline");
            num++;
        }
        if(num<1){
            $btnJoin.attr("type","submit");
        }//인풋 요소 다 채워져 있어야만 버튼 서브밋 작동하도록 함
    });//.btn_join.click end

    const $userGender = $(".user_gender");
    
    $userGender.click(function () {
        $("#genderRequiredSpace").css("display","none");
    });
</script>
</body>
</html>
    