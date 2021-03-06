<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/template" id="qualificationTmpl">
    <@ _.each(qualifications,function(q){@>
    <li class="form_box_item">
        <div class="register_profile_box">
            <div class="person_info_box">
                <div class="profile_img">
                    <img src="/img/profile/<@=q.img@>" width="45" height="45" />
                </div>
                <div class="profile_box">
                    <h4 class="name"><@=q.name@></h4>
                    <h4 class="birth_year"><@=q.birthDate@></h4>
                    <h4 class="address"><@=q.address@></h4>
                </div>
            </div>
		</div>
        <div class="introduce_box"><@=q.intro@></div>
        <div class="qualification_answer_box">
            <h3>자격 테스트 문제 답변</h3>
            <div>
                <ul class="answer_list">
                    <@_.each(_.zip(q.questions, q.answers),function(qna){@>
                    <li class="answer_item question"><@=qna[0]@></li>
                    <li class="answer_item answer"><@=qna[1]@></li>
                    <@})@>
                </ul>
            </div>
        </div>
        <div class="confirm_box">
            <h4>승인까지 남은 시간:<span class="remain_time"></span></h4>
            <div class="confirm_btn_box"><!-- 기본이 submit이라 막아야해-->
                <button type="button" class="allow_btn" crewNo="<@=q.crewNo@>" userNo="<@=q.userNo@>">가입 승인</button>
                <button type="button" class="reject_btn" crewNo="<@=q.crewNo@>" userNo="<@=q.userNo@>">가입 거절</button>
            </div>
        </div>
    </li>
    <@})@>
</script>