<%@ include file="../include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	
	String dicttype_type = request.getParameter("dicttype_type");
	if(dicttype_type == null 
		|| (!dicttype_type.equals("0")&&!dicttype_type.equals("1")&&!dicttype_type.equals("2")))
	{
		dicttype_type = "-1";
	}
%>

<html>
<head>
<title>字典管理</title>

<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<script type="text/javascript" src="js/dictTreeQuery.js"></script>

</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<form action="" name="Form1" target="hiddenFrame">
<div id="contentborder">
    <table>
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
    	           collapse="false"
    			   includeRootNode="true"    			   
    			   href="properties_content_toolbar.jsp"    			   
    			   target="base_properties_toolbar"
    			   dynamic="false"
    			   >         
    			   
    			   <tree:param name="dicttype_type" value="<%=dicttype_type%>" />
					
    			   <tree:treedata treetype="com.chinacreator.dictionary.DictTreeForData"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="字典类型"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
</div>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
