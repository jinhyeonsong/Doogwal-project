<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/template" id="postsTmpl">
    <@ _.each(crewPost,function(c){@>
    <div class="crewPostWrap"><!--crewPostWrap-->
		<div class="option_btn"><!--//option_btn start-->
        	<a><i class="fas fa-ellipsis-v"></i></a>
        	<ul class="option_list">
            	<li class="top_item">상위글로 고정</li>
            	<li class="ban_item">신고하기</li>
				<@if(crewMemberNo == c.memberNo){ @>
				<li class="delete_post_item">삭제하기</li>
				<li class="update_post_item">수정하기</li>
				<@}@>
			</ul>
			<input type="hidden" value="<@= c.no@>"/>
			<input type="hidden" value="<@=c.memberNo@>"/>
    	</div><!--//option_btn end-->

	<div class="postingUserInformationContainer"><!--postingUserInformationContainer-->
            <!-- -----------------------postUserInfo------------------------------ -->
 			<div class="posting_user_profile"><img src="img/profile/<@=c.userMember.profileImg@>" /></div>
        	<span class="posting_user_name"><@=c.userMember.name @></span>
        	<span class="posting_date"><@= moment(c.regdate).format("YYYY년 MM월 DD일 HH:mm:ss")@></span>
			<!-- -----------------------postUserInfoTmpl------------------------------ -->
        </div><!--//postingUserInformationContainer-->
        <div class="postingContentsContainer"><!--postingContentsContainer-->
            <p class="posting_text"><@=c.texts@></p>
            <div class="posting_image image_box_type<@if(c.postImgs.length>5){@><@=4@><@}else{@><@=c.postImgs.length@><@}@>"><!--posting_image-->
                <ul class="posting_image_list"><!--posting_image_list-->
			<!-- -----------------------posting Imags------------------------------ -->
				<@ for(let i=0;i<c.postImgs.length;i++){ @>
					<li class="posting_image_item"><img src="<@=c.postImgs[i].image@>" width="100%" height="100%" /></li>
                <@} @>
			<!-- -----------------------posting Imags------------------------------ -->
				</ul><!--//posting_image_list-->
            </div><!--//posting_image-->
        </div><!--//postingContentsContainer-->
        <div class="postCountContainer"><!--postCountContainer-->
            <div class="like_box"><!--like_box-->
                <div class="like_icon"><i class="fas fa-heart"></i></div>
			<!-- -----------------------like Cnt ------------------------------ -->
                <span class="like_count"><@=c.likeCnt @></span>
			<!-- -----------------------like Cnt ------------------------------ -->
                <div class="like_sort_icon"><i class="far fa-caret-square-down"></i></div>
                <div class="sorting_like_box"><!--sorting_like_box-->
                    <div class="sorting_like_title_box"><!--sorting_like_title_box-->
                        <div class="like_icon"><i class="fas fa-heart"></i></div>
				<!-- -----------------------sorting Cnt ------------------------------ -->
                        <span class="like_count"><@=c.likeCnt@></span>
				<!-- -----------------------sorting Cnt ------------------------------ -->
                    </div><!--//sorting_like_title_box-->
                    <ul class="sorting_like_list"><!--sorting_like_list_box_list-->
                        <!-- -----------------------------sortingLikeList -----------------------------------  -->
					<@ for(let i=0;i<c.likeMembers.length;i++){ @>
						<li class="sorting_like_list_item">
                        	<div class="like_user_profile"><img src="<@=c.likeMembers[i].profileImg @>.jpg" width="40" height="40" /><i class="fas fa-heart"></i></div>
                        	<span class="like_user_name"><@=c.likeMembers[i].name @></span>
                    	</li>
					<@} @>
					<!-- -----------------------------sortingLikeList -----------------------------------  -->
                    </ul><!--//sorting_like_box_list-->
                </div><!--//sorting_like_box-->
            </div><!--//like_box-->
            <div class="comment_box"><!--comment_box-->
                <span class="comment_title">댓글</span>
                <span class="comment_count"><@=c.replyCnt @></span>
            </div><!--//comment_box-->
        </div><!--//postCountContainer-->
        <div class="postReactionContainer"><!--postReactionContainer-->
            <div class="like_btn <@if(c.myLikeCount>0){ @>
				like
				<@}@>">
				<input class="likeBtn" type="checkbox" 
				<@if(c.myLikeCount>0){ @>
				checked="checked"
				<@}@>"/>
				<input type="hidden" value="<@= c.no@>"/>
			</div>
            <button class="comment_btn"></button>
        </div><!--//postReactionContainer-->
        <div class="commentContainer"><!--commentContainer-->
            <ul class="commented_list"><!--commented_list-->
            <!-- ----------------------------- replyList -----------------------------------  -->
			<@ for(let i=0;i<c.replies.length;i++){ @>
				<li class="commented_item"><!--commented_item-->
                	<div class="commented_user_profile"><img src="/img/profile/<@=c.replies[i].profileImg @>" width="40" height="40" /></div>
                	<span class="commented_user_name"><@=c.replies[i].name @></span>
                	<p class="commented_text"><@= c.replies[i].reply@></p>
                	<div class="commented_reaction_box"><!--commented_add_box-->
                    <span class="commented_date"><@= moment(c.replies[i].regdate).format("YYYY년 MM월 DD일 HH:mm:ss")@></span>
                    <!--<button class="comment_btn">답글쓰기</button>-->
                </div><!--//commented_add_box-->
            	</li><!--//commented_item-->
			<@} @>
			<!-- ----------------------------- replyList -----------------------------------  -->
            </ul><!--//commented_list-->
        </div><!--//commentContainer-->
        <div class="commentingContainer"><!--commentingContainer-->
            <form class="reply_form" method="get" action="/ajax/insertReply.json">
                <input class="commeningInput" name="reply"/>
				<input type="hidden" value="<@= c.no@>"/>
                <div class="commenting_user_profile"><img src="/img/profile/<%if(crewOrder !=-1){%><%=userCrews[crewOrder].getProfileImg() %>
				<%}else{%>
				/img/default.jpg
				<%}%>" /></div>
                <button class="commentingBtn">보내기</button>
            </form>
        </div><!--//commentingContainer-->

    </div><!--//crewPostWrap-->
    <@})@>
</script>