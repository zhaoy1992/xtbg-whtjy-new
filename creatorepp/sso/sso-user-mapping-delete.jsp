<%@ page language="java" pageEncoding="gb2312"%>
<jsp:directive.page import="com.liferay.portlet.iframe.action.SSOUserMapping" />

<%
	String Id = request.getParameter("ID");
	SSOUserMapping ssoum = new SSOUserMapping();
	if (ssoum.deleteUserMapping(Id)) {
%>
<script type="text/javascript">
				alert("�����ɹ�!");
				window.location.href="sso-user-mapping.jsp";
</script>
<%
} else {
%>
<script type="text/javascript">
				alert("�ܱ�ǫ,����ʧ�ܣ�");
				window.location.href="sso-user-mapping.jsp";
</script>
<%
}
%>


