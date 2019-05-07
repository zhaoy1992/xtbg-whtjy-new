<%-- 
	描述：角色资源权限查询框架页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-30
 --%>
<%@ page contentType="text/html; charset=GBK" language="java"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil,
				com.chinacreator.sysmgrcore.manager.RoleManager"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);

	String roleId = (String)request.getParameter("roleId");
	String type = (String)request.getParameter("typeName");
    RoleManager roleManager = SecurityDatabase.getRoleManager();
	Role role = roleManager.getRoleById(roleId);
	String name=role.getRoleName();
   

%>
<HTML>
 <HEAD>
   <title>【<%=name%>】角色资源权限查询</title>
   
 </HEAD>
  <frameset rows="38,*" border=0>
	<frame frameborder=0  noResize scrolling="no" marginWidth=0 name="forQuery" src="roleres_query.jsp?name=<%=name%>&type=<%=type%>"></frame>		
	<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forDocList" src="roleres_querylist.jsp?name=<%=name%>&type=<%=type%>"></frame>
	</frameset>	
</HTML>