<%@page import="com.doogwal.coffee.vo.User"%>
<%@page import="com.doogwal.coffee.dao.CrewMembersDAO"%>
<%@page import="com.doogwal.coffee.vo.CrewMember"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <%@ include file="/WEB-INF/template/link.jsp"%>
   <link rel="stylesheet" href="/css/myPage.css" />
</head>
<body>
<%@ include file="/WEB-INF/template/header.jsp"%>
    <div class="snb"><!--snb start-->
        <h3 class="screen_out">수직바</h3>
        <ul class="snb_list">
            <li><a href="">프로필</a></li>
            <li><a href="">개인정보</a></li>
            <li><a href="">탈퇴하기</a></li>
        </ul>
    </div><!--//snb end-->
    <div id="content"> <!--content start-->
        <div class="profiles"> <!--profiles start-->
            <div class="profiles_header">
                <h3>프로필</h3>
            </div>
            <ul class="profiles_content"><!--profiles_content start-->
            <% for(int i=0; i<3;i++) { 
            	if(userCrews[i] != null){ %>
                <li class="profile">
                    <dl>
                        <dt class="screen_out">크루명</dt>
                        <dd><%=userCrews[i].getName()%></dd>
                        <dt class="screen_out">해당크루 프로필사진</dt>
                        <dd><a><img src="/img/profile/<%=userCrews[i].getProfileImg()%>" width="100" height="100" alt="프로필사진" /></a></dd>
                    </dl> 
                    <label for="crewProfile<%=(i+1)%>">사진변경</label>
                    <input data-seq="<%=i%>" data-crew-no="<%=userCrews[i].getNo()%>" type="file" name="crewProfile<%=(i+1)%>" id="crewProfile<%=(i+1)%>" class="profile_input"/>
                    <div class="msg profile"></div>
                </li>
                <%}else{%>
                <li class="profile">
                    <dl>
                        <dt class="screen_out">크루명</dt>
                        <dd>가입 크루 없음</dd>
                        <dt class="screen_out">해당크루 프로필사진</dt>
                        <dd><a><img id="profileImg" src="/img/default profile.png" width="100" height="100" alt="프로필사진" /></a></dd>
                    </dl>
                    <a href="/main.jsp" class="find_crew">크루찾기</a>
                </li>
                <%}}//if~else, for문 end %>
            </ul><!--//profiles_content end-->
        </div><!--//profiles end-->
        <div class="personal_info"><!--personal_info start-->
            <div class="personal_info_header">
                <h3>개인정보</h3>
            </div>
            <dl class="personal_info_content"><!--personal_info_content start-->
                <dt><i class="fas fa-user"></i> 이름</dt>
                <dd><%=loginUser.getName()%></dd>
                <dt><i class="fas fa-map-pin"></i> 주소</dt>
                <dd>
                    <span class="address"><%=loginUser.getAddress()%></span>
                    <button onclick="changeUserAddress()" class="edit_btn">수정</button>
                </dd>
                <dt><i class="fas fa-mobile-alt"></i> 연락처</dt>
                <dd><%=loginUser.getPhoneNum()%></dd>
                <dt><i class="fas fa-envelope"></i> 이메일</dt>
                <dd>
                    <span class="email"><%=loginUser.getEmail()%></span>
                </dd>
                <dt><i class="fas fa-birthday-cake"></i> 생년월일</dt>
                <dd><%=loginUser.getBirthDate()%></dd>
                <dt><i class="fas fa-check-square"></i> 수신동의</dt>
                <dd>
<!-- 이것도 에이젝스-->
                        <span>
                            <input class="reception" data-name="smsCheck" name="smsCheck" type="checkbox" id="smsCheck"
                            value="<%=loginUser.getSmsCheck()%>"
                            <%if(loginUser.getSmsCheck()=='Y'){%> checked <%} %> />
                            <label for="smsCheck">SMS 수신동의</label>
                        </span>
                        <span>
                            <input class="reception" data-name="emailCheck" name="emailCheck" type="checkbox" id="emailCheck"
                            value="<%=loginUser.getEmailCheck()%>"
                            <%if(loginUser.getEmailCheck()=='Y'){%> checked <%} %> />
                            <label for="emailCheck">이메일 수신동의</label>
                        </span>
                </dd>
            </dl><!--personal_info_content end-->
        </div><!--//personal_info end-->
        <div class="user_leave"><!--user_leave start-->
            <div class="user_leave_header">
                <h3>탈퇴하기</h3>
            </div>
            <div class="user_leave_content">
                    <span>
                        <label for="leaveReason">탈퇴 이유를 적어주세요</label>
                        <input type="text" name="leaveReason" id="leaveReason" size="60" />
                        <button href="" class="leave_btn" type="submit">탈퇴하기</button>
                    </span>
            </div>
        </div><!--//user_leave end-->
    </div><!--content end-->
<%@ include file="/WEB-INF/template/footer.jsp"%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
		//image인지 확인하는 정규표현식
		const profileReg = /^image/;
		
		const $profileInput = $(".profile_input"); 
		
		$profileInput.on("change",function() {
			
			const $that = $(this);
			
			//인풋 안 속성 data-crew-no
			console.log(this.dataset.crewNo);
			const memberNo = this.dataset.crewNo;
			
			//파일 하나 넣을거니까 첫번째 파일 고르려면 인덱스 0 이어야 함.
			const file = this.files[0];//여기서 this 선택한 인풋요소
			
			//File 객체의 속성
			//- type : MIME( image/jpeg, audio/mp3, video/mp4...)
			//- name : 파일명
			//- lastModified : 최종수정일
			//- size : 파일 크기
			
			if(file==null||file.size<=0) {
				alert("제대로된 파일을 선택하세요~!");
				return;
			}//if end
			
			//이미지인지 확인!!
			if(!profileReg.test(file.type)) {
				alert("이미지 파일 선택");
				return;
			}
			
			//ajax로 넘길 폼을 생성하고
			const form = new FormData();
			
			//우리가 선택한 파일을 붙임
			form.append("crewMemberNo",this.dataset.crewNo);//크루번호 parameter
			form.append("type","P");//타입 parameter
			form.append("sequence",this.dataset.seq)
			
			//1)파라미터명, 2)파일 3)파일명
			form.append("uploadImage",file,file.name);//uploadImage parameter
			
			//multipart/form-data로 ajax처리
			$.ajax({
				url:"/ajax/uploadCrewMemberProfile.json",
				dataType:"json",
				type:"POST",//multipart/form-data
				processData:false,//multipart/form-data
				contentType:false,//multipart/form-data
				data:form,
				error:function() {
					alert("사진 서버 점검중!");
				},
				success:function(json) {
						$that.parents(".profile").find("img").attr("src","/img/profile/"+json.imageName);
				}//success end
				
			});//ajax() end
			
		});//change() end 
		
		const $address = $(".address");
		//주소 검색
		function changeUserAddress() {
    		new daum.Postcode({
        		oncomplete: function(data) {
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

            	// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            	if(data.autoRoadAddress) {

                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
            	}
            
            
            	//ajax로 user 주소 update하기
    			//주소 ajax 처리하기
    			$.ajax({
    				url:"/ajax/updateAddress.json",
    				dataType:"json",
    				type:"POST",
    				data:{"updatedAddress":roadAddr},
    				error:function() {
    					alert("서버 점검 중! 잠시 후 다시 시도해주세요~!");
    				},
    				success:function(json) {
    					if(json.result) {
    						$address.text(roadAddr);
    					}else {
    						alert("서버 점검!");
    					}
    				}//success end
    				
    			});//ajax() end
    			
        	}//oncomplete() end 
        	
    	}).open();
	}//end 주소 검색

   
    $(".snb li:nth-child(1)").click(function (e){
        e.preventDefault();
        $("html, body").animate({
            scrollTop : $( ".profiles").offset().top
        },700,"swing");
        //transition
    });//profile 사이드 바 누르면 이동하도록


    $(".snb li:nth-child(2)").click(function (e){
        e.preventDefault();
        $("html, body").animate({
            scrollTop : $( ".personal_info").offset().top
        },700,"swing");
        //transition
    });//개인정보 사이드 바 누르면 이동하도록

    $(".snb li:nth-child(3)").click(function (e){
        e.preventDefault();
        $("html, body").animate({
            scrollTop : $( ".user_leave").offset().top
        },700,"swing");
        //transition
    });//탈퇴하기 사이드 바 누르면 이동하도록 
    
    
	const $receptionStatus = $(".reception");
	//sms,email 수신상태 변경
    $receptionStatus.change(function () {
            if($(this).prop("checked")){
                alert("프로모션 정보수신에 동의하셨습니다.");
            }else{
                const intention = confirm("앞으로 새모에서 제공하는 프로모션 정보를 제공받으실 수 없습니다." + " " +
                    "수신 상태를 변경하시겠습니까?").valueOf();
                if(intention==true){
                alert("프로모션 정보 수신동의가 해제되셨습니다.");
                }else{
                    $(this).prop("checked",true);
                }//if~else end 
                
            }//if~else end 
            
            console.log($(this).prop("checked"));
            const reception = $(this).prop("checked");//true or false 나올 것
            
          	//ajax로 user 수신 상태 업데이트 하기
			$.ajax({
				url:"/ajax/updateReception.json",
				dataType:"json",
				type:"POST",
				data:{"updatedReception":reception,"receptionName": this.dataset.name},
				error:function() {
					alert("서버 점검 중! 잠시 후 다시 시도해주세요~!");
				},//error end
				success:function(json) {
					
				}//success end
				
			});//ajax() end
            
    });//change() end 
    
    //정진하 20210127 탈퇴하기 관련
    const $saemoLeaveBtn = $(".leave_btn");
    $saemoLeaveBtn.click(function(){
    	const intention = confirm("신선하고 즐거운 만남이 펼쳐질 새모에서 정말 탈퇴하시겠습니까?").valueOf();
    if(intention==true){
    alert("탈퇴할 수 없습니다~ 영원히 새모와 함께해요!");
    location.href ="/main.jsp";
    }else{
        alert("새모에서 더 즐거운 만남을 이어나가 보아요! ");
        location.href ="/main.jsp";
        
    }//if~else end 
    	
    });//click end 
    

</script>
</body>
</html>