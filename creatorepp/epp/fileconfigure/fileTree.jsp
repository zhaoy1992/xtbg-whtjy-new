<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
	String app_id = request.getParameter("app_id");
	session.setAttribute("app_id",app_id);
%>
<html>
	<head>
		<title>ักิ๑ฮฤผþ</title>
	</head>

	<frameset cols=30%,70% frameborder=1 border=0>
	    <frame id="tree" src="navigator_content.jsp" scrolling=no border=0 frameborder=1  resize>	    
        <frame id="base_properties_toolbar" src="file_list.jsp" scrolling=no  resize style="border-right: 1px #00a3e4 solid">
        
	</frameset>
	<%@ include file="/epp/css/cssControl.jsp"%><body>
	</body>
</html>