<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.directory.entity.DirectoryBean"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.impl.DirectoryServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String urls = request.getParameter("urls");
	String orgid = request.getParameter("orgid");
	String typeid = request.getParameter("typeid");
	String ispersonal = request.getParameter("ispersonal");
	String listtype = "falg";
	String orgname = DaoUtil.SqlToField("select org_name from td_sm_organization where org_id = '"+orgid+"'");
	DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
	DirectoryBean directoryBean = new DirectoryBean();
	if (!StringUtil.isBlank(typeid)) {
		directoryBean = directoryServiceIfc
		.getTypeBeanById(typeid,listtype);
	}
	
	//显示手机短码
	boolean personwork_viewdirectory_showPhone = CacheCommonManageProxy.getBooleanSystemParam("personwork_viewdirectory4publicaddress_sphone");
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->

<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!--公共部分结束  -->
<script type="text/javascript">
jQuery(document).ready(function() {
	// binds form submission and fields to the validation engine
	//jQuery("#form1").validationEngine();
});
$(function() {


});

function closeds(){
	var url = "";
	if("yes" == "<%=ispersonal%>"){
		url = "personaladdressbook.jsp";
	}else{
		parent.JqueryDialog.Close();
	}
	location.href = url;
}
</script>
</head>
<body>
<form id="form1" action="addorupdatedirectorydo.jsp" method="post"
	class="formular"><input type="hidden" name="directoryid"
	id="directoryid"
	value="<%=StringUtil.deNull(directoryBean.getDirectoryid())%>">
<input type="hidden" name="orgid" id="orgid"
	value="<%=StringUtil.nullOrBlank(directoryBean.getOrgid())?orgid:directoryBean.getOrgid()%>">
<!-- <input type="hidden" name="orgname" id="orgname"
			value="<%=StringUtil.deNull(directoryBean.getOrgname())%>"> --> <input
	type="hidden" name="duties" id="duties"
	value="<%=StringUtil.deNull(directoryBean.getDuties())%>"> <input
	type="hidden" name="paramjosn" id="paramjosn"> <input
	type="hidden" name="action" id="action">




<div  >
<div class="content_02_box" style="display: none;">
<input id="backbtn" name="backbtn" type="button" class="but_h_01"
	onClick="removeAlertWindows('windowId',true)" value="关闭" />
</div>

<div class="content_02_box">
<div class="content_02_box_title_bg"><span>基本资料</span></div>
<div class="content_02_box_div">

<table class="content_02_box_div_table" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<th class="content_02_box_div_table_th" width="20%">姓名：</th>
		<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getDirectoryname())%></td>
		<th class="content_02_box_div_table_th" width="20%">性别：</th>
		<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getDirectorysex())%></td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th">职务：</th>
		<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getPost())%></td>
		<th class="content_02_box_div_table_th">出生年月：</th>
		<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectoryyear())%></td>
	</tr>

</table>
</div>
</div>

<div class="content_02_box">
<div class="content_02_box_title_bg"><span>联系方式</span></div>
<div class="content_02_box_div">
<table class="content_02_box_div_table" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<th class="content_02_box_div_table_th" width="20%">办公手机：</th>
		<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getMobile())%></td>
		<th class="content_02_box_div_table_th" width="20%">常用手机：</th>
		<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getMobile2())%></td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th" width="20%">办公电话：</th>
		<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getWorkphone())%></td>
		<th class="content_02_box_div_table_th" width="20%">住宅地址：</th>
		<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getHomeadress())%></td>

	</tr>
	<tr>
		<th class="content_02_box_div_table_th">住宅电话：</th>
		<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getHomephone())%></td>
		<th class="content_02_box_div_table_th">电子邮箱：</th>
		<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getEmail())%></td>
	</tr>
	<%if(personwork_viewdirectory_showPhone==true){%>
	<tr>
		<th class="content_02_box_div_table_th">手机短码：</th>
		<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getRemark2())%></td>
		<th class="content_02_box_div_table_th"></th>
		<td class="content_02_box_div_table_td"></td>
	</tr>
	<%} %>
</table>
</div>
</div>
</div>

</form>

</body>
</html>