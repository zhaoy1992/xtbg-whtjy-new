<%--
　　描述：会议通知申请 会议议题 明细 页面
　　作者：黄海
　　版本：1.0
　　日期：2013-6-23
--%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingHandleServiceImpl" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String m_notice_id = request.getParameter("m_notice_id");
String m_topic_id = ""; 
String m_topic_name = "";
String m_begin_time = "";
String m_user_id = "";
String m_user_name = "";
String m_remark = "";
String m_topic_unit_ids = "";
String m_topic_user_ids = "";
String m_topic_unit_names = "";
String m_topic_user_names = "";	

String count4topic="0";

MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
List<Map<String, String>> meetingTopicBeanListMap = null;
if (!StringUtil.nullOrBlank(m_notice_id)){
	meetingTopicBeanListMap = service.getMeetingTopicBeanListMap(m_notice_id);
	
}else{
	
}
%>
<title>会议议题 页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>


<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
	
<!-- 引入上传控件 -->
<link rel="stylesheet" href="../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/js/meetingnoticedetail.js"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
var iCount = 0;
var j=0;


/*
	函数:  newAdd
	说明:  新加载数据至页面
*/
function newAdd(){
	var topicDiv = jQuery("#topicDiv");
	var topicTable=jQuery("#topicTable");
	//topicDiv.html(topicDiv.html() + topicTable.html().toString().replaceAll('myNum',''+iCount));
    //初始化单位列表和人员列表
    topicDiv.append(topicTable.html().toString().replaceAll('myNum',''+iCount));
	
	iCount++;
}
function romoveTable(count){
	jQuery("#table_" + count).remove();
}
/*
函数:  dynamicadddeptanduser4topic
说明:  弹出公告接收人和接收单位树
参数:   无
返回值: 无
*/
function dynamicadddeptanduser4topic(myNum,deptTd,m_topic_unit_ids,m_topic_unit_names,userTd,m_topic_user_ids,m_topic_user_names) {
	var org_ids = parent.frame1.getM_receiver_unit_ids();
	var user_ids = parent.frame1.getM_receiver_user_ids();
	if(isSpace(org_ids) && isSpace(user_ids)){
		alert("注意： 选择议题与会单位或人员之前请先设置好会议的与会单位或人员");
		return;
	}
	var s = new jQuery.z_tree_leftRigth();
	s.treeID='button_envelop_username';
	s.isShowSeacher="aa";
	s.treeName="选取人员";
	s.headerName="选取人员";
	s.titelText = "选择人员";
	s.rightHeaderText="已添加机构和人员";
	s.isNewCommonUse=true;
	s.treeList=[{
	 				leftHeaderText:'按人员选择',
	 				valueKey:'ps',
	 				selectedIds:jQuery("#"+m_topic_user_ids).val(),
	 				type : 'AUSER',
	 				user_ids:user_ids,
	 				org_ids:org_ids
	             },
		  		{
	 				'leftHeaderText':'按单位选择',
	 				'item_id' :'org_id',
	 				isType:'dept', 
	 				valueKey:'dept',
	 				selectedIds:jQuery("#"+m_topic_unit_ids).val(),
	 				type:'AORG4IDS',
	 				org_ids:org_ids
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
		jQuery("#"+deptTd).html("");
		jQuery("#"+m_topic_user_ids).val("");
		jQuery("#"+m_topic_user_names).val("");
		jQuery("#"+userTd).html("");
		jQuery("#"+m_topic_unit_ids).val("");
		jQuery("#"+m_topic_unit_names).val("");
		createrDeptAndPosn(object.dept,deptTd,m_topic_unit_ids,m_topic_unit_names);
		createrDeptAndPosn(object.ps,userTd,m_topic_user_ids,m_topic_user_names,false,false,false,true);
	}
	s.init();
}

function getBegintime4meeting(){
	return parent.frame1.jQuery("#m_begin_time").val();
}

jQuery(function() {
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	jQuery("#maindiv").height(_documentBodyHeight-100);
	
	//window.parent.setButtonDisplay();
<%
	if (meetingTopicBeanListMap!=null){
		count4topic = ""+meetingTopicBeanListMap.size();
		for (Map<String, String> map : meetingTopicBeanListMap) {
%>
			var topicDiv = jQuery("#topicDiv");
			var topicTable=jQuery("#topicTable");
			topicDiv.html(topicDiv.html() + topicTable.html().toString().replaceAll('myNum',''+j));
			j++;
<%			
		}
		for (Map<String, String> map : meetingTopicBeanListMap) {
			m_topic_id = StringUtil.deNull(map.get("m_topic_id"));
			m_topic_name = StringUtil.deNull(map.get("m_topic_name"));
			m_begin_time = StringUtil.deNull(map.get("m_begin_time"));
			if(m_begin_time.length()>0){
				m_begin_time=m_begin_time.substring(0, m_begin_time.length()-3);
			}
			m_user_id = StringUtil.deNull(map.get("m_user_id"));
			m_user_name = StringUtil.deNull(map.get("m_user_name"));
			m_remark = StringUtil.deNull(map.get("m_remark"));
			m_topic_unit_ids = StringUtil.deNull(map.get("m_topic_unit_ids"));
			m_topic_user_ids = StringUtil.deNull(map.get("m_topic_user_ids"));
			m_topic_unit_names = StringUtil.deNull(map.get("m_topic_unit_names"));
			m_topic_user_names = StringUtil.deNull(map.get("m_topic_user_names"));
%>
			jQuery("#m_topic_name_"+iCount).val('<%=m_topic_name%>');
			jQuery("#m_begin_time_"+iCount).val('<%=m_begin_time%>');
			jQuery("#m_user_id_"+iCount).val('<%=m_user_id%>');
			jQuery("#m_user_name_"+iCount).val('<%=m_user_name%>');
			jQuery("#m_remark_"+iCount).val('<%=m_remark%>');
			jQuery("#m_topic_unit_ids_"+iCount).val('<%=m_topic_unit_ids%>');
			jQuery("#m_topic_user_ids_"+iCount).val('<%=m_topic_user_ids%>');
			jQuery("#m_topic_unit_names_"+iCount).val('<%=m_topic_unit_names%>');
			jQuery("#m_topic_user_names_"+iCount).val('<%=m_topic_user_names%>');
			
			var dep = new Object();
			var ps = new Object();
			dep.id=jQuery("#m_topic_unit_ids_"+iCount).val();
			dep.name=jQuery("#m_topic_unit_names_"+iCount).val();
			ps.name=jQuery("#m_topic_user_names_"+iCount).val();
			ps.id=jQuery("#m_topic_user_ids_"+iCount).val();
			createrDeptAndPosn(dep,"deptTd_"+iCount,'m_topic_unit_ids'+iCount,'m_topic_unit_names'+iCount);
			createrDeptAndPosn(ps,"userTd_"+iCount, 'm_topic_user_ids'+iCount,'m_topic_user_names'+iCount,false,false,false,true);
			
			iCount++;
<%	
		}
		
	}
	//if(StringUtil.nullOrBlank(m_notice_id) || meetingTopicBeanListMap==null || meetingTopicBeanListMap.isEmpty() ){
	if(StringUtil.nullOrBlank(m_notice_id) && 1==2){
%>
		var topicDiv = jQuery("#topicDiv");
		var topicTable=jQuery("#topicTable");
		topicDiv.html(topicDiv.html() + topicTable.html().toString().replaceAll('myNum',''+iCount));
		
		jQuery("#m_topic_name_"+iCount).val('<%=m_topic_name%>');
		jQuery("#m_begin_time_"+iCount).val('<%=m_begin_time%>');
		jQuery("#m_user_id_"+iCount).val('<%=m_user_id%>');
		jQuery("#m_user_name_"+iCount).val('<%=m_user_name%>');
		jQuery("#m_remark_"+iCount).val('<%=m_remark%>');
		jQuery("#m_topic_unit_ids_"+iCount).val('<%=m_topic_unit_ids%>');
		jQuery("#m_topic_user_ids_"+iCount).val('<%=m_topic_user_ids%>');
		jQuery("#m_topic_unit_names_"+iCount).val('<%=m_topic_unit_names%>');
		jQuery("#m_topic_user_names_"+iCount).val('<%=m_topic_user_names%>');
		
		var dep = new Object();
		var ps = new Object();
		dep.id=jQuery("#m_topic_unit_ids_"+iCount).val();
		dep.name=jQuery("#m_topic_unit_names_"+iCount).val();
		ps.name=jQuery("#m_topic_user_names_"+iCount).val();
		ps.id=jQuery("#m_topic_user_ids_"+iCount).val();
		createrDeptAndPosn(dep,"deptTd_"+iCount,'m_topic_unit_ids'+iCount,'m_topic_unit_names'+iCount);
		createrDeptAndPosn(ps,"userTd_"+iCount, 'm_topic_user_ids'+iCount,'m_topic_user_names'+iCount,false,false,false,true);
		
		iCount++;
<%
	}
%>	
	window.parent.changeTabName('<%=count4topic%>');
	
	if(! window.parent.canOperate()){
		disabledAll();
		//隐藏新增和删除议题 的按钮
		jQuery("span[id='newAdd']").each(function(i, obj) {
			jQuery(this).hide();
		});
		jQuery("span[name='deletetopicbutton']").each(function(i, obj) {
			jQuery(this).hide();
		});
		jQuery("img[id='newAddButton']").each(function(i, obj) {
			jQuery(this).hide();
		});
		jQuery("img[id='delButton']").each(function(i, obj) {
			jQuery(this).hide();
		});
	}
});


/*
	函数:  checkData
	说明:  校验表单数据
*/
function checkData(){
	//tab页切换到frame3
	window.parent.toFrame(2);
	//自动校验
	var isFlag = jQuery('#form2').validationEngine('validate'); //是否全部验证通过
	if (!isFlag){
		return false;	
	}
	
	var arr_m_topic_unit_ids = jQuery("input[name=m_topic_unit_ids]");
	for(var i=0;i<arr_m_topic_unit_ids.length-1;i++){//最后一个克隆的不要
		if(isSpace(arr_m_topic_unit_ids[i].value)){
			//alert("注意：与会单位不能为空！");
			//return false;
		}
	}
	return true;
}
/*
	函数:  getJson
	说明:  得到对应实体类的json格式字符串
*/
function getJson(){
	var topicjsons = "";
	
	var arr_m_topic_id = jQuery("input[name=m_topic_id]");
	var arr_m_topic_name = jQuery("input[name=m_topic_name]");
	var arr_m_begin_time = jQuery("input[name=m_begin_time]");
	var arr_m_user_id = jQuery("input[name=m_user_id]");
	var arr_m_user_name = jQuery("input[name=m_user_name]");
	var arr_m_remark = jQuery("textarea[name=m_remark]");
	var arr_m_topic_unit_ids = jQuery("input[name=m_topic_unit_ids]");
	var arr_m_topic_user_ids = jQuery("input[name=m_topic_user_ids]");
	var arr_m_topic_unit_names = jQuery("input[name=m_topic_unit_names]");
	var arr_m_topic_user_names = jQuery("input[name=m_topic_user_names]");
	var m_notice_id = jQuery("#m_notice_id").val();
	for(var i=0;i<arr_m_topic_name.length-1;i++){//最后一个克隆的不要
		if(!isSpace(arr_m_topic_name[i].value)){
			if(i>0){
				topicjsons += ",";
			}
			topicjsons +=   "{'m_topic_id':'"+arr_m_topic_id[i].value+"'"+
							",'m_notice_id':'"+m_notice_id+"'"+
							",'m_topic_name':'"+arr_m_topic_name[i].value+"'"+
							",'m_begin_time':'"+arr_m_begin_time[i].value+"'"+
							",'m_user_id':'"+arr_m_user_id[i].value+"'"+
							",'m_user_name':'"+arr_m_user_name[i].value+"'"+
							",'m_remark':'"+arr_m_remark[i].value+"'"+
							",'m_topic_unit_ids':'"+arr_m_topic_unit_ids[i].value+"'"+
							",'m_topic_user_ids':'"+arr_m_topic_user_ids[i].value+"'"+
							",'m_topic_unit_names':'"+arr_m_topic_unit_names[i].value+"'"+
							",'m_topic_user_names':'"+arr_m_topic_user_names[i].value+"'}";
		}
	}
	return topicjsons;
}
/*
函数:  showMeetingTopicButton
说明:  显示控制button
*/
function showMeetingTopicButton(){
	jQuery("span[id='newAdd']").each(function(i, obj) {
		jQuery(this).show();
	});
	jQuery("span[name='deletetopicbutton']").each(function(i, obj) {
		jQuery(this).show();
	});
	jQuery("img[id='newAddButton']").each(function(i, obj) {
		jQuery(this).show();
	});
	jQuery("img[id='delButton']").each(function(i, obj) {
		jQuery(this).show();
	});
}
</script>
</head>
<body>
<div id="maindiv" class="vcenter" style="height:500px; overflow:auto;">
	<form action="" id="form2" name="form2" method="post" >
		<div>
			<div class="content_02_box" style="float: left;">
				<div class="content_02_box_title_bg">
					<span>会议议题</span>
					<div class="content_02_box_add show_content"  style="cursor: pointer">
						<img onclick="newAdd()" src="../../resources/style/blue/images/add.gif" id="newAddButton" style="margin-top:10px"/><span id="newAdd" onclick="newAdd()">新增议题&nbsp;</span>
					</div>
				</div>
			</div>
		</div>
		<div id="topicDiv">
		
		</div>
		<input type="hidden" name="m_notice_id" id="m_notice_id" value="<%=StringUtil.deNull(m_notice_id) %>" />
	</form>	
	<div class="content_02_box_div" style="float: left;" >
		<table border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td class="content_02_box_div_table_td" colspan=6>
				</td>
			</tr>
		</table>
	</div>
</div>
<!-- 克隆模板 begin-->
<div id="topicTable" style="display: none">
	<div class="content_02_box_div"  style="margin-left:10px"  id="table_myNum">
		<input type="hidden" name="m_topic_id" id="m_topic_id_myNum" value="" />
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr>
				<th width="200px" class="content_02_box_div_table_th">
					<span class="color_red">*</span>会议议题：
				</th>
				<td class="content_02_box_div_table_td" colspan="5">
					<input type="text" class="validate[required,maxSize[100]] input_cx_title_240" name="m_topic_name" id="m_topic_name_myNum" style="margin-top:3px" />
					<div class="content_02_box_add show_content"  style="cursor: pointer">
						<span id="deletetopicbutton_myNum" name="deletetopicbutton" onclick="romoveTable('myNum')" >删除议题</span> <img onclick="romoveTable('myNum')"   src="../../resources/style/blue/images/del.gif" id="delButton"/>
					</div>	
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>议题开始时间：</th>
				<td class="content_02_box_div_table_td" width="200px">
					<input class="validate[required] date_120 Wdate"
							type="text" id="m_begin_time_myNum" name="m_begin_time"
							onfocus="WdatePicker({minDate:getBegintime4meeting(),dateFmt:'yyyy-MM-dd HH:mm'})" />
				</td>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>汇报人：</th>
				<td class="content_02_box_div_table_td" colspan="2" width="200px">
					<input type="hidden" name="m_user_id"   id="m_user_id_myNum" value="" class="validate[required]"/>
					<input type="text"   name="m_user_name" id="m_user_name_myNum"  class="validate[required] xz_89_border" 
						value="" onclick="chooseActUsers('m_user_id_myNum','m_user_name_myNum','','radio')" />
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th">
					
				</th>
				<td class="content_02_box_div_table_td" colspan="5">
					<input type="button" value="选择单位和人员" class="but_six"  id="chooseButton"
						onclick="dynamicadddeptanduser4topic('myNum','deptTd_myNum','m_topic_unit_ids_myNum','m_topic_unit_names_myNum','userTd_myNum','m_topic_user_ids_myNum','m_topic_user_names_myNum')" />
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th" >与会单位列表：
					<input type="hidden" id="m_topic_unit_ids_myNum" name="m_topic_unit_ids" value=""  />
					<input type="hidden" id="m_topic_unit_names_myNum" name="m_topic_unit_names" value="" />
				</th>
				<td class="content_02_box_div_table_td" id="deptTd_myNum" name="deptTd" colspan="5" >
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th" ><span class="color_red">*</span>与会人员列表：
				</th>
				<td class="content_02_box_div_table_td" colspan="5">
					<input type="hidden" id="m_topic_user_ids_myNum" name="m_topic_user_ids" value="" />
					<input type="hidden" id="m_topic_user_names_myNum" name="m_topic_user_names" value="" />
					<textarea id="userTd_myNum" name= "userTd" class="validate[required,maxSize[500]] textarea_575" 
						style="width:98%" rows="5" readonly></textarea>
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th" style="width:191px;">备注：</th>
				<td class="content_02_box_div_table_td" colspan="5">
					<textarea  id="m_remark_myNum" name="m_remark" class="validate[maxSize[500]] textarea_575" style="width:98%" rows="5" ></textarea>
				</td>
			</tr>
			<hr />
		</table>
	</div>
	
</div>
<!-- 克隆模板 end-->
</body>
</html>