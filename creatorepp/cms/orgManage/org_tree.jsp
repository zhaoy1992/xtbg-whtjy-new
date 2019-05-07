<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(request,response);
	                            
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>������</title>
<script language="javascript">
function action11(){
	getPropertiesContent().location.href="<%=rootpath%>/sysmanager/orgmanager/organsearch.jsp";   
}
function neworg()
{
	openWin("new_org.jsp?flag=1",520,400);
}
</script>
<script src="../inc/js/func.js"></script>
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">

</head>
<body class="contentbodymargin" scroll="auto">

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
  <tr>
  	<%
  	ResourceManager resManager = new ResourceManager();
	String resId = resManager.getGlobalResourceid(AccessControl.ORGUNIT_RESOURCE);
	if (resId != null && !resId.equals("") && accessControl.checkPermission(resId,
					"addorg", AccessControl.ORGUNIT_RESOURCE))
	{   
		//ֻ��admin�ſ����½�һ������֯ 
		//baowen.liu 2008-4-23
		//if("1".equals(accessControl.getUserID())) {
	  	%>
	    <td align="center"><a href="#" onclick="neworg()">��������</a></td>
	   	<%
	   	//}
   	}
   	%>   	
  </tr>
</table>
    <table >
        <tr><td align="left">
         <tree:tree tree="org_tree"
    	           node="org_tree.node"
    	           imageFolder="../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="org_userlist.jsp" 
    			   target="org_userlist" 
    			   mode="static-dynamic"
    			   > 
    			    
    			   <tree:treedata treetype="CMSOrgChargeTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="������"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   enablecontextmenu="false" 
    	                   />
					
    	</tree:tree>
         </td></tr>
    </table>
<script language="javascript">
</script>

</body>
</html>