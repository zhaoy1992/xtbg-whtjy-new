<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String submittedinfoId = request.getParameter("submittedinfoId");
InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
InfoReportBaseInfoBean infoReportBaseInfoBean = infoReportdao.findInfoReportBaseInfo(submittedinfoId);

String sql = "select i.infotype_id, i.infotype_name from ta_oa_infre_info_type i where i.infotype_source = '"+InfoSource.INFORMATION_COLLECTION+"'";
String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id",StringUtil.deNull(infoReportBaseInfoBean.getInfotype_id()),"",false,"");//信息类型下拉框
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息浏览上报展示(已上报)</title>
</head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/ui/i18n/jquery.ui.datepicker-zh-CN.js" charset="UTF-8"></script>



<!-- 引入jQuery_dialog -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<script src="../resources/js/persondetailinfo.js" type="text/javascript"></script>

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
$(function() {
	$('#infotype_id').attr("disabled","disabled");
});

	function backTo(){
		var url = "infohasbereportedlist.jsp";
		location.href = url;
	}
</script>
<body>
<form action="" id="form1" name="form1" method="post">
	<table class="cQueryTableArea">
		<tr>
			<td colspan="4" align="left">
				<input class="cButton_4text" type="button" name="operation" value="返回" onclick="backTo()" id="backto"/>
			</td>
		</tr>
		<tr>
			<td class="tableLable"><FONT style="COLOR: red">*</FONT>标题</td>
			<td class="tableValue" colspan="3"><input class="cText_out" disabled="disabled" id="submittedinfo_title" name="submittedinfo_title" value="<%=infoReportBaseInfoBean.getSubmittedinfo_title() %>" /></td>
		</tr>
		<tr>
			<td class="tableLable">录入部门</td>
			<td class="tableValue">
			<input class="cText_out" disabled="disabled" type="text" value="<%=infoReportBaseInfoBean.getOrg_name() %>" id="orgname" name="orgname"></input>
			</td>
			<td class="tableLable">录入者</td>
			<td class="tableValue">
			<input class="cText_out" disabled="disabled" type="text" value="<%=infoReportBaseInfoBean.getInputuser_name() %>" id="inputuser_name" name="inputuser_name"></input>
			</td>
		</tr>
		<tr>
			<td class="tableLable"><FONT style="COLOR: red">*</FONT>信息类型</td>
			<td class="tableValue"><%=infotypeHtml %></td>
			<td class="tableLable">关键字</td>
			<td class="tableValue"><input class="cText_out" disabled="disabled" id="keyword" name="keyword" value="<%=infoReportBaseInfoBean.getKeyword() %>"/></td>
		</tr>
		<tr>
			<td class="tableLable"><FONT style="COLOR: red">*</FONT>内容</td>
			<td colspan="3" width="50px"><%=infoReportBaseInfoBean.getSubmit_content()%></td>
		</tr>
		<tr>
			<td colspan="4"><div id="audit_idea" style="font-size: 20px;">
				<ul>
				<%for(InfoReportAuditIdeaBean auditBean : infoReportBaseInfoBean.getAndit_infos()){ %>
					<li><%=auditBean.getAndit_person() %>的<%=auditBean.getAndit_state() %>意见:  <%=auditBean.getAndit_opinion() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=auditBean.getAndit_time() %></li>
				<%} %>	
				</ul>
			</div>
			</td>
		</tr>
	</table>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>