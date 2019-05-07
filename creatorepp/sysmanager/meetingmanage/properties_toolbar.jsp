<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);

String orgid =  request.getParameter("orgId");
String userId = request.getParameter("userId");

if(orgid == null){
	orgid = "";
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
var orgid="<%=orgid%>";
var uId = "<%=userId%>";
if(orgid!="" && uId =="")
	getPropertiesContent().location.href="../user/userManager.do?method=getUserList&orgId="+orgid;

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

		if(orgid!=""){
	    if(action == 1 && getPropertiesContent()){
			getPropertiesContent().location.href="../user/userManager.do?method=getUser";
	    }
	    else if(action == 2&&getPropertiesContent()){
			getPropertiesContent().location.href="../user/userJob.do?method=getJobList&orgId="+orgid;
	    }

	    else if(action == 3&&getPropertiesContent()){
	       getPropertiesContent().location.href="../user/userOrg.do?method=getOrgList&orgId="+orgid;
	    }
		else if(action == 4&&getPropertiesContent()){
	        getPropertiesContent().location.href="../user/userGroup.do?method=getGroupList&orgId="+orgid;
	    }
	    else if(action == 5&&getPropertiesContent()){
	        getPropertiesContent().location.href="../user/userRole.do?method=getRoleList&orgId="+orgid;
	    }
	    else if(action == 6&&getPropertiesContent()){
	        getPropertiesContent().location.href="../user/userManager.do?method=getUserList&orgId="+orgid;
	    }
	  }




	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">

<table width="100%" height=25 cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 height=25><img
			class="normal" src="../base/images/base_perspective_enabled.gif"></td>
		<td valign="middle"
			align="left" height=25 nowrap class="text">�������</td>
		<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle"
			align="right" width="*" height=25 nowrap class="text">
		<table height=25 cellpadding=0 cellspacing=0 border=0>
		<tr>
			<%
			 if (accessControl.checkPermission("userlist",
                        AccessControl.READ_PERMISSION, AccessControl.USER_RESOURCE))
            {%>
			<td class=normal name="tool1" id="tools1" title="�����ҹ���" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(6)" height=25><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="�����ҹ���" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;�����ҹ���&nbsp;</td></tr></table></td>
			<%}%>

			<%
			 if (accessControl.checkPermission("userbaseinfo",
                         AccessControl.READ_PERMISSION, AccessControl.USER_RESOURCE))
            {%>
			<td class=normal name="tool1" id="tools1" title="��������" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(1)" height=25><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="��������" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��������&nbsp;</td></tr></table></td>
			<%}%>

			<%
			 if (accessControl.checkPermission("usersubjectionjob",
                         AccessControl.READ_PERMISSION, AccessControl.USER_RESOURCE))
            {%>
			<td class=normal name="tool2" id="tools2" title="����֪ͨ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(2)" height=25><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="����֪ͨ" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;����֪ͨ&nbsp;</td></tr></table></td>
			<%}%>

			<%
			 if (accessControl.checkPermission("usersubjectionorg",
                         AccessControl.READ_PERMISSION, AccessControl.USER_RESOURCE))
            {%>
			<td class=normal name="tool3" id="tools3" title="�����Ҫ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(3)" height=25><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="�����Ҫ" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;�����Ҫ&nbsp;</td></tr></table></td>
			<%}%>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
