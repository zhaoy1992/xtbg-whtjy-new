
<%@include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<html>
<head>

<title>导航器工具栏</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">

<jsp:include page="../base/scripts/panes.jsp" />
<script language="javascript" src="../scripts/toolbar.js"></script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
<table width="100%" height=25 cellpadding=0 cellspacing=0 border=0>
	<tr>
	<td valign="middle" align="center" width=25 height=25><img
			class="normal" src="../base/images/base_perspective_enabled.gif" width=16 height=16></td>
	<td id="doubleclickcolumn" recover="双击恢复" maxtitle="双击最大化" title="双击最大化" valign="middle" align="left"
			width="*" height=25 nowrap class="text">用户映射角色信息</td>
	<td valign="middle" align="center" width=25 height=25><a
        href="<%=request.getContextPath()%>/ReloadPerspectiveActionJSP.jsp"
        target="perspective_workarea"><img class="normal"
        src="../images/refresh_enabled.gif"
        onMouseOver="src='../images/refresh_highlighted.gif';mouseover(this)"
        onMouseOut="src='../images/refresh_enabled.gif';mouseout(this)"
        onMouseDown="src='../images/refresh_highlighted.gif';mousedown(this)"
        onMouseUp="src='../images/refresh_enabled.gif';mouseup(this)"
        alt="刷新" title="刷新"></a></td>
        
	</tr>
	
</table>
</div>
</div>
</body>
</html>
