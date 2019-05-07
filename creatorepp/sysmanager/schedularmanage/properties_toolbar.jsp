<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
 	control.checkAccess(request,response);
 	String type = request.getParameter("type");
 	type = type == null ? "" : type;
 	String title = "";
 	if(type.equals("add")){
 		title = "日程安排";
 	}
 	if(type.equals("day")){
 		title = "每日安排";
 	}
 	if(type.equals("query")){
 		title = "日程查询";
 	}
%>
<html>
	<head>
		<title>操作容器工具栏</title>
		<link rel="stylesheet" type="text/css" href="<%=rootpath %>/sysmanager/css/toolbar.css">
		<script language="javascript" src="<%=rootpath %>/sysmanager/base/scripts/toolbar.js"></script>
		<script type="text/javascript">
			function load()
			{
				
			}	
		</script>
	</head>
	
	<%@ include file="/epp/css/cssControl.jsp"%><body class="toolbarbodymargin" onload="load();">
		<div id="toolbarborder">
			<div id="toolbar">
				<table width="100%" cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td valign="middle" align="center" width=25 height="20">
							<img class="normal" src="<%=rootpath %>/sysmanager/images/actions.gif">
						</td>
						<td valign="middle" align="left" nowrap class="text" height="20">
							<%=title %>
						</td>
						<td id="doubleclickcolumn" recover="双击恢复" maxtitle="双击最大化"
							title="双击最大化" valign="middle" align="right" width="*" nowrap
							class="text"></td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>
