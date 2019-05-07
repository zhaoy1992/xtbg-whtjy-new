<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);

String resId = request.getParameter("selected");
String restypeId = request.getParameter("restypeId");
String restypeName=request.getParameter("restypeName");

if(restypeId == null)
	restypeId = "";

if(resId==null)resId="";

//单击产生的参数
String resId2 = request.getParameter("resId2");
String resTypeId2 = request.getParameter("resTypeId2");
if(resId2==null)resId2="";
if(resTypeId2==null)resTypeId2="";
//从资源列表过来的参数
String resTypeName = request.getParameter("resTypeName");
String title = request.getParameter("title");
%>
<html>
<head>
<title>操作容器工具栏</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">

<script language="javascript" src="../scripts/toolbar.js"></script>
<script language="javascript">
var resId="<%=resId%>";
var restypeId="<%=restypeId%>";
var resTypeName="<%=resTypeName%>";
var title = "<%=title%>";
if(resId!="")

	getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/reslist.jsp?restypeId="+restypeId+ "&restypeName=<%=restypeName%>";


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
		var resId2 = "<%=resId2%>";
		var resTypeId2 = "<%=resTypeId2%>";
		if(resId2!="" && resTypeId2!= ""){
	    	if(action == 1 && getPropertiesContent()){
				//getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/hasPower.jsp?resId2="+resId2+"&resTypeId2="+resTypeId2;
				getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/hasPower_ajax.jsp?resId2="+resId2+"&resTypeId2="+resTypeId2+"&resTypeName="+resTypeName+"&title="+title;
	    	}
	    	if(action == 2 && getPropertiesContent()){
				getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/reslist.jsp?restypeId="+resTypeId2+ "&restypeName="+resTypeName;
	    	}

            if(action == 3 && getPropertiesContent()){
				getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/restypelist.jsp?restypeId="+resTypeId2+ "&restypeName="+resTypeName;
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
		<tr>

			<%
			 if (accessControl.checkPermission("resconfer",
                       AccessControl.READ_PERMISSION, AccessControl.RES_RESOURCE))
            {%>
			<td class=normal name="tool2" id="tools2" title="资源列表" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(2)" height=25><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="资源列表" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;资源列表&nbsp;</td></tr></table></td>
			<%}%>

			<%
			 if (accessControl.checkPermission("resconfer",
                       AccessControl.READ_PERMISSION, AccessControl.RES_RESOURCE))
            {%>
			<td class=normal name="tool1" id="tools1" title="资源访问授权" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(1)" height=25><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="资源访问授权" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;资源访问授权&nbsp;</td></tr></table></td>
			<%}%>
            <td class=normal name="tool2" id="tools2" title="资源类型" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(3)" height=25><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="资源列表" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;资源类型&nbsp;</td></tr></table></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
