<%
/*
 * <p>Title: 隶属用户添加的框架界面</p>
 * <p>Description: 隶属用户添加框架界面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
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
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);

  	String groupId=request.getParameter("groupId");
  	GroupManager groupManager=SecurityDatabase.getGroupManager();
  	Group group=groupManager.getGroupByID(groupId);
  	String groupName=group.getGroupName();
 	request.getSession().setAttribute("curGroupId", groupId);
%>

<html>
	<head>
		<title>【<%=groupName%>】用户组添加隶属用户</title>
	</head> 
	<frameset name="frame1" cols="30%,40%" frameborder="no" border="0" framespacing="0" >
	  <frame src="orgTree.jsp" name="orgTree" id="orgTree" />
	  <frame src="userList_ajax.jsp" name="userList" scrolling="No" noresize="noresize" id="orgList" />
	</frameset>
	<noframes>
		<%@ include file="/epp/css/cssControl.jsp"%><body >
		</body>
	</noframes>
</html>
