//0) 공용 js

//밋팅만들기 띄우기, 닫기
const $makeMeetingBtn = $(".make_meeting_btn");
const $meetingMakingWrap = $("#meetingMakingWrap");

$makeMeetingBtn.click(function(){
	$meetingMakingWrap.show();
	$("html").css("overflow-y","hidden");
})

$("#meetingMakingWrap>.close_btn").click(function(){
	$meetingMakingWrap.hide();
	$("html").css("overflow-y","scroll");
});
//-------------------------------------------------

// 화면 넘기기 기능
let currentIdx = 1;
const $nextBtn = $("#nextBtn");
const $prevBtn = $("#prevBtn");

$nextBtn.click(function (e) {
   if(getPassFlag(currentIdx)==0){
       alert("기입란을 채워주세요.");
       e.preventDefault();
   }else{
       $("#meetingMakingContainer").attr("class","meetingMakingStep"+ ++currentIdx);
       if(currentIdx==2){map.relayout();}
   }
});
$prevBtn.click(function () {
    $("#meetingMakingContainer").attr("class","meetingMakingStep"+ --currentIdx);
    if(currentIdx==2){map.relayout();}
});

const $progressList = $(".progress_list");
$nextBtn.click(function(){
    $progressList.children("li").eq(currentIdx-2).css("border-left", "45px solid #E0E0E0");
    $progressList.children("li").eq(currentIdx-1).css("border-left", "45px solid #FFAB40");
});
$prevBtn.click(function(){
    $progressList.children("li").eq(currentIdx).css("border-left", "45px solid #E0E0E0");
    $progressList.children("li").eq(currentIdx-1).css("border-left", "45px solid #FFAB40");
});
//-------------------------------------------------

//-------------------------------------------------------------------------------------
//1) essential_step js
const selectableDate = [new Date(), new Date(2200,11,31)];

// datePicker
const datepicker = new tui.DatePicker("#datePickerWrapper", {
    language: 'ko',
    input: {
        element: '#datepicker-input',
        format: 'yyyy년 MM월 dd일'
    },
    autoClose: true,
	selectableRanges: [selectableDate]
})

//-------------------------------------------------

// timePicker
const timepicker = new tui.TimePicker("#timePickerWrapper", {
    language: "ko",
    initialHour: 0,
    initialMinute: 0,
    hourStep: 1,
    minuteStep: 10,
    showMeridiem: false,
    inputType: "spinbox"
})
const timepicker2 = new tui.TimePicker("#timePickerWrapper2", {
    language: "ko",
    initialHour: 0,
    initialMinute: 0,
    hourStep: 1,
    minuteStep: 10,
    showMeridiem: false,
    inputType: "spinbox"
})
//-------------------------------------------------

// 하루종일 체크 시 시간 블락 먹이는 기능
const $timeInput = $(".tui-timepicker-spinbox-input");
const $timeBtn = $(".tui-timepicker-btn");
const $timeBtnIcon = $(".tui-timepicker-btn>span");

$("#allDayBtn").change(function() {
    if($(this).prop("checked")) {
        $timeInput.attr("disabled", true);
        $timeBtn.attr("disabled", true);
        $timeBtnIcon.css("pointer-events","none");
        timepicker.setTime(0,0);
        timepicker2.setTime(23,50);
    }else{
        $timeInput.removeAttr("disabled");
        $timeBtn.removeAttr("disabled");
        $timeBtnIcon.css("pointer-events","");
        timepicker.setTime(0,0);
        timepicker2.setTime(0,0);
    }
});
//-------------------------------------------------

// 글자 길이를 알려주고 일정 이상 넘어가는 걸 막는 함수
function textLengthGetPrevent($input, $lengthElement){
    let currentLength = $input.val().length;
    $lengthElement.text("("+currentLength+" / "+$input.attr("maxlength")+"자)");
}
//-------------------------------------------------

// 밋팅이름 길이 세주고 보였다 말았다 하는 기능
$meetingNameInput = $("#meetingNameInput");
$textLengthNotice = $(".text_length_notice");
$textLength = $(".text_length");
let passFlag1_step1 = 0;

$meetingNameInput.keyup(function(){
    if($(this).val().length==0){
        $textLengthNotice.css("display", "");
        $textLength.empty();
        passFlag1_step1 = 0;
    }else{
        $textLengthNotice.css("display", "none");
        $(this).val($(this).val().substring(0,10));
        textLengthGetPrevent($(this), $textLength);
        passFlag1_step1 = 1;
        if($(this).val().length<2){passFlag1_step1=0;}
    }
})
//-------------------------------------------------

// datePicker&timePicker 값 저장해놓기
const $datePickerValueTube = $("#datePickerValueTube");
const $timePickerValueTube = $("#timePickerValueTube");
const $timePickerValueTube2 = $("#timePickerValueTube2");

let passFlag2_step1 = 0;

datepicker.on("change",function(){
    $datePickerValueTube.val(datepicker.getDate());
    passFlag2_step1=1;
})
timepicker.on("change", function(){
    $timePickerValueTube.val(timepicker.getHour()+":"+timepicker.getMinute());
})
timepicker2.on("change", function(){
    $timePickerValueTube2.val(timepicker2.getHour()+":"+timepicker2.getMinute());
})
//-------------------------------------------------

//-------------------------------------------------------------------------------------
//2)location_step js

// 카카오 주소API
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
        center: new daum.maps.LatLng(37.480116, 126.953891), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };

//지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
//주소-좌표 변환 객체를 생성
var geocoder = new daum.maps.services.Geocoder();
//마커를 미리 생성
var marker = new daum.maps.Marker({
    position: new daum.maps.LatLng(100, 127.005476),
    map: map
});
//district_no를 위한 변수 
let strForDistrictNo;

function sample5_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = data.address; // 최종 주소 변수

            // 주소 정보를 해당 필드에 넣는다.
            document.getElementById("sample5_address").value = addr;
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

					$("#latStr").val(result.x);
                    $("#lngStr").val(result.y);
                }
            });

			//시도코드를 찾기 위한 시군구명 넣어주기
			$("#strForDistrictNo").val(data.sigungu);
        }
    }).open();
}

//---------------------------------------------------------------

//-------------------------------------------------------------------------------------
//3) additional_step js

let passFlag1_step3=0;
let passFlag2_step3=0;

// point 제한 기능
const $meetingPointInput = $("#meetingPointInput");
const $havingPoint = $(".having_point>span");

$meetingPointInput.keyup(function(){
    let bettingPoint = Number($meetingPointInput.val());
    let havePoint = Number($havingPoint.text());

    if(bettingPoint>havePoint){
        $havingPoint.css("color", "#DD0052");
        passFlag1_step3 = 0;
    }else{
        $havingPoint.css("color", "black");
        passFlag1_step3 = 1;
    }
})
// ----------------------------------------------------

// 세부설명 길이 세주는 기능
$meetingExplanationInput = $("#meetingExplanationInput");
$explanationLenth = $(".explanation_length");
$meetingExplanationInput.keyup(function(){
    $(this).val($(this).val().substring(0,20));
    textLengthGetPrevent($(this), $explanationLenth);
})
//-------------------------------------------------

//크루 카테고리가 분류의 디폴트가 되도록 하는 기능
const $options = $("#meetingCategoryChoice option");

function crewCategoryDefault(categoryNo){
    $options.each(function(index, item){
        if($(item).val()==categoryNo){
            $(item).attr("selected", true);
        }
    })
}
crewCategoryDefault(crewCategoryNo);
//--------------------------------------------------

// 사진 채워주는 기능
const $meetingImageInput = $("#meetingImageInput");
let imgTemp;

$("#meetingImageInput").on("change",function() {

    const file = this.files[0];

    //image/ 로 시작하는
    if (/^image\//.test(file.type)) {

    //multipart/form-data에 필요함
    const formData = new FormData();

    formData.append("uploadImage", file, file.name);
    formData.append("type", "M");

    //여기서 ajax로 파일 업로드 수행
    $.ajax({
        url:"/ajax/uploadImage.json",
        processData : false,//multipart/form-data
        contentType : false,//multipart/form-data
        data : formData,//multipart/form-data
        type : 'POST',//multipart/form-data
        dataType : "json",
        error : function(xhr, error, code) {
            alert("에러:" + code);
        },
        success:function(json) {
            $(".meeting_image").css("background-image","url(/img/meeting/"+json.imageName+")");
			imgTemp = json.imageName;
			passFlag2_step3 = 1;
        }
    });
    } else {
        alert("이미지를 선택해주세요!");
    }
});
//-------------------------------------------------

//-------------------------------------------------------------------------------------
//4)rule_step js

// 규칙&준비물 길이 세주는 기능
const $meetingRuleInput = $("#meetingRuleInput");
const $ruleLength = $(".rule_length");
$meetingRuleInput.keyup(function(){
    $(this).val($(this).val().substring(0,40));
    textLengthGetPrevent($(this), $ruleLength);
});

$meetingMaterialInput = $("#meetingMaterialInput");
$materialLength = $(".material_length");
$meetingMaterialInput.keyup(function(){
    $(this).val($(this).val().substring(0,20));
    textLengthGetPrevent($(this), $materialLength)
});
//-------------------------------------------------

// 규칙&준비물 추가 기능
const $ruleAddBtn = $("#meetingRuleInput+button");
const $materialAddBtn = $("#meetingMaterialInput+button");

$ruleAddBtn.click(function(e){
    e.preventDefault();
    if($(".rule_list").children("li").length==4){
        alert("규칙은 최대 4개까지 가능합니다.")
    }else {
        ruleAdd($meetingRuleInput.val());
        $meetingRuleInput.val("");
        textLengthGetPrevent($meetingRuleInput, $ruleLength);
    }
});
$materialAddBtn.click(function(e){
    e.preventDefault()
    materialAdd($meetingMaterialInput.val());
    $meetingMaterialInput.val("");
    textLengthGetPrevent($meetingMaterialInput, $materialLength);
});

$meetingRuleInput.keyup(function(e){
    if(e.keyCode==13){
        if($(".rule_list").children("li").length==4){
            alert("규칙은 최대 4개까지 가능합니다.")
        }else{
            ruleAdd($(this).val());
            $(this).val("");
            textLengthGetPrevent($(this), $ruleLength);
        }
    }
});
$meetingMaterialInput.keyup(function(e){
    if(e.keyCode==13){
        materialAdd($(this).val());
        $(this).val("");
        textLengthGetPrevent($(this), $materialLength);
    }
});

function ruleAdd(ruleText){
    let rule = $("<li><span></span><button>X</button></li>");
    rule.eq(0).attr("class","rule_item");
    rule.children("span").text(ruleText);
    rule.eq(0).children().eq(1).on("click", function(){
        $(this).parent().remove();
        $(".rule_number").text("("+$(".rule_list").children("li").length+" / 4개)");
    });

    $(".rule_list").append(rule);
    $(".rule_number").text("("+$(".rule_list").children("li").length+" / 4개)");

}
function materialAdd(materialText){
    let material = $("<li><span></span><button>X</button></li>");
    material.eq(0).attr("class","material_item");
    material.children("span").text(materialText);
    material.eq(0).children().eq(1).on("click", function(){
        $(this).parent().remove();
    });

    $(".material_list").append(material);
}
//-------------------------------------------------

//규칙과 준비물 정보 얻어오기
let rules;
let materials;
const $rulesInput = $("#rulesInput");
const $materialsInput = $("#materialsInput");

$nextBtn.click(function(){
	if($(this).parent().hasClass("meetingMakingStep5")){
		rules=[];
		materials=[];
		for(let i=0; i<$(".rule_list").children("li").length; i++){
			rules.push($(".rule_item>span").eq(i).text());
		}
		for(let i=0; i<$(".material_list").children("li").length; i++){
			materials.push($(".material_item>span").eq(i).text());
		}
		$rulesInput.val(rules);		
		$materialsInput.val(materials);
	}
});

//-------------------------------------------------------------------------------------
//5)confirm_step js

//확정창에 정보 setting
const $comfirmMeetingImg = $(".comfirm_meeting_img>img");
const $confirmBettingPoint = $(".confirm_betting_point");
const $confirmMeetingName = $(".confirm_meeting_name>span");
const $confirmMeetingCategoryImg = $(".confirm_meeting_name>img");
const $confirmMeetingLocation = $(".confirm_meeting_location");

$nextBtn.click(function(){
	if($(this).parent().hasClass("meetingMakingStep5")){
		$comfirmMeetingImg.attr("src", "/img/meeting/"+imgTemp);
		$confirmBettingPoint.text($meetingPointInput.val());
		$confirmMeetingName.text($meetingNameInput.val());
		if($("#partDropDown").val()=='M'){
			$confirmMeetingCategoryImg.attr("src","/img/fighting.png");
		}else{
			$confirmMeetingCategoryImg.attr("src","/img/get_together.png");
		}
		$confirmMeetingLocation.text($("#sample5_address").val());
	}
});
//------------------------------------------------------------

// 해당 Step의 조건 충족 여부 넘겨주는 함수
function getPassFlag(stepNumber){
    switch(stepNumber){
        case 1: return passFlag1_step1*passFlag2_step1;
        case 2: if($("#sample5_address").val()==""){return 0;}else{return 1;}
        case 3: return passFlag1_step3*passFlag2_step3;
        case 4: return 1;
        case 5: return 1;
    }
}
//-------------------------------------------------