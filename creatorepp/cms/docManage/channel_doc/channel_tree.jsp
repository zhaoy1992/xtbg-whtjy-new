<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ include file="/sysmanager/include/global1.jsp"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>相关文档的选择</title>
<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/windows.css">
</head>
<body class="contentbodymargin" scrolling="no">
<div id="contentborder">
    <table >
        <tr><td>
         <tree:tree tree="org_tree"
    	           node="org_tree.node"
    	           imageFolder="../../../comm/public_info/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="publicInfoList.jsp" 
    			   target="chn_doc_list" 
    			   mode="static-dynamic"
    			   >    			    
    			    
    			   <tree:treedata treetype="com.chinacreator.comm.publicInfo.menu.PublicInfoContentTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="信息公开"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   enablecontextmenu="true" 
    	                   />
					
    	</tree:tree>
         </td></tr>
    </table>
</div>
</body>
</html>