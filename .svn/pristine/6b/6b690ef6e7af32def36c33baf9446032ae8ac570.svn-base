<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String xmlfile = StringUtil.replaceNull(request.getParameter("xmlfile")+"","");
	String isLoad = StringUtil.replaceNull(request.getParameter("isLoad"),"");
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<title>组织机构管理</title>
	</head>
		<frameset name="userOrgFrame" cols="20%,*" border=0 framespacing="0">
			<frame frameborder=1 scrolling="yes" name="org_tree" src="xml_tree.jsp" marginWidth=0 marginHeight=0 >
			</frame>
			<frame frameborder=0 scrolling="yes" name="xmluser_list" src="xmluser_list.jsp?xmlfile=<%=xmlfile %>&&isLoad=<%=isLoad %>" marginWidth=0 marginHeight=0 >
			</frame>
		</frameset>
</html>
