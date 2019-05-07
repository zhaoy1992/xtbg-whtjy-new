<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%
String userId = request.getParameter("userId");

//点击了用户，置session
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
<title>操作容器工具栏</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">
<%

%>	

  <link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<script language="javascript" src="../scripts/toolbar.js"></script>
<script language="javascript">
	function upload()
   	{
   		getPropertiesContent().location.href="uploadPkg.jsp";
   	}
   	function update()
   	{
   		getPropertiesContent().location.href="updatePkg.jsp";
   	}
   	function packageList()
   	{
   		getPropertiesContent().location.href="packagemgr.jsp";
   	}
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
			align="left" height=25 nowrap class="text">工作流包管理</td>
		<td id="doubleclickcolumn" recover="双击恢复" maxtitle="双击最大化" title="双击最大化" valign="middle"
			align="right" width="*" height=25 nowrap class="text">
		<table height=25 cellpadding=0 cellspacing=0 border=0>
			<td class=normal name="tool1" id="tools1" title="包列表" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="packageList()" height=25>
			<table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="包列表" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;包列表&nbsp;</td></tr></table></td>
			<td class=normal name="tool1" id="tools1" title="上传新包" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="upload()" height=25>
			<table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="上传包" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;上传包&nbsp;</td></tr></table></td>
		</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
