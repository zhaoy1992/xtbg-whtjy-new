<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.chinacreator.menu.MainColumn" %>
<%@page import="com.chinacreator.security.AccessControl
                ,com.chinacreator.security.authorization.AccessException"%>

    <%
    
    MainColumn column = new MainColumn();  
    
    AccessControl control = AccessControl.getInstance();
    
    control.checkAccess(pageContext);
    column.init(pageContext,control);
    column.buildColumn();

    %>

