<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String showmode = request.getParameter("showmode");
showmode = "static-dynamic";
%>
<html>
	<head>
		<title>��������</title>
	<script src="<%=basePath %>eformsys/fceform/js/fcpub.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath %>sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath %>sysmanager/css/treeview.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath %>sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath %>sysmanager/css/tab.winclassic.css">
	</head>
	
	<script>
	function toUrl(class_id,_class,class_name)
		
	{
		//alert(class_id);
		//alert(class_name);
		var sUrl = "report_show.jsp?ec_id="+class_id+"&class_name="+class_name;
		//getPropertiesContent().location.href=sUrl;
		parent.parent.frames("mainFrame").window.location.href=sUrl;
		//window.location.target='mainFrame';
	
	}
</script>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="left">
			<form name="OrgJobForm" action="" method="post">
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="table">
					<tr>
						<td>
							<div align="center">
								��������ѡ�� &nbsp;&nbsp;
							</div>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td><!-- dynamic="false" -->
							<tree:tree tree="report_formclass_tree" node="report_formclass_tree.node"
								imageFolder="/sysmanager/images/tree_images/" collapse="true"
								includeRootNode="true" target="base_properties_toolbar"
								mode="<%=showmode %>">
								<tree:param name="showmode" value="<%=showmode%>"></tree:param>
								<tree:param name="appId"></tree:param>									
								<tree:treedata treetype="com.chinacreator.eform.formmanage.menu.FormTree" scope="request"
									rootid="0" rootName="����ҵ�����" expandLevel="1"
									showRootHref="true" needObserver="false"
									enablecontextmenu="true" />
							</tree:tree>
						</td>
					</tr>
				</table>
			</form>
		
		</div>
	</body>
</html>