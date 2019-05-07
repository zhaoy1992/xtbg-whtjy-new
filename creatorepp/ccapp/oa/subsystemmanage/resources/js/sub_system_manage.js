//外部子系统的默认图片路径
var images_url = "../resources/images/";
//外部子系统的图片数组
var test_json = [images_url+"dlk_03.jpg",images_url+"dlk_05.jpg",
             images_url+"dlk_07.jpg",images_url+"dlk_13.jpg",
             images_url+"dlk_15.jpg"];

jQuery(function(){
	//选中是否是公共子系统
	jQuery("input[name='sys_ispublic'][value='"+sys_ispublic+"']").attr("checked",'checked');
	createSubSysArea(sys_img_url);
})

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
var createSubSysArea = function (sys_img_url){
	var sub_sys_show_main_div = jQuery("#image_choose");
	
	var show_sys_div = null;//展示系统的div
	jQuery.each(test_json,function(key,val){
		if((key+1)%10 != 0){
			show_sys_div = createDiv("show_sys_div_left", "show_sys_div show_sys_div_2");
		}else{
			show_sys_div = createDiv("show_sys_div_right", "show_sys_div show_sys_div_2 show_sys_right_div");
		}
		sys_name = val.sys_name || "";
		var sys_img_href = jQuery("<span>");
		sys_img_href.click(function(){
			jQuery("input[name=sys_img_url]:eq("+key+")").attr("checked",'checked'); 
		});
		var subDiv = jQuery("<div/>");
		jQuery(subDiv).append(jQuery("<img>").attr("src",val || ""));
		jQuery(subDiv).append(jQuery("</br>"));
		jQuery(subDiv).append(sys_name);
		var radioDiv = jQuery("<div/>");//创建图片相关radio
		jQuery(radioDiv).append(jQuery("<input type='radio'  name='sys_img_url' value='"+val+"'/>"))
		if((IsSpace(sys_img_url) && 0 == key) || sys_img_url == val){//根据图片路径回选
			jQuery("input:radio",radioDiv).attr("checked",'checked'); 
		}
		jQuery(sys_img_href).append(subDiv)
		jQuery(show_sys_div).append(sys_img_href);
		jQuery(show_sys_div).append(radioDiv);
		jQuery(sub_sys_show_main_div).append(jQuery(show_sys_div));
		
	})
	return test_json[0].sys_id || "";
}

