<%
/**
 * <p>Title: ��ɫ����ǰ̨</p>
 * <p>Description: ��ɫ����ǰ̨</p>
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
		<title>��ɫ��<%=roleName %>��������Ϣ�鿴</title>
			<link rel="stylesheet" type="text/css" href="../css/windows.css">
			<link rel="stylesheet" type="text/css" href="../css/treeview.css">		
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder" align="center">
			<form method="post" name="roleform">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="20%" height="25" class="detailtitle" align="right">��ɫ���ƣ�</td>
						<td height="25">
							<input type=text name="roleName" readonly="readonly" style="width=50%" value="<%=roleName%>" maxlength="100"
							disabled="disabled"/>
						</td>
					</tr>
					<tr class="tr">					                   	
						<td width="20%" height="25" class="detailtitle" align="right">��ɫ����*��</td>						
					    <td>
					    <select name="roleType" class="cms_select" disabled="disabled">						
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
						<td height="25" width="20%" class="detailtitle" align="right">����*��</td>
						<td height="25">
							<textarea name="roleDesc" rows="4" cols="40" rows="5" disabled="disabled" ><%=roleDesc%></textarea>
						</td>
					</tr>
					<tr class="tr">
						<td width="25%" height="25" class="detailtitle" align="right">��ɫ�����ˣ�</td>
						<td height="25">
							<input type=text name="creatorName" readonly="readonly" style="width=50%" value="<%=userName%>��<%=userRealName%>��" maxlength="100"
							disabled="disabled"/>
						</td>
					</tr>
			</table>
            <hr width="100%">				
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
				<tr class="tr">
					<td class="td">
						<div align="center">
							<input name="calc" type="button" class="input" value="����" onClick="window.close();window.returnValue=false;">
					    </div>
					</td>
				</tr>
			  </table>
			</form>
		</div>
	</body>
</html>