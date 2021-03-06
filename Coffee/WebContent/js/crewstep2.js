const $crewNameLenLimit = $('.crew_name_len_limit');
const $crewIntroLenLimit = $('.crew_intro_len_limit');

const $crew_name = $('.crew_name_input');
const $crew_intro = $('.crew_intro_input');
// /*step1 end*/
/*step2 start*/
const nameExp = /^[ㄱ-힣|a-zA-Z|\s|0-9]{2,10}$/;
const introExp = /^[ㄱ-힣|a-zA-z|\s|\d|~!@#$%^&*()_+|<>?:{}]{0,20}$/;

let nameFlag = false, crewFlag = true,imgFlag=true;
// input 시 글자 10자 제한
$crew_name.keyup(function (e) {
	
    let val = $crew_name.val();
    val = val.substr(0,10);
    $crew_name.val(val);
    $crewNameLenLimit.text("("+val.length+" / 10자)");    //글자수 실시간 카운팅
    if(nameExp.test(val)){
        //ajax를 사용하여 중복체크
        nameFlag=false;
        //중복성 검사
        //여기서 ajax로 파일 업로드 수행
        $.ajax({
            url:"/ajax/checkCrewname.json",
            type : 'POST',//multipart/form-data
			data:{"name":val},
            dataType : "json",
            error : function(xhr, error, code) {
                alert("에러:" + code);
            },
            success:function(json) {
					console.log("ajax 실행:"+json.count);
                if(json.count==0) {
                    $nameMsg.removeClass("ok");
					nameFlag = true;
                }else{
					nameFlag = false;
					$nameMsg.addClass("ok");
					$nameMsg.text("중복된 크루 이름입니다.");
                }
           		nextBtnOn2(nameFlag,crewFlag,imgFlag);
			 }
        });
	
		// ajax는 불러오는데 시간이 있기 때문에 47번째 줄에 있는것은 
		// 바람직 하지 않음
        // nextBtnOn2(nameFlag,crewFlag,imgFlag);
    }else{
        $nameMsg.addClass("ok");
        nameFlag = false;
        nextBtnOn2(nameFlag,crewFlag,imgFlag);
    }// if ~ else end


});//#$crew_name.onkeydown() end
$crew_intro.keyup(function (e) {
    let val = $crew_intro.val();
    val = val.substr(0,20);
    $crewIntroLenLimit.text("("+val.length+" /20자)");    //글자수 실시간 카운팅
    if(introExp.test(val)){
        //ajax를 사용하여 중복체크
        crewFlag = true;
        nextBtnOn2(nameFlag,crewFlag,imgFlag);
    }else{
        crewFlag = false;
        nextBtnOn2(nameFlag,crewFlag,imgFlag);
    }// if ~ else end
});//#$crew_name.onkeydown() end
function nextBtnOn2(nameFlag, crewFlag, imgFlag){
    console.log("nextBtnOn step2");
    if(nameFlag==true && crewFlag==true && imgFlag==true){
        $nextBtnStep2.css({
            "background-color": "#FF6333",
            "color": "#fff"
        });
        $nextBtnStep2.removeAttr('disabled');

    }else{
        $nextBtnStep2.attr("disabled","disabled");
        $nextBtnStep2.css({
            "background-color": "#eee",
            "color": "#000"
        });
    }
}

/* step2 이미지 ajax*/
// const $crewImageItem = $('.crew_image_item input');
const $crewImageSelectedImg = $('.crew_image_selected img');

const $crewImageItem = $('.crew_image_item input');

$crewImageItem.change(function (e) {
    e.preventDefault();
    let src = $(this).next().children().data("src");
    console.log("crewImageItemChange: " + src);
    // $(this).children().attr("checked","checked");
    $crewImageSelectedImg.attr("src", src);
});

/*
$("#image_input").on("change",function() {

    const file = this.files[0];

    alert("클릭");
    console.log("file: "+ file);

    //image/ 로 시작하는

    if (/^image\//.test(file.type)) {

        //alert("여기에 오면 파일이 있고 사진임");

        //multipart/form-data에 필요함
        const formData = new FormData();

        formData.append("uploadImg", file, file.name);
        formData.append("type", "B");//B는 board의 줄임말

        //여기서 ajax로 파일 업로드 수행
        $.ajax({
            url:"ajax/uploadImage.json",
            processData : false,//multipart/form-data
            contentType : false,//multipart/form-data
            data : formData,//multipart/form-data
            type : 'POST',//multipart/form-data
            dataType : "json",
            error : function(xhr, error, code) {
                alert("에러:" + code);
            },
            success:function(json) {
                $crewImageSelectedImg.attr("src",json.url);
                // image
                // delta라는 개념을 하나 만들어라
                // 요소를 직접 못넣는다. custom delta
                $(".crew_image_item input:checked").prop("checked",false);
            
				$crewImageItem.change(function (e) {
				    e.preventDefault();
				    let src = $(this).next().children().data("src");
				    console.log("crewImageItemChange: " + src);
				    // $(this).children().attr("checked","checked");
				    $crewImageSelectedImg.attr("src", src);
				});
			}
        });


    } else {
        alert("이미지를 선택해주세요!");
    }
});
*/