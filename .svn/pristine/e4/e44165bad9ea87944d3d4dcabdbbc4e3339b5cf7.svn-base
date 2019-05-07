
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.workflow.Monitor"%>

<html>
  <head>   
    <title>restart</title>
  </head>
 
 <%
 try{
  Monitor mon = new Monitor(request);
  String proID = request.getParameter("proID");
  mon.restart(proID);
  out.println("<script language=\"javascript\">alert(\"操作成功\");history.back()</script>");
  }
  catch(Exception ex){
  ex.printStackTrace();
  out.println("<script language=\"javascript\">alert(\"操作失败\");history.back()</script>");
  }
 %>
  <%@ include file="/epp/css/cssControl.jsp"%><body >
  </body>
</html>
