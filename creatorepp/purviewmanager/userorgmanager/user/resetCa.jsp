<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.ca.CAManager"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
AccessControl control = AccessControl.getInstance();
control.checkAccess(request,response);
String path = request.getContextPath();
String userName = request.getParameter("userName");
String errorMessage = null;
try{
	CAManager.resetUserCERT_SN(userName);
}catch(Exception e){
	errorMessage = e.getMessage();
    if (errorMessage != null)
    {
        errorMessage = errorMessage.replaceAll("\\n", "\\\\n");
        errorMessage = errorMessage.replaceAll("\\r", "\\\\r");
    }
}
%>

<script language="javascript">
	<%if(errorMessage == null){%>
		alert("�����ɹ���");
	<%}else{%>
		alert("����ʧ�ܣ�/n<%=errorMessage%>");
	<%}%>
</script>