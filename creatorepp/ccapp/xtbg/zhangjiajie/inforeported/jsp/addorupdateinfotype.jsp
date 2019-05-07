
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoTypeBean"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.InfoTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.InfoTypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page contentType="text/html; charset=GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String infotype_id = request.getParameter("infotype_id");
	InfoTypeServiceIfc infoTypeServiceIfc = new InfoTypeServiceImpl();
	InfoTypeBean infoTypeBean = new InfoTypeBean();
	if (!StringUtil.isBlank(infotype_id)) {
			infoTypeBean = infoTypeServiceIfc.getInfoTypeBeanById(infotype_id);
	}
%>
<title>信息类型添加和修改页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js"type="text/javascript" charset="UTF-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js"type="text/javascript" charset="UTF-8"></script>

<!-- 引入公共JS -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分结束 -->
<script type="text/javascript">
/*
函数:  Ok
说明:  提交添加与修改用户
参数:   无
返回值: 无
*/
function save() {

	$('#form1').submit();
}
/*
函数:  validateAddRoom
说明:  校验数据是否为空
参数:   无
返回值: 无
*/
function validateAddRoom(){
	if(isEleNull('infotype_name')){
		alert("提示:类型名称不能为空!");
		return false;
	}
	return true;
}
/*
方法说明：某个元素的值是否为空
参数：
返回：true or false
*/
function isEleNull(id){
	var eleValue = document.getElementById(id).value;
	if(eleValue.replace(/(^\s*)|(\s*$)/,"") == ""){
		return true;
	}
	return false;
}

function submit_from()
{
	var paramjosn = "";
	if (IsSpace($("#infotype_id").val())) { //修改
		$("#action").val("add");
	} else {
		$("#action").val("update");
	}
	paramjosn = "{'infotype_id':'" + $("#infotype_id").val() + "','infotype_name':'" + $("#infotype_name").val() + "','infotype_source':'" + $("#infotype_source").val() + "','infotype_desc':'" + $("#infotype_desc").val()+"'}";
	$("#paramjosn").val(paramjosn);

}
var init = function() {
	if (!IsSpace($("#infotype_id").val())) { //修改
		$('#infotype_source').attr('disabled',true);
	} 
}

$(function(){
	jQuery("#form1").validationEngine();
})


</script>
<body onLoad="init()" style="overflow-y:hidden;">
	<form id="form1" action="addorupdateinfotypedo.jsp" method="post" onsubmit="submit_from()">
		<input type="hidden" name="infotype_id" id="infotype_id"
			value="<%=StringUtil.deNull(infoTypeBean.getInfotype_id()) %>">
		<input type="hidden" name="paramjosn" id="paramjosn"> <input
			type="hidden" name="action" id="action">
		
		
		<div id="users-contain">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_box_text">
			<!-- <tr>
				<td class="poptableLable" width="20%">来源</td>
				<td class="tableValue" width="80%">
					<select id="infotype_source" class="cSelected">
						<option value="01" <%if("01".equals(infoTypeBean.getInfotype_source())){%>selected<%} %>>信息采编</option>
						<option value="02" <%if("02".equals(infoTypeBean.getInfotype_source())){%>selected<%} %>>每日舆情</option>
					</select>				</td>
			</tr> -->
			
			<tr>
				<th><span class="color_red">*</span>类型名称</th>
				<td>
				
				<input type="text" name="infotype_name"
					id="infotype_name"  class="validate[required,maxSize[50]] input_188"
					value="<%=StringUtil.deNull(infoTypeBean.getInfotype_name()) %>">				
				</td>
			</tr>
			
			<tr>
			  <th>描述</th>
			  <td>
			  <textarea class="validate[maxSize[250]] cur_textarea_575" style="width: 188px;" name="infotype_desc" id="infotype_desc"><%=StringUtil.deNull(infoTypeBean.getInfotype_desc()) %></textarea>
			  </td>
			</tr>
		</table>
		</div>
		
		
		
	<div class="cue_box_foot">
		<input type="button" value='关闭' onclick="removeAlertWindows('',true)" class="but_y_01"/>
		<input type="button" class="but_y_01" onClick="save()" value="保存"/>
  	</div>
	
	</form>
</body>

</html>