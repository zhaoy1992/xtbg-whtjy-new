<% 
  response.setHeader("Cache-Control", "no-cache"); 
  response.setHeader("Pragma", "no-cache"); 
  response.setDateHeader("Expires", -1);  
  response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
/**
 * 
 * <p>Title: 选择字典</p>
 *
 * <p>Description: 选择字典</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-11-4
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accessControl = AccessControl.getInstance();
	if(!accessControl.checkManagerAccess(request, response)){
		return;
	}
%>

<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	<script type="text/javascript" language="Javascript">
		function okadd(){	
			selectNode = document.all.item("dictresid");
		
			if(selectNode==null){
 				alert("请选择菜单"); return;
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
 				alert("请选择菜单"); return;
 			}    
			window.returnValue = ret;   
			window.close();
		}
	
	</script>
</head>

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
    <tr>
    	<td><input name="dictresid" type="radio" value="globaldict:globaldict:global"/> 字典全局资源</td>
    	</tr>
    
        <tr><td>
         <tree:tree tree="selectmenunode"
    	           node="selectmenunode.node"
    	           imageFolder="../../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href=""
    			   target="abc"
    			   mode="static-dynamic">  			                           
				   <tree:radio name="dictresid"/>
				   
				   <tree:param name="restypeId" />
				   
    			   <tree:treedata treetype="com.chinacreator.sysmgrcore.purviewmanager.menu.ResSelectDictTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="字典树"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
</div>
</body>

</html>