// 가입 대기자 탬플릿
const qualificationTmpl = _.template($('#qualificationTmpl').html());
//--------------------------------------------------------------------------------------------

//인자 3개짜리는 나중에 생기는 요소들에게 함수를 붙여주는 역할을 한다.
//가입 승인
$(".form_box_list").on("click", '.allow_btn',function (e) {
	
    if (confirm("가입 승인하시겠습니까?") == true){
	
		const $that1 = $(this).parents(".form_box_item");
		const $that2 = $(this).parents(".confirm_box");
		
		$.ajax({
		    url:"/ajax/acceptRegularMember.json",
		    type : 'POST',
			data: {"crewNo": $(this).attr("crewNo"), "userNo": $(this).attr("userNo")},
			dataType : "json",
		    error : function(xhr, error, code) {
		        alert("에러:" + code);
		    },
		    success:function(json) {
				if(json.result) {
					alert("승인하였습니다!");
				}else {
					alert("서버 점검중!");
				}
    			$that1.addClass("allow");
				$that2.hide();  
			}
		});
    }else{;}
});

//가입 거절
$(".form_box_list").on("click", '.reject_btn',function (e) {
    if (confirm("가입 거절하시겠습니까?") == true){
	
		const $that1 = $(this).parents(".form_box_item");
		const $that2 = $(this).parents(".confirm_box");
        
		$.ajax({
		    url:"/ajax/rejectRegularMember.json",
		    type : 'POST',
			data: {"crewNo": $(this).attr("crewNo"), "userNo": $(this).attr("userNo")},
			dataType : "json",
		    error : function(xhr, error, code) {
		        alert("에러:" + code);
		    },
		    success:function(json) {
				if(json.result) {
					alert("거절되었습니다!");
				}else {
					alert("서버 점검중!");
				}
    			$that1.addClass("reject");
				$that2.hide();  
			}
		});
    }else{;}
});
//----------------------------------------------------------------------------------------------------

// 가입대기자목록 버튼 누르면 가입 대기자들 json 명단 받아오고 띄우기
const $registeWatingListBtn = $(".registe_wating_list_btn");
const $popRegisterWrap = $("#popRegisterWrap");
const $crewApplicantNobody = $(".registe_wating_list_btn").siblings(".crew_applicant_nobody");

$registeWatingListBtn.click(function(){
	$.ajax({
	    url:"/ajax/qualifications.json",
	    type : 'GET',
		data: {"no": crewNo},
		dataType : "json",
	    error : function(xhr, error, code) {
	        alert("에러:" + code);
	    },
	    success:function(json) {
			if(Object.keys(json).length==0){
	        	$crewApplicantNobody.show();
				setTimeout(function(){
					$crewApplicantNobody.fadeOut();
				},3000);
			}else{
				$popRegisterWrap.show();
				$("html").css("overflow-y","hidden");
				$('.form_box_list').html(qualificationTmpl({qualifications : json}));
				const $remainTime =  $(".remain_time");
	        	tikTokTime(json, $remainTime);
			}
	    }
	});
})
//----------------------------------------------------------------------------------------------------

//크루가입폼 닫기
$("html").click(function(e){

    if(!($(e.target).parents("#popRegisterForm").hasClass("pop_register_form")||$(e.target).hasClass("registe_wating_list_btn"))){
        $popRegisterWrap.hide();
        $("html").css("overflow-y","scroll");
    }else{
        ;
    }
});
$("#popRegisterWrap>.close_btn").click(function(){
	$popRegisterWrap.hide();
    $("html").css("overflow-y","scroll");
})
//----------------------------------------------------------------------------------------------------

//남은 시간 보여주는 기능
//시간 차이 보여줌 1초마다 차이가 줄어듦
function displaytime(json, jqueryObj){
    jqueryObj.each(function (idx){
        //  Date객체 생성 (
        let now = moment();
        let tomorrow = moment(json[idx].endDate);
        //  역사 1900년대 사람들은 2000년대를 고려하지 않고 getYear라는 함수를 만들었었음
        //시분초 차이 구하기
        let seconds = moment.duration(tomorrow.diff(now)).seconds();
        let minute = moment.duration(tomorrow.diff(now)).minutes();
        let hour = moment.duration(tomorrow.diff(now)).hours();
        let days = moment.duration(tomorrow.diff(now)).days();
        let fullTime;
        hour = days*24 + hour;
        //00:00:00으로 보이게 하기
        if(minute<10 && seconds<10){
            fullTime =  hour+":0" + minute+":0" + seconds;
        }else if(minute<10){
            fullTime =  hour+":0" + minute+":" + seconds;
        }else if(seconds<10){
            fullTime =  hour+":" + minute+":0" + seconds;
        }else{
            fullTime =  hour+":" + minute+":" + seconds;
        }

        // text 표시
        $(this).text(fullTime);
    });
}//displayTime() end

function tikTokTime(json, jqueryObj){
    setInterval(function (){
        displaytime(json, jqueryObj);
    },1000);
}
//----------------------------------------------------------------------------------------------------