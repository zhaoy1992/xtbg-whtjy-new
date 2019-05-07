<%
/**
 * <p>Title: 机构管理员设置主页面</p>
 * <p>Description: 机构管理员设置主页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
 <%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase,
		com.chinacreator.sysmgrcore.manager.OrgManager,
		com.chinacreator.sysmgrcore.entity.Organization,com.chinacreator.security.AccessControl" %>
<%
AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
String orgId1=request.getParameter("orgId");//获取需要设置机构管理员的机构id
OrgManager orgManager = SecurityDatabase.getOrgManager();
Organization org = orgManager.getOrgById(orgId1);
//String PAGE_QUERY_STRING = request.getParameter("PAGE_QUERY_STRING");
//System.out.println("PAGE_QUERY_STRING = " + PAGE_QUERY_STRING);
String orgName = "";
if(org.getRemark5() != null && !"".equals(org.getRemark5())){
	orgName = org.getRemark5();
}else{
	orgName = org.getOrgName();
}
%>
<html>
<head>
<title>为机构【<%=orgName%>】设置管理员</title>
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
</head> 
<frameset name="frame1" cols="*" frameborder="no" border="0" framespacing="0" >
  <!--<frame src="orgadminrree.jsp?orgId1=<%=orgId1%>" name="orgTree" id="orgTree" />
  --><frame src="changeorgadmin.jsp?orgId1=<%=orgId1%>&&orgId=<%=orgId1%>" name="userList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
<input type="hidden" name="orgId1" value="<%=orgId1%>" />
</html>
