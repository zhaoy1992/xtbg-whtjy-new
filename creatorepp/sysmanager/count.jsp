<%@ page language="java" import="java.util.*" pageEncoding="GBK"%><%@page import="com.chinacreator.security.AccessControl"%><%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
    int count = accesscontroler.getLoginUserCount();
    out.print(count);
    //out.flush();
    //out.close();
%>