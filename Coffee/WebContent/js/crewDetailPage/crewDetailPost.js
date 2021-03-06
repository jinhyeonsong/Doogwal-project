// 글 상세
const $detailPostsTmpl = _.template($('#detailPostsTmpl').html());

// 에디터 수정
const $popUpdateTmpl = _.template($('#popUpdateTmpl').html());

// 글 리스트
const $postsTmpl = _.template($('#postsTmpl').html());

// 글쓰기
const $popWriteTmpl = _.template($('#popWriteTmpl').html());

// 신고하기
const $reportTmpl = _.template($('#reportTmpl').html());

// 이미지 확대하기
const $detailImageTmpl = _.template($('#detailImageTmpl').html());

// 좋아요 기능
const $likeBtnBox = $(".like_btn");
const $likeBtn = $(".like_btn>.likeBtn");


// 글 번호
let postNo;

/* 페이지 처리 */
// 페이지 번호
let pageNo = 1;

//한 페이지에 보여지는 게시물수 
let numPage = 2;
/* 페이지 처리 */

// 라이크 박스 닫기
$("html").click(function(e){
	const $likeBox = $(this).find('.sorting_like_box');	
    if(!($(e.target).hasClass("like_box")||$(e.target).hasClass("like_icon")||
        $(e.target).hasClass("like_count")||$(e.target).hasClass("fa-caret-square-down")||$(e.target).hasClass("fa-heart"))){
        $likeBox.removeClass('appear');
    }
});
// 라이크 박스 닫기

/*글 불러오기 (페이지 1부터)*/
let currentBoardNo = boardNo;
getPost(currentBoardNo);

/*글 불러오기 페이징 처리*/
function getPost(boardNo){
	if(currentBoardNo==boardNo){
		$.ajax({
		    url:"/ajax/getCrewPost.json",
		    type:'get',
		    dataType:'json',
		    data:{
		    	crewNo:crewNo,
		    	crewMemberNo: crewMemberNo,
				start:pageNo++,
				end:numPage,
				boardNo: boardNo
		    },
		    error : function(xhr, error, code) {
		       // alert("에러:" + code);
		    },
		    success:function (json){
		    	console.log(json);
		        $postVariableBox.append($postsTmpl({crewPost:json}));
		    }
		});
	}else{
		currentBoardNo = boardNo;
		pageNo=1;
		$.ajax({
		    url:"/ajax/getCrewPost.json",
		    type:'get',
		    dataType:'json',
		    data:{
		    	crewNo:crewNo,
		    	crewMemberNo: crewMemberNo,
				start:pageNo++,
				end:numPage,
				boardNo: boardNo
		    },
		    error : function(xhr, error, code) {
		       // alert("에러:" + code);
		    },
		    success:function (json){
		    	console.log(json);
		        $postVariableBox.html($postsTmpl({crewPost:json}));
		    }
		});
	}
}
/*글 불러오기 페이징 처리*/

/*무한 스크롤링*/
$(window).scroll(function(e) {
    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
    	getPost(currentBoardNo);
    }
});	
	
	
	
/* 좋아요 관련 함수 */
function pushLike(url,postNo){
	$.ajax({
	    "url": url,
	    type:'get',
	    dataType:'json',
	    data:{
	    	postNo: postNo,
			likerNo: crewMemberNo
	    },
	    error : function(xhr, error, code) {
	       // alert("에러:" + code);
	    },
	    success:function (json){
	    	console.log(json);
	    }
	});
}
/* 좋아요 관련 함수 */

/* 글 옵션 더보기*/
$postVariableBox.on("click",'.option_btn',function(e){
	const $that = $(this).children().next();
	$that.toggleClass('appear');
});
/* 글 옵션 더보기*/


/*신고하기 옵션 클릭*/

let writerNo;
const $reportBoxWrap = $('#reportBoxWrap');
const $reportReasonItem = $('.report_reason_item');
$postVariableBox.on("click",'.ban_item',function(e){
	const $that = $(this).parent().next();
	$that.toggleClass('appear');
	$reportBoxWrap.toggleClass('on');
	$reportBoxWrap.append($reportTmpl);
	postNo = $that.val();
	writerNo = $that.next().val();
});
/*신고하기 옵션 클릭*/		

/*신고하기*/
$reportBoxWrap.on("click",'.report_reason_item' ,function (e) {
    const $that = $(this).children().children().next().next();
    const $remove = $(this).parent().parent().parent();
    const val = $that.val();
    console.log(val);
    const intention = confirm("허위로 신고를 할시 불이익을 받을 수 있습니다.\n 그래도 신고하시겠습니까?").valueOf();
    console.log(intention);
    if(intention==true){
        $.ajax({
            url: "/ajax/insertReport.json",
            type:'get',
            data:{
            	postNo:postNo,
            	reporterNo : crewMemberNo,
            	writerNo : writerNo,
            	type : val
            },
            dataType:'json',
            error : function(xhr, error, code) {
                alert("신고하기 에러:" + code);
                $reportBoxWrap.toggleClass('on');
            },
            success:function (json){
            	if(json.result==1){
                  	alert("신고하였습니다.");
            	}else{
            		alert("신고가 되질 않습니다.");
            	}
                $reportBoxWrap.toggleClass('on');
            }
        });
    }else{
        alert("신고를 취소하였습니다.");
        $reportBoxWrap.toggleClass('on');
    }
    $remove.remove();
});
/*신고하기*/

/* 글 삭제하기 */
$postVariableBox.on("click",".delete_post_item",function(e){
	const $that = $(this).parent().next();
	const $popWrap = $(this).parent().parent().parent();
	const val = $that.val();
	console.log($popWrap);
	$.ajax({
	    url:"/ajax/deletePost.json",
	    type:'get',
	    data:{
	    	postNo:val
	    },
	    error : function(xhr, error, code) {
	        alert("글 삭제 에러:" + code);
	    },
	    success:function (){
	    	$popWrap.remove();    
	    }
	});
});
/* 글 삭제하기 */



/*댓글쓰기 박스 누르기*/
$postVariableBox.on("click",'.comment_btn',function(e){
	const $that = $(this).parent().next().next().children().children().eq(0);
	console.log($that);
	$that.focus();
});
/*댓글쓰기 박스 누르기*/

/*좋아요 누르기*/
$postVariableBox.on("click",'.like_btn',function(e){
// likeBtn
const $that = $(this).children();
const val = $that.next().val();

const $likeCnt = $(this).parent().parent().children().next().next().next().children().children().next().eq(0);
const likeCnt = $likeCnt.text();
console.log($likeCnt);

if($that.prop("checked")){
    $that.attr("checked",false);
    $(this).removeClass("like");
    pushLike("/ajax/unPushLike.json",val);
 	$likeCnt.text(parseInt(likeCnt)-1);
}else{
    $that.attr("checked",true);
    $(this).addClass("like");
    pushLike("/ajax/pushLike.json",val);
	$likeCnt.text(parseInt(likeCnt)+1);
}
});
/*좋아요 누르기*/

// 좋아요 박스 누르기
$postVariableBox.on("click",'.like_box',function(e){
	const $that = $(this).children().next().next().next();
	console.log($that);
    //$(".sorting_like_box").css("display","block");
	$that.toggleClass('appear');
	
	if($that.children().next().children().length>6){
    $that.addClass("over");
	}
	else{
    $that.removeClass("over");
	}
});
// 좋아요 박스 누르기

/* 댓글 달기*/
const $replyTmpl = _.template($('#replyTmpl').html());
$postVariableBox.on("submit",'.reply_form',function(e){
	e.preventDefault();
	const $that = $(this).children();
	let val = $that.val().substr(0,30);
	const postNoVal = $(this).children().next().val();
	
	// 댓글 갯수 증가
	const $replyCount = $(this).parent().parent().children().next().next().next().children().next().eq(0);
	//let replyCnt = $replyCount.text();
	console.log($replyCount.text());
	console.log($replyCount);
	$.ajax({
	    url: "/ajax/insertReply.json",
	    type:'get',
	    dataType:'json',
	    data:{
	    	postNo: postNoVal,
	    	memberNo: crewMemberNo,
			reply:val
	    },
	    error : function(xhr, error, code) {
	       alert("댓글 달기 에러:" + code);
	    },
	    success:function (json){
	    	console.log(json);
	    	$that.val('');
			//$replyCount.text(parseInt(replyCnt)+1); 
	    	$('.commented_list').append($replyTmpl({r:json}))
	    }
	});
	
});
/* 댓글 달기*/


/* 글 상세 관련 start*/

/*글 상세*/
const $pop_post_detail_wrap = $('.pop_post_detail_wrap');
//const $popCrewPost = $('.popCrewPost');
$postVariableBox.on("click",'.postingContentsContainer > p',function(e){
	e.preventDefault();
	// 스크롤 막기
	$("html, body").toggleClass("not_scroll");
	const $that = $(this).parent().parent().children().children().next().next();
	const postNoval = $that.val()
	$pop_post_detail_wrap.addClass("on");
	$.ajax({
	    url: "/ajax/getCrewPostDetail.json",
	    type:'get',
	    dataType:'json',
	    data:{
	    	postNo: postNoval,
	    	memberNo: crewMemberNo,
			crewNo:crewNo
	    },
	    error : function(xhr, error, code) {
	       alert("글 상세 에러:" + code);
	    },
	    success:function (json){
	    	$pop_post_detail_wrap.append($detailPostsTmpl({c:json}));
	    	console.log(json);
			const height = $('.detail_post_wrap').height();
			$('.detail_post_wrap').css("marginTop",(height*0.5));
	    }
	});
});
/*글 상세*/


/*글 상세 닫기*/
$pop_post_detail_wrap.on("click",'.close',function(e){
	const $that = $(this);
	// 스크롤 막기
	$("html, body").toggleClass("not_scroll");
	$that.parent().removeClass('on');
	$that.parent().children().remove();
});
/*글 상세 닫기*/

/* 글 상세 좋아요 누르기*/
$pop_post_detail_wrap.on("click",'.like_btn',function(e){
// likeBtn
const $that = $(this).children();
const val = $that.next().val();

const $likeCnt = $(this).parent().parent().children().next().next().next().children().children().next().eq(0);
const likeCnt = $likeCnt.text();
console.log($likeCnt);
if($that.prop("checked")){
    $that.attr("checked",false);
    $(this).removeClass("like");
    pushLike("/ajax/unPushLike.json",val);
    $likeCnt.text(parseInt(likeCnt)-1);
}else{
    $that.attr("checked",true);
    $(this).addClass("like");
    pushLike("/ajax/pushLike.json",val);
    $likeCnt.text(parseInt(likeCnt)+1);
}
});
/*글 상세 좋아요 누르기*/



/* 글 상세 댓글 달기*/
$pop_post_detail_wrap.on("submit",'.reply_form',function(e){
	e.preventDefault();
	const $that = $(this).children();
	let val = $that.val().substr(0,30);
	const postNoVal = $(this).children().next().val();
	
	$.ajax({
	    url: "/ajax/insertReply.json",
	    type:'get',
	    dataType:'json',
	    data:{
	    	postNo: postNoVal,
	    	memberNo: crewMemberNo,
			reply:val
	    },
	    error : function(xhr, error, code) {
	       alert("댓글 달기 에러:" + code);
	    },
	    success:function (json){
	    	console.log(json);
	    	$that.val('');
	    	$('.pop_post_detail_wrap .commented_list').append($replyTmpl({r:json}))
	    }
	});
	
});
/* 글 상세 댓글 달기*/


const $postDetailImageWarp = $('.post_detail_image_warp');
let imageArr = [];
let imageIdx = 0;
/*글 상세 이미지 확대*/
$postVariableBox.on("click",'.posting_image_item',function(e){
	e.preventDefault();
	
	// 화면 어둡게 하기
	$postDetailImageWarp.toggleClass('on');

	// 스크롤 막기
	$("html, body").toggleClass("not_scroll");
	
	const $that = $(this).parent().parent().parent().parent().children().children().next().next();
	console.log($that);
	const postNoVal = $that.val();
	console.log(postNoVal);
	$.ajax({
        url:"/ajax/postImage.json",
        type:'get',
        dataType:'json',
        data:{
        	postNo:postNoVal
        },
        error : function(xhr, error, code) {
            alert("에러:" + code);
        },
        success:function (json){
        	$postDetailImageWarp.append($detailImageTmpl);
        	console.log(json.length);
			if(json.length==1){
				$(".right_icon").css("display","none");
			}
            for(let i=0; i<json.length; i++){
                imageArr[i] = json[i].image;
                console.log(imageArr[i]);
            }
            $(".image_box").css("backgroundImage", "url("+imageArr[0]+")");
        }
    });
});
/*글 상세 이미지 확대*/

/*글 상세 이미지 확대 팝업 닫기*/
$postDetailImageWarp.on('click','.close',function (e) {
    
    let $that = $(this).parent();
    $that.parent().toggleClass('on');
    // 스크롤 열기
    $("html, body").toggleClass("not_scroll");
    imageArr=[];
    $that.remove();
});
/*글 상세 이미지 확대 팝업 닫기*/

const $rightBtn = $(".right_icon");
const $leftBtn = $(".left_icon");

/*우로 넘기기*/
$postDetailImageWarp.on('click','.right_icon',function (e) {
    imageIdx++;
    console.log(imageIdx);
    if(imageIdx==imageArr.length-1){
        $(this).css("display","none");
    }
    if(imageIdx!=0){
        $(".left_icon").css("display","block");
    }
    imageChange(imageIdx);
});
/*우로 넘기기*/

/*좌로 넘기기*/
$postDetailImageWarp.on('click','.left_icon',function (e) {
    imageIdx--;
    console.log(imageIdx);
    if(imageIdx!=imageArr.length-1){
        $(".right_icon").css("display","block");
    }
    if(imageIdx==0){
        $(this).css("display","none");
    }
    imageChange(imageIdx);
});
/*좌로 넘기기*/

function imageChange(imageIdx){
    $(".image_box").css("background-image", "url("+imageArr[imageIdx]+")");
}

/*글 이미지 확대 끝*/


/* 글 상세 관련 start*/





/* Quill Editor start */
/*post*/
/*popWrite start*/
const $popWriteWrap= $(".pop_write_wrap");
const $popWrite = $('.pop_write');

/* 새글 쓰기 버튼 on*/
const $postingBtn = $('.posting_btn');
$postingBtn.click(function (e) {
    e.preventDefault();
    $popWriteWrap.addClass("on");
 	// 스크롤 막기
	$("html, body").toggleClass("not_scroll");
    $popWriteWrap.append($popWriteTmpl());
    quill = new Quill('#editorContainer', {
	    modules: {
	        toolbar: {
	            container: '#toolbar-container',
	        }
	    },
	    theme: 'snow'
	});
    quill.focus();
	quill.on('text-change', function(delta, source) {
		range = quill.getSelection();
	});
})

const $post_top_input = $('#post_top_input');

/*에디터 글 작성 완료*/
$popWriteWrap.on("submit","#writeForm",function (e) {

    const contents = 
    	$(".ql-editor").html();

    const text = $(".ql-editor").text();
    const $contents = $("#contents");
    $contents.val(contents);
    console.log("text:"+text);
    console.log("contents:"+contents);
    
    if (text.length <= 0) {
        alert("내용을 입력하세요.");
        return false;
    }//if end
    // 첫번째 값이 엔터면 아무것도 글자를 쓰지 않았음
    else if(contents.ops[0].insert=="\n") {
        alert("글자를 입력해주세요!");
        return false;
    }else {
        //const contentString =JSON.stringify(contents);
        //input type=hidden에 value로 세팅
    	/*if(!$("#post_top_input").prop('checked')){
    		$post_top_input.val('N');
    	}*/
        
        // 수정
        //$contents.val(contentString);
       	$popWriteWrap.removeClass('on');
        return false;
    }

});//#writeForm submit() end
/*에디터 글 작성 완료*/


const $popUpdateWrap = $('.pop_update_wrap');
/*에디터 수정 글 작성 완료*/
$popUpdateWrap.on("submit","#writeForm",function (e) {

    const contents = 
    	$(".ql-editor").html();

    const text = $(".ql-editor").text();
    const $contents = $("#contents");
    $contents.val(contents);
    console.log("text:"+text);
    console.log("contents:"+contents);
    
    if (text.length <= 0) {
        alert("내용을 입력하세요.");
        return false;
    }//if end
    // 첫번째 값이 엔터면 아무것도 글자를 쓰지 않았음
    else if(contents.ops[0].insert=="\n") {
        alert("글자를 입력해주세요!");
        return false;
    }else {
        //const contentString =JSON.stringify(contents);
        //input type=hidden에 value로 세팅
    	/*if(!$("#post_top_input").prop('checked')){
    		$post_top_input.val('N');
    	}*/
        
        // 수정
        //$contents.val(contentString);
       	$popUpdateWrap.removeClass('on');
        return false;
    }

});//#writeForm submit() end
/*에디터 수정 글 작성 완료*/



/* 글 쓰기 수정 닫기 버튼 */
$popWriteWrap.on("click",'.close',function (e) {
	// 스크롤 막기
	$("html, body").toggleClass("not_scroll");
	//pop_write_wrap
	const $that = $(this).parent().parent().parent().parent().parent();
    $that.removeClass('on');
    $that.children().remove();
});
/* 글 쓰기 수정 닫기 버튼 */

var quill;
let range=null;


/*에디터에 이미지 삽입*/
$popWriteWrap.on("change","#image_input",function() {
	
    const file = this.files[0];
    console.log(file);	

	console.log("quill: "+ quill);

	  
    console.log("range: "+ range);

    //image/ 로 시작하는

    if (/^image\//.test(file.type)) {

        //alert("여기에 오면 파일이 있고 사진임");

        //multipart/form-data에 필요함
        const formData = new FormData();

        
        formData.append("uploadImage", file, file.name);

        //여기서 ajax로 파일 업로드 수행
        $.ajax({
            url:"/ajax/uploadPostImage.json",
            processData : false,//multipart/form-data
            contentType : false,//multipart/form-data
            data : formData,//multipart/form-data
            type : 'POST',//multipart/form-data
            dataType : "json",
            error : function(xhr, error, code) {
                alert("에디터에 이미지 삽입 에러:" + code);
            },
            success:function(json) {
               
                $('.imageApplicable').val('T');
                let idx = 0;
                if(range!=null) {
                    idx = range.index;
                }
                // image
                // delta라는 개념을 하나 만들어라
                // 요소를 직접 못넣는다. custom delta
                quill.insertEmbed(idx, 'image', "/upload/"+json.imageName);
                quill.insertText( quill.getSelection() + 1, ' ', Quill.sources.SILENT);
            }
        });
    } else {
        alert("이미지를 선택해주세요!");
    }
})
/*에디터에 이미지 삽입*/



/*에디터에 수정 이미지 삽입*/
$popUpdateWrap.on("change","#image_input",function() {
	
    const file = this.files[0];
    console.log(file);

    //image/ 로 시작하는

    if (/^image\//.test(file.type)) {

        //alert("여기에 오면 파일이 있고 사진임");

        //multipart/form-data에 필요함
        const formData = new FormData();

        
        formData.append("uploadImage", file, file.name);

        //여기서 ajax로 파일 업로드 수행
        $.ajax({
            url:"/ajax/uploadPostImage.json",
            processData : false,//multipart/form-data
            contentType : false,//multipart/form-data
            data : formData,//multipart/form-data
            type : 'POST',//multipart/form-data
            dataType : "json",
            error : function(xhr, error, code) {
                alert("에디터에 이미지 삽입 에러:" + code);
            },
            success:function(json) {
                const range = quill.getSelection();
                console.log(range);
                $('.imageApplicable').val('T');
                let idx = 0;
                if(range!=null) {
                    idx = range.index;
                }
                // image
                // delta라는 개념을 하나 만들어라
                // 요소를 직접 못넣는다. custom delta
                quill.insertEmbed(idx, 'image', "/upload/"+json.imageName);
                quill.insertText( quill.getSelection() + 1, ' ', Quill.sources.SILENT);
            }
        });
    } else {
        alert("이미지를 선택해주세요!");
    }
})
/*에디터에 수정 이미지 삽입*/



/*에디터 폰트 크기 설정*/
var Size = Quill.import('attributors/style/size');
Size.whitelist = ['20px', '28px', '36px','48px'];
Quill.register(Size, true);
/*에디터 폰트 크기 설정*/

/*에디터 색깔 넣기*/
var ColorClass = Quill.import('attributors/class/color');
Quill.register(ColorClass, true);
/*에디터 색깔 넣기*/

/*popWrite end*/

let updateSelectPostNo = null;
/*수정하기*/
$postVariableBox.on("click",'.update_post_item',function(e){
	const $that = $(this).parent().next();
	// 스크롤 막기
	$("html, body").toggleClass("not_scroll");
	const postNo = $that.val();
	const writerMemberNo = $that.next().val();
	const $updateContents = $('.update_contents');
	$that.toggleClass('appear');
	console.log(postNo+" / "+ writerMemberNo);
	
	$.ajax({
	    url: "/ajax/updateSelectPost.json",
	    type:'post',
	    dataType:'json',
	    data:{
	    	postNo: postNo,
			reporterMemberNo : crewMemberNo,
	    	writerMemberNo: writerMemberNo,
	    },
	    error : function(xhr, error, code) {
	        alert("수정하기 에러:" + code);
	    },
	    success:function (json){
	    	console.log(json);

			updateSelectPostNo = json.no;
	    	$popUpdateWrap.append($popUpdateTmpl({c:json}));
	    	$popUpdateWrap.addClass("on");
		    
		    quill = new Quill('#editorContainer', {
			    modules: {
			        toolbar: {
			            container: '#toolbar-container',
			        }
			    },
			    theme: 'snow'
				
			});
			
		    quill.focus();


			quill.on('text-change', function(delta, source) {
				console.log("text-change2");
			  
			});

	    }
	});
	
});


/*수정하기*/

/* Quill Editor end */

