/*step4 start*/
// % -> @ 으로
let question=0;
let answer=0;

//% -> @ 으로
_.templateSettings = {interpolate: /\<\@\=(.+?)\@\>/gim,evaluate: /\<\@([\s\S]+?)\@\>/gim,escape: /\<\@\-(.+?)\@\>/gim};

let $questionNum = $('.question_num');

const $addQuestionList = $('.add_question_list');

/*객관식 질문*/
const $addMultipleChoiceQuestion = $('.add_multiple_choice_question');
const multipleChoiceTmpl = _.template($('#multipleChoiceTmpl').html());


/*객관식 보기 질문*/
const $addAnswer = $('.add_answer');
const multipleChoiceAnswerTmpl = _.template($('#multipleChoiceAnswerTmpl').html());

/*주관식 질문*/
const $addSubjectiveQuestion = $('.add_subjective_question');
const subjectiveTmpl = _.template($('#subjectiveTmpl').html());

/*파일첨부 질문*/
const $addFileAttachmentQuestion = $('.add_file_attachment_question');
const fileAttachmentTmpl = _.template($('#fileAttachmentTmpl').html());

//객관식 질문 추가
$addMultipleChoiceQuestion.click(function (e) {
    e.preventDefault();
    // 필터에 따라서 강의 목록을 불러오는 함수
    getAddQuestionList();
});


//주관식 질문 추가
$addSubjectiveQuestion.click(function (e) {
    e.preventDefault();
    $addQuestionList.append(subjectiveTmpl());
})

//파일 첨부 질문 추가
$addFileAttachmentQuestion.click(function (e) {
    e.preventDefault();
    $addQuestionList.append(fileAttachmentTmpl);
})

function getAddQuestionList(){
    $addQuestionList.append(multipleChoiceTmpl());
}//getLectureList() end
//const $removeQuestion = $('.remove_question');

// 질문 삭제 클릭 함수가 작동하지 않아서 만듦
$(document).on("click", '.remove_question',function (e) {
    console.log("click");
    $(this).parent().parent().remove();

    //question number들 차례대로 초기화
    --question;
    console.log($('.question_num').length);
    let idx =1;
    _.each($('.question_num'),function(){
        $('.question_num').eq(idx-1).text(idx++);
    });
});


//보기 추가 버튼 클릭
// 템플릿으로 만들어진 애들은 인자 3개짜리로 만들어야한다.
$(document).on("click", '.add_answer',function (e) {
    //console.log("click");
    const $that = $(this).parent().parent();
    $that.append(multipleChoiceAnswerTmpl);
    let val = $that.children().next().val();
    $that.children().next().val(++val);
    console.log($that.children().next().val());
    $(this).parent().remove();
});

// 객관식 답변 보기 삭제제
const $removeAnswer = $('.remove_answer');
$(document).on("click", '.remove_answer',function (e){
    const $that = $(this).parent().parent().children().next();
    let val = $that.val();
    //console.log($(this).parent().parent().children().length);
    if($(this).parent().parent().children().length<7){
        console.log($(this).parent().parent().children().length);
    }else {
		$that.val(--val);
        $(this).parent().remove();
    }
});




let qList =[];
const questionExp = /^[ㄱ-힣|a-zA-z|\s|\d|~!@#$%^&*()_+|<>?:{}]{5,50}$/;
/*질문 보기 유효성 검사*/
const $questionMsg = $('.question_msg');
const $questionInput = $('.question_input');
const $answerInput = $('.answer_input');
$(document).on('keyup','.question_input',function (e) {
    const $this = $(this);
    let val = $this.val();
    console.log(val);
    val = val.substr(0,50);
    $(this).val(val);
    if(questionExp.test(val)){
        console.log("합격");
        $this.removeClass("add_border");
        $this.parent().next().next().removeClass("ok");
    }else{
        //2자 미만일때
        console.log("불합격");
        $this.addClass("add_border");
        $this.parent().next().next().addClass("ok");
        $questionMsg.text('최소 5자 입력해주세요');
    }
});
$(document).on('keyup','.answer_input',function (e) {
    const $this = $(this);
    let val = $this.val();
    console.log(val);
    val = val.substr(0,50);
    $(this).val(val);
    if(questionExp.test(val)){
        console.log("합격");
        $this.removeClass("add_border");
        $this.parent().next().next().removeClass("ok");
    }else{
        //2자 미만일때
        console.log("불합격");
        $this.addClass("add_border");
        $this.parent().next().next().addClass("ok");
        $questionMsg.text('최소 5자 입력해주세요');
    }
});
/*step4 end*/