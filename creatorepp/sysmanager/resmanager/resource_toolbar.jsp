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
String parent_resId = request.getParameter("parent_resId");
String parent_resName = request.getParameter("parent_resName");
	
if(restypeId == null)
	restypeId = "";

if(resId==null)resId="";

//���������Ĳ���
String resId2 = request.getParameter("resId2");
String resTypeId2 = request.getParameter("resTypeId2");
if(resId2==null)resId2="";
if(resTypeId2==null)resTypeId2="";
//����Դ�б�����Ĳ���
String resTypeName = request.getParameter("resTypeName");
String title = request.getParameter("title");
%>
<html>
<head>
<title>��������������</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">

<script language="javascript" src="../scripts/toolbar.js"></script>
<script language="javascript">
var resId="<%=resId%>"; 
var restypeId="<%=restypeId%>";
var resTypeName="<%=resTypeName%>";
var title = "<%=title%>";
if(resId!="")
	
	getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/subreslist.jsp?restypeId="+restypeId+ "&restypeName=<%=restypeName%>&parent_resId=<%=parent_resId%>&parent_resName=<%=parent_resName%>";			


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
				getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/subreslist.jsp?restypeId="+resTypeId2+ "&restypeName="+resTypeName + "&parent_resId=<%=parent_resId%>&parent_resName=<%=parent_resName%>";			
	    	}		   
	   	}
	}

</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">

<table width="100%"  cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 ><img
			class="normal" src="../images/actions.gif"></td>
		<td valign="middle"
			align="left"  nowrap class="text">ҵ�����</td>
		<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle"
			align="right" width="*"  nowrap class="text">
		<table  cellpadding=0 cellspacing=0 border=0>
		<tr>
			<%
			 if (accessControl.checkPermission("resconfer",
                       AccessControl.READ_PERMISSION, AccessControl.RES_RESOURCE))
            {%>
			<td class=normal name="tool2" id="tools2" title="��Դ�б�" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(2)" ><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="��Դ�б�" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��Դ�б�&nbsp;</td></tr></table></td>
			<%}%>
			
			<%
			 if (accessControl.checkPermission("resconfer",
                       AccessControl.READ_PERMISSION, AccessControl.RES_RESOURCE))
            {%>
			<td class=normal name="tool1" id="tools1" title="��Դ������Ȩ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(1)" ><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="��Դ������Ȩ" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��Դ������Ȩ&nbsp;</td></tr></table></td>			
			<%}%>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
