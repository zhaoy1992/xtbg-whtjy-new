<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String flag = request.getParameter("flag");
	String channelId = request.getParameter("channelId");
	String siteid = request.getParameter("siteid");
	String title = "::::::文档选择::::::::::::::::::::::.";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<title><%=title%></title> 
<style type="text/css">
	.STYLE1 {color: #0000FF}
	.STYLE2 {color: #000099}
	.style3 {
		font-size: 14px;
		font-weight: bold;
		color: #3300FF;
	}
	.operStyle{
	width:17;
	height:16;
	}
</style>
<SCRIPT LANGUAGE="JavaScript">
	
</SCRIPT>
</head>
	<frameset rows="85%,*" border=0>
	<frame frameborder=0  noResize scrolling="yes" marginWidth=0 name="chn_doc_top" src="channel_doc_top.jsp"></frame>
	<frame   frameborder=0  noResize scrolling="auto" marginWidth=0 name="chn_doc_ok" src="channel_doc_submit.jsp?siteid=<%=siteid%>&channelId=<%=channelId%>"></frame>
	</frameset>
</html>