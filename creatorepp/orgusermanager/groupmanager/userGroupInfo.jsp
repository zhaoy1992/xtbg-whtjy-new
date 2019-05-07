<%
/*
 * <p>Title: 用户组信息</p>
 * <p>Description: 查看用户组信息</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>
<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%

	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);

	String groupId = (String) request.getParameter("groupId");
	
	String groupName = "";
	String groupDesc = "";
	String userName="";
	String userRealName="";
	if(groupId != null && !groupId.equals(""))
	{
		//依据组ID获取当前所选组的基本信息
		GroupManager groupManager=SecurityDatabase.getGroupManager();
		UserManager userManager=SecurityDatabase.getUserManager();
		Group group=groupManager.getGroupByID(groupId);
		if(group != null)
		{
			groupName=group.getGroupName();
			groupDesc=group.getGroupDesc();	
			String groupOwnerId=String.valueOf(group.getOwner_id());
			User user=userManager.getUserById(groupOwnerId);
			userName=user.getUserName();
			userRealName=user.getUserRealname();
		}
	}
	else
	{
		groupId="";
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>【<%=groupName%>】用户组基本信息</title>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript">
			function init()
			{
				document.getElementById("groupName").value = "<%=groupName%>";	
				document.getElementById("groupDesc").value = "<%=groupDesc%>";
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  onload="init()">
	<%
		if(groupId.equals(""))
	{
	%>
	 <table>
		 <tr>
	 		<td class="detailtitle">请选择左边的组再进行操作</td>
	 	</tr> 
	 </table>
	<%
	}
	else
	{
	%>
	<form action="" id="groupForm" method="post">
		<table width="100%" height="25" border="0" cellpadding="2" cellspacing="0" class="thin">
				<tr>
				<td colspan="2"><strong>&nbsp;用户组基本信息</strong></td>
				</tr>
				<tr>
					<td width="16%" height="25" class="detailtitle">
						<P align="center">
							用户组名称：
						</P>
					</td>
					<td width="907" height="25">
						<input name="groupName" id="groupName" type="text" value="<%=groupName%>" style="width=50%" maxlength="100" readonly/>
					</td>
				</tr>
				<tr>
					<td height="25" class="detailtitle">
						<P align="center">
							用户组说明：
						</P>
					</td>
					<td height="25">
						<textarea name="groupDesc" id="groupDesc" rows="4" cols="50" readonly="true" style="TEXT-ALIGN: left" wrap="soft">
						</textarea>
					</td>
				</tr>
				<tr>
					<td width="16%" height="25" class="detailtitle">
						<P align="center">
							创建人信息：
						</P>
					</td>
					<td width="907" height="25">
						<input name="creatorName" id="creatorName" type="text" value="<%=userName%>【<%=userRealName%>】" style="width=50%" maxlength="100" readonly/>
					</td>
				</tr>
		</table>
		<br/>
		<div align="center">
			<input type="button" class="input" value="返回" onclick="window.close();">
		</div>
	</form>
	<%
	}
	%>	
	</body>
</html>