<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.directory.entity.DirectoryBean"%>
<%@page
	import="com.chinacreator.xtbg.pub.directory.service.impl.DirectoryServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc"%>
<%@ page contentType="text/html; charset=utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%><html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String urls = request.getParameter("urls");
	String orgid = request.getParameter("orgid");
	String typeid = request.getParameter("typeid");
	String ispersonal = request.getParameter("ispersonal");
	
	String orgname = DaoUtil.SqlToField("select org_name from td_sm_organization where org_id = '"+orgid+"'");
	DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
	DirectoryBean directoryBean = new DirectoryBean();
	if (!StringUtil.isBlank(typeid)) {
		directoryBean = directoryServiceIfc
		.getTypeBeanById(typeid);
	}
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入jQuery_dialog -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet"
	href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"
	type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js"
	type="text/javascript" charset="GBK">
	
</script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js"
	type="text/javascript" charset="GBK"></script>
<script type="text/javascript">
jQuery(document).ready(function() {
	// binds form submission and fields to the validation engine
	jQuery("#form1").validationEngine();
});
$(function() {
	$("#directoryyear").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});
	$("#worktime").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});
	$("#joinparttime").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});

});

function closed(){
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
	<form id="form1" action="addorupdatedirectorydo.jsp" method="post" class="formular">
		<input type="hidden" name="directoryid" id="directoryid"
			value="<%=StringUtil.deNull(directoryBean.getDirectoryid())%>">
		<input type="hidden" name="orgid" id="orgid"
			value="<%=StringUtil.nullOrBlank(directoryBean.getOrgid())?orgid:directoryBean.getOrgid()%>">
		<!-- <input type="hidden" name="orgname" id="orgname"
			value="<%=StringUtil.deNull(directoryBean.getOrgname())%>"> -->
		<input type="hidden" name="duties" id="duties"
			value="<%=StringUtil.deNull(directoryBean.getDuties())%>">
		<input type="hidden" name="paramjosn" id="paramjosn"> <input
			type="hidden" name="action" id="action">
		<div>
	<table class="ctable">
		<tr>
			<td>
				<input class="cButton_Gray" type="reset" id="resert" value="关闭" onclick="closed()"/>
			</td>
		</tr>
	</table>
	
	<table class="ColumnTableArea">
      <tr>
        <td class="Columnbg">基本资料</td>
         </tr>
    </table>
	<table class="popTableArea" align="center" >
			<tr>
				<td class="poptableLable" width="15%">姓名</td>
				<td class="tableValue font12_grey" width="25%"><%=StringUtil.deNull(directoryBean.getDirectoryname())%></td>
				<td class="poptableLable" width="15%">性别</td>
				<td class="tableValue font12_grey" width="25%"><%=StringUtil.deNull(directoryBean.getDirectorysex())%></td>
				<td width="20%"></td>
			</tr>
			<tr>
				<td class="poptableLable" >职务</td>
				<td class="tableValue font12_grey" ><%=StringUtil.deNull(directoryBean.getPost())%></td>
				<td class="poptableLable" >出生年月</td>
				<td class="tableValue font12_shuzi" ><%=StringUtil.deNull(directoryBean.getDirectoryyear())%></td>
			</tr>

	</table>
	<table class="ColumnTableArea">
	      <tr>
	        <td class="Columnbg">联系方式</td>
	         </tr>
	    </table>
	<table class="popTableArea" align="center" >
			<tr>
				<td class="poptableLable" width="15%">手机号码</td>
				<td class="tableValue font12_shuzi" width="25%"><%=StringUtil.deNull(directoryBean.getMobile())%></td>
				<td class="poptableLable" width="15%">办公电话</td>
				<td class="tableValue font12_shuzi" width="25%"><%=StringUtil.deNull(directoryBean.getWorkphone())%></td>
				<td width="20%"></td>
			</tr>
			<tr>
				<td class="poptableLable" >住宅电话</td>
				<td class="tableValue font12_shuzi" ><%=StringUtil.deNull(directoryBean.getHomephone())%></td>
				<td class="poptableLable" >电子邮箱</td>
				<td class="tableValue font12_grey" ><%=StringUtil.deNull(directoryBean.getEmail())%></td>
			</tr>
			
		</table>
		</div>
	</form>
</body>
</html>