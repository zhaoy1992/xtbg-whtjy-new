
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAppraisalServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevAppraisalService"%>
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
	String appr_id = request.getParameter("appr_id");
	//类型业务
	DevAppraisalService service = new DevAppraisalServiceImpl();
	if("insert".equals(actionName)){
	} else {
		bean = service.getDevAppraisalBean(appr_id);
	}
	
	String appr_org_id = DictDropDownList.buildSelect4DictType("gdzc_jddw","appr_org_id",StringUtil.deNull(bean.get("appr_org_id")),"",true,"","","class='validate[required] select_240' style='width: 190px;height:24px;'","" );
	
	String appr_method_id = DictDropDownList.buildSelect4DictType("gdzc_jdfs","appr_method_id",StringUtil.deNull(bean.get("appr_method_id")),"",true,"","","class='validate[required] select_240' style='width: 190px;height:24px;'","" );
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>检定记录管理界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入上传控件 -->
<link rel="stylesheet" href="../../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
<script type="text/javascript" src="../../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#dev_code").focus(); 
		jQuery("#appr_result").val("<%=bean.get("appr_result")%>");
	});
	
	 /*
	函数:  openDevAppInfo
	说明:  选择仪器设备物品
	返回值: 无
	*/
	  function openDevAppInfo(){
		//选择设备    状态 为 "完好"+"在库"
		var path ="<%=path%>/ccapp/xtbg/tjy/account/jsp/changeaccountlist.jsp?windowsId=windowIds&gdzc_classify=2";
		openAlertWindows('windowIds',path,'设备信息',900,450,'25%','25%');
	 }
	
  /*
	函数:  setDevInfo
	说明:  选择仪器设备物品
	参数:   sbid:设备ID,sbname:设备名称      sbcode：设备编号         设备状态：sbstat 设备型号:type
			make_users:制造厂商   technical_parameters:设备参数信息
	返回值: 无
	*/
	function loadInfo(id,num,name,it,manufacturer,t_trsynx){
		
		//设备ID
		jQuery("#t_sb_id").val(id);
		//设备编号
		jQuery("#dev_code").val(num);  
		//设备名称
		jQuery("#dev_name").val(name);   
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
	  s.treeName="选取机构";
	  s.headerName="选取机构";
	  s.item_id = 'org_id';
	  s.isType='dept';
	  s.type="AORG";
	  s.selectedIds=jQuery('#appr_org_id').val();
	  s.returnFunction=function(orgObj){
		  jQuery('#appr_org_id').val(orgObj.id);
		  jQuery('#appr_org_name').val(orgObj.name);
	  }
	 s.init();
}	

</script>
<body style="overflow-y:auto;" class="vcenter">
	<form id="form1" action="devappraisalinfodo.jsp" method="post"  >
		<input type="hidden" name="appr_id" id="appr_id" value="<%=StringUtil.deNull(bean.get("appr_id"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
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
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>检定证书编号：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="appr_no" id="appr_no" value="<%=StringUtil.deNull(bean.get("appr_no"))%>"  
								class="validate[required,maxSize[100]] input_cx_title_188" style="height=23px" />		
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>检定单位：</td>
						<td class="content_02_box_div_table_td">
							<%=appr_org_id %>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>检定方式：</td>
						<td class="content_02_box_div_table_td">
							<%=appr_method_id %>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>本次检定日期：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="appr_time" id="appr_time" 
							 class="validate[required] date_120 Wdate" style="width:160px;height=23px" 
								value="<%=StringUtil.deNull(bean.get("appr_time"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>下次检定日期：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="next_appr_time" id="next_appr_time" 
							 class="validate[required] date_120 Wdate" style="width:160px;height=23px" 
								value="<%=StringUtil.deNull(bean.get("next_appr_time"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">检定结果：</td>
						<td class="content_02_box_div_table_td">
							<select id="appr_result" name="appr_result" class='validate[required] select_240' style='width: 190px;height:24px;'>
								<option value="合格">合格</option>
								<option value="不合格">不合格</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">参数范围：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:90%;" rows="6" cols="7" name="appr_parrange" class="validate[maxSize[500]]"
							id="remark" ><%=StringUtil.deNull(bean.get("appr_parrange"))%></textarea>
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