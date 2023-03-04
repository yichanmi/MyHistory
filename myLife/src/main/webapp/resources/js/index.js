var img1; //현재 이미지
var lst_img; //마지막 이미지

window.onload = function() {
	//setInterval(호출 함수,시간);
	setInterval("fn_change()", 2000);
}

function fn_change() {
	img1 = $("#img_area img").eq(0);
	lst_img = $("#img_area img").eq(-1);
	
	//마지막 img(".img4")를 첫번째로 이동
	lst_img.addClass("z-index").css("opacity", 0).animate({opacity:1}, 1000, function() {
		$("#img_area").prepend(lst_img);
		img1.removeClass("z-index");
		
		$("#img_area img").hide();
		$("#img_area img").eq(0).show();
	});
}