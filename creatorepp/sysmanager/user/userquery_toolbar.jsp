<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%
String userId = request.getParameter("userId");
String qstring = request.getParameter("qstring");
String qqstring = qstring;
if(qstring != null){
	qstring = java.net.URLEncoder.encode(qstring);
}


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


<script language="javascript" src="../scripts/toolbar.js"></script>
<script language="javascript">
var uId = "<%=userId%>";
var qstring="<%=qstring%>";
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
	    if(action == 1 && getPropertiesContent()){
			getPropertiesContent().location.href="../user/userquery_content.jsp?<%=qqstring%>";
	    }
	    else if(action == 2&&getPropertiesContent()){
			getPropertiesContent().location.href="../user/userManager.do?method=getUser&advQuery=1&qstring=<%=qstring%>";
	    }
	}
</script>
<style type="text/css">
<!--
.style1 {color: #000000}
-->
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
<table width="100%" cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 ><img
			class="normal" src="../images/actions.gif"></td>
		<td align="left" valign="middle" nowrap class="text">�û���ѯ</td>
		<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle"
			align="right" width="*" nowrap class="text">
		<table cellpadding=0 cellspacing=0 border=0>
			<!--<td class=normal name="tool1" id="tools1" title="�û���ѯ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(1)" ><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="�û��б�" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;�û��б�&nbsp;</td></tr></table></td>
			<td class=normal name="tool1" id="tools1" title="�û�������Ϣ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(2)" ><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="�û�������Ϣ" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;�û�������Ϣ&nbsp;</td></tr></table></td>
			-->
		
		</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
