<%-- 
	描述：用户权限查询框架页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-31
 --%>
<%@ page contentType="text/html; charset=GBK" language="java"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);

	String userId = (String)request.getParameter("userId");
	String typeName = (String)request.getParameter("typeName");
	String orgId = (String)request.getParameter("orgId");

	//根据userId查询用户名称
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(userId);
	String userName = user.getUserName();
	
	//判断你选择的用户是否是管理员，为管理员的话，直接弹出对话框，提示用户拥有所有权限
	DBUtil dbUtil = new DBUtil();
	StringBuffer hsql = new StringBuffer("select count(*) from td_sm_userrole t where t.role_id = '1' and t.user_id = "+userId+"");
	dbUtil.executeSelect(hsql.toString());
	StringBuffer isAdmin = new StringBuffer();
	//dbUtil.getInt(0,0)
	if(dbUtil.getInt(0,0) > 0)
	{
		isAdmin.append("alert('该用户是管理员，拥有所有权限！');window.close();");
	}
	else
	{
		isAdmin.append("");
	}


%>
<HTML>
 <HEAD>
   <title>用户[<%=userName%>]资源权限查询</title>
   <script language="javascript">
		<%=isAdmin.toString()%>
   </script>
 </HEAD>
  <frameset rows="38,*" border=0>
	<frame frameborder=0  noResize scrolling="no" marginWidth=0 name="forQuery" src="userres_query.jsp?userId=<%=userId%>&&typeName=<%=typeName%>&&orgId=<%=orgId %>"></frame>		
	<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forDocList" src="userres_querylist.jsp?userId=<%=userId%>&&typeName=<%=typeName%>&&orgId=<%=orgId %>"></frame>
	</frameset>	
</HTML>