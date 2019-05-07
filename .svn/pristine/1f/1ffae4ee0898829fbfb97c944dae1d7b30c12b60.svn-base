<%--
描述：通讯录人员信息展示
姓名：戴连春
日期：2013-06-13
 --%>
<%@page import="com.chinacreator.xtbg.core.directory.constant.DirectoryConstant"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.DirectoryBean"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.impl.DirectoryServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String urls = request.getParameter("urls");
	String orgid = request.getParameter("orgid");
	String typeid = request.getParameter("typeid");
	String ispersonal = request.getParameter("ispersonal");
	String listtype = "falg";
	
	DirectoryServiceIfc service = new DirectoryServiceImpl();
	DirectoryBean directoryBean = new DirectoryBean();
	if (!StringUtil.isBlank(typeid)) {
		directoryBean = service.getTypeBeanById(typeid,listtype);
		//特检院OA 个性化显示【职务】 start 
		directoryBean.setPost(DirectoryConstant.parsePost(directoryBean.getPost(), true));
		//特检院OA 个性化显示【职务】 end
	}
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">

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
<div>
	<div class="content_02_box">
		<div class="content_02_box_title_bg">
		  <span>基本资料</span>
		</div>
	<div class="content_02_box_div">
	
	<table class="content_02_box_div_table" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<th class="content_02_box_div_table_th" width="20%">姓名：</th>
			<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getDirectoryname())%>&nbsp; </td>
			<th class="content_02_box_div_table_th" width="20%">性别：</th>
			<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getDirectorysex())%>&nbsp; </td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th">职务：</th>
			<td class="content_02_box_div_table_td" ><%=StringUtil.deNull(directoryBean.getPost())%>&nbsp; </td>
			<!--特检院OA 2014-05-22 start  将通讯录的【单位通讯录】的详细信息对话框的【基础信息】表格的【出生年月】字段隐藏不予展示。 -->
			<%-- <th class="content_02_box_div_table_th">出生年月：</th>
			<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectoryyear())%>&nbsp; </td> --%>
			<th class="content_02_box_div_table_th">部门：</th>
			<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDepartment())%>&nbsp; </td> 
			<!--特检院OA 2014-05-22 end  将通讯录的【单位通讯录】的详细信息对话框的【基础信息】表格的【出生年月】字段隐藏不予展示。 -->
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
			<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getMobile())%>&nbsp; </td>
			<th class="content_02_box_div_table_th" width="20%">办公手机2：</th>
			<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getMobile2())%>&nbsp; </td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th" width="20%">办公电话：</th>
			<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getWorkphone())%>&nbsp; </td>
			<th class="content_02_box_div_table_th" width="20%">住宅地址：</th>
			<td class="content_02_box_div_table_td" width="30%"><%=StringUtil.deNull(directoryBean.getHomeadress())%>&nbsp; </td>
	
		</tr>
		<tr>
			<th class="content_02_box_div_table_th">住宅电话：</th>
			<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getHomephone())%>&nbsp;</td>
			<th class="content_02_box_div_table_th">电子邮箱：</th>
			<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getEmail())%>&nbsp;</td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th">短号：</th>
			<td class="content_02_box_div_table_td" colspan="3"><%=StringUtil.deNull(directoryBean.getRemark4())%>&nbsp;</td>
			
		</tr>
		<tr>
			<th class="content_02_box_div_table_th">备注：</th>
			<td class="content_02_box_div_table_td" colspan="3">
			<%=StringUtil.deNull(directoryBean.getRemark5())%>&nbsp;
			</td>
		</tr>
	</table>
	</div>
	</div>
</div>
</body>
</html>