<%-- 
描述：通知公告基本信息页面
作者：黄艺平
版本：1.0
日期：2013-09-19
 --%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page import="org.apache.velocity.runtime.directive.Foreach"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.impl.NoticeHandleServiceImpl"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String curUserId =  accesscontroler.getUserID();
	String curUserName =  accesscontroler.getUserName();
	String subid = request.getParameter("subid");
	String path = request.getContextPath();//服务器根路径
	String n_attach_id = "";
	String n_notice_id = request.getParameter("n_notice_id");
	String n_creator_username = "";
	String n_creator_userid = "";
	String n_orgid = "";
	String n_orgname = "";
	String unit_id="";//单位ID
	String unit_name="";//单位名称
	String n_audit_name ="";//审核人名称
	String n_audit_id = "";//审核人编号
	String n_audite_state ="";
	String curTime = StringUtil.convertTimeToString(new Timestamp(System.currentTimeMillis()), "");
	
	NoticeHandleServiceIfc noticeHandleServiceIfc = new NoticeHandleServiceImpl();
	Map<String, String> viewMap = new HashMap<String, String>();
	
	if(StringUtil.isBlank(n_notice_id)) {
		n_attach_id = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		n_creator_username = curUserName;
		n_creator_userid = curUserId;
		n_orgname = accesscontroler.getChargeOrgName();
		n_orgid = accesscontroler.getChargeOrgId();
		UserCacheBean userCacheBean = UserCache.getUserCacheBean(curUserId);
		if(userCacheBean != null) {
			unit_id = userCacheBean.getUnit_id();
			unit_name = userCacheBean.getUnit_name();
		}
	} else {
		viewMap = noticeHandleServiceIfc.getNoticeBaseInfoBean(n_notice_id);
		n_attach_id = StringUtil.deNull(viewMap.get("n_attach_id"));
		if(StringUtil.isBlank(n_attach_id)) {
			n_attach_id = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		}
		n_creator_username = StringUtil.deNull(viewMap.get("n_creator_username"));
		n_creator_userid = StringUtil.deNull(viewMap.get("n_creator_userid"));
		n_orgname = StringUtil.deNull(viewMap.get("n_orgname"));
		n_orgid = StringUtil.deNull(viewMap.get("n_orgid"));
		unit_id = StringUtil.deNull(viewMap.get("n_unit_id"));
		unit_name = StringUtil.deNull(viewMap.get("n_unit_name"));
		n_audit_name = StringUtil.deNull(viewMap.get("n_audit_name"));
		n_audit_id = StringUtil.deNull(viewMap.get("n_audit_id"));
		n_audite_state= StringUtil.deNull(viewMap.get("n_audite_state"));
	}
	//判断是否有短信，及时，邮件，站内消息提示
	SysParamUitl noticeutil=new SysParamUitl();
	Map<String,String> msgmap=noticeutil.getCheckedSystemMsg();
	String is_pub_sms=msgmap.get(SysParamConstant.IS_PUB_SMS);
	String is_pub_msg=msgmap.get(SysParamConstant.IS_PUB_MSG);
	String is_pub_rtx=msgmap.get(SysParamConstant.IS_PUB_RTX);
	String is_pub_mail=msgmap.get(SysParamConstant.IS_PUB_MAIL);
	String audit = SysParamUitl.getSysParamValue("audit_show");
	String publish = SysParamUitl.getSysParamValue("publish_show");
%>
<title>通知公告基本信息页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-newcommonuse.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js"></script>
<!-- 
<script type="text/javascript" src="../resources/js/announcementdrew.js"></script>
 -->
<script type="text/javascript">
var n_attach_id = '<%=n_attach_id %>';
var path = '<%=path %>';
var n_notice_id = '<%=n_notice_id %>';
var n_state = '<%=viewMap.get("n_state") %>';
var subid = '<%=subid %>';
var audit = '<%=audit %>';
var publish = '<%=publish %>';

jQuery(function() {
	eWebEditor1.setMode('VIEW');
	jQuery("#form1").validationEngine();
	MyFancyupload.createUpload('_fileshow', '#_filebut', path, path+'/servlet/pubFileUpload?buessid='+n_attach_id, true, n_attach_id);
	
	var dep = new Object();
	var ps = new Object();
	dep.id=jQuery("#n_receiver_orgid").val();
	dep.name=jQuery("#n_receiver_orgname").val();
	ps.name=jQuery("#n_receiver_username").val();
	ps.id=jQuery("#n_receiver_userid").val();
	createrDeptAndPosn(dep,"deptTd",'n_receiver_orgid','n_receiver_orgname');
	createrDeptAndPosn(ps,"userTd",'n_receiver_userid','n_receiver_username',false,false,false,true);

	if(n_notice_id != '') {
		jQuery("#n_unit_or_personal").val("<%=StringUtil.deNull(viewMap.get("n_unit_or_personal")) %>");
	}
	if("1"=="<%=StringUtil.deNull(viewMap.get("n_is_sms")) %>"){
		jQuery("#n_is_sms").attr("checked","checked");
	}
	if("1"=="<%=StringUtil.deNull(viewMap.get("n_is_msg")) %>"){
		jQuery("#n_is_msg").attr("checked","checked");
	}
	if("1"=="<%=StringUtil.deNull(viewMap.get("n_is_rtx")) %>"){
		jQuery("#n_is_rtx").attr("checked","checked");
	}
	if("1"=="<%=StringUtil.deNull(viewMap.get("n_is_mail")) %>"){
		jQuery("#n_is_mail").attr("checked","checked");
	}
	jQuery("#n_title").attr("disabled","disabled");
	jQuery("#n_unit_or_personal").attr("disabled","disabled");
	jQuery("#fj").hide();
	jQuery("#unit_person").hide();
	jQuery("#n_audit_name").attr("disabled","disabled");
	
});


/*
	作者:  黄艺平
	时间:  2013-06-19
	函数:  adddeptanduser
	说明:  弹出公告接收人和接收部门树
	参数:   无
	返回值: 无
*/
function adddeptanduser() {
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
	 				selectedIds:jQuery("#n_receiver_userid").val(),
	 				type:'{"type":"6"}'
	 				//type : 'APERSON'
	             },
		  		{
	 				'leftHeaderText':'按单位选择',
	 				'item_id' :'org_id',
	 				isType:'unit', 
	 				valueKey:'unit',
	 				selectedIds:jQuery("#n_receiver_orgid").val(),
	 				//type:'AORG'
	 				type:'{"type":"7"}'
	 			},
	 			{
	 				leftHeaderText:'常用分组',
	 				item_id :'org_id',
	 				isType:'dept', 
	 				valueKey:'dept',
	 				selectedIds:'',
	 				isGroup:true,
	 				type:"notice"
		 		}];
	 s.returnFunction=function(object){
	   	 jQuery("#deptTd").html("");
		 jQuery("#n_receiver_userid").val("");
		 jQuery("#n_receiver_username").val("");
		 jQuery("#userTd").html("");
		 jQuery("#n_receiver_orgid").val("");
		 jQuery("#n_receiver_orgname").val("");
		 createrDeptAndPosn(object.unit,"deptTd",'n_receiver_orgid','n_receiver_orgname');
		 createrDeptAndPosn(object.ps,"userTd",'n_receiver_userid','n_receiver_username',false,false,false,true);
	 }
	 s.init();
}
/*
	作者:  黄艺平
	时间:  2013-6-19
	函数:  dotempNotice
	说明:  存稿
	参数:   无
	返回值: 无
*/
var dotempNotice = function() {
	if(validateForm()){
		if(jQuery("#n_receiver_userid").val()==""&&jQuery("#n_receiver_orgid").val()==""){
			alert("接收单位和人员不能同时为空");
			return;
		}
	
		ischecked();
		jQuery("#n_state").val("0");
		jQuery("#action").val("dotempNotice");
	
		var okF = function(){
			document.all.form1.target = "hiddenFrame";
			jQuery("#form1").submit();
		}
		 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
		alert('确定要存草稿？',p);
	}
}

/*
作者:  黄艺平
时间:  2013-6-19
函数:  dotempRelease
说明:  发布
参数:   无
返回值: 无
*/
var dotempRelease = function() {
if(validateForm()){
	if(jQuery("#n_receiver_userid").val()==""&&jQuery("#n_receiver_orgid").val()==""){
		alert("接收单位和人员不能同时为空");
		return;
	}
	ischecked();
	jQuery("#n_audit_state_view").val('1');//意见状态
	jQuery("#n_audit_state").val('2');//主表状态
	jQuery("#n_state").val('1');//主表状态
	jQuery("#n_release_userid").val('<%=curUserId %>');
	jQuery("#n_release_username").val('<%=curUserName %>');
	jQuery("#n_release_time").val('<%=curTime %>');
	jQuery("#n_view").val(jQuery("#n_view").val()+"。"+'<%=curUserName%>'+'<%=n_attach_id%>');
	jQuery("#action").val("dotempRelease");
	jQuery("#tablepage").val('2');
	
	var okF = function(){
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定通过吗？',p);
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
if(jQuery('#n_is_sms').attr("checked")=="checked"){
	jQuery('#n_is_sms').val("1");
}else{
	jQuery('#n_is_sms').val("0");
}
if(jQuery('#n_is_mail').attr("checked")=="checked"){
	jQuery('#n_is_mail').val("1");
}else{
	jQuery('#n_is_mail').val("0");
}
if(jQuery('#n_is_rtx').attr("checked")=="checked"){
	jQuery('#n_is_rtx').val("1");
}else{
	jQuery('#n_is_rtx').val("0");
}
if(jQuery('#n_is_msg').attr("checked")=="checked"){
	jQuery('#n_is_msg').val("1");
}else{
	jQuery('#n_is_msg').val("0");
}
}
/*
	作者:  黄艺平
	时间:  2013-6-19
	函数:  validateForm
	说明:  存稿
	参数:   无
	返回值: 无
*/
var validateForm = function(){
	if(jQuery("#form1").validationEngine("validateform")){
	var str = eWebEditor1.getHTML();
	jQuery('#n_content').val(str);
	if(IsSpace(jQuery('#n_content').val())){
		alert("内容不能为空");
		return false;
	}
		return true;
	}
}

/*
作者:  黄艺平
时间:  2013-6-21
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
function back(){
		var okF = function(){
			removeWindows(subid,true);
		}
		 var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'};
		 alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}
/*
作者:  李星
时间:  2013-11-27
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
var dotempAuditing = function(){
	if(validateForm()){
		if(jQuery("#n_receiver_userid").val()==""&&jQuery("#n_receiver_orgid").val()==""){
			alert("接收单位和人员不能同时为空");
			return;
		}
		ischecked();
		jQuery("#n_state").val("5");
		jQuery("#n_audit_state_view").val('2');//意见状态
		jQuery("#n_release_userid").val('<%=curUserId %>');
		jQuery("#n_release_username").val('<%=curUserName %>');
		jQuery("#n_release_time").val('<%=curTime %>');
		jQuery("#n_view").val(jQuery("#n_view").val()+"。"+'<%=curUserName%>'+'<%=n_attach_id%>');
		jQuery("#n_audit_state").val("2");
		jQuery("#action").val("dotempRelease");
		jQuery("#tablepage").val('2');
		var okF = function(){
			document.all.form1.target = "hiddenFrame";
			jQuery("#form1").submit();
		}
		 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
		alert('确定不通过吗？',p);
	}
}


</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="noticedo.jsp?subid=<%=subid %>" method="post">

<input type="hidden" name="n_notice_id" id="n_notice_id"  value="<%=StringUtil.deNull(viewMap.get("n_notice_id")) %>" />
<input type="hidden" name="n_state" id="n_state"  value="<%=StringUtil.deNull(viewMap.get("n_state")) %>"/>
<input type="hidden" name="n_attach_id" id="n_attach_id"  value="<%=n_attach_id %>"/>

<input type="hidden" name="n_release_userid" id="n_release_userid"  />
<input type="hidden" name="n_release_username" id="n_release_username"  />
<input type="hidden" name="n_release_time" id="n_release_time"  />
<input type="hidden" name="n_audit_state" id="n_audit_state"  />
<input type="hidden" name="n_audit_state_view" id="n_audit_state_view"  />

<input type ="hidden" id ="tablepage" name ="tablepage"/>

<input type="hidden" name="action" id="action"   />

<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<input name="tgbt" id="tgbt" value="通过" onclick="dotempRelease();"  type="button" class="but_y_01" />
		<input name="btgbt" id="btgbt" value="不通过" onclick="dotempAuditing();"  type="button" class="but_y_01" />  
		<input name="" value="返回" onclick="back()" type="button" class="but_y_01" />
	</div>
</div>
<!-- 操作-->

<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px;">
	
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>基本信息</span></div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<th width="191" class="content_02_box_div_table_th">
							<span class="color_red">*</span>公告标题：</th>
						<td class="content_02_box_div_table_td" colspan="3"><input
							type="text" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[80]] input_title_text"
							name="n_title" id="n_title"
							value="<%=StringUtil.deNull(viewMap.get("n_title")) %>" /></td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">起草人：</th>
						<td class="content_02_box_div_table_td"><%=n_creator_username %>
							<input type="hidden" name="n_creator_userid" id="n_creator_userid"  value="<%=n_creator_userid %>" />
							<input type="hidden" name="n_creator_username" id="n_creator_username"  value="<%=n_creator_username %>" />
						</td>
						<th class="content_02_box_div_table_th">起草者单位：</th>
						<td class="content_02_box_div_table_td" width="192px"><%=unit_name %>
							<input type="hidden" name="n_unit_id" id="n_unit_id" value="<%=unit_id %>" />
							<input type="hidden" name="n_unit_name" id="n_unit_name" value="<%=unit_name %>" />
							<input type="hidden" name="n_orgid" id="n_orgid" value="<%=n_orgid %>" />
							<input type="hidden" name="n_orgname" id="n_orgname" value="<%=n_orgname %>" />
						</td>
					</tr>
					<tr id="sel">
						<th width="212" valign="top" class="content_02_box_div_table_02_th">发送名义：</th>
						<td  class="content_02_box_div_table_02_td">
							<select
								id="n_unit_or_personal" name="n_unit_or_personal" class="select_100_box" style="width: 125px">
								<option value="0">个人名义发送</option>
								<option value="1">单位名义发送</option>
							</select>
						</td>
						<th width="212" valign="top" class="content_02_box_div_table_02_th"><span class="color_red">*</span>审核人：</th>
						<td  class="content_02_box_div_table_02_td">
							<input  type="text" id="n_audit_name" name="n_audit_name" 
							class="validate[required] input_title_text" 
							 value="<%=n_audit_name %>"/>
							<input type="hidden" id="n_audit_id" name="n_audit_id" value="<%=n_audit_id %>"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>其他信息</span></div>
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr id="fj">
						<th width="212" valign="top">附件：</th>
						<td width="560"><a href="#" id="_filebut">请选择文件</a></td>
					</tr>
					<tr>
						<th valign="top">附件列表：</th>
						<td>
						<ul id="_fileshow"></ul>
						&nbsp;</td>
					</tr>
				</table>
			</div>
		</div>
	
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>接收单位和人员</span></div>
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table_02">
					
					<tr id="unit_person">
						<th width="212" valign="top" class="content_02_box_div_table_02_th"><span
							class="color_red">*</span>接收单位和人员：</th>
						<td width="560" class="content_02_box_div_table_02_td">
							<input type="button" value="选择部门和人员" class="but_six" onclick="adddeptanduser()" />
						</td>
					</tr>
					
					<tr>
						<th class="content_02_box_div_table_02_th">接收单位列表：
							<input type="hidden" id="n_receiver_orgid" name="n_receiver_orgid" value="<%=StringUtil.deNull(viewMap.get("n_receiver_orgid")) %>" /> 
							<input type="hidden" id="n_receiver_orgname" name="n_receiver_orgname" value="<%=StringUtil.deNull(viewMap.get("n_receiver_orgname")) %>" /> 
						</th>
						<td class="content_02_box_div_table_02_td" id="deptTd"></td>
					</tr>
				
					<tr>
						<th class="content_02_box_div_table_02_th">接收人员列表：</th>
						<td class="content_02_box_div_table_02_td">
							<input type="hidden" id="n_receiver_userid" name="n_receiver_userid" value="<%=StringUtil.deNull(viewMap.get("n_receiver_userid")) %>" /> 
							<input type="hidden" id="n_receiver_username" name="n_receiver_username" value="<%=StringUtil.deNull(viewMap.get("n_receiver_username")) %>" />
							<textarea id="userTd" class="textarea_575" rows="5" readonly></textarea>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		
		<%if("1".equals(is_pub_sms) || "1".equals(is_pub_rtx) || "1".equals(is_pub_msg) || "1".equals(is_pub_mail)){ %>
		<div class="content_02_box">
			<!-- 消息提醒begin -->
			<div class="content_02_box_title_bg">
				<span>消息提醒</span>
			</div>
			<input type="hidden" id="m_id" name="m_id" value="" />
			<input type="hidden" id="" name="" value="" />
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
					<tr>
						<th class="content_02_box_div_table_th"  style="width:200px;">提醒方式：</th>
						<td class="content_02_box_div_table_td" colspan="3">
						<%if("1".equals(is_pub_sms)){ %>
							<input name="n_is_sms" id="n_is_sms" type="checkbox"  value="" />&nbsp;短信
							&nbsp;<%} %>
							<%if("1".equals(is_pub_mail)){ %>
							<input name="n_is_mail" id="n_is_mail" type="checkbox"   value="" />&nbsp;邮件&nbsp;
							<%} if("1".equals(is_pub_rtx)){%>
							<input name="n_is_rtx" id="n_is_rtx" type="checkbox"   value="" />&nbsp;即时信息&nbsp;
							<%} if("1".equals(is_pub_msg)){%>
							<input name="n_is_msg" id="n_is_msg" type="checkbox"   value="" />&nbsp站内信息&nbsp;
							<%} %>
						</td>
						
					</tr>
				</table>
			</div>
			<!-- 消息提醒end -->
		</div>
		<%} %>
		
		<div class="content_02_box">
		
			<div class="content_02_box_title_bg"><span>正文</span> 
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<span class="color_red">提示：可以直接粘贴word、excel表格</span>
			<div class="content_02_box_add" id="t2"><span id="selAreaImg" class="tabs_search_text_but"></span></div>
			</div>
		
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<td colspan="4">
						<textarea style="display: none" name="n_content" id="n_content"><%=StringUtil.deNull(viewMap.get("n_content")) %></textarea> 
						<iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=n_content&style=gray" frameborder="0" 
						scrolling="no" width="100%" height="400"></iframe>
						</td>
					</tr>
				</table>
			</div>
			
		</div>
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>审核意见</span></div>
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr >
						<textarea style="height: 100px;width: 765px;" name="n_view" id="n_view"></textarea>
					</tr>
					
				</table>
			</div>
		</div>
	</div>
</div>

</form>

<iframe name="hiddenFrame" width="0" height="0"></iframe>

</body>
</html>