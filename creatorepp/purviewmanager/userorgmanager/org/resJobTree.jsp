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
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@page import="com.frameworkset.common.poolman.DBUtil,
			com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String orgId = request.getParameter("orgId") ;
	
	String url = "../../grantmanager/operList_global.jsp?resTypeId=job&currRoleId="+ orgId +"&role_type=organization";
	String urlleft = "../../grantmanager/jobsetList.jsp?resTypeId=job&currRoleId="+ orgId +"&role_type=organization";
%>

<html>
<head>
<tab:tabConfig/>
<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../css/windows.css">

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
						<tab:iframe id="jobGlogRes" src="<%=url%>" frameborder="0" scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
					<tab:tabPane id="jobset_res" tabTitle="岗位机构设置权限" lazeload="true">
						<tab:iframe id="jobsetRes" src="<%=urlleft%>" frameborder="0" scrolling="no" width="98%" height="550">
						</tab:iframe>
					</tab:tabPane>
					
			
					
<!-------------------------------------------------------------------------------------------------------------------------------->
					
				</tab:tabContainer>			
			</td>
		</tr>
  </table>	
</body>

</html>