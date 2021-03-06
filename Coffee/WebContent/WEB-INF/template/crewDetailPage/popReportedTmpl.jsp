<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/template" id="popReportedTmpl">
    <@ _.each(reportPost,function(c){@>
    <div class="crewReportWrap"><!--crewPostWrap-->
        <div class="postingUserInformationContainer"><!--postingUserInformationContainer-->
            <!-- -----------------------postUserInfo------------------------------ -->
            <div class="posting_user_profile"><img src="<@=c.profileImg @>" /></div>
            <span class="posting_user_name"><@=c.name @></span>
            <span class="posting_date"><@= moment(c.regdate).format("YYYY년 MM월 DD일 HH:mm:ss")@></span>
            <!-- -----------------------postUserInfo------------------------------ -->
        </div><!--//postingUserInformationContainer-->
        <div class="postingContentsContainer"><!--postingContentsContainer-->
            <p class="posting_text"><@=c.contents@></p>
        </div><!--//postingContentsContainer-->
        <div class="reportReasonContainer"><!--commentContainer-->
            <div class="report_title_box"><span>신고</span></div>
            <ul class="report_reason_list"><!--commented_list-->
                <@ _.each(c.reports,function(r){@>
                <li class="report_reason_item"><!--report_reason_item-->
                    <span class="reporting_date"><@=moment(r.regdate).format("YYYY년 MM월 DD일 HH:mm:ss")@></span>
                    <span class="reporting_reason"><@=r.type @></span>
                    <div class="reporting_user_profile"><img src="<@=r.profileImg @>" /></div>
                </li><!--//report_reason_item-->
                <@})@>
            </ul><!--//commented_list-->
        </div><!--//commentContainer-->
        <!--//crewPostWrap--></div>
    <@})@>
</script>