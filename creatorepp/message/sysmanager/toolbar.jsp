<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>

<html>
<head>
<title>操作容器工具栏</title>
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/toolbar.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
<script language="javascript" src="../../sysmanager/scripts/toolbar.js"></script>
<script language="javascript">
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="toolbarbodymargin" scrolling="no">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
<table width="100%" height=25 cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 height=25><img
			class="normal" src="../../sysmanager/images/actions.gif"></td>
		<td valign="middle"
			align="left" height=25 nowrap class="text">消息资源管理</td>
		<td id="doubleclickcolumn" recover="双击恢复" maxtitle="双击最大化" title="双击最大化" valign="middle"
			align="right" width="*" height=25 nowrap class="text">
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
