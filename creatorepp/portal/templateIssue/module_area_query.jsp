<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.framework.MenuHelper"%>
<%@page import="com.chinacreator.portal.PortalUtil"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	String contextPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath+"/";
	String i = request.getParameter("i");
	String areaType = request.getParameter("issueArea"+i);
	String menuPath = request.getParameter("appModuleSrc"+i);
	String moduleName = request.getParameter("moduleName"+i);
	String url = PortalUtil.getRealMenuPath(contextPath, menuPath, areaType);
	System.out.println(areaType + " = " + url);
%>

<html>

<head><title>ģ������Ԥ��</title></head>

<%@ include file="/epp/css/cssControl.jsp"%><body>
<form action="" method="post">
<table>

</table>
<table >
<tr>
<td>
ģ��[<%=moduleName %>]��[<%=areaType %>]����Ԥ��
</td>
</tr>
<tr>

<td>
<iframe src="<%=url %>" height="600" width="1024"></iframe>
</td>
</tr>
</table>
</form>
</body>

</html>