<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.workflow.Monitor"%>


<html>
  <head>    
    <title>suspend</title>    
  </head>
 
   <%
  String proID = request.getParameter("proID");
  try{
  Monitor mon = new  Monitor(request);
  mon.suspend(proID);
  out.println("<script language=\"javascript\">alert(\"�����ɹ�\");history.back()</script>");
  }
  catch(Exception ex){
  ex.printStackTrace();
  out.println("<script language=\"javascript\">alert(\"����ʧ��\");history.back()</script>");
  }
  %>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body >
  </body>
</html>
