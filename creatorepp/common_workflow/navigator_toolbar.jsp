<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<html>
<head>

<title>������������</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/toolbar.css">

<script language="javascript" src="<%=request.getContextPath()%>/sysmanager/scripts/toolbar.js"></script>
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar">

<table width="100%"  cellpadding=0 cellspacing=0 border=0 >
	<tr>
	<td valign="middle" align="center" width=25 ><img
			class="normal" src="<%=request.getContextPath()%>/sysmanager/base/images/base_perspective_enabled.gif" width=16 height=16></td>
	<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle" align="left"
			width="*"  nowrap class="text">
			���̼����	
	</td>
	<td valign="middle" align="center" width=25 ><a
       
        target="perspective_workarea"><img class="normal"
        src="<%=request.getContextPath()%>/sysmanager/images/refresh_enabled.gif"
        onMouseOver="src='<%=request.getContextPath()%>/sysmanager/images/refresh_highlighted.gif';mouseover(this)"
        onMouseOut="src='<%=request.getContextPath()%>/sysmanager/images/refresh_enabled.gif';mouseout(this)"
        onMouseDown="src='<%=request.getContextPath()%>/sysmanager/images/refresh_highlighted.gif';mousedown(this)"
        onMouseUp="src='<%=request.getContextPath()%>/sysmanager/images/refresh_enabled.gif';mouseup(this)"
        alt="ˢ��" title="ˢ��" href="javascript:void 0;" onclick="getNavigatorContent().location.reload();return false;" ></a></td>
	</tr>
	
</table>
</div>
</div>
</body>
</html>
