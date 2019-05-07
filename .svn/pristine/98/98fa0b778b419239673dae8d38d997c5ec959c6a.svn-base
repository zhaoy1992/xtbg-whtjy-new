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
	
	String resName2 = request.getParameter("resName2");
	String isBatch = request.getParameter("isBatch");
%>
<html>
<head>
<title>ÊÚÓè×éÖ¯</title>
</head>
	<frameset cols="25%,*" border=0>
		<frame frameborder=0  noResize scrolling="yes" marginWidth=0 name="res_org_tree" src="res_org_tree.jsp?resId2=<%=resId2%>&resTypeId2=<%=resTypeId2%>&resTypeName=<%=resTypeName%>&title=<%=title%>&resName2=<%=resName2 %>&isBatch=<%=isBatch %>">
		</frame>
		<frame frameborder=0  noResize scrolling="yes" marginWidth=0 name="res_org_list" src="operList_tab.htm">
		</frame>
	</frameset>
</html>