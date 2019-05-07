<%@page contentType="text/html;charset=GBK"%> 
<%@ page import="com.chinacreator.menu.OutlookbarMenu" %>
<%@page import="com.chinacreator.security.AccessControl
                ,com.chinacreator.security.authorization.AccessException"%>

    <%
    String showMode = request.getParameter("showMode");
    if(showMode == null)
    	showMode = "0";
    
    
    OutlookbarMenu column = new OutlookbarMenu();  
    
    AccessControl control = AccessControl.getInstance();
    
    control.checkAccess(pageContext);
    column.init(pageContext,control);
    column.setShowMode(showMode);
    column.buildColumn();

    %> 

