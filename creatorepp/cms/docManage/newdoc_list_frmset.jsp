<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.*"%>

<%
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(request, response);
%>
<html>
	<frameset rows="120,*" border=0>
	<frame frameborder=0  noResize marginwidth="0" scrolling="auto"  name="forQuery" src="newdoc_queryFrame.jsp"></frame>	
	<frame frameborder=0  noResize  marginwidth="0" scrolling="auto"  name="forDocList" src="newdoc_list.jsp"></frame>
	</frameset><noframes></noframes>
</html>
