<%--
描述：土地房屋详细添加界面
作者：jiao.chen
版本：1.0
日期：2015-11-23
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.LandHouseInfoItemServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.LandHouseItemService"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OrgCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String user_name = accesscontroler.getUserName();
	String user_id = accesscontroler.getUserID();
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//主键ID
	String lh_id = request.getParameter("lh_id");
	//类型业务
	LandHouseItemService service = new LandHouseInfoItemServiceImpl();
	if("insert".equals(actionName)){
		//ID
		bean.put("lh_id","");
	} else {
		bean = service.getLandHouseBean(lh_id);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>土地房屋详细添加界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#code").focus();
	});
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
		jQuery("#form1").attr("target","officedetaildoJSPhiddenFrame");
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
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="<%=path %>/ccapp/xtbg/tjy/device/jsp/landhouseinfodo.jsp" method="post"  >
		<input type="hidden" name="lh_id" id="lh_id" value="<%=StringUtil.deNull(bean.get("lh_id"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th">基本信息</th>
						<td class="content_02_box_div_table_td" colspan="1">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>编号：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="lh_number" id="lh_number"  class="validate[required,maxSize[100]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("lh_number"))%>">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>名称：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="lh_name" id="lh_name"  class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("lh_name"))%>">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>面积：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="lh_area" id="lh_area"  class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("lh_area"))%>">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>地点：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="lh_location" id="lh_location"  class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("lh_location"))%>">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>证号：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="lh_identify_code" id="lh_identify_code"  class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("lh_identify_code"))%>">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>日期：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="lh_date" id="lh_date"  class="validate[required,maxSize[100]] date_120 Wdate" style="height=23px" 
							value="<%=StringUtil.deNull(bean.get("lh_date"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">金额：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="lh_money" id="lh_money"  class="validate[maxSize[20],custom[positivenumber]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("lh_money"))%>">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">备注：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:85%;" rows="3" cols="7" name="lh_remarks" class="validate[maxSize[250]]"
							id="r_content" ><%=StringUtil.deNull(bean.get("lh_remarks"))%></textarea>
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="返回" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="完成" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="officedetaildoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>