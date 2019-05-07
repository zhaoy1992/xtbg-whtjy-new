<%
/**
 * <p>Title: 角色更新前台</p>
 * <p>Description: 角色更新前台</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author liangbing.tao
 * @version 1.0
 **/
 %>
 <%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
 

<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.RoleType"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>


<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	
	String roleId = request.getParameter("roleId");
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	UserManager userManager=SecurityDatabase.getUserManager();
	Role role = roleManager.getRoleById(roleId);
	String roleName = "";
	String roleDesc = "";
	String roleTypeid = "";
	String userName="";
	String userRealName="";
	if(role != null)
	{
		roleName = role.getRoleName();
		roleDesc = role.getRoleDesc();
		roleTypeid = role.getRoleType();
		
		String roleOwnerId=String.valueOf(role.getOwner_id());
		User user=userManager.getUserById(roleOwnerId);
		userName=user.getUserName();
	    userRealName=user.getUserRealname();
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>角色【<%=roleName %>】基本信息修改</title>
			<link rel="stylesheet" type="text/css" href="../css/windows.css">
			<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<SCRIPT LANGUAGE="JavaScript"> 
			function updateRole() 
			{
				
				var form = document.forms[0];
				if (form.roleName.value.length < 1 || form.roleName.value.replace(/\s/g,"")=="") 
				{			
					alert("角色名称必须填写");
					return;
				}
				if (form.roleDesc.value.length < 1 || form.roleDesc.value.replace(/\s/g,"")=="") 
				{			
					alert("角色描述必须填写");
					return;
				}				
				
				if (form.roleName.value.length == "adminstrator") 
				{			
					alert("系统管理员不能修改。谢谢合作:)");
					return;
				}
				
				var rn = form.roleName.value;
				var rd = form.roleDesc.value;
				if(rn.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("角色名称不能有\\/|:*?<>\"'!等特殊字符");
					return;
				}	
				if(rd.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("角色描述不能有\\/|:*?<>\"'!等特殊字符");
					return;
				}
				
				if(rn.length>100)
				{
					alert("角色名称过长,限制在100字符以内!");
					return;
				}
				if(rd.length>100)
				{
					alert("角色描述过长,限制在100字符以内!");
					return;
				}
				if ((form.roleType.value==""))
  	  			{
		  	  	    alert("请选择角色类别");		  	  	
		  	  	    return;
  	  	        }
				
				document.all.divProcessing.style.display = "block";
				
			  	form.action = "modifyRole_do.jsp";
			  	
			  	document.all.update.disabled = true;
			  	document.all.calc[0].disabled = true;
			  	document.all.calc[1].disabled = true;
			  	
				form.target = "hiddenFrame";
				form.submit();
			}
			
			function checkLength(e)
			{
				var elength = e.value.length;
				var v = e.value;				
				if(elength>=100)
				{
					e.value = v.substring(0,100);
				}
			}	
		</SCRIPT>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder" align="center">
			<form method="post" name="roleform">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<input type="hidden" name="roleId" value="<%=roleId%>"/>
					<tr class="tr">
						<td width="20%" height="25" class="detailtitle" align="right">角色名称：</td>
						<td height="25">
							<input type=text name="roleName" readonly="readonly" style="width=50%" value="<%=roleName%>" maxlength="100"
							<%
							if(roleId.equals("1") || roleId.equals("2") || roleId.equals("3") || roleId.equals("4"))
							{
							%>
							disabled
							<%
							}
							%>
							/>
						</td>
					</tr>
					<tr class="tr">					                   	
						<td width="20%" height="25" class="detailtitle" align="right">角色类型*：</td>						
					    <td>
					    <select name="roleType" class="cms_select" 
					    <%
						if(roleId.equals("1") || roleId.equals("2") || roleId.equals("3") || roleId.equals("4"))
						{
						%>
						disabled
						<%
						}
						%>
					    >						
						<%
						List typenamelist = null;
						RoleTypeManager rtm = new RoleTypeManager();
						typenamelist = rtm.getTypeNameList();
						if(typenamelist != null)
						{
							for(int i=0;i<typenamelist.size();i++)
							{
								RoleType rt = (RoleType)typenamelist.get(i);
								if(roleTypeid.equals(rt.getRoleTypeID()))
								{
									%>
									<option value="<%=rt.getRoleTypeID()%>" selected><%=rt.getTypeName()%></option>
									<%
								}
								else
								{
									%>
									<option value="<%=rt.getRoleTypeID()%>"><%=rt.getTypeName()%></option>
									<%
								}
							}
						}
						%>												
						</select>		
					    </td>
					</tr>
					<tr class="tr">
						<td height="25" width="20%" class="detailtitle" align="right">描述*：</td>
						<td height="25">
							<textarea name="roleDesc" rows="4" cols="40" rows="5" onkeyup="checkLength(this)"
							<%
							if(roleId.equals("1") || roleId.equals("2") || roleId.equals("3") || roleId.equals("4"))
							{
							%>
							disabled
							<%
							}
							%>
							><%=roleDesc%></textarea>
						</td>
					</tr>
					<tr class="tr">
						<td width="25%" height="25" class="detailtitle" align="right">角色创建人：</td>
						<td height="25">
							<input type=text name="creatorName" readonly="readonly" style="width=50%" value="<%=userName%>【<%=userRealName%>】" maxlength="100"
							disabled="disabled"/>
						</td>
					</tr>
			</table>
            <hr width="100%">				
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
				<tr class="tr">
					<td class="td">
						<div align="center">
							<%
							if(roleId.equals("1") || roleId.equals("2") || roleId.equals("3") || roleId.equals("4"))
							{
							%>
							<input name="update" type="button" onClick="updateRole()" class="input" value="保存" disabled/>
							<input name="calc" type="reset" class="input" value="清空" disabled>
							<input name="calc" type="button" class="input" value="返回" onClick="window.close();window.returnValue=false;">
							<%
							}
							else
							{
							%>								
							<input name="update" type="button" onClick="updateRole()" class="input" value="保存"/>
							<input name="calc" type="reset" class="input" value="清空">
							<input name="calc" type="button" class="input" value="返回" onClick="window.close();window.returnValue=true;">
							<%
							}
							%>
					    </div>
					</td>
				</tr>
			  </table>
			</form>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:100px;top:260px;display:none">
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
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>