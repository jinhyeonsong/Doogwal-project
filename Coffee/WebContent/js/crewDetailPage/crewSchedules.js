//일별 일정 리스트 템플릿: 현재 여기에 일별+모든 일정 리스트 다 합쳐서 넣음.
const dailySchedulesListTmpl = _.template($("#dailySchedulesListTmpl").html());
//모든 일정 리스트 템플릿
const allSchedulesListTmpl = _.template($("#allSchedulesListTmpl").html());

const calendarEl = document.getElementById("calendar");//이거 지금 템플릿 안에 있어서 그런가?
//undefined 뜨는 이유가?==> 그래서 일단 템플릿 밖으로 뺌.
  
const calendar = new FullCalendar.Calendar(calendarEl, {
    headerToolbar: {
      //툴바 위치 조정 여기서 가능함
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth',
    },

    initialDate: new Date(),
    //navLinks: true, // can click day/week names to navigate views
    //이거 true 아니면 e.stopPropagation(); 안해줘도 됨.
    businessHours: true, // display business hours
    editable: true,
    selectable: true,
    locale:"ko",
    //select: triggered when a date/time selection is made.
    dateClick: function(info) {
      getDailySchedulesList(info.date,info.dateStr,info.date.getFullYear(),info.date.getMonth()+1,info.date.getDate(),
            info.date.getHours(),info.date.getMinutes(),info.date.getSeconds(),info.date.getMilliseconds());//풀캘린더가 자체적으로 갖고 있는 속성들 date, dateStr 

      //alert('selected ' + info.startStr + ' to ' + info.endStr);
      //우리가 만든 일별 일정 리스트 html템플릿에 일 날짜 클릭시에 뜨게할 때 필요함!!
    }
  });//풀캘린더 만들기.

const $newMonthCalendar= $(".calendar_tab li:nth-child(1)>a");//일정 캘린터 탭
const $newWholeCalendar= $(".calendar_tab li:nth-child(2)>a");//일정 전체보기 탭
const $dailyScheduleBox = $(".daily_schedule_box");//매일 일정 리스트 박스
const $allSchedulesList = $("#allSchedulesList");//전체 스케줄 리스트 담는애
//지금 템플릿 안에 넣어서 페이지 안에 없음.... 페이지가 로딩될때는 jquery 입장에서 얘가 없음
const $calendarWrap = $(".calendar_wrap");//매일일정, 캘린더, 전체 스케줄 리스트 다 담고 있는애

const $monthCalendar = $(".fc-dayGridMonth-button");//기존 "월" 버튼
const $wholeCalendar = $(".fc-listMonth-button");//기존 "일정목록" 버튼
const $todayBtn = $(".fc-today-button");//오늘 버튼


//일정 버튼 누르면 캘린더와 일별일정 리스트 뜨게 만들기
function ScheduleFormOpen(){
	$calendarBox.show();
    $newMonthCalendar.addClass("color");
    calendar.render();//렌더해야 캘린더 찌그러지는거 막음.
    getDailySchedulesList(new Date());
}

$newMonthCalendar.click(function (e) {
	e.preventDefault();
    $monthCalendar.click();
    $calendarBox.show();
    $(".box_for_full_calendar").show();
    $(".daily_schedule_box").removeClass("disappear");
    $allSchedulesList.removeClass("appear");
    $(this).addClass("color");
    $newWholeCalendar.removeClass("color");//일정 전체보기 색깔 빼기
    calendar.render();
});

$newWholeCalendar.click(function (e) {//일정 전체보기 탭 클릭시
	e.preventDefault();//링크이동 막기
    $(this).addClass("color");//일정 전체보기 탭에 색깔 줌
    $(".box_for_full_calendar").hide();
    $(".daily_schedule_box").addClass("disappear");
    $newMonthCalendar.removeClass("color");
    $allSchedulesList.addClass("appear");
});
  
function getDailySchedulesList(dateAll,dateStr,year,month,date,hour,min,sec,milSec) {
	
  $.ajax({
    url:"/ajax/getDailyScheduleList.json",
    dataType: "json",
    type: "GET",
    data:{"dateAll":dateAll,"dateStr":dateStr,"crewNo":crewNo,"year":year,"month":month,"date":date,"hour":hour,"min":min,
       "sec":sec,"milSec":milSec},//넘겨야 할 정보들
    error:function() {
      alert("해당 서비스 점검중입니다. 나중에 시도해주세요.");
    },
    success:function (json) {
      let dayArray=["일","월","화","수","목","금","토"]
      $(".daily_schedule_box").html(dailySchedulesListTmpl({date :dateAll.getDate(), day:dayArray[dateAll.getDay()], dailySchedules:json}));

    }//success end
  })//ajax end

}//getDailySchedulesList() end
    
//이렇게 했기 때문에 오늘 날짜가 제일 먼저 뜨는 것.
getDailySchedulesList(new Date());

//모든 일정 목록을 불러오는 함수
function getAllSchedulesList() {

  $.ajax({
    url:"/ajax/getAllScheduleList.json",
    dataType: "json",
    type: "GET",
    data:{"crewNo":crewNo},
    error:function() {
      alert("해당 서비스 점검중입니다. 나중에 시도해주세요.");
    },
    success:function (json) {
      console.log(json);
      $("#allSchedulesList").html(allSchedulesListTmpl({allSchedules : json}));
    }//success end
  })//ajax end

}//getAllSchedulesList() end
getAllSchedulesList();
calendar.render();

function getMonthSchedules() {
	$.ajax({
      url:"/ajax/getMonthlySchedules.json",
      
      data:{
       "crewNo":crewNo
      },
      error:function () {
        alert("에러!");
      },
      success: function (json) {
        console.log(json);
        calendar.addEventSource(json);
      }
    });
}
getMonthSchedules();
//월별 스케줄은 미리 떠 있어야 함. 그래서 함수 호출함.
//일별 스케줄은 dateClick 속성 적용해서 따로 만든 li html 에 뜨게 해야 함.

