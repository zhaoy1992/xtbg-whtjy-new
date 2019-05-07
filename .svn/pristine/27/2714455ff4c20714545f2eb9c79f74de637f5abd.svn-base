<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="com.chinacreator.workflow.Monitor"%>
<html>
  <head>  
    <title>放弃</title>
  </head>
 
 <%
 String proID = request.getParameter("proID");
 try{
  Monitor mon = new  Monitor(request);
  System.out.println("abot.jsp..........proID:"+proID+"............");
  mon.abort(proID);
  out.println("<script language=\"javascript\">alert(\"操作成功\");history.back();</script>");
  }
  catch(Exception ex){
  ex.printStackTrace();
  out.println("<script language=\"javascript\">alert(\"操作失败\");history.back();</script>");
  }
 %> 
  <%@ include file="/epp/css/cssControl.jsp"%><body >
  </body>
</html>
