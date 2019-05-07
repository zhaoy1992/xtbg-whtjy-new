

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ include file="../base/scripts/panes.jsp"%>
<%@page import="com.frameworkset.util.StringUtil"%>

<%

%>
<SCRIPT LANGUAGE="JavaScript"> 
	function okadd(){	
		selectNode = document.all.item("userinfo");
		
	if(selectNode==null){
 		alert("请选择角色"); return;
 	}    
 	var ret ;
 	
 	if(selectNode.length)
 	{
 		for(var i = 0;  i < selectNode.length; i ++)
 		{
 			if(selectNode[i].checked)
 			{
 				ret = selectNode[i].value;
 			}
 			
 		}
 	}
 	else if(selectNode)
 	{
 		if(selectNode.checked)
		{
			ret = selectNode.value;
		}
 	}
 	if(!ret)
 	{
 		alert("请选择角色"); return;
 	}    
	window.returnValue = ret;   
	window.close();
	}
	
	
</SCRIPT>
<head>    
  <title>请选择角色</title>


<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">   
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin"  scroll="no">
<div align="center">
<tr>
<td>
<input name="add" type="button" class="input" value="确定" onclick="okadd()" >
    <input name="exit" type="button" class="input" value="取消" onclick="parent.window.close();">
</td>
</tr>
</DIV>
<div id="contentborder" style="width:100%;height:495;overflow:auto">

    <table >
        <tr><td>
         <tree:tree tree="org_tree_tran"
    	           node="org_tree_tran.node"
    	           imageFolder="/sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href=""
    			   target="abc"
    			   dynamic="false">  			                           
				   <tree:radio name="userinfo"/>
				   
    			   <tree:treedata treetype="com.chinacreator.menu.ChargeRoleTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="角色树"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
</div>
 

 
</body>