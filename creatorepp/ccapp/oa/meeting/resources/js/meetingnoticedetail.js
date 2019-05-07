/*
	函数:  displaymore
	说明:  显示/隐藏 更多内容
*/
var strSum = 0; 
function displaymore() {
	strSum = strSum + 1;
	jQuery("#strSum").val(strSum);
	jQuery("tr[id='more']").each(function(i, obj) {
		jQuery(this).show();
	});
	jQuery("div[id='more']").each(function(i, obj) {
		jQuery(this).show();
	});
	jQuery("#imgdiv").removeClass("up_d");
	jQuery("#imgdiv").addClass("up_s");
	if (strSum % 2 == 0) {
		jQuery("tr[id='more']").each(function(i, obj) {
			jQuery(this).hide();
		});
		jQuery("div[id='more']").each(function(i, obj) {
			jQuery(this).hide();
		});
		jQuery("#imgdiv").removeClass("up_s");
		jQuery("#imgdiv").addClass("up_d");
	}
}

/*
作者:  肖杰
时间:  2013-10-08
函数:  ischecked
说明:  
参数:   无
返回值: 无
*/
var ischecked = function(){
if(jQuery('#is_sms').attr("checked")=="checked"){
	jQuery('#is_sms').val("1");
}else{
	jQuery('#is_sms').val("0");
}
if(jQuery('#is_mail').attr("checked")=="checked"){
	jQuery('#is_mail').val("1");
}else{
	jQuery('#is_mail').val("0");
}
if(jQuery('#is_rtx').attr("checked")=="checked"){
	jQuery('#is_rtx').val("1");
}else{
	jQuery('#is_rtx').val("0");
}
if(jQuery('#is_msg').attr("checked")=="checked"){
	jQuery('#is_msg').val("1");
}else{
	jQuery('#is_msg').val("0");
}
}

/*
	函数:  displaymore
	说明:  显示
*/
function displays() {
	jQuery("tr[id='more']").each(function(i, obj) {
		jQuery(this).show();
	});
	jQuery("div[id='more']").each(function(i, obj) {
		jQuery(this).show();
	});
	jQuery("#imgdiv").removeClass("up_d");
	jQuery("#imgdiv").addClass("up_s");
}

/*
	函数:  adddeptanduser4topic
	说明:  弹出公告接收人和接收单位树
	参数:   无
	返回值: 无
*/
function adddeptanduser4topic() {
	var s = new jQuery.z_tree_leftRigth();
	s.treeID='button_envelop_username';
	s.isShowSeacher="aa";
	s.treeName="选取人员";
	s.headerName="选取人员";
	s.titelText = "选择人员";
	s.rightHeaderText="已添加机构和人员";
	s.isNewCommonUse=true;
	s.treeList=[{
	 				'leftHeaderText':'按人员选择',
	 				valueKey:'ps',
	 				selectedIds:jQuery("#m_topic_user_ids").val(),
	 				type : 'APERSON'
	             },
		  		{
	 				'leftHeaderText':'按单位选择',
	 				'item_id' :'org_id',
	 				isType:'dept', 
	 				valueKey:'dept',
	 				selectedIds:jQuery("#m_topic_unit_ids").val(),
	 				type:'AORG'
	 				//type:'{"type":"24"}'
	 			},
	 			{
	 				leftHeaderText:'常用分组',
	 				item_id :'org_id',
	 				isType:'dept', 
	 				valueKey:'dept',
	 				selectedIds:'',
	 				isGroup:true,
	 				type:"A4"
		 		}];
	 s.returnFunction=function(object){
	   	 jQuery("#deptTd").html("");
		 jQuery("#m_topic_user_ids").val("");
		 jQuery("#m_topic_user_names").val("");
		 jQuery("#userTd").html("");
		 jQuery("#m_topic_unit_ids").val("");
		 jQuery("#m_topic_unit_names").val("");
		 createrDeptAndPosn(object.dept,"deptTd",'m_topic_unit_ids','m_topic_unit_names');
		 createrDeptAndPosn(object.ps,"userTd",'m_topic_user_ids','m_topic_user_names',false,false,false,true);
	 }
	 s.init();
}
/*
函数:  adddeptanduser
说明:  弹出公告接收人和接收单位树
参数:   无
返回值: 无
*/
function adddeptanduser(delFlag) {
var s = new jQuery.z_tree_leftRigth();
s.treeID='button_envelop_username';
s.isShowSeacher="aa";
s.treeName="选取人员";
s.headerName="选取人员";
s.titelText = "选择人员";
s.rightHeaderText="已添加机构和人员";
s.isNewCommonUse=true;
s.treeList=[{
 				'leftHeaderText':'按人员选择',
 				valueKey:'ps',
 				selectedIds:jQuery("#m_receiver_user_ids").val(),
 				//type : 'APERSON'
 				type:'{"type":"2"}'
 					             },
	  		{
 				'leftHeaderText':'按单位选择',
 				'item_id' :'org_id',
 				isType:'unit', 
 				valueKey:'unit',
 				selectedIds:jQuery("#m_receiver_unit_ids").val(),
 				//type:'AORG'
 				type:'{"type":"3"}'
 			},
 			{
 				leftHeaderText:'常用分组',
 				item_id :'org_id',
 				isType:'dept', 
 				valueKey:'dept',
 				selectedIds:'',
 				isGroup:true,
 				type:"A4"
	 		}];
 s.returnFunction=function(object,arr,o){
   	 jQuery("#deptTd").html("");
	 jQuery("#m_receiver_user_ids").val("");
	 jQuery("#m_receiver_user_names").val("");
	 jQuery("#userTd").html("");
	 jQuery("#m_receiver_unit_ids").val("");
	 jQuery("#m_receiver_unit_names").val("");
	 //过滤根节点 --------begin
	 var top_id = "";
	 if(arr[0].isType=="dept"){
		 var arr4dept = arr[0];
	 }else{
		 var arr4dept = arr[1];
	 }
	 
	 for(var i=0;i<arr4dept.length;i++){
		 if(arr4dept[i].parent_id==0){
			 top_id=arr4dept[i].id
			 break;
		 }
	 }
	 var arr_depts = object.unit.id.split(",");//  1,2,3
	 var arr_depts_name = object.unit.name.split(",");
	 var depts = "";
	 var deptnames = "";
	 for(var j=0;j<arr_depts.length;j++){
		 if(arr_depts[j]!=top_id){
			 depts+=","+arr_depts[j];
			 deptnames+=","+arr_depts_name[j];
		 }
	 }
	 if(arr_depts.length>0){
		 depts=depts.substring(1);
		 deptnames=deptnames.substring(1);
	 }
	 object.unit.id=depts;
	 object.unit.name=deptnames;
	 //过滤根节点 --------end
	 createrDeptAndPosn(object.unit,"deptTd",'m_receiver_unit_ids','m_receiver_unit_names');
	 createrDeptAndPosn(object.ps,"userTd",'m_receiver_user_ids','m_receiver_user_names',false,false,false,true);
	 
	 if(delFlag=='clean'){
		 //清空全部议题的与会单位和人员列表
		 parent.frame3.jQuery("input[name=m_topic_user_ids]").each(function(){
			 jQuery(this).val('');
		 });
		 parent.frame3.jQuery("input[name=m_topic_unit_ids]").each(function(){
			 jQuery(this).val('');
		 });
		 jQuery("input[name=m_topic_user_names]").each(function(){
			 jQuery(this).val('');
		 });
		 parent.frame3.jQuery("input[name=m_topic_unit_names]").each(function(){
			 jQuery(this).val('');
		 });
		 parent.frame3.jQuery("textarea[name=userTd]").each(function(){
			 jQuery(this).html('');
		 });
		 parent.frame3.jQuery("td[name=deptTd]").each(function(){
			 jQuery(this).html('');
		 });
	 }
 }
 s.init();
}
/*
 * new add by xiaojie 8-23
函数:  adddeptanduser1
说明:  弹出公告接收人和接收单位树
参数:   无
返回值: 无
*/
function adddeptanduser1(delFlag,userids,unitids) {
var s = new jQuery.z_tree_leftRigth();
s.treeID='button_envelop_username';
s.isShowSeacher="aa";
s.treeName="选取人员";
s.headerName="选取人员";
s.titelText = "选择人员";
s.rightHeaderText="已添加机构和人员";
s.isNewCommonUse=true;
s.treeList=[{
 				'leftHeaderText':'按人员选择',
 				valueKey:'ps',
 				selectedIds:jQuery("#m_receiver_user_ids").val(),
 				userids:userids,
 				type : 'MEET_PERSON'
 					             },
	  		{
 				'leftHeaderText':'按单位选择',
 				'item_id' :'org_id',
 				isType:'dept', 
 				valueKey:'dept',
 				unitids:unitids,
 				type:'MEET_AORG'
 				//type:'{"type":"24"}'
 			},
 			{
 				leftHeaderText:'常用分组',
 				item_id :'org_id',
 				isType:'dept', 
 				valueKey:'dept',
 				selectedIds:'',
 				isGroup:true,
 				type:"A4"
	 		}];
 s.returnFunction=function(object){
   	 jQuery("#deptTd").html("");
	 jQuery("#m_receiver_user_ids").val("");
	 jQuery("#m_receiver_user_names").val("");
	 jQuery("#userTd").html("");
	 jQuery("#m_receiver_unit_ids").val("");
	 jQuery("#m_receiver_unit_names").val("");
	 createrDeptAndPosn(object.dept,"deptTd",'m_receiver_unit_ids','m_receiver_unit_names');
	 createrDeptAndPosn(object.ps,"userTd",'m_receiver_user_ids','m_receiver_user_names',false,false,false,true);
	 
	 if(delFlag=='clean'){
		 //清空全部议题的与会单位和人员列表
		 parent.frame3.jQuery("input[name=m_topic_user_ids]").each(function(){
			 jQuery(this).val('');
		 });
		 parent.frame3.jQuery("input[name=m_topic_unit_ids]").each(function(){
			 jQuery(this).val('');
		 });
		 jQuery("input[name=m_topic_user_names]").each(function(){
			 jQuery(this).val('');
		 });
		 parent.frame3.jQuery("input[name=m_topic_unit_names]").each(function(){
			 jQuery(this).val('');
		 });
		 parent.frame3.jQuery("textarea[name=userTd]").each(function(){
			 jQuery(this).html('');
		 });
		 parent.frame3.jQuery("td[name=deptTd]").each(function(){
			 jQuery(this).html('');
		 });
	 }
 }
 s.init();
}
/*
函数:  chooseOrg
说明:  选择人员
参数：   userId（回填父页面的控件id）,userName（回填父页面的控件id）,
		orgName(回填父页面的“单位”控件id),treetypestr（单选radio或多选checkbox）
*/
var chooseActUsersSetCount = function (userId,userName,orgName,treetypestr){
	var s = new jQuery.z_tree();
	s.treeID = 'mianUser';
	s.treetypestr = treetypestr;
	s.isShowSeacher = true;
	s.treeName = "选取人员";
	s.headerName = "选取人员";
	s.type = "APERSON";
	s.selectedIds = jQuery("#"+userId).val(),
	s.returnFunction = function(userObj,o) {
		if (!IsSpace(userObj)) {
			jQuery('#'+userId).val(userObj.id);
			jQuery('#'+userName).val(userObj.name);
			if (orgName!=""){
				jQuery('#'+orgName).val(userObj.returnparentNode);
			}
			jQuery('#m_attender_count').val(userObj.id.split(',').length);
		} else {
			jQuery('#'+userId).val("");
			jQuery('#'+userName).val("");
			jQuery('#'+orgName).val("");
		}
		onchangemsg();
	}
	s.init();
}

/*
函数:  chooseOrg
说明:  选择人员
参数：   userId（回填父页面的控件id）,userName（回填父页面的控件id）,
		orgName(回填父页面的“单位”控件id),treetypestr（单选radio或多选checkbox）
*/
var chooseActUsers = function (userId,userName,orgName,treetypestr){
	var s = new jQuery.z_tree();
	s.treeID = 'mianUser';
	s.treetypestr = treetypestr;
	s.isShowSeacher = true;
	s.treeName = "选取人员";
	s.headerName = "选取人员";
	s.type = "APERSON";
	s.selectedIds = jQuery("#"+userId).val(),
	s.returnFunction = function(userObj,o) {
		if (!IsSpace(userObj)) {
			jQuery('#'+userId).val(userObj.id);
			jQuery('#'+userName).val(userObj.name);
			if (orgName!=""){
				jQuery('#'+orgName).val(userObj.returnparentNode);
			}
			if(userId=="m_link_user_id") jQuery("#m_link_tel").val(o[0].user_mobiletel1);
		} else {
			jQuery('#'+userId).val("");
			jQuery('#'+userName).val("");
			jQuery('#'+orgName).val("");
		}
	}
	s.init();
}
/*
函数:  chooseOrg
说明:  选择单位
参数：   orgId（回填父页面的控件id）,orgName（回填父页面的控件id）
*/
var chooseOrg = function(orgId,orgName) {
	var s = new jQuery.z_tree();
	s.treeID = 'mian';
	s.isShowSeacher = true;
	s.treeName = "选取单位";
	s.isType = 'dept';
	s.headerName = "选取单位";
	s.item_id = 'm_receiver_unit_ids';
	s.selectedIds = jQuery('#m_receiver_unit_ids').val();
	s.type = 'AORG';
	s.returnFunction = function(orgObj) {
		if (!IsSpace(orgObj)) {
			jQuery('#'+orgId).val(orgObj.id);
			jQuery('#'+orgName).val(orgObj.name);
		} else {
			jQuery('#'+orgId).val("");
			jQuery('#'+orgName).val("");
		}
	}
	s.init();
}
/*
函数:  getMeetingmsglogJsonNew
说明:  得到对应实体类的json格式字符串
*/
function getMeetingmsglogJsonNew(m_msg_send_flag, m_msg_send_flag_name){
	var msgjsonsNew = {
		m_id:jQuery("#m_id").val(),
		m_notice_id:jQuery("#m_notice_id").val()
	}
	var msgjsons = "'m_id':'"+jQuery("#m_id").val()+"'"+",'m_notice_id':'"+jQuery("#m_notice_id").val()+"'";
	var is_sms  = jQuery("#is_sms")[0].checked;
	var is_msg  = jQuery("#is_msg")[0].checked;
	var is_rtx  = jQuery("#is_rtx")[0].checked;
	var is_mail  = jQuery("#is_mail")[0].checked;
	var str = "";
	if(!isSpace(is_sms)){
		str+="1,";
	}
	if(!isSpace(is_msg)){
		str+="2,";
	}
	if(!isSpace(is_rtx)){
		str+="3,";
	}
	if(!isSpace(is_mail)){
		str+="4,";
	}
	str=str.substring(0,str.length-1);
	
	msgjsons+=",'m_msg_type':'"+str+"'";
	msgjsons+=",'m_msg_send_flag_name':'"+m_msg_send_flag_name+"'";   
	msgjsons+=",'m_contents':'"+jQuery("#msg_contents").val()+"'";
	msgjsons+=",'m_msg_send_flag':'"+m_msg_send_flag+"'";
	
	msgjsonsNew.m_msg_type=str;
	msgjsonsNew.m_msg_send_flag_name=m_msg_send_flag_name;
	msgjsonsNew.m_contents=jQuery("#msg_contents").val();
	msgjsonsNew.m_msg_send_flag=m_msg_send_flag;
	
	return msgjsonsNew;
}
/*
函数:  getMeetingmsglogJson
说明:  得到对应实体类的json格式字符串
*/
function getMeetingmsglogJson(m_msg_send_flag, m_msg_send_flag_name){
	var msgjsons = "'m_id':'"+jQuery("#m_id").val()+"'"+",'m_notice_id':'"+jQuery("#m_notice_id").val()+"'";
	var is_sms  = jQuery("#is_sms")[0].checked;
	var is_msg  = jQuery("#is_msg")[0].checked;
	var is_rtx  = jQuery("#is_rtx")[0].checked;
	var is_mail  = jQuery("#is_mail")[0].checked;
	var str = "";
	if(!isSpace(is_sms)){
		str+="1,";
	}
	if(!isSpace(is_msg)){
		str+="2,";
	}
	if(!isSpace(is_rtx)){
		str+="3,";
	}
	if(!isSpace(is_mail)){
		str+="4,";
	}
	str=str.substring(0,str.length-1);
	
	msgjsons+=",'m_msg_type':'"+str+"'";
	msgjsons+=",'m_msg_send_flag_name':'"+m_msg_send_flag_name+"'";   
	msgjsons+=",'m_contents':'"+jQuery("#msg_contents").val()+"'";
	msgjsons+=",'m_msg_send_flag':'"+m_msg_send_flag+"'";
	return msgjsons;
}
/*
函数:  getAlertWindowMeetingmsglogJson
说明:  得到对应实体类的json格式字符串
*/
function getAlertWindowMeetingmsglogJson(m_msg_send_flag, m_msg_send_flag_name,m_notice_id){
	var msgjsons = "'m_id':'','m_notice_id':'"+m_notice_id+"'";
	var is_sms  = jQuery("#is_sms")[0].checked;
	var is_msg  = jQuery("#is_msg")[0].checked;
	var is_rtx  = jQuery("#is_rtx")[0].checked;
	var is_mail  = jQuery("#is_mail")[0].checked;
	var str = "";
	if(!isSpace(is_sms)){
		str+="1,";
	}
	if(!isSpace(is_msg)){
		str+="2,";
	}
	if(!isSpace(is_rtx)){
		str+="3,";
	}
	if(!isSpace(is_mail)){
		str+="4,";
	}
	str=str.substring(0,str.length-1);
	msgjsons+=",'m_msg_type':'"+str+"'";
	msgjsons+=",'m_msg_send_flag_name':'"+m_msg_send_flag_name+"'";   
	msgjsons+=",'m_contents':'"+jQuery("#msg_contents").val()+"'";
	msgjsons+=",'m_msg_send_flag':'"+m_msg_send_flag+"'";
	return msgjsons;
}

/*
函数:  disabledAll
说明:  禁用表单元素
*/
function disabledAll(){
	jQuery("form input").prop("disabled", true);
	jQuery("form select").prop("disabled", true);
	jQuery("form radio").prop("disabled", true);
	jQuery("form checkbox").prop("disabled", true);
	jQuery("form textarea").prop("disabled", true);
	jQuery("#m_msg_contents").prop("disabled", false);
	jQuery("#m_msg_type1").prop("disabled", false);
	jQuery("#m_msg_type2").prop("disabled", false);
	jQuery("#changenotetmpbutton").prop("disabled", false);
}
/*
函数:  undisabledAll
说明:  表单元素置为可用
*/
function undisabledAll(){
	jQuery("form input").prop("disabled", false);
	jQuery("form select").prop("disabled", false);
	jQuery("form radio").prop("disabled", false);
	jQuery("form checkbox").prop("disabled", false);
	jQuery("form textarea").prop("disabled", false);
}

/*
函数:  openmeetingnotetemplatelist
说明:  打开短信模板1
*/
function openmeetingnotetemplatelist() {
    openAlertWindows('showMeetingNoteTemplate'
            ,getCurrentFilePath()+'meetingnotetemplatelist4noticechoose.jsp?windowId=showMeetingNoteTemplate&canChoose=yes','短信模板列表',800,450,'10%','10%');
}

/*
函数:  adddeptanduser4Other
说明:  弹出公告接收人和接收单位树 for 其他
参数:   无
返回值: 无
*/
function adddeptanduser4Other(delFlag) {
var s = new jQuery.z_tree_leftRigth();
s.treeID='button_envelop_username';
s.isShowSeacher="aa";
s.treeName="选取人员";
s.headerName="选取人员";
s.titelText = "选择人员";
s.rightHeaderText="已添加机构和人员";
s.isNewCommonUse=true;
s.treeList=[{
			    leftHeaderText: "个人通讯录",
			    valueKey: "gr",
			    selectedIds: jQuery("#m_receiver_other_user_ids").val(),
			    type: "GRTXL"
			},
			{
			    leftHeaderText: "公共通讯录",
			    valueKey: "gg",
			    selectedIds: jQuery("#m_receiver_other_unit_ids").val(),
			    type: "GGTXL"
			}];
 s.returnFunction=function(object){
	 jQuery("#m_receiver_other_user_ids").val("");
	 jQuery("#m_receiver_other_user_names").val("");
	 jQuery("#userTd4Other").val("");
	 jQuery("#m_receiver_other_unit_ids").val("");
	 jQuery("#m_receiver_other_unit_names").val("");
	 
	 if(!isSpace(object.gr)){
		 jQuery("#m_receiver_other_user_ids").val(object.gr.id);
		 jQuery("#m_receiver_other_user_names").val(object.gr.name); 
	 }
	 if(!isSpace(object.gg)){
		 jQuery("#m_receiver_other_unit_ids").val(object.gg.id);
		 jQuery("#m_receiver_other_unit_names").val(object.gg.name);
	 }
	 
	 if(!isSpace(object.gr) && !isSpace(object.gg)){
		 jQuery("#userTd4Other").val(object.gg.name+","+object.gr.name);
	 }else if(!isSpace(object.gr)){
		 jQuery("#userTd4Other").val(object.gr.name);
	 }else if(!isSpace(object.gg)){
		 jQuery("#userTd4Other").val(object.gg.name);
	 }
	 
 }
 s.init();
}

function getM_begin_time(){
	var sDate = jQuery("#m_begin_time").val();
	if(!isSpace(sDate)){
		sDate = jQuery("#m_begin_time").val()+" 00:00:01";
	}
	return sDate;
}
function getM_end_time(){
	var sDate = jQuery("#m_end_time").val();
	if(!isSpace(sDate)){
		sDate = jQuery("#m_end_time").val()+" 23:59:59";
	}
	return sDate;
}
/*
函数:  publicFormatterMeetingDate
说明:  格式化时间到分，秒舍去
*/
function publicFormatterMeetingDate(dStr){
	return (isSpace(dStr)||dStr.length!=19)?"": dStr.substring(0,16);
}