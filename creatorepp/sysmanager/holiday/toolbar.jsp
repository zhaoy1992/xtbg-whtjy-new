<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%
String userId = request.getParameter("userId");

//������û�����session
if(userId != null){
	session.setAttribute("currUserId",Integer.valueOf(userId));
}
if(userId == null){
	session.setAttribute("currUserId",null);
	userId = "";
}
%>
<html>
<head>
<title>��������������</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">
<%

%>

  <link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<script language="javascript" src="../scripts/toolbar.js"></script>
<script language="javascript">
	
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin" scrolling="no">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
<table width="100%" height=25 cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 height=25><img
			class="normal" src="../images/actions.gif"></td>
		<td valign="middle"
			align="left" height=25 nowrap class="text">�ڼ����趨</td>
		<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle"
			align="right" width="*" height=25 nowrap class="text">
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>