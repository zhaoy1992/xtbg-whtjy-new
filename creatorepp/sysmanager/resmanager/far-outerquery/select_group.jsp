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
 * <p>Title: 选择用户组</p>
 *
 * <p>Description: 选择用户组</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2009-02-04
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
			selectNode = document.all.item("groupresid");
		
			if(selectNode==null){
 				alert("请选择！"); return;
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
 				alert("请选择！"); return;
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
    	<td><input name="groupresid" type="radio" value="groupmanager:groupmanager:global"/> 用户组全局资源</td>
    	</tr>
    </table>
</div>
</body>

</html>