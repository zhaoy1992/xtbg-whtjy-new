<%@include file="../../sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<html>
<head>

<title>������������</title>
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/toolbar.css">

<jsp:include page="../../sysmanager/base/scripts/panes.jsp" />
<script language="javascript" src="../../sysmanager/scripts/toolbar.js"></script>
</head>
<body class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_NAVIGATOR%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
<table width="100%"  cellpadding=0 cellspacing=0 border=0 class="table">
	<tr class="tr">
	<td class="td" valign="middle" align="center" width=25 ><img
			class="normal" src="../../sysmanager/base/images/base_perspective_enabled.gif" width=16 height=16></td>
	<td id="doubleclickcolumn" title="˫�������" valign="middle" align="left"width="*"  nowrap class="text">��ԱȨ�޹���</td>
	<td class="td" valign="middle" align="center" width=25 ><a
       
        target="perspective_workarea"><img class="normal"
        src="../../sysmanager/images/refresh_enabled.gif"
        onMouseOver="src='../../sysmanager/images/refresh_highlighted.gif';mouseover(this)"
        onMouseOut="src='../../sysmanager/images/refresh_enabled.gif';mouseout(this)"
        onMouseDown="src='../../sysmanager/images/refresh_highlighted.gif';mousedown(this)"
        onMouseUp="src='../../sysmanager/images/refresh_enabled.gif';mouseup(this)"
        alt="ˢ��" title="ˢ��"></a></td>
        
	</tr>
	
</table>
</div>
</div>
</body>
</html>
