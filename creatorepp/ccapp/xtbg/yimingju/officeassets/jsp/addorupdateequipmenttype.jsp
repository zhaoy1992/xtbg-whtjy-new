<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeEquipmentTypeBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.impl.OfficeEquipmentTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.OfficeEquipmentTypeServiceIfc"%>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String oetype_id = request.getParameter("oetype_id");
	OfficeEquipmentTypeServiceIfc receivesetServiceIfc = new OfficeEquipmentTypeServiceImpl();
	OfficeEquipmentTypeBean oetBean = new OfficeEquipmentTypeBean();
	if (!StringUtil.isBlank(oetype_id)) {
		oetBean = receivesetServiceIfc.getOeBeanById(oetype_id);
	}
	
%>
<title>缓急程度维护</title>
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
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
	});
/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	var paramjosn = "";
	if (IsSpace($("#oetype_id").val())) { //修改
		$("#action").val("add");
	} else {
		$("#action").val("update");
	}
	paramjosn = "{'oetype_id':'" + $("#oetype_id").val() + "','oetype_name':'" + $("#oetype_name").val() + "','oetype_remark':'" + $("#oetype_remark").val() + "','oetype_no':'"+$("#oetype_no").val()+"'}";
	$("#paramjosn").val(descape(escape(paramjosn)));
	//if(myValidateNums()){
		$("#form1").submit();	
	//}
}
function closed(){
	parent.JqueryDialog.Close();
}

/*
*方法说明:校验排序号
*参数：无
*返回值：true 或者 false  true：校验通过,false: 校验失败
*/
function myValidateNums(){
	var pattern = "^[0-9]*$"; //只能是数字
	var value = $("#oetype_no").val(); //排序号值
	if(value.search(pattern)!=0 ){
		 alert("排序号只能是数字");
		return false;
		}   
	if (document.getElementById('oetype_no').value != ""
			&& document.getElementById('oetype_no').value <= 0) {
		alert("排序号必须大于0！");
		return false;
	}
	return true;
}
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="addorupdateequipmenttypedo.jsp" method="post">
		<input type="hidden" name="oetype_id" id="oetype_id"
			value="<%=StringUtil.deNull(oetBean.getOetype_id())%>">
		<input type="hidden" name="paramjosn" id="paramjosn"> <input
			type="hidden" name="action" id="action">
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>类别名称：</th>
						<td class="content_02_box_div_table_td"><input type="text" name="oetype_name" id="oetype_name" class="validate[required,maxSize[20]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(oetBean.getOetype_name())%>">
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>排序号：</td>
						<td class="content_02_box_div_table_td"><input type="text" name="oetype_no" id="oetype_no" 
						 class="validate[required,maxSize[10],custom[positiveinteger]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(oetBean.getOetype_no()+"")%>">
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">备注：</td>
						<td class="content_02_box_div_table_td"><input style="width:90%;height=23px" type="text" name="oetype_remark" class="validate[maxSize[100]] input_188"
							id="oetype_remark"
							value="<%=StringUtil.deNull(oetBean.getOetype_remark())%>">
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="保存" onclick="Ok()"/>
		</div>
		
	</form>
</body>
</html>