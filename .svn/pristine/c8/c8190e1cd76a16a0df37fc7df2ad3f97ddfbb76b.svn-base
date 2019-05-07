<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String channelName = request.getParameter("channelName");
	String siteid = request.getParameter("siteid");
	String channelId = request.getParameter("channelId");

%>
<html>
	<HEAD>
		<TITLE>ÐÅÏ¢À×´ï</TITLE>
	</HEAD>
	<frameset rows="100,*" border=0>
		<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forQuery" 
			src="crawl_queryFrame.jsp?channelName=<%=channelName%>&siteid=<%=siteid%>&channelId=<%=channelId%>">
		</frame>	
		<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forDocList" 
			src="crawl_doc_list.jsp?channelName=<%=channelName%>&siteid=<%=siteid%>&channelId=<%=channelId%>">
		</frame>
	</frameset>
</html>
