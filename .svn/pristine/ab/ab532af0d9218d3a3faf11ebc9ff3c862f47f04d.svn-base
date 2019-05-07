<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectInfoDaoImpl"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.WorkIPBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.BriefsTypeBean"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectResetDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean"%>
<%@page import ="java.text.SimpleDateFormat"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);

String workip_id = request.getParameter("workip_id");

WorkIPBean workIPBean = new WorkIPBean();
ElectInfoDao electInfoDao = new ElectInfoDaoImpl();

if(!StringUtil.isBlank(workip_id)){
	workIPBean = electInfoDao.findWorkIPInfo(workip_id);
}

%>
<title>添加办公IP</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js"type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js"type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet"href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"type="text/css" />


<!-- 引入其它  -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"charset="utf-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分结束 -->
<script type="text/javascript">

jQuery(document).ready(function() {
	jQuery("#workip_start_ip").focus();
});
	
/*
函数:  Ok
说明:  提交添加与修改简报类型
参数:   无
返回值: 无
*/
function Ok() {
	document.all.form1.target = "hiddenFrame";
	$("#form1").submit();
}
function closed(){
	parent.JqueryDialog.Close();
}
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="addorupdaworkipdo.jsp" method="post">
		<input type="hidden" name="workip_id" id="workip_id" value="<%=StringUtil.deNull(workip_id)%>">
		<input type="hidden" name="dowhat" id="dowhat" value="addorupdate">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_box_text">
			<tr>
				<th>开始IP：</th>
				<td>
				<input type="text" class="validate[required]" id="workip_start_ip" name="workip_start_ip" value="<%=StringUtil.deNull(workIPBean.getWorkip_start_ip()) %>">
				</td>
				<th>结束IP：</th>
				<td>
					<input type="text" class="validate[required]" id="workip_end_ip" name="workip_end_ip" value="<%=StringUtil.deNull(workIPBean.getWorkip_end_ip()) %>">
				</td>
			</tr>
			<tr>
				<th>备注：</th>
				<td colspan="3">
					 <textarea class="validate[maxSize[4000]]" style="width: 99%;height: 130px;" name="workip_remark" id="workip_remark"><%=StringUtil.deNull(workIPBean.getWorkip_remark()) %></textarea>
				</td>
			</tr>
		
		</table>
		
		
		
		<%-- <table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_box_text">			
		<tr>
				<td width="20%">您好，下班时间是</td>
				<td width="30%"><%=StringUtil.deNull(electresetBean.getEnd_time()) %>
				</td>
				<td width="20%">上班IP为</td>
				<td width="30%">
					<%=StringUtil.deNull(ip)%>
				</td>
			</tr>
			</table> --%>
		</div>
			<div class="cue_box_foot">
		<!-- <input type="button" value='关闭' onclick="removeAlertWindows('',true)" class="but_y_01"/> -->
		<input type="button" class="but_y_01" onClick="Ok()" value="提交" id="s1"/>
  	</div>
	
	</form>
		<iframe name="hiddenFrame" width=0 height=0></iframe>
		
	
</body>
</html>