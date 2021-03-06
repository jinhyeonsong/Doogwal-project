/* step2 이미지 ajax*/
// const $crewImageItem = $('.crew_image_item input');
const $crewImageSelectedImg = $('.crew_image_selected img');

const $crewImageItem = $('.crew_image_item input');

$crewImageItem.change(function (e) {
    e.preventDefault();
    let src = $(this).next().children().data("src");
    console.log("crewImageItemChange: " + src);
    // $(this).children().attr("checked","checked");
    $crewImageSelectedImg.attr("src", src);
});

$("#image_input").on("change",function() {

    const file = this.files[0];

    alert("클릭");
    console.log("file: "+ file);

    //image/ 로 시작하는

    if (/^image\//.test(file.type)) {

        //alert("여기에 오면 파일이 있고 사진임");

        //multipart/form-data에 필요함
        const formData = new FormData();

        formData.append("uploadImg", file, file.name);
        formData.append("type", "B");//B는 board의 줄임말

        //여기서 ajax로 파일 업로드 수행
        $.ajax({
            url:"ajax/uploadImage.json",
            processData : false,//multipart/form-data
            contentType : false,//multipart/form-data
            data : formData,//multipart/form-data
            type : 'POST',//multipart/form-data
            dataType : "json",
            error : function(xhr, error, code) {
                alert("에러:" + code);
            },
            success:function(json) {
                console.log("ajax 실행:"+json.url);
                $crewImageSelectedImg.attr("src",json.url);
                // image
                // delta라는 개념을 하나 만들어라
                // 요소를 직접 못넣는다. custom delta
                $(".crew_image_item input:checked").prop("checked",false);
            }
        });


    } else {
        alert("이미지를 선택해주세요!");
    }
})