<%@page import="com.doogwal.coffee.vo.User"%>
<%@page import="com.doogwal.coffee.vo.Category"%>
<%@page import="com.doogwal.coffee.dao.CategoriesDAO"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%

	List<Category> tempCategories = CategoriesDAO.selectList();
	Category[] firstCategoies = new Category[9];
	ArrayList<Category>[] secondCategories = new ArrayList[9]; // 우선 ArrayList 배열 선언
	for(int i=0; i<9; i++) {
		secondCategories[i] = new ArrayList<Category>(); // 배열에 Class를 지정하여 ArrayList 저장
	}
	
	for(Category category : tempCategories){
		if(category.getPriorNo()==0){
			firstCategoies[category.getNo()-1] = category;
		}else{
			secondCategories[category.getPriorNo()-1].add(category); 
		}
	}
	
	for(int i=0;i<9;i++){
		for(Category category : secondCategories[i]){
			System.out.println(category.getName());
		}
	}
	
	User user = (User)session.getAttribute(User.LOGIN);
	System.out.println(user.getEmail());
	//System.out.println(user.getBirthYear()+"년생");
	int birthYear = user.getBirthYear();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>크루만들기</title>
    <link rel="stylesheet" href="css/reset.css"/>
    <link rel="stylesheet" href="css/default.css" />
    <link rel="stylesheet" href="css/all.min.css"/>
    <link rel="stylesheet" href="css/step1.css"/>
    <link rel="stylesheet" href="css/step2.css"/>
    <link rel="stylesheet" href="css/step3.css"/>
    <link rel="stylesheet" href="css/step4.css"/>
    
    <style>
        /*2020-12-17 주성호 step 변화*/
        .step1 .step_box:nth-child(1) {display: block}
        .step1 .step_box:nth-child(2) {display: none}
        .step1 .step_box:nth-child(3) {display: none}
        .step1 .step_box:nth-child(4) {display: none}

        .step2 .step_box:nth-child(1) {display: none}
        .step2 .step_box:nth-child(2) {display: block}
        .step2 .step_box:nth-child(3) {display: none}
        .step2 .step_box:nth-child(4) {display: none}

        .step3 .step_box:nth-child(1) {display: none}
        .step3 .step_box:nth-child(2) {display: none}
        .step3 .step_box:nth-child(3) {display: block}
        .step3 .step_box:nth-child(4) {display: none}

        .step4 .step_box:nth-child(1) {display: none}
        .step4 .step_box:nth-child(2) {display: none}
        .step4 .step_box:nth-child(3) {display: none}
        .step4 .step_box:nth-child(4) {display: block}

        /*프로그레스바 전체*/
        .progressbar_container{
            width: 100%;
            height: 2px;
            position: absolute;
            bottom: -2px;
        }

        /*프로그레스바 차지한 영역*/
        .step_progressbar{
            background: #FF6333;
            height: 2px;
            width: 25%;
            transition:.5s;
        }

        /*이전 버튼*/
        .prev_btn{
            width: 200px;
            height: 50px;
            background-color: #eeeeee;
            outline: none;
            border: none;
        }

        /*예외처리*/
        .msg{
            font-size: 12px;
            margin-top:5px;
            display: none;
        }

        /*예외처리 ok class 추가*/
        .msg.ok{
            font-size: 12px;
            margin-top: 5px;
            display: block;
            color:#FF1744;
        }
        form button{
            cursor: pointer;
        }
        button:disabled{
            opacity: 1;
            color: #000;
        }
        .question_num{
        	margin-right:5px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/template/header.jsp" %>
<div id="containerCreateCrew" class="step1"><!--container start-->
    <form action="/createCrew.do" method="post">
        <fieldset>
            <div class="step_box">
                <h2 class="spot">카테고리 선택</h2>
                <div class="section_category"><!--category_section start-->
                    <ul class="category_list"><!--질문1. ul 써도 되는지 안되는지 질문으로 -->
                        <%for(int i=0;i<firstCategoies.length;i++){ %>
                        <li class="category_item"><!-- catery_item start-->
                            <div class="category_icon"><i class="fas <%=firstCategoies[i].getIcon()%>"></i></div>
                            <h3 class="category_title"><%=firstCategoies[i].getName() %></h3>
                            <div class="category_detail_box"><!--category_detail_box start-->
                                <h3 class="screen_out"><%=firstCategoies[i].getName() %> 하위 카테고리</h3>
                                <ul class="category_detail_list"><!--category_detail_list start -->
                                <%for(Category category: secondCategories[i]){ 
                                	int categoryNo = category.getNo();
                                %>
                                    <li class="category_detail_item">
                                        <input id="categoryDetailItem<%=categoryNo %>"  name="category_no" type="radio" value="<%=categoryNo %>"/>
                                        <h4><label for="categoryDetailItem<%=categoryNo %>"><%=category.getName() %></label></h4>
                                    </li>
                                <%} %>
                    			</ul><!--category_detail_list end -->
                   			</div><!--category_detail_box end-->
                        </li><!-- catery_item end-->
                        <%} %>
                    </ul><!--category_list end -->
                </div><!--category_section end-->
            </div><!--// step1 end-->
            <div class="step_box"><!--step2 start-->
                <div class="crew_create_box">
                    <legend class="screen_out">크루 만들기 step2</legend>
                    <div class="crew_create_input_name_box">
                        <label><h2>크루이름</h2>
                            <input name="name" class="crew_name_input" placeholder="크루이름 입력" maxlength="10"/><span class="crew_name_len_limit">최소2자/최대10자</span>
                        </label>
                        <!-- p 요소 한개로만 두어서 text만 바꾸게 해라-->
                        <p id="nameMsg" class="msg">최소 2자 입력해주세요</p>
                    </div>
                    <div class="crew_create_cover_box">
                        <h2>크루 커버사진</h2>
                        <div class="crew_create_cover_inner">
                            <div class="crew_image_selected">
                                <img src="img/category1.jpg" width="280" height="220" title="" alt="" />
                            </div>
                            <ul class="crew_image_list">
                                <%for(int i=1;i<=7;i++){ %>
	                                <li class="crew_image_item">
	                                    <input id="categoryImageItem<%=i %>" 
	                                    <%if(i==1){ %>
	                                    checked="checked"
	                                    <%} %>
	                                    name="cover_img" type="radio" value="<%=i %>"/>
	                                    <label for="categoryImageItem<%=i %>">
	                                        <img src="img/category<%=i %>.jpg" width="150" height="100" data-src="img/category<%=i %>.jpg" title="" alt="" />
	                                        <div class="crew_cover_check">
	                                            <i class="fas fa-check"></i>
	                                            <div class="check_on"></div>
	                                        </div>
	                                    </label>
	                                </li>
                                <%} %>
                                <li class="crew_image_item">
                                    <label for="image_input">
                                        <div class="category_upload_image">
                                            <i class="fas fa-camera"></i>
                                            <h4>사진추가</h4>
                                        </div>
                                        <input id="image_input" name="cover_img" type="file" style="display: none;"/>
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </div><!--crew_create_cover_box-->
                    <div class="crew_create_input_intro_box">
                        <label><h2>크루 한 줄 소개글</h2>
                            <input class="crew_intro_input" maxlength="20" placeholder="한 줄 소개글 입력" name='intro'/>
                            <span class="crew_intro_len_limit">최대 20자</span>
                            <span class="crew_create_detail"></span>
                        </label>
                    </div>
                    <div class="crew_create_btn_box"><!-- 기본이 submit이라 막아야해-->
                        <button type="button" class="prev_btn"><a>이전</a></button>
                        <button type="button" class="next_btn next_btn_step2" disabled="disabled">다음</button>
                    </div>

                </div><!-- crew_create_box end-->
            </div><!--//step2 end-->
            <div class="step_box"><!--step3 start-->
                <div>
                    <div class="birth_year_box"><!--birth_year_box start-->
                        <h2><label for=olderYear>크루 연령대 설정</label></h2>
                        <span class="age">
                                <select id="olderYear" name="olderYear">
                                <%for(int i=birthYear;i>=birthYear-10;i--){%>
                                	<option
                                	<%if(birthYear==i){%>
                                		selected 
                                	<%} %>value="<%=i %>"><%=i %></option>
                                <%} %>
                                </select><span class=""> ~ </span>
                        </span>
                        <label for=youngerYear></label>
                        <span class="age">
                                <select id="youngerYear" name="youngerYear">
                                    <%for(int i=birthYear;i<=birthYear+10;i++){%>
                                	<option
                                	<%if(birthYear==i+10){%>
                                		selected 
                                	<%} %>value="<%=i %>"><%=i %></option>
                                <%} %>
                                </select><span> 년생</span>
                        </span>
                        <h4><%=birthYear-10 %>년 ~ <%=birthYear+10 %>년생까지 설정할 수 있습니다.</h4>
                    </div><!--//birth_year_box end-->
                    <div class="popular_limit_box">
                        <span>
                            <label><h2>최대 인원 설정</h2>
                                <input class="crew_population_input" maxlength="2" placeholder="30" value="30" name="max_pop"/><span class="head_count"> 명</span>

                                <span class="crew_population_limit">(최소 10명 / 최대 30명)</span>
                            </label>
                            <p id="populationMsg" class="msg">10이상 숫자 입력!</p>
                        </span>
                    </div><!--//popular_limit_box end-->
                    <div class="crew_create_btn_box">
                        <button type="button" class="prev_btn"><a>이전</a></button>
                        <button type="button" class="next_btn next_btn_step3">다음</button>
                    </div>
                </div><!--// inner end -->
            </div><!--//step3 end-->
            <div class="step_box"><!--step4 start-->
                <div class="qualification_write_box">
                    <div class="qualification_write_inner_box">
                        <div class="content_qualification_write_box"><!--content_qualification_write_box start-->
                            <h2>크루장님이 원하시는 크루 가입조건을 설정해주세요</h2>
                            <div class="add_multiple_choice_question"><h2><a href=""><i class="far fa-plus-square"></i> 객관식 질문 추가</a></h2></div>
                            <div class="add_subjective_question"><h2><a href=""><i class="far fa-plus-square"></i> 단답형 질문 추가</a></h2></div>
                            <div class="add_file_attachment_question"><h2><a href=""><i class="far fa-plus-square"></i> 파일 첨부 질문 추가</a></h2></div>
                            <ul class="add_question_list">
                            </ul>
                        </div><!--//content_qualification_write_box end-->
                        <div class="content_description_box">
                            <h4>예시)</h4><!--제목 h4-->
                            <!--dl-->
                            <dl>
                                <dt><h5>1. 연봉은 어떻게 되시나요?</h5></dt><!-- dt-->
                                <dd class="description_star">* 객관식 질문</dd><!--dd-->
                                <dd><i class="fas fa-check-circle"></i> 2000~3000만원</dd>
                                <dd><i class="fas fa-check-circle"></i> 3000~4000만원</dd>
                                <dd><i class="fas fa-check-circle"></i> 4000~5000만원</dd>
                                <dd><i class="fas fa-check-circle"></i> 5000만원 이상</dd>


                                <dt><h5>2. 직업은 어떻게 되시나요?</h5></dt>
                                <dd class="description_star">* 단답형형 질문</dd>
                                <dd>(연봉 2400 이하 지원 금지)</dd>

                                <dt><h5>3. 귀하의 사진을 첨부해주세요</h5></dt>
                                <dd class="description_star">* 파일첨부 질문</dd>
                                <dd class="description_file">파일 업로드</dd>
                            </dl>
                        </div><!--// content_description_box end-->
                    </div><!--//qualification_write_box end-->
                    <div class="crew_create_btn_box">
                        <button type="button" class="prev_btn"><a>이전</a></button>
                        <button type="submit" class="next_btn next_btn_step4" disabled="true">제출</button>
                    </div><!--crew_create_btn_box end-->
                </div><!--//inner end-->
            </div><!--//step4 end-->
        </fieldset>
    </form>
    <!--    <div class="step_box step4"></div>-->
</div><!--// container end-->
<%@ include file="/WEB-INF/template/footer.jsp" %>

<!--객관식 질문 추가-->
<script type="text/template" id="multipleChoiceTmpl">
    <li class="question_item">
        <div>
            <label>
                <span class="question_num"><@= ++question@></span><input name="quest<@=question@>" class="question_input" placeholder='질문명을 입력해 주세요'/>
            </label>
            <span class="remove_question">질문 삭제</span>
        </div>
		<%for(int i=0;i<3;i++){%>
        <div>
            <label><span><i class="far fa-dot-circle"></i></span>
                <input class="answer_input" placeholder='보기를 적어주세요'/>
            </label>
            <span class="remove_answer"><i class="far fa-minus-square"></i></span>
        </div>
		<%}%>
    </li>
</script>
<!--//객관식 질문 추가 end-->
<!--객관식 보기 추가--><!--2개 이하는 못지움-->
<script type="text/template" id="multipleChoiceAnswerTmpl">
    <div>
        <label><span><i class="far fa-dot-circle"></i></span>
            <input class="answer_input" placeholder='보기를 적어주세요'/>
        </label>
        <span class="remove_answer"><i class="far fa-minus-square"></i></span>
    </div>
    <div class="add_box"><span class="add_answer"><i class="far fa-plus-square"></i></span></div>
</script>

<!--주관식 질문 추가-->
<script type="text/template" id="subjectiveTmpl">
    <li>
        <div>
            <label>
                <span class="question_num"><@=++question@> </span><input class="question_input" placeholder='질문명을 입력해 주세요'/>
            </label>
            <span class="remove_question">질문 삭제</span>
        </div>
        <div>
            <label>
                <input class="answer_input" for="" placeholder='(세부사항을 적어주세요)'/>
            </label>
        </div>
    </li>
</script>
<!--//주관식 질문 추가 end-->

<!--파일첨부 질문 추가-->
<script type="text/template" id="fileAttachmentTmpl">
    <li>
        <div>
            <label>
                <span class="question_num"><@=++question@> </span><input class="question_input" placeholder='질문명을 입력해 주세요'/>
            </label>
            <span class="remove_question">질문 삭제</span>
        </div>
        <div>
            <label>
                <input class="answer_input" type="file" for="" placeholder='파일을 첨부해주세요'/>
            </label>
        </div>
    </li>
</script>
<!--//파일첨부 질문 추가 end-->


<script src="js/jquery.js"></script>
<script src="js/underscore-min.js"></script>
<script src="js/default.js"></script>
<script src="js/step1.js"></script>
<script src="js/step2.js"></script>
<script src="js/step3.js"></script>
<script src="js/step4.js"></script>

<script>
	const $nameMsg = $('#nameMsg');
    const $populationMsg = $('#populationMsg');
    const $prevBtn = $('.prev_btn');
    const $nextBtn = $('.next_btn');
    const $nextBtnStep2 = $('.next_btn_step2');
    const $nextBtnStep3 = $('.next_btn_step3');


    /* step change start*/
    let idx = 1;
    let progress=25;
    console.log(idx);

    // 다음 버튼 클릭
    $('.next_btn').click(changeStep);


    // 이전 버튼 클릭
    $prevBtn.click(function () {
        $("#containerCreateCrew").attr("class","step"+ --idx);
        progress-=25;
        $(".step_progressbar").css("width",""+ progress +"%");
        console.log(idx);
    });

    // changeStep 함수 (nextBtn)
    function changeStep(){
        $("#containerCreateCrew").attr("class","step"+ ++idx);
        progress+=25;
        $(".step_progressbar").css("width",""+ progress +"%");
        console.log(idx);
    };
    /* step change end*/

    let categoryPath="";

</script>
</body>
</html>