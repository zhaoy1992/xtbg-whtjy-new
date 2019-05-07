




$successful.initsucessful=function(response) {
	var obje = $("#sub_sys_main");

	// 左DIV
	var leftDiv = createDiv("sub_sys_left_div", "sub_sys_left_div");
	$(obje).append($(leftDiv));
	
	//右DIV
	var rightDiv = createDiv("sub_sys_right_div", "sub_sys_right_div");
	$(obje).append($(rightDiv));

	
	var first_sysid = createLeftSubSysArea(response);
	createRightSubSysArea(first_sysid);
};

/**
 * 构建左边子系统区域内容
 * @return
 */
var createLeftSubSysArea = function (response){
	var sub_sys_left_div = $("#sub_sys_left_div");
	var test_json = response.result;
	
	var show_sys_div = null;//展示系统的div

	$.each(test_json,function(key,val){
		if(key%2 == 0){
			show_sys_div = createDiv("show_sys_div_left", "show_sys_div");
		}else{
			show_sys_div = createDiv("show_sys_div_right", "show_sys_div show_sys_right_div");
		}
		sys_name = val.sys_name || "";
		sys_desc = val.sys_desc || "";
		sys_url = val.sys_url || "";
		var sys_img_href = $("<span>").attr("title",val.sys_desc);
		sys_img_href.click(function(){
			sys_id = val.sys_id || "";
			if(Search)Search();
		});
		var subDiv = $("<div/>");
		$(subDiv).append($("<img>").attr("src",val.sys_img_url || ""));
		$(subDiv).append($("</br>"));
		$(subDiv).append(sys_name);
		$(sys_img_href).append(subDiv)
		$(show_sys_div).append(sys_img_href);
		$(sub_sys_left_div).append($(show_sys_div));
		
	})
	return test_json[0].sys_id || "";
}

var createRightSubSysArea = function(sys_id){
	$("#sub_sys_right_div").html("");
	$("#sub_sys_right_div").load("sub_system_useinfo_list.jsp?sys_id="+sys_id);
}
