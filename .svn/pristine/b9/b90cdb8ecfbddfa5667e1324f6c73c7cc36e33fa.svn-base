
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.CMSManager"%>
<%@ page import="com.chinacreator.cms.sitemanager.SiteCacheManager"%>
<%@ page import="com.chinacreator.cms.sitemanager.Site"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    if(!accesscontroler.checkAccess(request, response))
    	return;
    
    CMSManager cmsmanager = new CMSManager();
	cmsmanager.init(request, session, response, accesscontroler);
	
	
	String siteId = cmsmanager.getSiteID();
	
	Site site = SiteCacheManager.getInstance().getSite(siteId) ;
	
	if(site == null)
	{

		return ;
	}
	
	String siteDir = site.getSiteDir() ;
	String siteName = site.getName() ;	      
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>站点目录</title>
<script language="javascript"> 
	function okadd()
	{	
		selectNode = document.all.item("uri");
		
		if(selectNode==null)
		{
	 		alert("请选择要查询的目录!"); 
	 		return ;
	 	}  
	 	  
 		var uri ;
 	
	 	if(selectNode.length)
	 	{
	 		for(var i = 0;  i < selectNode.length; i ++)
	 		{
	 			if(selectNode[i].checked)
	 			{
	 				uri = selectNode[i].value;
	 			}
	 			
	 		}
	 	}
	 	else if(selectNode)
	 	{
	 		if(selectNode.checked)
			{
				uri = selectNode.value;
			}
	 	}
	 	if(!uri)
	 	{
	 		alert("请选择要查询的目录!");
	 		return ;
	 	}    
	 	
	 	if(window.confirm("你确定要查询:" +uri + "目录下的冗余文件?"))
	 	{
	 		fileForm.action = "file_listFrame.jsp?siteDir=<%=siteDir%>&uri=" + uri ;
		 	fileForm.target= "base_properties_content";		
		 	fileForm.submit() ;
	 	}
	}
</script>
<link rel="stylesheet" type="text/css" href="../../purviewmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../purviewmanager/css/treeview.css">
</head>
<body class="contentbodymargin" scroll="auto">
	
	
<form name="fileForm"  method="post" target="base_properties_content" >
	
    <table >
    	<tr>
			<td align="center">
				<input name="add" type="button" class="input" value="查询无关联文件" onclick="okadd()" >
			</td>
		</tr>
        <tr><td align="left">
         <tree:tree tree="singlesite_tree"
    	           node="singlesite_tree.node"
    	           imageFolder="/cms/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="" 
    			   target="" 
    			   mode="static-dynamic"
    			   >     		
    			   <tree:radio name="uri"/>	    
    			   <tree:treedata treetype="com.chinacreator.cms.garbagemanager.SiteProjectTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="<%=siteName%>"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   enablecontextmenu="false" 
    	                   />					
    	</tree:tree>
         </td></tr>
    </table>
</form>
</body>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>
