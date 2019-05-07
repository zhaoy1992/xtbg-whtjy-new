<%
/*
 * <p>Title: 用户隶属岗位前台页面</p>
 * <p>Description: 用户隶属岗位前台页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-22
 * @author liangbing.tao
 * @version 1.0
 */
%>
<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager,
				com.chinacreator.sysmgrcore.entity.*,
				com.chinacreator.security.AccessControl" %>
			

<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	
	//String userId = (String)session.getAttribute("userId");
	String userId = request.getParameter("userId");
	
	if (userId == null) {
		out.println("用户不存在");
		return;
	} 
	
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(userId);
  	String userName= user.getUserRealname();
	String orgid = request.getParameter("orgId");
%>
<html>
  <head>
  <title>用户【<%=userName%>】隶属岗位</title>
  </head>
<frameset rows="*" cols="100%" framespacing="3" frameborder="yes" border="0" >
	<frame src="changeJob_ajax.jsp?userId=<%=userId%>&orgId=<%=orgid%>" name="lusersys1" id="lusersys1">
</frameset>
</html>