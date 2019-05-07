<%@ include file="../../../sysmanager/include/global1.jsp"%>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.net.URLEncoder,java.net.URLDecoder" %>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
 	control.checkAccess(request,response);
%>
<html>
	<head>
		<title>操作容器工具栏</title>
		<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/toolbar.css">
		<script language="javascript" src="../../../sysmanager/base/scripts/toolbar.js"></script>
		<script type="text/javascript">
			function load()
			{
				
			}	
		</script>
	</head>
	  <%@ include file="/epp/css/cssControl.jsp"%>
	<body class="toolbarbodymargin" onload="load();">
		<div id="toolbarborder">
			<div id="toolbar">
				<table width="100%" cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td valign="middle" align="center" width=25>
							<img class="normal" src="../../../sysmanager/images/actions.gif">
						</td>
						<td valign="middle" align="left" nowrap class="text">
							表单列表
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
