<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileLendingServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

String id = request.getParameter("id");
String subid = request.getParameter("subid");
String windowId = request.getParameter("windowId");
String f_lending_id = StringUtil.getUUID();
Map<String, String> viewMap = new HashMap<String, String>();
FileLendingServiceIfc fileFondsnoServiceIfc=new FileLendingServiceImpl();
if(!StringUtil.isBlank(id)){
	viewMap=fileFondsnoServiceIfc.getFileLendingDetailBean(id);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
var windowId = '<%=windowId%>';
function close(){
	removeAlertWindows(windowId,true);
}
</script>
<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script src="../../resources/js/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
</head>
<body>
<!-- 操作-->
				<div class="content_02_box_title_bg" style="width: 900px;">
					<span>档案借阅申请</span>
				</div>
				<div class="content_02_box_div" style="width: 900px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
						<tr><%--row1--%>
							<th class="content_02_box_div_table_th">借阅人：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" name="f_lending_username" id="f_lending_username" class="input_cx_title_283" readonly="readonly" value="<%=StringUtil.deNull(viewMap.get("f_lending_username"))%>">
								<input type="hidden" name="f_lending_userid" id="f_lending_userid">
							</td>
							<th class="content_02_box_div_table_th">所属部门：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" name="f_dept_name" id="f_dept_name" class="input_cx_title_283" readonly="readonly" value="<%=StringUtil.deNull(viewMap.get("f_dept_name"))%>">
								<input type="hidden" name="f_dept_id" id="f_dept_id">
								<input type="hidden" name=f_org_name id="f_org_name">
								<input type="hidden" name=f_org_id id="f_org_id">
							</td>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th">联系电话：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" name="f_tel" id="f_tel" readonly="readonly" class="input_cx_title_283" value="<%=StringUtil.deNull(viewMap.get("f_tel"))%>">
							</td>
							<th class="content_02_box_div_table_th">申请日期：</th>
							<td class="content_02_box_div_table_td">
								<input class="input_cx_title_283" type="text" id="f_creator_time" readonly="readonly"  name="f_creator_time" value="<%=StringUtil.deNull(viewMap.get("f_creator_time"))%>"/>
							</td>
						</tr>
						<tr><%--row3--%>
							<th class="content_02_box_div_table_th" style="height: 70px">借阅理由：</th>
							<td class="content_02_box_div_table_td" colspan=4>
                                  <textarea class="validate[maxSize[1000]] textarea_575"  readonly="readonly" style="width:99%" name="f_lending_reason" id="f_lending_reason" ><%=StringUtil.deNull(viewMap.get("f_lending_reason"))%></textarea>
							</td>
						</tr>
					</table>
				</div>
</body>
</html>