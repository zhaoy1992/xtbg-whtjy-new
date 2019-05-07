<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl
				,com.chinacreator.config.ConfigManager"%>
<%
			AccessControl accessControl = AccessControl.getInstance();
			accessControl.checkAccess(pageContext);

			String groupId = (String) request.getParameter("groupId");			
			if(groupId == null)	
				groupId = "";
%>
<html>
	<head>
		<title>��������������</title>
		<link rel="stylesheet" type="text/css" href="../css/toolbar.css">
			<script language="javascript" src="../scripts/toolbar.js"></script>
		<script language="javascript">
		var groupId= "<%=groupId%>";
				 
		if(groupId != ""){
			getPropertiesContent().location.href="<%=rootpath%>/sysmanager/groupmanager/groupInfo.jsp?groupId="+groupId;	
		}else{
			getPropertiesContent().location.href="<%=rootpath%>/sysmanager/groupmanager/groupInfo.jsp";
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
	
	function bussinessAction(action){	 
		if(groupId == null || groupId == "")
		{
			alert("��ѡ���û��飡");
			return;
		}
	
		if (action == 1 && getPropertiesContent()) {
			
			getPropertiesContent().location.href="groupInfo.jsp?groupId=" + groupId;	
		}
		if (action == 2 && getPropertiesContent()) {
			getPropertiesContent().location.href="changeRole_ajax.jsp?groupId=" + groupId;	
		}
		if (action == 3 && getPropertiesContent()) {
			getPropertiesContent().location.href="group2user.jsp?groupId=" + groupId;	
			//getPropertiesContent().location.href="../../groupmanager.do?method=getExistList";
		}					
		
	}
</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
		<div id="toolbarborder">
			<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
				<table width="100%"  cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td valign="middle" align="center" width=25 >
							<img class="normal" src="../images/actions.gif">
						</td>
						<td valign="middle" align="left"  nowrap class="text">
							����
						</td>
						<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����"  title="˫�����" valign="middle" align="right" width="*"  nowrap class="text">
							<table  cellpadding=0 cellspacing=0 border=0>
									<%
									 if (accessControl.checkPermission(groupId,
						                       AccessControl.WRITE_PERMISSION, AccessControl.GROUP_RESOURCE))
						            {%>
									<td class=normal name="tool1" id="tools1" title="�û��������Ϣ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(1)">
									<table border=0 cellPadding=0 cellSpacing=0 class="text">
									  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="�û��������Ϣ" width=16 height=16 border=0 class="normal">
									  </td><td valign=center>&nbsp;�û��������Ϣ&nbsp;</td></tr>
									  </table>
									</td>
								<%}%>
								
								
									<%
									 if (accessControl.checkPermission(groupId,
						                       "roleset", AccessControl.GROUP_RESOURCE)
						                       && ConfigManager.getInstance().getConfigBooleanValue("enablergrouprole", true))
						            {%>
									<td class=normal name="tool1" id="tools1" title="������ɫ�޸�" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(2)">
									<table border=0 cellPadding=0 cellSpacing=0 class="text">
									  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="������ɫ�޸�" width=16 height=16 border=0 class="normal">
									  </td><td valign=center>&nbsp;������ɫ�޸�&nbsp;</td></tr>
									  </table>
									</td>
								<%}%>
								
									<%
									 if (accessControl.checkPermission(groupId,
						                       "adduser", AccessControl.GROUP_RESOURCE))
						            {%>
									<td class=normal name="tool1" id="tools1" title="��������û�" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(3)">
									<table border=0 cellPadding=0 cellSpacing=0 class="text">
									  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="��������û�" width=16 height=16 border=0 class="normal">
									  </td><td valign=center>&nbsp;��������û�&nbsp;</td></tr>
									  </table>
									</td>
								<%}%>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>
