<%--
描述：设备维修和保养记录管理界面
作者：邱炼
版本：1.0
日期：2014-03-8
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevTakcareService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevTakcareServiceImpl"%>
<%@page import="java.util.Date"%>
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
	String tac_id = request.getParameter("tac_id");
	//附件ID
	String attachment_id = new Date().getTime()+"";
	//类型业务
	DevTakcareService service = new DevTakcareServiceImpl();
	if("insert".equals(actionName)){
		//维修和保养申请时间
		bean.put("tac_time",DateUtil.getCurrentDate());
	} else {
		bean = service.getDevTakcareBean(tac_id);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>设备维修和保养界面</title>
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
var actionName = "<%=actionName%>"
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#dev_code").focus();
		if(actionName == "insert"){
			jQuery("#qiyong").hide();
			jQuery("#baofei").hide();
		}
	});
	
	 /*
	函数:  openDevAppInfo
	说明:  选择仪器设备物品
	返回值: 无
	*/
	  function openDevAppInfo(){
		//选择设备  状态为 "完好"+"在修"
		var path ="<%=path%>/ccapp/xtbg/tjy/account/jsp/changeaccountlist.jsp?windowsId=windowIds&gdzc_classify=8";
		openAlertWindows('windowIds',path,'设备信息',900,450,'25%','25%');
	 }
	
  /*
	函数:  setDevInfo
	说明:  选择仪器设备物品
	参数:   sbid:设备ID,sbname:设备名称      sbcode：设备编号         设备状态：sbstat 设备型号:type
			make_users:制造厂商   technical_parameters:设备参数信息 arrive_time:到货时间 
			custos_userid:设备保管人ID  custos_username:设备保管人名称
	返回值: 无
	*/
	function loadInfo(id,num,name,it,manufacturer,t_trsynx){
		
		//设备ID
		jQuery("#t_sb_id").val(id);
		//设备编号
		jQuery("#dev_code").val(num);  
		//设备名称
		jQuery("#dev_name").val(name);   
		//设备类型
		jQuery("#dev_type").val(it);
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
function updateState(is_qiyong){
		var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		if (isFlag){
			jQuery("#hidden_action").val("changeInfo");
			jQuery("#is_qiyong").val(is_qiyong);
			jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
			jQuery("#form1").submit();
		}
}
</script>
<body style="overflow-y:auto;" class="vcenter">
	<form id="form1" action="devtakcareinfodo.jsp" method="post"  >
		<input type="hidden" name="tac_id" id="tac_id" value="<%=StringUtil.deNull(bean.get("tac_id"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="is_qiyong" id="is_qiyong">
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
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
						<td class="content_02_box_div_table_th">规格型号：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="dev_type" id="dev_type" value="<%=StringUtil.deNull(bean.get("dev_type"))%>"  
								class="input_cx_title_188" readonly="readonly" style="height=23px" />		
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" ><font color="red">*</font>维修保养内容：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:90%;" rows="6" cols="5" name="tac_content" class="validate[required,maxSize[1000]]"
								id="tac_content" ><%=StringUtil.deNull(bean.get("tac_content"))%></textarea>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" >维保单位/人：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="tac_maintenance" id="tac_maintenance" value="<%=StringUtil.deNull(bean.get("tac_maintenance"))%>" 
							 class="validate[maxSize[100]] input_cx_title_188" style="height=23px" 	/>
						</td>
					</tr>
					</tr>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th"><font color="red">*</font>日期：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="tac_time" id="tac_time" 
								 class="validate[required,maxSize[100]] date_120 Wdate" style="width:160px;height=23px" 
								value="<%=StringUtil.deNull(bean.get("tac_time"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="返回" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="完成" onclick="Ok()"/>
			<input class="but_y_01" type="button" id="baofei"  value="报废" onclick="updateState(1)"/>
			<input class="but_y_01" type="button" id="qiyong"  value="启用" onclick="updateState(0)"/>
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>