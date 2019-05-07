<%-- 
描述：补发界面
作者：黄海
版本：1.0
日期：2013-09-28
 --%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String p_manage_ids = StringUtil.deNull(request.getParameter("p_manage_ids"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title>补发界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" ></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" ></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" ></script>


<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../resources/js/meetingnoticedetail.js"></script>
<script>
var windowId = "<%=StringUtil.deNull(request.getParameter("windowId"))%>";
jQuery(document).ready(function() {
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	jQuery("#maindiv").height(_documentBodyHeight-(_documentBodyHeight-560+50));	
});
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
	 }
	 s.init();
}
/*
	函数:  returnReplaceNoteContents
	说明:  用替代后短信内容设置页面上短信内容的文本域
	参数:  替代后短信内容
*/
function replaceNoteContents(str){
	var tabwindow = getParentWindow('');	
	jQuery("#m_msg_contents").val(tabwindow.frame1.window.returnReplaceNoteContents(str));
}
/* 
	函数:  reissueMeeting
	说明:  补发
*/
function reissueMeeting(){
	if (jQuery("#m_msg_type1")[0]==undefined && jQuery("#m_msg_type2")[0]==undefined ){
		var msgFlag = "";
		var noteFlag = "";
	}else if (!jQuery("#m_msg_type1")[0].checked && !jQuery("#m_msg_type2")[0].checked ){
		var msgFlag = "";
		var noteFlag = "";
	}else{
		var msgFlag  = jQuery("#m_msg_type1")[0].checked;
		var noteFlag = jQuery("#m_msg_type2")[0].checked;
	}
	
	if (!isSpace(msgFlag) || !isSpace(noteFlag)){//发消息 ，就要判断内容不可为空
		if(isSpace(jQuery('#m_msg_contents').val())){
			alert("注意：提醒内容不能空！");
			return false;
		}
	}else if (!isSpace(jQuery('#m_msg_contents').val()) && isSpace(msgFlag) && isSpace(noteFlag) ){
		alert("注意：提醒方式不能空！");
		return false;
	}	
	jQuery("#hidden_action").val("SendAdd");
	jQuery("#onlyFrom").submit();
}

/* 
	函数:  closeform
	说明:  关闭指定窗口，刷新其父页面列表
	参数:  windowId 窗口id
*/
function closeform(windowId){
    closeAlertWindows(windowId, false, true);
}

//关闭弹窗
function closed(){
	var p={
			headerText:'提示',
			okName:'确认',
	        okFunction:function(){
	        	removeAlertWindows(windowId,true);
	        },
	        cancelName:'取消'
		};
	alert("关闭后，数据将不会保存，确定关闭？",p);
    
}	

<%--提交后回调--%>
var afterSubmitFn=function(result){
	result=JSON.parse(result);
	if(result.flag==true){
		alert(result.info);
		closeAlertWindows(windowId,true,true);
	}else{
		alert(result.info);
	}
};
</script>
</head>
<body>
<div id="maindiv" class="vcenter" style="height:400px;overflow-x:hidden;overflow-y:auto;">
	
	<form id="onlyFrom" name="onlyFrom" method="post" action="papersendtypechangedo.jsp" target="fileTempleateinfodoJSPhiddenFrame">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="p_manage_ids" id="p_manage_ids" value="<%=p_manage_ids %>" />
		<div class="cue_box_top">
			<input class="but_y_01" type="button" value="关闭" onclick="closed()" />
			<input class="but_y_01" type="button" value="补发" onclick="reissueMeeting()"/>
		</div>
		<!-- 补发与会单位与人员 begin -->
		<div class="content_02_box_title_bg">
			<span>补发的单位与人员</span>
			<div class="content_02_box_add show_content" style="cursor: hand">
				<input type="button" value="选择" class="but_six" onclick="adddeptanduser1('','','')" />
			</div>
		</div>
		<div class="content_02_box_div">
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th" style="width:191px;">部门列表：
						<input type="hidden" id="m_receiver_unit_ids" name="m_receiver_unit_ids" value="" />
						<input type="hidden" id="m_receiver_unit_names" name="m_receiver_unit_names" value="" />
					</th>
					<td class="content_02_box_div_table_td" id="deptTd" colspan="5" >
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width:191px;">人员列表：
					</th>
					<td class="content_02_box_div_table_td" colspan="5">
						<input type="hidden" id="m_receiver_user_ids" name="m_receiver_user_ids" value="" />
						<input type="hidden" id="m_receiver_user_names" name="m_receiver_user_names" value="" />
						<textarea id="userTd" name= "userTd" class="validate[required,maxSize[500]] textarea_575" 
							style="width:98%"  onclick="adddeptanduser1('','','')" rows="5" readonly="readonly"></textarea>
					</td>
				</tr>
			</table>
		</div>
		<!-- 补发与会单位与人员 end -->
		<!-- 消息提醒begin -->
		<div class="content_02_box_title_bg">
			<span>消息提醒</span>
		</div>
		<input type="hidden" id="m_id" name="m_id" value="" />
		<div class="content_02_box_div">
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th" >提醒方式：</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<input name="m_msg_type" id="m_msg_type1" type="checkbox"   value="1" />&nbsp;短信
						&nbsp;
						<input name="m_msg_type" id="m_msg_type2" type="checkbox" value="2" />&nbsp;即时信息
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >提醒内容：</th>
					<td class="content_02_box_div_table_td" colspan="5">
						<textarea id="m_msg_contents" name="m_msg_contents" class="validate[required,maxSize[300]] textarea_575" style="width:98%" rows="5" ></textarea>
					</td>
				</tr>
			</table>
		</div>
		<!-- 消息提醒end -->
	</form>
	<iframe name="fileTempleateinfodoJSPhiddenFrame" width=0 height=0></iframe>
</div>
</body>
</html>