<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>


<%
String groupId = (String)request.getParameter("groupId");
//String uid = (String)session.getAttribute("currUserId");
%>
<html>
<head>
<title>操作容器工具栏</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">
<jsp:include page="../base/scripts/panes.jsp" />
<script language="javascript" src="../scripts/toolbar.js"></script>
<script language="javascript">

var groupId="<%=groupId%>";

getPropertiesContent().location.href="<%=rootpath%>/sysmanager/opermanager/infoFrame.jsp?groupId="+groupId;

	function getElementByName(eName){
		var elements = document.body.all;
		for(i = 0;i< elements.length;i++){
           if (elements[i].name==eName) return elements[i];
		}
		return null;
	}
	function selectTool(toolName) {
	    var tool=getElementByName(toolName);
		if (tool) {
		    tool.onclick();
		}
	}
	
	function bussinessAction(action){	 
		 
		if(groupId!=""){ 		
	    	if(action == 1 && getPropertiesContent()){	      
				getPropertiesContent().location.href="<%=rootpath%>/sysmanager/opermanager/operManager.do?method=getGroupAndopList"+"&groupId="+groupId;
	    	}	   
    	}
	}
	
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">

<table width="100%" height=25 cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 height=25><img
			class="normal" src="../images/actions.gif"></td>
		<td valign="middle"
			align="left" height=25 nowrap class="text">业务操作</td>
		<td id="doubleclickcolumn" recover="双击恢复" maxtitle="双击最大化" title="双击最大化" valign="middle"
			align="right" width="*" height=25 nowrap class="text">
		<table height=25 cellpadding=0 cellspacing=0 border=0>
	

		</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>