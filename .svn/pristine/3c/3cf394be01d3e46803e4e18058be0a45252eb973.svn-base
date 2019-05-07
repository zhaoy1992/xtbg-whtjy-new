<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String resId2 = request.getParameter("resId2");
	String resTypeId2 = request.getParameter("resTypeId2");
	String resTypeName = request.getParameter("resTypeName");
	String title = request.getParameter("title");
	
	String isBatch = request.getParameter("isBatch");
	String resName2 = request.getParameter("resName2");
%>
<html>
<head>
<title>ÊÚÓè½ÇÉ«</title>
</head>
<!-- 
<iframe src="../../sysmanager/resmanager/hasPower_ajax.jsp?resId2=<%=resId2%>&resTypeId2=<%=resTypeId2%>&resTypeName=<%=resTypeName%>&title=<%=title%>&isBatch=<%=isBatch %>"  border=0 scrolling="no" id="docVerListFrame" name="docVerListFrame" height="100%" width="100%"></iframe>
-->
<iframe src="hasPower_ajax.jsp?resId2=<%=resId2%>&resTypeId2=<%=resTypeId2%>&resTypeName=<%=resTypeName%>&title=<%=title%>&isBatch=<%=isBatch %>&resName2=<%=resName2 %>"  border=0 scrolling="no" id="docVerListFrame" name="docVerListFrame" height="100%" width="100%"></iframe>
</html>