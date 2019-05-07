<%--
描述：检查记录管理界面
作者：邱炼
版本：1.0
日期：2014-03-7
--%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevCheckInfoService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevCheckInfoServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page contentType="text/html; charset=GBK"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//主键ID
	String id = request.getParameter("id");
	//附件ID
	String attachment_id = new Date().getTime()+"";
	//类型业务
	DevCheckInfoService service = new DevCheckInfoServiceImpl();
	if("insert".equals(actionName)){
	} else {
		bean = service.getDevCheckInfoBean(id);
		//附件ID
		attachment_id = bean.get("attachid");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>检查记录管理界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入上传控件 -->
<link rel="stylesheet" href="../../../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
<script type="text/javascript" src="../../../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script src="../../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script src="../../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#dev_code").focus();
		
		 MyFancyupload.createUpload('file_list', '#file_attach', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=attachment_id%>', true, "<%=attachment_id%>");
	});
	
	 /*
	函数:  openDevAppInfo
	说明:  选择仪器设备物品
	返回值: 无
	*/
	  function openDevAppInfo(){
		//选择设备    状态 为 "完好"+"在库"
		var path ="<%=path%>/ccapp/xtbg/tjy/device/jsp/devInfoList.jsp?windowsId=windowIds1&dev_stockflag=1&dev_state=1";
		openAlertWindows('windowIds1',path,'设备信息',900,450,'25%','25%');
	 }
	
  /*
	函数:  setDevInfo
	说明:  选择仪器设备物品
	参数:   sbid:设备ID,sbname:设备名称      sbcode：设备编号         设备状态：sbstat 设备型号:type
			make_users:制造厂商   technical_parameters:设备参数信息
	返回值: 无
	*/
	function setDevInfo(sbid,sbcode,sbname,sbstat,type,make_users,technical_parameters){
		
		//设备ID
		jQuery("#t_sb_id").val(sbid);
		//设备编号
		jQuery("#dev_code").val(sbcode);  
		//设备名称
		jQuery("#dev_name").val(sbname);   
		//设备类型
		jQuery("#dev_type").val(type);
	}
  
	/*
	函数:  Ok
	说明:  提交添加与修改来文单位
	参数:   无
	返回值: 无
	*/
	function Ok() {
		var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		if (isFlag){
			jQuery("#hidden_action").val("addInfo");
			jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
			jQuery("#form1").submit();
		}
	}
afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					getParentWindow("windowId").userSearch();
					removeAlertWindows("windowId",true);
			} else {
				alert(result);
				getParentWindow("windowId").userSearch();
				removeAlertWindows("windowId",true);
			}
			
		}
	}catch(e){alert(e.description);}
};
function closed(){
	removeWindows('',true);
}
	
/**
 * 选取人员
 */
var chooseReportUnits = function(){
	var s = new jQuery.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.type="APERSON";
	  s.selectedIds=jQuery('#user_id').val();
	  s.returnFunction=function(orgObj){
		  jQuery('#user_id').val(orgObj.id);
		  jQuery('#user_name').val(orgObj.name);
	  }
  	 s.init();
	  
}	
</script>
<body style="overflow-y:auto;" class="vcenter">
	<form id="form1" action="devcheckinfodo.jsp" method="post"  >
		<input type="hidden" name="id" id="id" value="<%=StringUtil.deNull(bean.get("id"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<input type="hidden" name="attachid" id="attachid" value="<%=StringUtil.deNull(attachment_id)%>">
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>设备编号：</th>
						<td class="content_02_box_div_table_td">
							<!--设备ID-->
							<input type="hidden" name="t_sb_id" id="t_sb_id" value="<%=StringUtil.deNull(bean.get("t_sb_id"))%>" >
							<input type="text" name="dev_code" id="dev_code" value="<%=StringUtil.deNull(bean.get("dev_code"))%>" 
							 class="validate[required,maxSize[100]] input_cx_title_188" style="height=23px" readonly="readonly" onclick="openDevAppInfo();" />
							<input type="button" name="btn" id="btn" style="margin-left: 7px;" value="选择设备" class="but_y_01" onclick="openDevAppInfo();"/>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">设备名称：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="dev_name" id="dev_name" value="<%=StringUtil.deNull(bean.get("dev_name"))%>" 
							 class="input_cx_title_188" style="height=23px" readonly="readonly"	/>
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">规格型号：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="dev_type" id="dev_type" value="<%=StringUtil.deNull(bean.get("dev_type"))%>"  
								class="input_cx_title_188" readonly="readonly" style="height=23px" />		
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>检查日期：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="chinfo_date" id="chinfo_date" 
							 class="validate[required,maxSize[100]] date_120 Wdate" style="width:188px;height=23px" 
								value="<%=StringUtil.deNull(bean.get("chinfo_date"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>责任人：</td>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="user_id" id="user_id" value="<%=StringUtil.deNull(bean.get("user_id"))%>">
							<input type="text" name="user_name" id="user_name" value="<%=StringUtil.deNull(bean.get("user_name"))%>"
						 class="validate[required,maxSize[100]] input_160" style="width:190px;height=23px"  readonly="readonly" onclick="chooseReportUnits()">
							<input name="" type="button" value="" style="margin-left: 5px;" class="but_x" onclick="chooseReportUnits()"/></td>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">核查文档附件：</td>
						<td class="content_02_box_div_table_td">
							<a href="#" id="file_attach">请选择附件</a>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th" class="poptableLable" valign="top">核查文档附件列表：</th>
						<td class="content_02_box_div_table_td" style="height: 80px;">
							<ul id="file_list"></ul>&nbsp;
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">备注：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:90%;" rows="6" cols="7" name="remark" class="validate[required,maxSize[300]]"
							id="remark" ><%=StringUtil.deNull(bean.get("remark"))%></textarea>
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="返回" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="完成" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>