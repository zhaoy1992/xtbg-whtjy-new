<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.CMSManager"%>

<%
		AccessControl accesscontroler = AccessControl.getInstance();
    	if(!accesscontroler.checkAccess(request, response))
    		return;
    		
    	CMSManager cmsmanager = new CMSManager();
		cmsmanager.init(request, session, response, accesscontroler);
		String siteid = cmsmanager.getSiteID();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		
		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/treeview.css">
		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/tab.winclassic.css">
		
		<script src="../inc/js/func.js"></script>
		<script src="../inc/js/rightMenu.js"></script>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		//刷新频道数
		function refresh()
		{
			window.open("navigator_content.jsp","perspective_toolbar");
			parent.parent.window.open("../top.jsp","perspective_topbar");
		}
		//站内文档查询
		function serchSiteDoc()
		{
			var url = "../docManage/siteDoc_frames.jsp";
			parent.window.open(url,"base_properties_content");
		}
		
		//刷新站点缓冲
		function refreshSite(siteId)
		{
			if(siteId)
			{
				siteForm.action = "refreshcache_handle.jsp?flag=site&refreshId=" + siteId;
				siteForm.target = "hiddenFrame";
				siteForm.submit();
				refresh();
			}
		}
		
		//刷新全部频道缓冲
		function refreshChannel(siteId)
		{
			if(siteId)
			{
				siteForm.action = "refreshcache_handle.jsp?flag=channel&refreshId=" + siteId;
				siteForm.target = "hiddenFrame";
				siteForm.submit();
				refresh();
			}
		}
		
		//刷新频道缓冲
		function refreshSubChannel(channelId)
		{
			if(channelId)
			{
				siteForm.action = "refreshcache_handle.jsp?flag=subChannel&refreshId=" + channelId;
				siteForm.target = "hiddenFrame";
				siteForm.submit();
				refresh();
			}
		}
		//-->
		</SCRIPT>
	</head>

<body class=""  scroll="auto">
<form action="" method="post" name="siteForm">
<table width="182" border="0"  background="../images/left_bg.jpg"  cellpadding="0" cellspacing="0" class="table" >
	<tr>
		<td height="115" style="padding-top:80px;" align="left">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<img src="../images/refresh.gif" onClick="refresh()" width="16" height="15" border="0" title="刷新频道树" style="cursor:hand">
			&nbsp;&nbsp;
			<%
			if(accesscontroler.checkPermission(siteid,AccessControl.SITE_DOCSEARCH_PERMISSION,AccessControl.SITE_RESOURCE))
			{
			%>
			<img src="../images/ico_channel.gif" width="16" height="15" border="0">
				<a href="javascript:serchSiteDoc()"> 站内文档查询</a>
			<%
			}
			%>
		</td>
	</tr>
</table>
	<table height="100%"  width="182" background="../images/left_center_bg.jpg" style="background-repeat:repeat-y">
	  <tr ><td  width="100%" height="100%" valign=top>
	    <table>
	        <tr><td align="left"> 
	         <tree:tree tree="singlesite_tree"
	    	           node="singlesite_tree.node"
	    	           imageFolder="/cms/images/tree_images/"
	    	           collapse="true"
	    			   includeRootNode="true"
	    			   href=""
	    			   target="base_properties_content" 
	    			   mode="static-dynamic"> 
	    			   <tree:treedata treetype="com.chinacreator.cms.sitemanager.menu.SingleSiteTree"
	    	                   scope="request"
	    	                   rootid="ResourceManager"  
	    	                   rootName="内容管理"
	    	                   expandLevel="1"
	    	                   showRootHref="false"
	    	                   needObserver="false"
	    	                   enablecontextmenu="true"
	    	                   />
	    	          
	    	</tree:tree>
	         </td></tr>
	    </table>
		
	</td></tr></table>
</form>

<iframe name="hiddenFrame" width=0 height=0></iframe>
	

</body>
</html>
