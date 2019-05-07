
$successful.initsucessful=function(response) {
	createSubSysArea(response);
};

var createDiv = function(id, className) {
	var div = document.createElement("div");
	jQuery(div).attr("id", id);
	addStyle(div, className);
	return div;
}

/**
 * 构建子系统区域内容
 * @return
 */
var createSubSysArea = function (response){
	var sub_sys_show_main_div = $("#sub_sys_show_main");
	var test_json = response.result;
	
	var show_sys_div = null;//展示系统的div

	$.each(test_json,function(key,val){
		if((key+1)%3 != 0){
			show_sys_div = createDiv("show_sys_div_left", "show_sys_div show_sys_div_2");
		}else{
			show_sys_div = createDiv("show_sys_div_right", "show_sys_div show_sys_div_2 show_sys_right_div");
		}
		sys_name = val.sys_name || "";
		var sys_img_href = $("<span>").attr("title",val.sys_desc || "");
		if(!IsSpace(val.sys_url)){
			sys_img_href.click(function(){
				if("N" == val.sys_ispublic ){
					window.open(val.sys_url+(val.sys_url.indexOf("?") == -1?"?":"&")+"userName="+val.sys_user_id+"&password="+val.sys_user_password,"_blank");
				}else{
					window.open(val.sys_url,"_blank");
				}
			});
		}
		
		var subDiv = $("<div/>");
		$(subDiv).append($("<img>").attr("src",val.sys_img_url || ""));
		$(subDiv).append($("</br>"));
		$(subDiv).append(sys_name);
		$(sys_img_href).append(subDiv)
		$(show_sys_div).append(sys_img_href);
		$(sub_sys_show_main_div).append($(show_sys_div));
		
	})
	return test_json[0].sys_id || "";
}

