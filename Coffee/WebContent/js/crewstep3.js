
let countFlag = false;
const $crewPopulationInput = $('.crew_population_input');
$crewPopulationInput.keyup(function (e) {
    let val = $crewPopulationInput.val();
    if(val>=10 && val<=30){
        $populationMsg.removeClass("ok");
        countFlag= true;
        nextBtnOnStep3(countFlag);
    }else if(val<10){
        $populationMsg.addClass("ok").text("10이상 숫자 입력!");
        countFlag= false;
        nextBtnOnStep3(countFlag);
    }else{
        $populationMsg.addClass("ok").text("30이하 숫자 입력!");
        countFlag= false;
        nextBtnOnStep3(countFlag);
    }

});

function nextBtnOnStep3(countFlag){
    console.log("nextBtnOn step3");
    if(countFlag==true){
        $nextBtnStep3.css({
            "background-color": "#FF6333",
            "color": "#fff"
        });
        $nextBtnStep2.removeAttr('disabled');
    }else{
        $nextBtnStep3.css({
            "background-color": "#eee",
            "color": "#000"
        });
        $nextBtnStep2.attr("disabled","disabled");
    }
}