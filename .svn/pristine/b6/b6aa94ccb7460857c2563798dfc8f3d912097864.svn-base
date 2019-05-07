<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>

<%@page import="com.frameworkset.util.StringUtil"%>

<%
	String defaultValue = request.getParameter("defaultValue");
	if(defaultValue == null)
		defaultValue = "";
%>
<SCRIPT LANGUAGE="JavaScript"> 
	function okadd(){	
		selectNode = document.all.item("jobinfo");
		
	if(selectNode==null){
 		alert("请选择机构和岗位"); return;
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
 		alert("请选择机构和岗位"); return;
 	}    
 	
	var temps = ret.split("$");
	var ids  = temps[0].split(":");
	var names  = temps[1].split(":");	
	var orgid = ids[0];
	var orgname = names[0];
	var jobid = ids[1];
	var jobname = names[1];
	     
	window.returnValue = orgname + ":" + jobname + "," + orgid + ":" + jobid;   
	window.close();
	
	}
	
	
</SCRIPT>
<head>    
  <title>请选择机构和岗位</title>


<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">

 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin"  scroll="no">
<div align="center">
<tr>
<td>
<input name="add" type="button" class="input" value="确定" onclick="okadd()" >
<input name="exit" type="button" class="input" value="取消" onclick="parent.window.close();">
</td>
</tr>
</div>
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
    			   mode="static-dynamic">  
    			   <tree:param name="defaultValue"/>
    			   <tree:param name="displayNameInput"/>
    			   <tree:param name="displayNameInput1"/>
    			   <tree:param name="displayValueInput"/>
    			   <tree:param name="displayValueInput1"/>    			                           
				   <tree:radio name="jobinfo" defaultValue="<%=defaultValue%>"/>
				   
    			   <tree:treedata treetype="com.chinacreator.menu.ChargeOrgJobTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="机构岗位树"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
</div>
 

 
</body>