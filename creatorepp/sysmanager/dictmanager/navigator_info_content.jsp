<%@ include file="../include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	String selectNode = "";
	selectNode = request.getParameter("did")==null?"":request.getParameter("did");
%>

<html>
<head>
<title>字典管理</title>

<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<script language="javaScript" src="js/dictTreeQuery.js"></script>
<script type="text/javascript" language="JavaScript">
	function refreshDict(dictId){
		document.dictForm.action = "refreshDict.jsp?dictId=" + dictId;
		document.dictForm.target = "hiddenFrame";
		document.dictForm.submit();
	}
</script>

</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
<form action="" name="dictForm" target="hiddenFrame" method="post">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
		<tr>
			<td>
				<div align="center">
					<%
					if(accessControl.isAdmin()){
					%>
					<a href="newDict.jsp" target="base_properties_content">新增字典</a>
					<%	
					}else{
						ResourceManager resManager = new ResourceManager();
						String resId = resManager.getGlobalResourceid(AccessControl.DICT_RESOURCE);
						if (resId != null && !resId.equals("") && accessControl.checkPermission(resId,
	       							"add", AccessControl.DICT_RESOURCE))
						{
					%>
					<a href="newDict.jsp" target="base_properties_content">新增字典</a>
					<%
						}
					}
					%>
					</div>
			</td>
		</tr>
		<tr>
			<td align="left">
			<input name="blurryValue" type="text" onpropertychange="onBlurryQueryChange()" onkeydown="enterKeydowngo()"/>
			
			</td>
			
			
		</tr>
		<tr>
		<td align="right">
			<input type="button" name="queryBtn" value="查询" onclick="blurryQuary()"  class="input">
			<input style="display:none" name="nextBtn" type="button" value="查找下一个" onclick="nextNodes()" class="input">
			</td>
		</tr>
	</table>
    <table>
        <tr><td>
         <tree:tree tree="dict_tree"
    	           node="dict_tree.node"
    	           imageFolder="../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"    			   
    			   href="properties_info_toolbar.jsp"    			   
    			   target="base_properties_toolbar"
    			   dynamic="false"
    			   >                                            

    			   <tree:treedata treetype="com.chinacreator.dictionary.DictTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="字典类型"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   enablecontextmenu="true"
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
    </form>
</div>
</body>
<script>
    var obj;
    if("<%=selectNode%>"!=""){	 
	    document.all.item("<%=selectNode%>").className = "selectedTextAnchor";
	    selectNode = "<%=selectNode%>";
    } 
</script>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>
