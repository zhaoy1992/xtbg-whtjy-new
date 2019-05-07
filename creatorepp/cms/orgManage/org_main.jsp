<%
/**
  * 组织机构管理
  */
%>
<%@ page contentType="text/html; charset=GBK" language="java"%>
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
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<title>组织机构管理</title> 
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
	<frameset cols="25%,*" border=0>
		<frame frameborder=0  noResize scrolling="yes" marginWidth=0 name="org_tree" src="org_tree.jsp">
		</frame>
		<frame frameborder=0  noResize scrolling="yes" marginWidth=0 name="org_userlist" src="org_userlist.jsp">
		</frame>
	</frameset>
</html>