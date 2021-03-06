<%@page import="com.doogwal.coffee.dao.MtpQuestsDAO"%>
<%@page import="com.doogwal.coffee.vo.MtpQuest"%>
<%@page import="com.doogwal.coffee.vo.Question"%>
<%@page import="com.doogwal.coffee.dao.QuestionsDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//크루 번호 받기
	//http://localhost/userAnswer.jsp?crewNo=5037
	String crewNoStr = request.getParameter("crewNo");
	int crewNo = Integer.parseInt(crewNoStr);

	// 크루 질문 가져오기
	List<Question> questions = QuestionsDAO.selectQuestionList(crewNo);
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>가입조건</title>
    <%@ include file="/WEB-INF/template/link.jsp" %>
    <style>
        #container{
            padding-top: 30px;
        }
        #container h2{
            font-size: 20px;
            font-weight: 700;
            margin: 20px 0;
        }
        #form{

        }
        #form dd{
            margin:5px;
        }
        #form dl,dt{
            margin:10px 0;
        }
        .multiple_choice_question dd,label,input{
            display: inline-block;

        }
        input[type="text"]{
            width: 300px;
            padding:8px 10px;
            margin:5px 0;
        }
        .basic_info{
            margin:40px 0;
            position: relative;
        }
        .profile_image_upload img,input,textarea {
            display: inline-block;
            vertical-align: middle;
            margin: 5px 10px 5px 0;
        }
        .basic_info h3{
            margin:10px 0;
            font-size: 18px;
            font-weight: 600;
        }

        .crew_create_btn_box{
            text-align: center;
            position:relative;
            height: 50px;
            padding:25px 0;
        }
        .prev_btn{
            width: 200px;
            height: 50px;
            background-color: #eeeeee;
            outline: none;
            border: none;
        }
        .next_btn{
            width: 200px;
            height: 50px;
            background-color: #eeeeee;
            outline: none;
            border: none;
        }
        .introduce{
            width: 500px;
            height: 100px;
            vertical-align: middle;
            resize: none;
            margin-right: 10px;
            font-size: 20px;
            padding:8px 10px;
        }
        .counting_characters{/*글자 수 카운티 글*/
            font-size: 10px;
            position: absolute;
            bottom:10px;
            left: 450px;
        }
        .profile_introduce_upload{
            position: relative;
        }
        .profile_image_upload{
            position: relative;
        }
        textarea,input:focus{
            outline-color: #ff6333;
        }
        .form_box input[]
    </style>
</head>
<body>
	<%@ include file="/WEB-INF/template/header.jsp" %>
    <h2>두괄 크루가 물어보고 싶은게 있대요!</h2>
    <div class="form_box">
        <form id="form" action="/qualAnswers.do" method="post">
        	<input type="hidden" name="crewNo" value="<%=crewNo %>"/>
            <fieldset>
            <%for(int i=0;i<questions.size();i++){ 
            	if(questions.get(i).getType()=='M'){
            		// 크루 객관식 질문 가져오기
            		List<MtpQuest> mtpQuestions = MtpQuestsDAO.selectUserAnswersMtpQuestsList(questions.get(i).getNo());
            		System.out.println(questions.get(i).getNo());
            	%>
				<dl>
                    <dt class="multiple_choice_question"><%=i+1 %>. <%=questions.get(i).getQuest() %></dt>
                    <input type="hidden" name="qNo" value="<%=questions.get(i).getNo() %>"/>
                    <input type="hidden" name="type" value="M"/>
                    <%for(int j=0;j<mtpQuestions.size();j++){ %>
                    <dd>
                        <label>
                            <input type="radio" name="answers<%=i%>" value="<%=j+1%>"/>
                            <span><%=mtpQuestions.get(j).getMtpChoice() %></span>
                            <input type="hidden" name="mtpChoiceNo" value="<%=mtpQuestions.get(j).getNo() %>"/>
                        </label>
                    </dd>
                    <%} %>
                </dl>
				<%}else if(questions.get(i).getType()=='S'){ %>
				<dl>
                    <dt class="multiple_choice_question1"><%=i+1 %>. <%=questions.get(i).getQuest() %></dt>
                    <dd>
                        <label>
                            <input type="text" name="answer<%=i%>"/>
                            <input type="hidden" name="type" value="S"/>
                            <input type="hidden" name="qNo" value="<%=questions.get(i).getNo() %>"/>
                        </label>
                    </dd>
                </dl>
				<%}else if(questions.get(i).getType()=='F'){ %>
				<dl>
                    <dt class="file_attachment_question"><%=i+1 %>. <%=questions.get(i).getQuest() %></dt>
                    <dd>
                        <label>
                            <input type="file" name="answer<%=i%>"/>
                            <input type="hidden" name="type" value="F"/>
                            <input type="hidden" name="qNo" value="<%=questions.get(i).getNo() %>"/>
                        </label>
                    </dd>
                </dl>
				<%} %>            
                
				<%} %>
                <div class="basic_info">
                    <div class="profile_image_upload">
                        <label>
                            <h3>프로필 사진</h3>
                            <img src="img/default.jpg" width="60" height="60"/>
                            <input type="file" id="profile" name="profile"/>
                        </label>
                        </dd>
                    </div>
                    <div class="profile_introduce_upload">
                        <label>
                            <h3>간단한 자기소개</h3>
                            <textarea name="introduce" maxlength="100" class="introduce" placeholder="내용을 입력해 주세요"></textarea>
                            <span class="counting_characters">(0/100자)</span>
                        </label>
                    </div>
                </div>
                <div class="crew_create_btn_box">
                    <button type="button" class="prev_btn"><a>이전</a></button>
                    <button type="submit" class="next_btn">제출</button>
                </div><!--crew_create_btn_box end-->
            </fieldset>
        </form>
    </div>
	<%@ include file="/WEB-INF/template/footer.jsp" %>

<script src="js/jquery.js"></script>
<script src="js/default.js"></script>
<script>
    const $addSubjectiveQuestion = $('.add_subjective_question');
    const $addFileAttachmentQuestion = $('.add_file_attachment_question');

    const $crewImageSelectedImg = $('.crew_image_selected img');

    const $crewImageItem = $('.crew_image_item input');

    $crewImageItem.change(function (e) {
        e.preventDefault();
        let src = $(this).next().children().data("src");
        console.log("crewImageItemChange: " + src);
        // $(this).children().attr("checked","checked");
        $crewImageSelectedImg.attr("src", src);
    });

    $("#profile").on("change",function() {

        const file = this.files[0];
        console.log("file: "+ file);

        //image/ 로 시작하는

        if (/^image\//.test(file.type)) {

            //alert("여기에 오면 파일이 있고 사진임");

            //multipart/form-data에 필요함
            const formData = new FormData();

            formData.append("uploadImage", file, file.name);

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
                    console.log("ajax 실행:"+json.imageName);
                    $('.profile_image_upload img').attr("src","/upload/"+json.imageName);
                }
            });
        } else {
            alert("이미지를 선택해주세요!");
        }
    });



    $('.introduce').keyup(function (e){
        let val = $(this).val();
        val = val.substr(0,100);
        $('.counting_characters').text("("+val.length+" /100자)");    //글자수 실시간 카운팅
    });
</script>
</body>
</html>