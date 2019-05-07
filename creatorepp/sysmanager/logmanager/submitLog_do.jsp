<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.LogManagerImpl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String curUserId = accesscontroler.getUserID();
	String url="";
	String submitFlag = request.getParameter("flag");
	if(submitFlag.equals("1"))
	{
		String status = request.getParameter("status");
		String id = request.getParameter("id");
		LogManager logManager = SecurityDatabase.getLogManager();
		logManager.updatelog(status,id);
		url="LogModuleList.jsp";
	}
	else
	{
		LogManagerImpl logMgr = new LogManagerImpl();
		if(accesscontroler.isAdmin()){
			logMgr.deleteAllLog();	
		}else{
			logMgr.deleteAllLog(curUserId);
		}
		url="logList.jsp";
	}
%>
<html>
<head>
<title></title>
<script language="javascript">
  function initial()
  {
  	window.location.href="<%=url%>";
  }
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  onload="initial()">
</body>
</html>
