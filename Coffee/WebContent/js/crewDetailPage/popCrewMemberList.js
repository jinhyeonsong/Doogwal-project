//크루원들 리스트 가져오는 ajax
$.ajax({
    url:"/ajax/crewMemberList.json",//요청하는 서버주소
    type:"GET", //클라이언트 -> 서버 GET, POST
	data: {"crewNo": crewNo},
    dataType:"json", //서버->클라이언트 데이터타입
    error:function(xhr,code,type) {
        alert("서버 점검중!");
    },
    success:function(json) {
		_.each(json,function(j){
            const $memberImg = $("<img class='member_img'>").attr("src","/img/profile/"+j.profileImg);
            const $memberName = $("<span class='member_name'>").text(j.name);
			const $hiddenInputCrewNo = $("<input type='hidden' name='crewMemberNo' value='"+j.crewMemberNo+"' />");
            let $memberItem = $("<div class='member_item'>")

            if(j.rank=='C') {
                const $mark = $("<div class='crew_head_title'>").text("장");
                $memberItem = $memberItem.append($memberImg, $memberName ,$mark);
                $("<li class='liorder_first'>").append($memberItem, $hiddenInputCrewNo).appendTo('.member_list');
           }

           if(j.rank=='O') {
                const managementOperatorBox =
                    $("<div class='management_operator_box'>").append(
                        $("<span>").text("관리"),
                        $("<div class='management_btn_box'>").append(
                            $("<div class='transform_member_btn'>").text("일반회원으로 전환"),
                            $("<div class='unsubscribe_btn'>").text("탈퇴시키기")
                        )
                    );

                const $declarationBox = $("<div class='declaration_box'>").append($("<span>").text("신고"));
				const $reportNum = $("<input type='hidden' value="+j.reportNum+">");
				const $crewMemberNo = $("<input type='hidden' value="+j.crewMemberNo+">");

                const $mark = $("<div class='crew_middle_title'>").text("운영진");
                $memberItem = $memberItem.append($memberImg, $memberName, $mark, managementOperatorBox, $declarationBox,$reportNum,$crewMemberNo);
                $("<li class='liorder_third'>").append($memberItem, $hiddenInputCrewNo).appendTo('.member_list');
            }

            if(j.rank=='M') {
                const $managementMemberBox =
                    $("<div class='management_member_box'>").append(
                        $("<span>").text("관리"),
                        $("<div class='management_btn_box'>").append(
                            $("<div class='transform_operator_btn'>").text("운영진으로 등용"),
                            $("<div class='unsubscribe_btn'>").text("탈퇴시키기")
                        )
                    );
                const $declarationBox = $("<div class='declaration_box'>").append($("<span>").text("신고"));
	
				const $reportNum = $("<input type='hidden' value="+j.reportNum+">");
				const $crewMemberNo = $("<input type='hidden' value="+j.crewMemberNo+">");  
                $memberItem = $memberItem.append($memberImg, $memberName ,$managementMemberBox, $declarationBox,$reportNum,$crewMemberNo,);
                $("<li class='liorder_second'>").append($memberItem, $hiddenInputCrewNo).appendTo('.member_list');
            }
 
			managementBoxAboutRank(crewRank);
        });//each() end

    }//success end
});//$.ajax() end
//--------------------------------------------------------------------------------------

//랭크에 따라 관리버튼이 보이는 정도를 조절하는 기능
function managementBoxAboutRank(userRank){
    switch(userRank){
        case 'M':
            $(".management_member_box").hide();
            $(".management_operator_box").hide();
			$(".declaration_box").hide();
            break;
        case 'O':
            $(".management_operator_box").hide();
			$(".management_operator_box").next().hide();
            break;
		case 'C':
			break;
		case 'S':
			$(".management_member_box").hide();
            $(".management_operator_box").hide();
			$(".declaration_box").hide();
            break;
    }
}
//--------------------------------------------------------------------------------------

//크루원 리스트 띄우는
const $crewMemberNumber = $(".crew_member_number");
const $popMemberListWrap = $("#popMemberListWrap");

$crewMemberNumber.click(function(){
	$popMemberListWrap.show();
	$("html").css("overflow-y","hidden");
})
//--------------------------------------------------------------------------------------

//크루원 리스트 닫기
$("html").click(function(e){

    if(!($(e.target).parents("#popMemberListContainer").hasClass("pop_member_list_container")||$(e.target).hasClass("crew_member_number"))){
        $popMemberListWrap.hide();
        $("html").css("overflow-y","scroll");
    }else{
        ;
    }
});
$("#popMemberListWrap>.close_btn").click(function(){
	$popMemberListWrap.hide();
    $("html").css("overflow-y","scroll");
})
//-----------------------------------------------------------------------------------------

//운영진으로 등용, 회원으로 전환 기능
const $memberList = $(".member_list");
$memberList.on("click", ".transform_operator_btn", function(){
	if(confirm("운영진으로 등용하시겠습니까?")==true){	
		$.ajax({
			url:"/transformRankToOperator.doo",
	   		type:"POST",
			data: {"crewMemberNo": $(this).parents(".member_item").next().val()}, 
	    	error:function(xhr,code,type) {
	        	alert("서버 점검중!");
	    	},
	    	success:function(json) {
				alert("완료되었습니다.")
				location.reload();
			}
		});
	}
});
$memberList.on("click", ".transform_member_btn", function(){
	if(confirm("일반회원으로 전환하시겠습니까?")==true){
		$.ajax({
			url:"/transformRankToMember.doo",
	   		type:"POST",
			data: {"crewMemberNo": $(this).parents(".member_item").next().val()}, 
	    	error:function(xhr,code,type) {
	        	alert("서버 점검중!");
	    	},
	    	success:function(json) {
				alert("완료되었습니다.")
				location.reload();
			}
		});
	}
});
//---------------------------------------------------------------------------------------

//회원 탈퇴시키기
$memberList.on("click", ".unsubscribe_btn", function(){
	if(confirm("탈퇴시키시겠습니까?")==true){
		let name = $(this).parents(".member_item").children(".member_name").text();
		if(confirm("정말, "+name+"(을)를 내쫓으시겠습니까?")==true){
			if(confirm("우리 "+name+"(이)가 얼마나 귀여운데 ㅠㅠ 근데도? 근데도 저 험악한 길거리에 던져버릴 거예요?")==true){
				if(confirm("당신은 씻을 수 없는 죄를 지을 거예요, 지금이라도 늦지 않았어요")==true){
					if(confirm("정말정말, 남에 마음에 상처를 내고싶은 거라면, 어쩔 수 없죠... 정말 탈퇴시키실 거예요?")==true){
						alert("시렁! 내가 허락 못행!!");
					}
				}
			}
		}
	}
});
//---------------------------------------------------------------------------------------
