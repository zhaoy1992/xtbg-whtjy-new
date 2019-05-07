<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil,com.chinacreator.sysmgrcore.manager.db.OrgCacheManager"%>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

String orgId = request.getParameter("orgId");
Organization org = OrgCacheManager.getInstance().getOrganization(orgId);
String orgName = "";
if(org.getRemark5() != null && !"".equals(org.getRemark5())){
	orgName = org.getRemark5();
}else{
	orgName = org.getOrgName();
}
%>
<HTML>
 <HEAD>
   <title>������<%=orgName%>�������û�</title>
 </HEAD>
  <frameset name="framefold" cols="30,70" frameborder="no" border="0" framespacing="0">
	<frame src="orguserTree.jsp?oid=<%=orgId%>" name="orgTree" id="orgTree"></frame>		
	<frame src="userList_ajax.jsp?oid=<%=orgId%>" name="userList" scrolling="No" noresize="noresize" id="userList"></frame>
  </frameset>	
</HTML>
