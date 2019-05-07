<%@page session="false" contentType="text/html;charset=GBK"%><%@page import="com.chinacreator.security.AccessControl
                ,com.chinacreator.security.authorization.AccessException"%><%
  AccessControl accesscontroler = AccessControl.getInstance();
  boolean success = accesscontroler.checkAccess(request, response);
  accesscontroler.logout(false);
  //out.flush();
  //out.close();   
%>