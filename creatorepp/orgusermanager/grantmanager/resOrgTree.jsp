<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%
/**
 * 
 * <p>Title: 机构tab页面</p>
 *
 * <p>Description: 机构tab页面，机构分为全局操作和详细操作</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>


<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String isBatch = request.getParameter("isBatch");
	String orgId = request.getParameter("orgId");
	
	//是否管理员
	boolean isOrgManager = false;
	
	if(role_type.equals("user")){
		isOrgManager = new OrgAdministratorImpl().isOrgManager(currRoleId.split(",")[0]);
	}
	
	StringBuffer url = new StringBuffer()
		.append("operList_global.jsp?resTypeId=orgunit&currRoleId=").append(currRoleId)
		.append("&currOrgId=").append(orgId)
		.append("&role_type=").append(role_type)
		.append("&isBatch=").append(isBatch)
		.append("&isOrgManager=").append(isOrgManager);
	
	StringBuffer urlreadorgname = new StringBuffer()
		.append("resReadOrgNameTree.jsp?resTypeId=orgunit&currRoleId=").append(currRoleId)
		.append("&currOrgId=").append(orgId)
		.append("&role_type=").append(role_type)
		.append("&isBatch=").append(isBatch);
	//String url = "operList_global.jsp?resTypeId=orgunit&currRoleId="+currRoleId+"&currOrgId="+orgId+"&role_type=user";
	//String urlreadorgname = "resReadOrgNameTree.jsp?resTypeId=orgunit&currRoleId="+currRoleId+"&currOrgId="+orgId+"&role_type=user";
	

%>

<html>
<head>
<tab:tabConfig/>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<%@ include file="/epp/css/cssControl.jsp"%><body >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">

		<tr>
			<td colspan="2">
				<tab:tabContainer id="orgResFrame" selectedTabPaneId="readorgname_res" skin="bluesky">
<!-- ------------------------------------------------------------------------------------------------------------------------------------------>
					<% 
					//if(role_type.equals("user")){
					//	if(isOrgManager){
					%>
					<% 
					//	}
					//}else{
					%>
					<tab:tabPane id="orgGlog_res" tabTitle="机构全局权限" lazeload="true">
						<tab:iframe id="orgGlogRes" src="<%=url.toString()%>" frameborder="0" scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
					<%//} %>
					<tab:tabPane id="readorgname_res" tabTitle="可访问机构权限" lazeload="true">
						<tab:iframe id="readorgnameRes" src="<%=urlreadorgname.toString()%>" frameborder="0" scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
					
			
					
<!-------------------------------------------------------------------------------------------------------------------------------->
					
				</tab:tabContainer>			
			</td>
		</tr>
  </table>	
</body>

</html>