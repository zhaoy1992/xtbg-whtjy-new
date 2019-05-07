<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>

<%@ page import="com.chinacreator.security.AccessControl
				,com.chinacreator.config.ConfigManager"%>
<%

AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);


String orgid = request.getParameter("selected");
String resName = request.getParameter("resName");


if(orgid==null)orgid="";

//��ǰ�û��Ƿ�ӵ�г�������ԱȨ���벿�Ź���ԱȨ��
boolean isAdminOrOrgManager = false;
//�Ƿ��ǹ���Ա
boolean isOrgManager = new com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl().isOrgManager(accessControl.getUserID());
boolean isAdmin = accessControl.isAdmin();
if(isAdmin || isOrgManager){
	isAdminOrOrgManager = true;
}


%>
<html>
<head>
<title>��������������</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">


<script language="javascript" src="../scripts/toolbar.js"></script>
<script language="javascript">
var orgid="<%=orgid%>";
var resName ="<%=resName%>";
	if(orgid!="")
		getPropertiesContent().location.href="<%=rootpath%>/orgmanager/org.do?method=getOrgInfo&orgId="+orgid;
	if(orgid=="0")
		getPropertiesContent().location.href="<%=rootpath%>/sysmanager/orgmanager/new_org.jsp";

	//else
	//getPropertiesContent().location.href="<%=rootpath%>/sysmanager/orgmanager/organsearch.jsp";

	//if(resName==null || resName=="null"){
	//	getPropertiesContent().location.href="<%=rootpath%>/sysmanager/orgmanager/new_org.jsp";
	//}
	    


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
	
		if(orgid==""){
			alert("���ڻ�������ѡ����Ҫ�����Ļ���!");
			//getPropertiesContent().location.href="../orgmanager/noorg.jsp";
			
			return;       
		}
		
		if(orgid!=""){
	    if(action == 1 && getPropertiesContent()){
			getPropertiesContent().location.href="<%=rootpath%>/orgmanager/org.do?method=getOrgInfo&orgId="+orgid+"&resName="+resName;
	    }
	    else if(action == 2&& getPropertiesContent()){
			getPropertiesContent().location.href="<%=rootpath%>/orgmanager/orgoperjob.do?method=showOrgallJob&orgId="+orgid;
	    }

	    else if(action == 3&& getPropertiesContent()){
	       getPropertiesContent().location.href="<%=rootpath%>/sysmanager/orgmanager/orgsubuserlist.jsp?orgId="+orgid;
	    }
		else if(action == 4&& getPropertiesContent()){
	        getPropertiesContent().location.href="<%=rootpath%>/sysmanager/orgmanager/suborglist.jsp?orgId="+orgid;
	    }
	    else if(action == 5&& getPropertiesContent()){
	        getPropertiesContent().location.href="<%=rootpath%>/createMail.do?method=getUserList&orgId="+orgid;
	    }
	    else if(action == 6&& getPropertiesContent()){
	        getPropertiesContent().location.href="<%=rootpath%>/orgmanager/orgrole.do?method=getRoleList&orgId="+orgid;
	    }
	     else if(action == 7&& getPropertiesContent()){
	        getPropertiesContent().location.href="<%=rootpath%>/sysmanager/orgmanager/change2job.jsp?orgId="+orgid;
	    }
	    else if(action == 8){
			window.showModalDialog("<%=rootpath%>/sysmanager/orgmanager/orgres_queryframe.jsp?orgId="+
				orgid,"","dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
	    }
	 }


	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
<table width="100%" cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25><img fullscreenrecover="��ԭ" fullscreen="ȫ��" title="ȫ��"
			class="normal" onclick="dofullscreen(<%=Framework.SWITCH_WORKSPACE%>,document.all.doubleclickcolumn);" src="../images/actions.gif"></td>
		<td valign="middle"
			align="left" nowrap class="text">ҵ�����</td>
		<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle"
			align="right" width="*" nowrap class="text">
		<%if(isAdminOrOrgManager){ %>
		<table cellpadding=0 cellspacing=0 border=0>
		<tr>
			<%
			 if (accessControl.checkPermission(orgid,
                       AccessControl.WRITE_PERMISSION, AccessControl.ORGUNIT_RESOURCE))
            {%>
			  <td class=normal name="tool1" id="tools1" title="����������Ϣ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(1)"><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="����������Ϣ" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;����������Ϣ&nbsp;</td></tr></table></td>
			<%}%>
<!----------------------------------------------------------------------------------------------------->

			<%
			 if (accessControl.checkPermission(orgid,
                        "orgjobset", AccessControl.ORGUNIT_RESOURCE)
                        && ConfigManager.getInstance().getConfigBooleanValue("enableorgrole", true))
            {%>
			<td class=normal name="tool2" id="tools2" title="������Դ�б�" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(8)"><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../images/edit.gif" alt="������Դ�б�" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;������Դ�б�&nbsp;</td></tr></table></td>
			<%}%>
<!----------------------------------------------------------------------------------------------------->
			<%
			 if (accessControl.checkPermission(orgid,
                        "orgjobset", AccessControl.ORGUNIT_RESOURCE))
            {%>
			<td class=normal name="tool2" id="tools2" title="��λ����" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(2)"><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../images/edit.gif" alt="��λ����" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��λ����&nbsp;</td></tr></table></td>
			<%}%>
<!----------------------------------------------------------------------------------------------------->


			<%
			 if (accessControl.checkPermission(orgid,
                        "directorgs", AccessControl.ORGUNIT_RESOURCE))
            {%>
			<td class=normal name="tool4" id="tools3" title="ֱ���ӻ���" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(4)"><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="ֱ���ӻ���" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;ֱ���ӻ���&nbsp;</td></tr></table></td>
			<%}%>
<!----------------------------------------------------------------------------------------------------->				

			<%
			 if (accessControl.checkPermission(orgid,
                        "orgroleset", AccessControl.ORGUNIT_RESOURCE)
                        && ConfigManager.getInstance().getConfigBooleanValue("enableorgrole", true))
            {%>
			<td class=normal name="tool5" id="tools5" title="��ɫ����" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(6)"><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../images/edit.gif" alt="��ɫ����" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��ɫ����&nbsp;</td></tr></table></td>
			<%}%>				

			
			</tr>
		</table>
		<%} %>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
