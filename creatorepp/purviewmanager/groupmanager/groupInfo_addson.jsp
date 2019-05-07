<%
/*
 * <p>Title: 增加子用户组</p>
 * <p>Description: 增加子用户组</p>
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
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>

<%

	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
		
	String groupId = (String) request.getParameter("groupId");
	GroupManager groupManager=SecurityDatabase.getGroupManager();
	Group group=groupManager.getGroupByID(groupId);
	String groupName=group.getGroupName();
	if(groupId == null)
	{
		groupId = "";
	}
	
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>【<%=groupName%>】用户组新增子组</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<script language="javascript">	 		    
        
		  //保存用户组
		  function saveGroup() 
		  {
		    var submitFlag=0;
			if(groupForm.groupName.value == "" || 
					groupForm.groupName.value.length<1 || 
					groupForm.groupName.value.replace(/\s/g,"")=="" ||
					groupForm.groupDesc.value == "" || 
					groupForm.groupDesc.value.length<1 || 
					groupForm.groupName.value.replace(/\s/g,"")=="")
			{
				alert("带*为必填项");
				return false;
			}
			
			var gn = groupForm.groupName.value;
			
			var gd = groupForm.groupDesc.value;
			
			if(gn.search(/[\\\/\|:\*\?<>"']/g)!=-1)
			{
				alert("组名称不能有\\/|:*?<>\"'!等特殊字符");
				return false;
			}
			if(gd.search(/[\\\/\|:\*\?<>"']/g)!=-1)
			{
				alert("组描述不能有\\/|:*?<>\"'!等特殊字符");
				return false;
			}
			if(gn.length>100)
			{
				alert("组名称过长,限制在100字符以内!");
				return false;
			}
			if(gd.length>100)
			{
				alert("组描述过长,限制在100字符以内!");
				return false;
			}
			
			document.all.divProcessing.style.display = "block";
      		document.all.SaveButton.disabled = true;
	        document.all.BackButton.disabled = true;
	        
			groupForm.action= "submitGroup.jsp?son=1&flag=1";
			groupForm.target="submitGroup";
			groupForm.submit(); 
		  } 
		  
		  function back()
		  {
		  	window.returnValue="<%=groupId%>";
		  	window.close();
		  }
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  >
	       <iframe src="" name="submitGroup" style="display:none"></iframe>
			<form action="" id="groupForm" method="post">
				<table width="100%" height="25" border="0" cellpadding="2" cellspacing="0" class="thin">
					<tr>
					<td colspan="2"><strong>&nbsp;用户组基本信息</strong></td>
					</tr>
					<tr>
						<td width="16%" height="25" class="detailtitle">
							<P align="center">
								用户组名称*：
							</P>
						</td>
						<td width="907" height="25">
							<input name="groupName" type="text" style="width=50%" maxlength="100" />
							
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<P align="center">
								用户组说明*：
							</P>
						</td>
						<td height="25">
							<textarea name="groupDesc" rows="4" cols="50"></textarea>
						
						</td>
					</tr>
			</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td>
							<table width="60%" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr>
									<td align="center">
										<input type="button" name="SaveButton" class="input" value="保存" onclick="saveGroup();" />
									&nbsp;&nbsp;
										<input type="button" name="BackButton" class="input" value="返回" onclick="back()" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<input type="hidden" name="parentId" value="<%=groupId%>" />
			</form>
			
			<div id=divProcessing style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
				<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
					<tr>
						<td bgcolor=#3A6EA5>
							<marquee align="middle" behavior="alternate" scrollamount="5">
								<font color=#FFFFFF>...处理中...请等待...</font>
							</marquee>
						</td>
					</tr>
				</table>
			</div>
	</body>
</html>