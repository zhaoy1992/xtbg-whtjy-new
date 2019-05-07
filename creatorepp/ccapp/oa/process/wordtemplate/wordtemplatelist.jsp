<%--
　　描述：模板列表页面
　　作者：黄艺平
　　版本：1.0
　　日期：2013-07-31
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String orgId = StringUtil.deNull(request.getParameter("org_id"));
	String orgName = StringUtil.deNull(request.getParameter("org_name"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>模板列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript" ></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script src="js/wordtemplatelist.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>

<script type="text/javascript">
	var org_id = "<%=orgId%>";
	var org_name = "<%=orgName%>";
	var path = "<%=path%>";
</script>

</head>
<body>
<form name="form1" method="post">
<table width="100%" id="queryTable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="tabs_search_ctable">
						<tr>
							<th width="90" class="input_cx_title_th">模版名称：</th>
							<td width="296" class="cx_title_td">
								<input name="mb_mc" id="mb_mc" type="text" class="input_cx_title_283" /></td>
							<td width="385" colspan="2">
								<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01" /></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
		<table id="gridTable"></table>
		</td>
	</tr>
</table>
<iframe name="hiddenFrame" width="0" height="0"></iframe></form>
</body>
</html>