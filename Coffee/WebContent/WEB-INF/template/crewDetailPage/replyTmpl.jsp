<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/template" id="replyTmpl">
<li class="commented_item"><!--commented_item-->
	<div class="commented_user_profile"><img src="<@=r.profileImg @>" width="40" height="40" /></div>
    <span class="commented_user_name"><@=r.name @></span>
    <p class="commented_text"><@= r.reply@></p>
    <div class="commented_reaction_box"><!--commented_add_box-->
    <span class="commented_date">방금 전</span>
                    
    </div><!--//commented_add_box-->
 </li><!--//commented_item-->
</script>