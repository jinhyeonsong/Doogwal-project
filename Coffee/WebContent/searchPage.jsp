<%@page import="com.doogwal.coffee.vo.PageVO"%>
<%@page import="java.util.Map"%>
<%@page import="com.doogwal.coffee.vo.Crew"%>
<%@page import="java.util.List"%>
<%@page import="com.doogwal.coffee.dao.CrewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색결과</title>
 
	<%@ include file="/WEB-INF/template/link.jsp" %>
	<link rel="stylesheet" href="/css/searchPage.css" />
</head>
<body>
<%@ include file="/WEB-INF/template/searchPageHeader.jsp" %>
    <div id="content"><!-- content start-->
        <div class="meeting_filters"><!-- meeting_filters start-->
            <ul class="search_specifics">
                <li class="category">
                	<button class="category_a">분류</button>
                    <ul class="category_box"><!-- category_box start-->
                        <li><a href="/searchPage.jsp?categoryNo=1" class="game" data-category-no="1">게임</a></li>
                        <li><a href="/searchPage.jsp?categoryNo=9" class="art" data-category-no="9">문화/예술</a></li>
                        <li><a href="/searchPage.jsp?categoryNo=3" class="pet" data-category-no="3">반려동물</a></li>
                        <li><a href="/searchPage.jsp?categoryNo=4" class="volunteer" data-category-no="4">봉사활동</a></li>
                        <li><a href="/searchPage.jsp?categoryNo=5" class="social_gathering" data-category-no="5">사교모임</a></li>
                        <li><a href="/searchPage.jsp?categoryNo=6" class="study" data-category-no="6">스터디</a></li>
                        <li><a href="/searchPage.jsp?categoryNo=7" class="sports" data-category-no="7">스포츠/레저</a></li>
                        <li><a href="/searchPage.jsp?categoryNo=8" class="music" data-category-no="8">음악/악기</a></li>
                        <li><a href="/searchPage.jsp?categoryNo=2" class="outdoor" data-category-no="2">아웃도어</a></li>
                    </ul><!-- category_box end-->
                </li>

                <li class="ages"><button class="ages_a">연령대</button>
                    <ul class="age_box"><!-- age_box start -->
                        <li><a href="/searchPage.jsp?age=20" class="twenties" data-age="20">20대</a></li>
                        <li><a href="/searchPage.jsp?age=30" class="thirties" data-age="30">30대</a></li>
                        <li><a href="/searchPage.jsp?age=40" class="forties" data-age="40">40대</a></li>
                        <li><a href="/searchPage.jsp?age=50" class="fifties" data-age="50">50대</a></li>
                    </ul><!--age_box end -->
                </li>
                
                <li class="number_of_crew"><button class="number_of_crew_a">크루원 수</button>
                  	<ul class="number_of_crew_box"><!-- number_of_crew_box start-->
                        <li><a href="/searchPage.jsp?memberSize=" class="number_of_crew_descending" data-order="desc">많은순</a></li>
                        <li><a href="/searchPage.jsp?memberSize=" class="number_of_crew_ascending" data-order="asc">적은순</a></li>
                    </ul><!-- number_of_crew_box end-->
                </li>
            </ul>
        </div><!--//meeting_filters end-->

        <div class="crews_recruiting_new_members_box"><!-- crews_recruiting_new_members_box start-->
            <div class="crews_recruiting_new_members_box_top"><!-- crews_recruiting_new_members_box_top start-->
                <h2>모집 중인 크루</h2>
                <a href=""><h3 class="crew_all">더보기</h3></a>
            </div><!--//
            
            
             crews_recruiting_new_members_box_top end-->
            <div>
                <ul class="crews_recruiting_new_members_list">
                
               </ul>
            </div>
        </div><!--// crews_recruiting_new_members_box end -->
    </div><!--// content end-->
    
<!-- 검색결과 크루 리스트 템플릿 -->
<script type="text/template" id="searchListTmpl">
<@ _.each(crew,function(c){@>
<li class="crews_recruiting_new_members_item"><!--
	--><a href=""><!--
    	--><img class="crew_img" src="img/<@=c.coverImg @>" width="247.5" height="180"/><!--
    	--><p class="crew_name"><@=c.name @></p><!--
    	--><p class="crew_introduction"><@=c.intro @></p><!--
	--></a><!--
--></li>
<@})@>
</script>

<%@ include file="/WEB-INF/template/footer.jsp" %>


<script src="js/jquery.js"></script>
<script src="js/underscore-min.js"></script>

<script>

	let pageNo = 1;
	//한 페이지에 보여지는 게시물수 
	let numPage = 4;
	/* 페이지 처리 */
	let searchResult=null;
	const $searchBoxInput = $(".search_box_input");
	const crewNameExp = /^[ㄱ-힣|a-zA-Z|\s|0-9]{1,255}$/;
	//20210126 검색키워드에 따른 ajax 불러오기
	$searchBoxInput.keyup(function(e) {
		e.preventDefault();
		searchResult = $searchBoxInput.val();
		if(crewNameExp.test(searchResult) && searchResult!=beforeSearchResult){
			pageNo=1;
			console.log(pageNo);
			removeList();
			getSearchCrewList();
		}
	    });//click() end 
		
		
	
	//헤더 검색창 스크롤에 따라 검색창으로 이동
	$(window).scroll(function (evt) {
	    let y = $(this).scrollTop();
	    if(y>200){
	        $(".header_search").css({
	            "display":"block"
	        });
	        $("#header").css({
	            "position":"fixed"
	        });
	        $(".search_box").css({
	            "display":"none"
	        });
	    }else{
	        $(".header_search").css({
	            "display":"none"
	        });
	        $("#header").css({
	            "position":"relative"
	        });
	        $(".search_box").css({
	            "display":"block"
	        });
	    }//if~else end
	});//scroll() end
	
	
	//검색결과 ajax 코드
	_.templateSettings = {interpolate: /\<\@\=(.+?)\@\>/gim,evaluate: /\<\@([\s\S]+?)\@\>/gim,escape: /\<\@\-(.+?)\@\>/gim};
	
	const searchListTmpl = _.template($('#searchListTmpl').html());
	const $crewsRecruitingNewMembersList = $('.crews_recruiting_new_members_list');
	
	let categoryNo= null;
	let ages = null;
	let order = "desc";
	// 리스트 새로고침
	function removeList(){
		$crewsRecruitingNewMembersList.children().remove();
	}

    //분류 드롭박스
    $('.category_box a').click(function(e){
        e.preventDefault();
        const $this = $(this);
        $('.category_a').text($this.text()).css("color","#3D41B3").css("font-weight","900");
        categoryNo = $(this).data('categoryNo');
        $(".category_box").hide();
        removeList();
        getSearchCrewList();
        
    });
    $(".category").mouseenter(function () {
        $(".category_box").show();
    });

    //연령대 드롭박스
    $(".age_box a").click(function (e) {
        e.preventDefault();
       $(".ages_a").text($(this).text()).css("color","#3D41B3").css("font-weight","900");
       ages = $(this).data('age');
        $(".age_box").hide();
        removeList();
        getSearchCrewList();
    });
    $(".ages").mouseenter(function (e) {
        $(".age_box").show();
    });

    //크루원수 드롭박스
    $(".number_of_crew_box a").click(function (e) {
        e.preventDefault();
        $(".number_of_crew_a").text($(this).text()).css("color","#3D41B3").css("font-weight","900");
        $(".number_of_crew_box").hide();
        order = $(this).data('order');
        removeList();
        getSearchCrewList();
    });
    $(".number_of_crew").mouseenter(function () {
        $(".number_of_crew_box").show();
    });
    
    let beforeAges=null;
	let beforeOrder="desc";
	let beforeCategoryNo=null;
	let beforeSearchResult=null;
    function getSearchCrewList() {
    	
    	console.log("지금: "+searchResult);
    	console.log("전:  "+beforeSearchResult);
    	if(beforeAges!=null || beforeCategoryNo!=null || beforeSearchResult!=null){
    		if(beforeAges!=ages){
    			beforeAges = ages;
	   			pageNo = 1;
    		}
    		if(beforeOrder!=order){
    			beforeOrder = order;
	   			pageNo = 1;
    		}
    		if(beforeCategoryNo!=categoryNo){
    			beforeCategoryNo = categoryNo;
	   			pageNo = 1;
    		}
    		if(beforeSearchResult!=searchResult){
    			beforeSearchResult = searchResult;
    			pageNo = 1;
    		}
    	}
    	console.log("지금: "+searchResult);
    	console.log("전:  "+beforeSearchResult);
        $.ajax({
            url:"/ajax/getSearchCrewList.json",
            type : "GET",
            data:{
            	categoryNo:categoryNo,
            	ages:ages,
            	order:order,
            	start:pageNo,
    			end:numPage,
    			searchResult:searchResult
            },
            dataType : "json",
            error : function(xhr, error, code) {
                alert("에러:" + code);
            },
            success:function(json) {
                console.log(json);
                $crewsRecruitingNewMembersList.append(searchListTmpl({crew : json}));
                beforeAges = ages;
            	beforeOrder = order;
            	beforeCategoryNo = categoryNo;
            	beforeSearchResult = searchResult;
            }
        });
    }// getSearchCrewList();
    
    getSearchCrewList();
    
    $('.crew_all').click(function(e){
		e.preventDefault();
    	getSearchCrewList();
    	pageNo++;
    })
    
</script>
</body>
</html>