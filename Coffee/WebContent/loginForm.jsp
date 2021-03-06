<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인 창</title>
	<%@include file="/WEB-INF/template/link.jsp" %>
    <link rel="stylesheet" href="css/loginForm/loginForm.css" />
</head>
<body>
<%@ include file="/WEB-INF/template/header.jsp" %>
    <div id="loginWrap"><!--loginWrap-->
        <div id="loginHeader"><!--loginHeader-->
            <img class="login_logo_img" src="img/logo.png" width="100" />
        </div>
        <div id="loginContainer"><!--loginContainer-->
            <div class="login_form">
                <form action="/login.do" method="post">
                    <input id="loginId" name="loginId" placeholder="  아이디" />
                    <input id="loginPassword" <%
                    String fail = (String)session.getAttribute("fail");
                    if(fail!=null){%>
                    class="fail"
                    <% }%> name="loginPassword" type="password" placeholder="  비밀번호" />
                    <div class="login_fail_phrase"><span>비밀번호가 틀렸습니다. 다시 한번 확인해주세요</span></div>
                    <button class="login_btn">로그인</a></button>
                    <div class="login_keep_box">
                        <input id="loginKeepBtn" name="loginKeepBtn" type ="checkbox" />
                        <label for="loginKeepBtn">로그인 상태 유지</label>
                    </div>
                </form>
            </div>
            <div class="login_help_box"><!--login_help_box-->
                <a class="find_id" href="">아이디 찾기</a>
                <a class="find_password" href="">비밀번호 찾기</a>
                <a class="sign_up" href="">회원가입</a>
            </div><!--//login_help_box-->
        </div><!--loginContainer-->
    </div><!--//loginWrap-->
<%@ include file="/WEB-INF/template/footer.jsp" %>
<%
	session.removeAttribute("fail");
    if(fail!=null) {
%>
<script>
	//로그인 실패시 뜨는 문구 기능
	$(".login_fail_phrase").show();
</script>
<%}//if end %>
</body>
</html>