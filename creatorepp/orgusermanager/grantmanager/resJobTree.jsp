<%
/**
 * 
 * <p>Title: 岗位tab页面</p>
 *
 * <p>Description: 岗位tab页面，岗位分为全局操作和详细操作</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String orgId = "";
	if(role_type.equals("user")){
		orgId = request.getParameter("orgId");
	}
	String isBatch = request.getParameter("isBatch");
	StringBuffer url = new StringBuffer()
		.append("operList_global.jsp?resTypeId=job&currRoleId=").append(currRoleId)
		.append("&currOrgId=").append(orgId)
		.append("&role_type=").append(role_type)
		.append("&isBatch=").append(isBatch);
		
	StringBuffer urlleft = new StringBuffer()
		.append("jobsetList.jsp?resTypeId=job&currRoleId=").append(currRoleId)
		.append("&currOrgId=").append(orgId)
		.append("&role_type=").append(role_type)
		.append("&isBatch=").append(isBatch);	
	//String url = "operList_global.jsp?resTypeId=job&currRoleId="+currRoleId+"&currOrgId="+orgId+"&role_type=user";
	//String urlleft = "jobsetList.jsp?resTypeId=job&currRoleId="+currRoleId+"&currOrgId="+orgId+"&role_type=user";
%>

<html>
<head>
<tab:tabConfig/>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<!-- 
<frameset name="userId" cols="30,70" frameborder="no" border="0" framespacing="0" >
	
  	<frame src="resOrgTree.jsp?resTypeId=orgunit" name="globalOperList" id="globalOperList" scrolling="No" noresize="noresize" />
  	<frame src="user_operdefault.jsp" name="operList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
</noframes>
-->
<%@ include file="/epp/css/cssControl.jsp"%><body >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">

		<tr>
			<td colspan="2">
				<tab:tabContainer id="jobResFrame" selectedTabPaneId="jobGlog_res" skin="bluesky">
<!-- ------------------------------------------------------------------------------------------------------------------------------------------>
					<tab:tabPane id="jobGlog_res" tabTitle="岗位全局权限" lazeload="true">
						<tab:iframe id="jobGlogRes" src="<%=url.toString()%>" frameborder="0" scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
					<tab:tabPane id="jobset_res" tabTitle="岗位授予权限" lazeload="true">
						<tab:iframe id="jobsetRes" src="<%=urlleft.toString()%>" frameborder="0" scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
					
			
					
<!-------------------------------------------------------------------------------------------------------------------------------->
					
				</tab:tabContainer>			
			</td>
		</tr>
  </table>	
</body>

</html>