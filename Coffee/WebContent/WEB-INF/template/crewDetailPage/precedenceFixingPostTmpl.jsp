<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/template" id="precedenceFixingPostTmpl">
	<@ _.each(precedencePostContents,function(p){@>
	<li class="precedence_fixing_post_item">
    	<div class="precedence_fixing_post_before_icon"><i class="fas fa-grip-lines-vertical"></i></div>
    	<div class="precedence_fixing_post"><@=p.contents@></div>
   	 	<div class="precedence_fixing_post_after_icon"><i class="fas fa-caret-right"></i></div>
    </li>
	<@})@>
</script>