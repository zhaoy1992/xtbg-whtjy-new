<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.workbench.session.SessionListener" %>
<%@page import="com.chinacreator.xtbg.core.workbench.entity.UserSessionBean" %>
<%
List<UserSessionBean>  list = SessionListener.getOnlineUser();
for(UserSessionBean bean : list){
	String ss = "�û�id ==> "+bean.getUser_id()+"  �û���==>" +bean.getUser_name() + "  ��½ip ==> "+ bean.getLogin_ip();
	out.println(ss);
	out.println("<br/>");
}
%>