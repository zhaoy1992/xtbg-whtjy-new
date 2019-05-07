<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    
    <title></title>
    <%
     AccessControl control = AccessControl.getInstance();
     control.checkAccess(request,response);
     String appUserName = (String)session.getAttribute("subsystem_id_nouse");
	 if(appUserName == null || "".equals(appUserName.trim()) || "module".equalsIgnoreCase(appUserName.trim())){
	     appUserName = "";
     }else{
	     appUserName = "APP_"+appUserName.trim().toUpperCase()+".";
     }
     //System.out.println("appUserName:"+appUserName);     
    %>
    <script language="javascript" type="text/javascript">
    var appUserName = "<%=appUserName%>";
    </script>
	
  </head>
  
  <body>
     <iframe src="support.jsp" width="100%" height="100%"></iframe>
  </body>
</html>
