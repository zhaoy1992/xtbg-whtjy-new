<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl,com.chinacreator.workflow.business.model.AssignmentDevolveManager"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
     <title>取消所有委托</title>
    <%
        AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String userId = accesscontroler.getUserID(); 
		AssignmentDevolveManager assignmentDevolveManager=new AssignmentDevolveManager();	
		boolean issuccess=assignmentDevolveManager.CancelAll(userId);
	if(issuccess)
	out.println("<script language=\"javascript\">alert(\"取消所有委托成功！\");location.href=\"assignmentDevolve.jsp\";</script>");
	else
	out.println("<script language=\"javascript\">alert(\"取消所有委托失败！\");history.back();</script>");
    %>  	
			
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body >
   
  </body>
</html>
