<%@ include file="../../include/global1.jsp"%>
<%@ include file="../../base/scripts/panes.jsp"%>
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
<link rel="stylesheet" type="text/css" href="../../css/toolbar.css">
<%

%>

  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
<script language="javascript" src="../../scripts/toolbar.js"></script>
<script language="javascript">
var uId = "<%=userId%>";
	function getElementByName(eName){
		var elements = document.body.all;
		for(i = 0;i< elements.length;i++){
           if (elements[i].name==eName) return elements[i];
		}
		return null;
	}
	function selectTool(toolName) {
	    var tool=getElementByName(toolName);
		if (tool) {
		    tool.onclick();
		}
	}

	function bussinessAction(action){	 
		
			if (action == 1 ) {
				getPropertiesContent().location.href="selfwaitdolist.jsp"
			}
			if (action == 2 ) {
				getPropertiesContent().location.href="agentwaitdolist.jsp" ;	
			}
			
	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin" scrolling="no">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
<table width="100%" height=25 cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 height=25><img
			class="normal" src="../../images/actions.gif"></td>
		<td valign="middle"
			align="left" height=25 nowrap class="text">代办信息</td>
		<td id="doubleclickcolumn" recover="双击恢复" maxtitle="双击最大化" title="双击最大化" valign="middle"
			align="right" width="*" height=25 nowrap class="text">
		<table height=25 cellpadding=0 cellspacing=0 border=0>
			<td class=normal name="tool1" id="tools1" title="个人待办信息" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(1)" height=25>
			<table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../../images/new.gif" alt="个人待办信息" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;个人待办信息&nbsp;</td></tr></table></td>
			<td class=normal name="tool1" id="tools1" title="代理待办信息" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(2)" height=25>
			<table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../../images/new.gif" alt="代理待办信息" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;代理待办信息&nbsp;</td></tr></table></td>
					
		</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
