<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.liferay.portlet.iframe.action.UserMapping"%>
<%@page import="com.liferay.portlet.iframe.action.SSOUserMapping"%>
<%
		try { 
			UserMapping um = new UserMapping();
			String A_APP_ID = request.getParameter("A_APP_ID");
			String A_USER_NAME    = request.getParameter("A_USER_NAME");
			String B_APP_ID   = request.getParameter("B_APP_ID");
			String B_USER_NAME    = request.getParameter("B_USER_NAME");
			String B_USER_PASSWORD    = request.getParameter("B_USER_PASSWORD");
			String USER_REMARK    = request.getParameter("USER_REMARK");
			um.setA_APP_ID(A_APP_ID);
			um.setA_USER_NAME(A_USER_NAME);
			um.setB_APP_ID(B_APP_ID);
			um.setB_USER_NAME(B_USER_NAME);
			um.setB_USER_PASSWORD(B_USER_PASSWORD);
			um.setUSER_REMARK(USER_REMARK);
			SSOUserMapping ssoum = new SSOUserMapping();
			int landId = ssoum.userMapping(A_APP_ID,A_USER_NAME,B_APP_ID,B_USER_NAME,B_USER_PASSWORD,USER_REMARK);
			if(landId > 0) {				
		 	%>
		 	<script type="text/javascript">
				alert("�����ɹ�!");
				window.location.href="sso-user-mapping.jsp";
			</script>
		 	<%
			}else {
				%>
			 	<script type="text/javascript">
					alert("����ʧ��!");
					window.location.href="sso-user-mapping.jsp";
				</script>
		 	<%
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
 %>
	
	  
	