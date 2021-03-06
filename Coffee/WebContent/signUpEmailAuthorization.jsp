<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%session.removeAttribute("signUp");%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>font awesome 아이콘 사용</title>
    <%@ include file="/WEB-INF/template/link.jsp"%>
    <link rel="icon" href="/img/favicon.png" />
    <style>
        #container{
            position: relative;
            padding-top: 0;
        }
        #content{
        	font-family: 'NIXGONM-Vb', sans-serif;
            width: 1080px;
            margin: auto;
        }
        #footer{
            margin-top: 300px;
        }
        /*상단 진행 상태*/
        .sign_up_head{ /* <h1>SAEMO 회원가입</h1>*/
            font-size: 30px;
            font-weight: 900;
            text-align: center;
            margin-top: 50px;
        }
        .sign_up_list{/*진행 바*/
            position: relative;
            float: right;
            left: -55%;
            margin-top: 50px;
        }
        .sign_up_item{/*아이콘+아이콘 감싼 원+부제목*/
            position: relative;
            float: left;
            left: 50%;
            margin-left: 100px;
        }
        .sign_up_circle{/*아이콘을 감싼 원*/
            width: 70px;
            height: 70px;
            background-color: rgb(190, 190, 190);
            border-radius: 50%;
            font-size: 50px;
            color: white;
            text-align: center;
            line-height: 75px;
            margin: 0 auto;
        }
        .circle_color{/*원에 색주기*/
            background-color: rgb(255, 91, 51);
        }
        .sign_up_subtitle{/*<p>약관 동의,정보입력,이메일인증</p>*/
            font-size: 18px;
            font-weight: 550;
            margin-top: 10px;
        }
        .font_weight_up{/*글 굵기 키우기*/
            font-weight: 900;
            font-size: 20px;
        }
        .vertical_line{/*수평선*/
            position: absolute;
            width: 350px;
            height: 2px;
            background-color: rgb(190, 190, 190);
            left:400px;
            top: 35px;
        }
        /*상단 진행 상태*/
        /*----------------------------------------------------------인증 안내 글*/
        .email_certification{/*이메일 인증안내글*/
            text-align: center;
            margin-top: 200px;
        }
        .email_certification h1{/*h1 이메일 인증*/
            font-size: 30px;
            font-weight: 500;
        }
        .email_certification strong{/*강조 글*/
            color: black;
            font-weight: 800;
        }
        .paragraph1{ /*첫번 째 문단*/
            font-size: 20px;
            color: #808080;
            margin-top: 15px;
        }
        .paragraph1_line1{
            margin-top: 40px;
        }
        .paragraph1_line2{
            margin-top: 30px;
        }
        .paragraph2{ /*두번 째 문단*/
            font-size: 17px;
            color: #808080;
            margin-top: 15px;
            margin-bottom: 80px;
        }
        .paragraph2_line1{
            margin-top: 50px;
        }
        .paragraph2_line2{
            margin-top: 10px;
        }
        .certification_btn{  /*인증하기 버튼*/
           width: 300px;
            height: 50px;
            margin: auto;
            font-size: 18px;
            color: white;
            background-color: rgb(255, 91, 51);
            border: none;
            border-radius: 8px;
        }
        .certification_btn:hover{  /*인증하기 버튼 오버시*/
            cursor: pointer;
            box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/template/header.jsp"%>
        <!-- content -->
        <div id="content">
            <div class="sign_up_head"><h1>SAEMO 회원가입</h1></div><!--상단 진행 상태-->
            <div class="sign_up_list">
                <div class="vertical_line"></div>
                <div class="sign_up_item"><div class="sign_up_circle"><i class="far fa-check-circle"></i></div><p class="sign_up_subtitle">약관 동의</p></div>
                <div class="sign_up_item"><div class="sign_up_circle"><i class="fas fa-clipboard-list"></i></div><p class="sign_up_subtitle">정보 입력</p></div>
                <div class="sign_up_item"><div class="sign_up_circle circle_color"><i class="fas fa-id-badge"></i></div><p class="sign_up_subtitle font_weight_up">가입 완료</p></div>
            </div><!--//상단 진행 상태-->
            <!--이메일 인증안내글-->
            <div class="email_certification">
            <h1>시작하기 <i class="fas fa-envelope"></i></h1>
            <div class="paragraph1"><!--첫번 째 문단-->
            <p class="paragraph1_line1">회원가입이 완료되었습니다.</p>
            <p class="paragraph1_line2">신선하고 즐거운 만남이 가득한 새모에서 일상에 활력을 더해보세요.</p>
            </div><!--//첫번 째 문단-->
            <div class="paragraph2"><!--//두번 째 문단-->
            <p class="paragraph2_line1">크루를 찾아보세요!</p>
            <p class="paragraph2_line2">로그인을 하시고 <strong>새모에서</strong> 관심사에 맞는 다양한 크루들을 만나보실 수 있습니다.</p>
            </div><!--//두번 째  문단-->
                <a href="/main.jsp"><button class="certification_btn">메인으로</button></a>
            </div>
            <!--//이메일 인증안내글-->
        </div>
        <!-- //content -->
<%@ include file="/WEB-INF/template/footer.jsp"%>
</body>
</html>
