<%--
������У׼��¼�������
���ߣ�����
�汾��1.0
���ڣ�2014-04-8
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevCalibrateRecodeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevCalibrateRecodeService"%>
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
	//����ID
	String calib_id = request.getParameter("calib_id");
	//����ҵ��
	DevCalibrateRecodeService service = new DevCalibrateRecodeServiceImpl();
	if("insert".equals(actionName)){
	} else {
		bean = service.getDevCalibrateRecode(calib_id);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>У׼��¼�������</title>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- ����jQuery UI -->
<!-- �������� -->
<script src="../../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- ����jQuery_dialog -->
<script src="../../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- �����ϴ��ؼ� -->
<link rel="stylesheet" href="../../../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
<script type="text/javascript" src="../../../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- ���빫��JS -->
<!-- ����formvValidatetion -->
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
		jQuery("#calib_type option[value='<%=StringUtil.deNull(bean.get("calib_type"))%>']").attr("selected","selected");
	});
	
	 /*
	����:  openDevAppInfo
	˵��:  ѡ�������豸��Ʒ
	����ֵ: ��
	*/
	  function openDevAppInfo(){
		//ѡ���豸    ״̬ Ϊ "���"+"�ڿ�"
		var path ="<%=path%>/ccapp/xtbg/tjy/device/jsp/devInfoList.jsp?windowsId=windowIds1&dev_stockflag=1&dev_state=1";
		openAlertWindows('windowIds1',path,'�豸��Ϣ',900,450,'25%','25%');
	 }
	
  /*
	����:  setDevInfo
	˵��:  ѡ�������豸��Ʒ
	����:   sbid:�豸ID,sbname:�豸����      sbcode���豸���         �豸״̬��sbstat �豸�ͺ�:type
			make_users:���쳧��   technical_parameters:�豸������Ϣ
	����ֵ: ��
	*/
	function setDevInfo(sbid,sbcode,sbname,sbstat,type,make_users,technical_parameters){
		
		//�豸ID
		jQuery("#t_sb_id").val(sbid);
		//�豸���
		jQuery("#dev_code").val(sbcode);  
		//�豸����
		jQuery("#dev_name").val(sbname);   
	}
  
	/*
	����:  Ok
	˵��:  �ύ������޸����ĵ�λ
	����:   ��
	����ֵ: ��
	*/
	function Ok() {
		var isFlag = jQuery('#form1').validationEngine('validate'); //�Ƿ�ȫ����֤ͨ��
		if (isFlag){
			jQuery("#hidden_action").val("addInfo");
			jQuery("#form1").attr("target","devcailinfodoJSPhiddenFrame");
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
 * ѡȡ��Ա
 */
var chooseReportUnits = function(){
	var s = new jQuery.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="ѡȡ����";
	  s.headerName="ѡȡ����";
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
	<form id="form1" action="devcalibraterecodeinfodo.jsp" method="post"  >
		<input type="hidden" name="calib_id" id="calib_id" value="<%=StringUtil.deNull(bean.get("calib_id"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>�豸��ţ�</th>
						<td class="content_02_box_div_table_td">
							<!--�豸ID-->
							<input type="hidden" name="t_sb_id" id="t_sb_id" value="<%=StringUtil.deNull(bean.get("t_sb_id"))%>" >
							<input type="text" name="dev_code" id="dev_code" value="<%=StringUtil.deNull(bean.get("dev_code"))%>" 
							 class="validate[required,maxSize[100]] input_cx_title_188" style="height=23px" readonly="readonly" onclick="openDevAppInfo();" />
							<input type="button" name="btn" id="btn" style="margin-left: 7px;" value="ѡ���豸" class="but_y_01" onclick="openDevAppInfo();"/>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">�豸���ƣ�</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="dev_name" id="dev_name" value="<%=StringUtil.deNull(bean.get("dev_name"))%>" 
							 class="input_cx_title_188" style="height=23px" readonly="readonly"	/>
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>У׼֤���ţ�</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="calib_no" id="calib_no" value="<%=StringUtil.deNull(bean.get("calib_no"))%>"  
								class="validate[required,maxSize[100]] input_cx_title_188" style="height=23px" />		
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>У׼��λ��</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="calib_org_name" id="calib_org_name" value="<%=StringUtil.deNull(bean.get("calib_org_name"))%>"
								 class="validate[required,maxSize[100]] input_160" style="width:190px;height=23px" >
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>У׼���ڣ�</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="calib_time" id="calib_time" 
							 class="validate[required] date_120 Wdate" style="width:160px;height=23px" 
								value="<%=StringUtil.deNull(bean.get("calib_time"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>��Ч�ڣ�</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="calib_valitime" id="calib_valitime" 
							 class="validate[required] date_120 Wdate" style="width:160px;height=23px" 
								value="<%=StringUtil.deNull(bean.get("calib_valitime"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">������Χ��</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:90%;" rows="6" cols="7" name="calib_parrange" class="validate[maxSize[500]]"
							id="calib_parrange" ><%=StringUtil.deNull(bean.get("calib_parrange"))%></textarea>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">У׼���ͣ�</td>
						<td class="content_02_box_div_table_td">
							<select id="calib_type" name="calib_type" style="width:160px;height=23px">
								<option value="��У׼">��У׼</option>
								<option value="��У׼">��У׼</option>
							</select>
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="����" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="���" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="devcailinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>