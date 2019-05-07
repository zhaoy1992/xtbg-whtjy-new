<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.workbench.session.SessionListener" %>
<%@page import="com.chinacreator.xtbg.core.workbench.entity.UserSessionBean" %>
<%
List<UserSessionBean>  list = SessionListener.getOnlineUser();
for(UserSessionBean bean : list){
	String ss = "用户id ==> "+bean.getUser_id()+"  用户名==>" +bean.getUser_name() + "  登陆ip ==> "+ bean.getLogin_ip();
	out.println(ss);
	out.println("<br/>");
}
%>