//% -> @ 으로
_.templateSettings = {interpolate: /\<\@\=(.+?)\@\>/gim,evaluate: /\<\@([\s\S]+?)\@\>/gim,escape: /\<\@\-(.+?)\@\>/gim};
//--------------------------------------------------------------------------------------------

// 성별 아이콘 조절
const $sexRatioMaleImageBox = $(".sex_ratio_male_image_box");
const $sexRatioFemaleImageBox = $(".sex_ratio_female_image_box");
let maleNumber = $sexRatioMaleImageBox.data("maleNumber");
let femaleNumber = $sexRatioFemaleImageBox.data("femaleNumber");
let maleRatio = (maleNumber*260)/(maleNumber+femaleNumber);
let femaleRatio = (femaleNumber*260)/(maleNumber+femaleNumber);
let sexRatio = (maleNumber*100)/(maleNumber+femaleNumber);

$sexRatioMaleImageBox.css("max-height", maleRatio+"px");
$sexRatioFemaleImageBox.css("max-height", femaleRatio+"px");
$(".sex_ratio_female_image_box>img").css("margin-top", "-"+(260-femaleRatio)+"px");
$(".crew_sex_ratio_box>span").text(sexRatio+"%")
//-------------------------------------------------

// 게시판 추가 기능
const $boardAdding = $(".board_adding");
const $boardPlusContainer = $("#boardPlusContainer");

$boardAdding.click(function(){
    $boardPlusContainer.css("display", "block")
    $("html").css("overflow-y","hidden");
})

$("html").click(function(e){

    if(!($(e.target).parents("#boardPlusContainer").hasClass("board_plus_container")||$(e.target).hasClass("board_adding"))){
        $boardPlusContainer.css("display", "none");
        $("html").css("overflow-y","scroll");
    }else{
        ;
    }
});
$("#boardPlusContainer>.close_btn").click(function(){
	$boardPlusContainer.hide();
    $("html").css("overflow-y","scroll");
})
//-------------------------------------------------

// 게시판 갯수 제한 + 글자 수 제한
const $crewDetailBoardList = $(".crew_detail_board_list");
const $boardNumber = $(".board_number");
const $boardName = $("#boardName");
let newBoardNumber = $crewDetailBoardList.children(".new_board").length;

if(newBoardNumber==3) {
    $boardAdding.hide();
}

$boardName.keyup(function(){
    $(this).val($(this).val().substr(0,5));
});
$boardNumber.text("("+newBoardNumber+" / 3)");
//-------------------------------------------------

// upcomming event에서 "N명 참여 중" 위에 마우스 올렸을 때, 참여하는 인원들 프로필 사진을 띄우는 함수
const $participants = $(".upcomming_event_participants");
const $participantsListBox = $(".upcomming_event_participants_list_box");

$participants.hover(function(){
    $participantsListBox.css("display","block");
}, function(){
    $participantsListBox.css("display", "none");
}); //$participants.hover end
//-------------------------------------------------

// 가입조건 3개 초과시 숨기고 더 보기 띄우는 기능
const $conditionList = $(".condition_list");
const $viewMore = $(".view_more");

if($conditionList.children().length>3){
    $conditionList.parent().parent().css("height","179px");
    $conditionList.css("margin-bottom","19px");
    $viewMore.show();
}
//-------------------------------------------------

//게시판에 따라 바뀌는 상위 고정글
const precedenceFixingPostTmpl = _.template($('#precedenceFixingPostTmpl').html());
const $precedenceFixingPostBox = $(".precedence_fixing_post_box");
const $precedenceFixingPostList = $(".precedence_fixing_post_list");

if($precedenceFixingPostList.children().length==0){
	$precedenceFixingPostBox.hide();
}else{
	$precedenceFixingPostBox.show();
}

function changePrecedencePost(boardNum){
	$.ajax({
	    url:"/ajax/precedencePosts.json",
	    type : 'GET',
		data: {"boardNum": boardNum},
		dataType : "json",
	    error : function(xhr, error, code) {
	        alert("에러:" + code);
	    },
	    success:function(json) {

	        $(".precedence_fixing_post_list").html(precedenceFixingPostTmpl({precedencePostContents : json}));
			if($precedenceFixingPostList.children().length==0){
 		   		$precedenceFixingPostBox.hide();
			}else{
				$precedenceFixingPostBox.show();
			}
	    }
	});
}
//-------------------------------------------------

//게시판 따라 바뀌는 가운데 컨테이너
const $fixedPostContainer = $("#fixedPostContainer");
const $postVariableBox = $(".post_variable_box");
const $calendarBox = $(".calendar_box");//모든 스케줄 다 감싼 박스

function changeBoard(boardId){
	if(boardId=="boardItem2"){
		$fixedPostContainer.hide();
		$postVariableBox.hide();
		$calendarBox.show();
	}else{
		$fixedPostContainer.show();
		$postVariableBox.show();
		$calendarBox.hide();
	}
}