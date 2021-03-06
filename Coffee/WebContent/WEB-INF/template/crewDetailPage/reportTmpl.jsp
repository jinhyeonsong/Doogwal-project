<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/template" id="reportTmpl">
       <div id="reportBox"><!--reportBox-->
        <div class="report_title">신고하기</div>
        <form class="report_reason_box" method="get" action="/"><!--report_reason_box-->
            <ul class="report_reason_list">
                <li class="report_reason_item">
                    <label>
                        <span>스팸입니다.</span>
                        <i class="fas fa-angle-right"></i>
                        <input class="report_input" type="radio" name="type" value="S"/>
                    </label>
                </li>
                <li class="report_reason_item">
                    <label>
                        <span>부적절한 상품을 팔거나 홍보하고 있습니다.</span>
                        <i class="fas fa-angle-right"></i>
                        <input class="report_input"  type="radio" name="type" value="P"/>
                    </label>
                </li>
                <li class="report_reason_item">
                    <label>
                        <span>자해나 자살과 관련된 내용입니다.</span>
                        <i class="fas fa-angle-right"></i>
                        <input class="report_input" type="radio" name="type" value="H"/>
                    </label>
                </li>
                <li class="report_reason_item">
                    <label>
                        <span>나체 이미지거나 음란한 내용을 담고 있습니다.</span>
                        <i class="fas fa-angle-right"></i>
                        <input class="report_input" type="radio" name="type" value="D"/>
                    </label>
                </li>
                <li class="report_reason_item">
                    <label>
                        <span>저작권, 명예훼손 등 기타 권리를 침해하는 내용입니다.</span>
                        <i class="fas fa-angle-right"></i>
                        <input class="report_input" type="radio" name="type" value="C"/>
                    </label>
                </li>
                <li class="report_reason_item">
                    <label>
                        <span>특정인의 개인정보가 포함되어 있습니다.</span>
                        <i class="fas fa-angle-right"></i>
                        <input class="report_input" type="radio" name="type" value="I"/>
                    </label>
                </li>

                <li class="report_reason_item">
                    <label>
                        <span>혐오를 조장하는 내용입니다.</span>
                        <i class="fas fa-angle-right"></i>
                        <input class="report_input" type="radio" name="type" value="H"/>
                    </label>
                </li>
            </ul>
        </form><!--//report_reason_box-->
    </div>
</script>