<%@ page language="java" contentType="text/html; charset=gbk"%>
<%@page import="com.chinacreator.security.AccessControl,com.chinacreator.workflow.business.model.AssignmentDevolveManager"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
     
    <title>ȡ��ί��</title>
     <%
       AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String userId = accesscontroler.getUserID();
	String procDefId=request.getParameter("procDefId");
	AssignmentDevolveManager assignmentDevolveManager=new AssignmentDevolveManager();
	boolean issuccess=assignmentDevolveManager.CancelDevolve(userId,procDefId);
	if(issuccess)
	out.println("<script language=\"javascript\">alert(\"ȡ��ί�гɹ���\");location.href=\"assignmentDevolve.jsp\";</script>");
	else
	out.println("<script language=\"javascript\">alert(\"ȡ��ί��ʧ�ܣ�\");history.back();</script>");
    %>  
   
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body >
   
  </body>
</html>