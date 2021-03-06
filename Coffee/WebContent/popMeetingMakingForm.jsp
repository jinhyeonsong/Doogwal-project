<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="meetingMakingWrap"><!--meetingMakingWrap-->
    <div class="close_btn"><i class="fas fa-times"></i></div>
    <div id="meetingMakingContainer" class="meetingMakingStep1"><!--meetingMakingContainer-->
        <div id="meetingMakingHeader"><!--meetingMakingHeader-->
            <div id="containerTitleBox"><!--containerTitleBox-->
                <span>밋팅 만들기</span>
            </div><!--//containerTitleBox-->
            <div id="meetingMakingProgressBox"><!--meetingMakingProgressBox-->
                <ol class="progress_list"><!--progress_list-->
                    <li class="progress_item"><p>1</p></li><!--
                    --><li class="progress_item"><p>2</p></li>
                    <li class="progress_item"><p>3</p></li><!--
                    --><li class="progress_item"><p>4</p></li>
                    <li class="progress_item"><p>5</p></li>
                </ol><!--//progress_list-->
            </div><!--//meetingMakingProgressBox-->
        </div><!--//meetingMakingHeader-->
        <div id="meetingMakingContents"><!--meetingMakingContents-->
            <form action="/makingMeeting.doo" method="post" ><!--form-->
            	<input type="hidden" name="crewNo" value="<%=crew.getNo() %>" />
                <div class="essential_step"><!--essentialStep-->
                    <div class="meeting_part_box"><!--meeting_part_box-->
                        <label>파트</label>
                        <select id="partDropdown" name="partDropdown"><!--partDropdown-->
                            <option value='M'>대결</option>
                            <option value='F'>친목</option>
                        </select><!--//partDropdown-->
                    </div><!--//meeting_part_box-->
                    <div class="meeting_name_box"><!--meeting_name_box-->
                        <label>이름</label>
                        <input id="meetingNameInput" name="meetingNameInput" maxlength="10" /><!--<i class="fas fa-exclamation-circle"></i>-->
                        <span class="text_length_notice">최소 2자 / 최대 10자</span>
                        <span class="text_length"></span>
                    </div><!--//meeting_name_box-->
                    <div class="calender_box"><!--calender_box-->
                        <label>날짜</label>
                        <div class="tui-datepicker-input tui-datetime-input tui-has-focus ">
                            <input type="text" id="datepicker-input" name="datepicker_input" aria-label="Date-Time" autocomplete="off">
                            <span class="tui-ico-date"></span>
                        </div>
                        <div id="datePickerWrapper"></div>
                        <input id="datePickerValueTube" name="datePickerValueTube" />
                    </div><!--//calender_box-->
                    <div class="time_box"><!--time_box-->
                        <label>시간</label>
                        <div id="timePickerWrapper"></div>
                        <input id="timePickerValueTube" name="timePickerValueTube" />
                        <span>~</span>
                        <div id="timePickerWrapper2"></div>
                        <input id="timePickerValueTube2" name="timePickerValueTube2" />
                        <div class="all_day_btn_box"><input id="allDayBtn" type="checkbox" /><label for="allDayBtn">하루종일</label></div>
                    </div><!--//time_box-->
                    <div class="theme_box"><!--theme_box-->
                        <label>테마</label>
                        <select id="themeDropdown" name="themeDropdown"><!--partDropdown-->
                            <option value="1">너희와 있어 즐겁다</option>
                            <option value="2">이쁜 달밤 아래에서</option>
                            <option value="3">건강부터 챙기자</option>
                            <option value="4">내일은 없다</option>
                            <option value="5">나가자! 싸우자!</option>
                            <option value="6">그 때처럼 처음처럼</option>
                            <option value="7">움직이기 싫어~</option>
                            <option value="8">주저리 주저리</option>
                            <option value="9">1.2kg 1.2kg</option>
                            <option value="10">요즘 그게 유행이래</option>
                        </select><!--//partDropdown-->
                    </div><!--//theme_box-->
                </div><!--//essentialStep-->
                <div class="location_step"><!--locationStep-->
                    <div class="meeting_address_box"><!--meeting_address_box-->
                        <label>주소</label>
                        <input type="text" id="sample5_address" name="sample5_address" placeholder="주소검색">
                        <input id="specifyAddressInput" name="specifyAddressInput" placeholder="상세주소 입력"/>
                        <input type="button" onclick="sample5_execDaumPostcode()">
                        <div id="map"></div>
                        <input type="hidden" id="latStr" name="latStr" />
                        <input type="hidden" id="lngStr" name="lngStr" />
                        <input type="hidden" id="strForDistrictNo" name="strForDistrictNo" />
                    </div><!--//meeting_address_box-->
                </div><!--//locationStep-->
                <div class="additional_step"><!--additionalStep-->
                    <div class="meeting_category_box"><!--meeting_category_box-->
                        <label>분류</label>
                        <!-- 자기 분류가 디폴트가 되도록 설정 -->
                        <select id="meetingCategoryChoice" name="meetingCategoryChoice">
                            <optgroup label="게임">
                                <option value="10">콘솔게임</option>
                                <option value="11">PC게임</option>
                                <option value="12">모바일게임</option>
                            </optgroup>
                            <optgroup label="아웃도어">
                                <option value="13">해외여행</option>
                                <option value="14">국내여행</option>
                                <option value="15">배낭여행</option>
                                <option value="16">캠핑</option>
                            </optgroup>
                            <optgroup label="반려동물">
                                <option value="17">반려동물</option>
                            </optgroup>
                            <optgroup label="봉사활동">
                                <option value="18">봉사활동</option>
                            </optgroup>
                            <optgroup label="사교모임">
                                <option value="19">사교모임</option>
                            </optgroup>
                            <optgroup label="스터디">
                                <option value="20">언어</option>
                                <option value="21">자격증</option>
                                <option value="22">스터디</option>
                            </optgroup>
                            <optgroup label="스포츠/레저">
                                <option value="23">자전거</option>
                                <option value="24">구기종목</option>
                                <option value="25">골프</option>
                                <option value="26">등산</option>
                                <option value="27">낚시</option>
                                <option value="28">볼링</option>
                                <option value="29">수영</option>
                                <option value="30">러닝</option>
                                <option value="31">스노보드/스키</option>
                                <option value="32">스포츠/레저</option>
                            </optgroup>
                            <optgroup label="음악/악기">
                                <option value="33">팝</option>
                                <option value="34">락/메탈</option>
                                <option value="35">힙합</option>
                                <option value="36">클래식/재즈</option>
                                <option value="37">인디</option>
                                <option value="38">악기</option>
                            </optgroup>
                            <optgroup label="문화/예술">
                                <option value="39">영화</option>
                                <option value="40">공연/뮤지컬</option>
                                <option value="41">미술/전시</option>
                                <option value="42">그림/일러스트</option>
                                <option value="43">댄스/무용</option>
                                <option value="44">문화생활</option>
                            </optgroup>
                        </select>
                    </div><!--//meeting_category_box-->
                    <div class="meeting_image_box"><!--meeting_image_box-->
                        <i class="far fa-image"></i>
                        <div class="meeting_image"><input id="meetingImageInput" name="meetingImageInput" type="file" accept="image/*" /><i class="far fa-plus-square"></i></div>
                    </div><!--//meeting_image_box-->
                    <div class="meeting_point_box"><!--meeting_category_box-->
                        <label>포인트</label>
                        <input id="meetingPointInput" name="meetingPointInput"  oninput="this.value = this.value.replace(/[^0-9]/g, '');" />
                        <div class="having_point">
                            <img src="img/saemoPoint.png" width="15px" height="15px" />
                            <span><%=crew.getPoint() %></span>
                        </div>
                    </div><!--//meeting_category_box-->
                    <div class="meeting_explanation_box"><!--meeting_category_box-->
                        <label>세부설명</label>
                        <input id="meetingExplanationInput" name="meetingExplanationInput" maxlength="20" />
                        <span class="explanation_length">(0 / 20자)</span>
                    </div><!--//meeting_category_box-->
                </div><!--//additionalStep-->
                <div class="rule_step"><!--ruleStep-->
                    <div class="meeting_rule_box"><!--meeting_rule_box-->
                        <label>규칙</label>
                        <input id="meetingRuleInput" name="meetingRuleInput" maxlength="40" />
                        <button>추가</button>
                        <span class="rule_number">(0 / 4개)</span>
                        <span class="rule_length">(0 / 40자)</span>
                        <div class="rules_box"><!--rules_box-->
                            <ul class="rule_list"><!--rule_list-->
                            </ul><!--//rule_list-->
                        </div><!--//rules_box-->
                        <input type="hidden" id="rulesInput" name="rulesInput" />
                    </div><!--//meeting_rule_box-->
                    <div class="meeting_material_box"><!--meeting_material_box-->
                        <label>준비물</label>
                        <input id="meetingMaterialInput" name="meetingMaterialInput" maxlength="20" />
                        <button>추가</button>
                        <span class="material_length">(0 / 20자)</span>
                        <div class="materials_box"><!--materials_box-->
                            <ul class="material_list"><!--material_list-->
                            </ul><!--//material_list-->
                        </div><!--//materials_box-->
                        <input type="hidden" id="materialsInput" name="materialsInput" />
                    </div><!--//meeting_material_box-->
                </div><!--//ruleStep-->
                <div class="confirm_step"><!--confirmStep-->
                    <div class="confirm_shape_box"><!--confirm_shape_box-->
                        <div class="comfirm_meeting_img"><img src="img/5.jpg" width="260" height="120" /></div>
                        <div class="confirm_meeting_text"><!--confirm_meeting_text-->
                            <div class="confirm_betting_point"><img src="img/saemoPoint.png" width="16" height="16" />2000</div>
                            <div class="confirm_crew_name"><%=crew.getName() %></div>
                            <div class="confirm_meeting_name"><span></span><img src="img/fighting.png" width="15" height="15" /></div>
                            <div class="confirm_meeting_location"></div>
                        </div><!--//confirm_meeting_text-->
                        <div class="confirm_btn"><button>확인</button></div>
                    </div><!--//confirm_shape_box-->
                </div><!--//confirmStep-->
            </form><!--//form-->
        </div><!--//meetingMakingContents-->
        <i id="nextBtn" class="fas fa-angle-right"></i>
        <i id="prevBtn" class="fas fa-angle-left"></i>
    </div><!--//meetingMakingContainer-->
</div><!--//meetingMakingWrap-->
