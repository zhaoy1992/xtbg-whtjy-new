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


function goResourceList()
{
	var restypeId = getPropertiesContent().document.all.item("restypeId");
	
	var temp = "";
	
	if(!restypeId)
	{
		alert("��ѡ����Դ��");
		return;
	}
	if(restypeId.length)
	{
		temp = restypeId[0]; 
	}
	else
	{
		temp = restypeId; 
	}
	
	var resTypeName = getPropertiesContent().document.all.item("resTypeName");

	getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/reslist.jsp?restypeId="+temp.value+ "&restypeName="+resTypeName.value;		

}
function authorResource()
{
	

	var restypeId = getPropertiesContent().document.all.item("restypeId");
	
	if(!restypeId)
	{
		alert("��ѡ����Դ��");
		return;
	}
	var resId = getPropertiesContent().document.all.item("checkBoxOne");
	var resTypeName = getPropertiesContent().document.all.item("resTypeName");
	var title = getPropertiesContent().document.all.item("title");
	if(!resId)
	{
		
		return;
	}
	if(!resId.length )
	{
		if(!resId.checked)
		{
			alert("��ѡ��Ҫ��Ȩ����Դ��");
			return;
		}
		//��Ȩ
		getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/hasPower_ajax.jsp?resId2="+resId.value+"&resTypeId2="+restypeId.value+"&resTypeName="+resTypeName.value+"&title="+title.value;
	}
	
	if(resId.length)
	{
		
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < resId.length; i ++)
		{
			if(!resId[i].checked)
			{
				continue;
			}
			else
			{				
				count ++;
				index = i;
			}
		}
		if(count == 0)
		{
			alert("��ѡ��Ҫ��Ȩ����Դ��");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/hasPower_ajax.jsp?resId2="+resId[index].value+"&resTypeId2="+restypeId.value+"&resTypeName="+resTypeName.value+"&title="+title[index].value;
			
		}
		else
		{
			alert("ֻ��ѡ��һ����Դ������Ȩ��");
			return;
		}
		
	}
	
		
	
}

var resId="<%=resId%>"; 
var restypeId="<%=restypeId%>";
var resTypeName="<%=resTypeName%>";
var title = "<%=title%>";
if(resId!=""){
		getPropertiesContent().location.href="<%=rootpath%>/sysmanager/resmanager/reslist.jsp?restypeId="+restypeId+ "&restypeName=<%=restypeName%>";
	}
	



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
	
	

</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">


<table width="100%" cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25><img
			class="normal" src="../images/actions.gif"></td>
		<td valign="middle"
			align="left" nowrap class="text">ҵ�����</td>
		<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle"
			align="right" width="*" nowrap class="text">
		<table cellpadding=0 cellspacing=0 border=0>
		<tr>
			<%
			 if (accessControl.checkPermission(restypeId,
                       AccessControl.WRITE_PERMISSION, AccessControl.RES_RESOURCE))
            {%>
			<td class=normal name="tool2" id="tools2" title="��Դ�б�" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="goResourceList()"><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="��Դ�б�" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��Դ�б�&nbsp;</td></tr></table></td>
			<%}%>			
<!--------------------------------------------------------------------------------------------------------------			-->
			<%
			 if (accessControl.checkPermission(restypeId,
                       "respermissionset", AccessControl.RES_RESOURCE))
            {%>
			<td class=normal name="tool1" id="tools1" title="��Դ������Ȩ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="authorResource()"><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="��Դ������Ȩ" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��Դ������Ȩ&nbsp;</td></tr></table></td>			
			<%}%>                       
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>

</body>
</html>
