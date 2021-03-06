<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/template" id="popWriteTmpl">
		<div class="pop_write"><!-- popWrite start-->
            <form id="writeForm" method="post" action="/writePost.do">
                <!-- 질문 2 : fieldset 추가 적당한지-->
                <fieldset>
                    <input type="hidden" id="contents" name="contents" value=""/>
                    <input type="hidden" name="boardNo" value="<@=boardNo@>"/>
                    <input type="hidden" name="memberNo" value="<%=crewMemberNo%>"/>
                    <input class="imageApplicable" type="hidden" name="imageApplicable" value="N" />
                    <h2>글쓰기</h2>
                    <div id="standalone-container">
                        <div id="toolbar-container">
                            <!--                    <span class="ql-formats">-->
                            <select class="ql-size">
                                <option>20px</option>
                                <option>28px</option>
                                <option>36px</option>
                                <option>48px</option>
                            </select>
                            <!--                    </span>-->
                            <!--                    <span class="ql-formats">-->
                            <button class="ql-bold" data-toggle="tooltip" data-placement="bottom" title="Bold"></button>
                            <button class="ql-italic" data-toggle="tooltip" data-placement="bottom" title="Italic"></button>
                            <button class="ql-underline" data-toggle="tooltip" data-placement="bottom" title="Underline"></button>
                            <button class="ql-strike" data-toggle="tooltip" data-placement="bottom" title="Strike"></button>
                            <select class="ql-color">
                                <option selected></option>
                                <option value="red"></option>
                                <option value="orange"></option>
                                <option value="yellow"></option>
                                <option value="green"></option>
                                <option value="blue"></option>
                                <option value="purple"></option>
                            </select>
                        </div>
                        <!-- 에디터 감싸는 컨테이너 -->
                        <div id="editorContainer"></div>
                        <div class="file_box">
                            <ul class="file_list"></ul>
                        </div>
                        <!-- 에디터 -->
                        <div class="editor_upload_box">
                            <ul class="editor_write_images">
                                <li>
                                    <label for="image_input"><i class="far fa-image"></i>
                                    </label>
                                    <input id="image_input" type="file" style="display: none;"/>
                                </li>
                                <li>
                                    <label for="file_input"><i class="fas fa-paperclip"></i>
                                    </label>
                                    <input id="file_input" type="file" style="display: none;"/>
                                </li>
                            </ul>
                            <div>
                                <label for="post_top_input">게시글 상위 고정</label>
                                <input type="checkbox" id="post_top_input" name="post_top" value="T"/><!--질문 3: value 뭐가 좋을지? -->
                            </div>

                            <div id="post_submit_btn"><button type="submit">저장</button></div>
                        </div><!--//editor_upload_box end-->
                        <div class="close"><i class="fas fa-times"></i></div>
                    </div>
                </fieldset>
            </form>
        </div><!--// popWrite end-->
</script>