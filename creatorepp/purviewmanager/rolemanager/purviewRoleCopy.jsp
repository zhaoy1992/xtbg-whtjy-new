<%
/**
 * <p>Title: Ȩ�޸���</p>
 * <p>Description: Ȩ�޸�����ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author da.wei
 * @version 1.0
 */
%>

<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role" %>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	
	String roleId = request.getParameter("roleId");
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	Role role = roleManager.getRoleById(roleId);
	String roleName = role.getRoleName();
	//System.out.println("roleName = " + roleName);
%>
<html>
<head>
	<title>��ɫ<%=roleName%>Ȩ�޸���</title>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<tab:tabConfig/>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body   bgcolor="#F7F8FC">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<td colspan="2">
				<tab:tabContainer id="purviewCopy" selectedTabPaneId="purview-copy">
					<tab:tabPane id="copy-rest" tabTitle="�ý�ɫȨ�޸��Ƹ�������ɫ" lazeload="true">
						<tab:iframe id="copyRest" src="" frameborder="0" scrolling="yes" width="99%" height="540">
						</tab:iframe>
					</tab:tabPane>
					<tab:tabPane id="copy-self" tabTitle="������ɫ��Ȩ�޸��Ƹ��ý�ɫ" lazeload="false">
						<tab:iframe id="copySelf" src="" frameborder="0" scrolling="yes" width="99%" height="540">
						</tab:iframe>
					</tab:tabPane>
				</tab:tabContainer>			
			</td>
		</tr>
  </table>	
 <iframe name="exeman" width="0" height="0" style="display:none"></iframe>
 
</body>
	<script language="javascript">
	    window.onload=function init()
	    {
	        var path = "rolecopy.jsp?roleId=<%=roleId%>";
	        document.all("copyRest").src = path;
	        var path = "roleCopySelf.jsp?roleId=<%=roleId%>";
	        document.all("copySelf").src = path;
	    }
	</script>
</html>
