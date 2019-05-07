<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<% 
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response);
	//��ǰ�û��Ƿ�ӵ�г�������ԱȨ���벿�Ź���ԱȨ��
	boolean isAdminOrOrgManager = false;
	//�Ƿ��ǹ���Ա
	boolean isOrgManager = new OrgAdministratorImpl().isOrgManager(accessControl.getUserID());
	boolean isAdmin = accessControl.isAdmin();
	if(isAdmin || isOrgManager){
		isAdminOrOrgManager = true;
	}
%>
<html>
<head>
<title>��Դ������ɼ���������</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<SCRIPT type="text/javascript">
	function chooseUR(){
		var v = document.all("choose").value;
		var type = "";
		if(v=="1"){
			type = "user";
			userOrRoleFrame.location.href = "orgByUserFrame.jsp?";
		}else{
			type = "role";
			userOrRoleFrame.location.href = "roleList.jsp";
		}
		getPropertiesContent().document.frames.saveOrgGrant.location.href="saveOrgGrant.jsp?type="+type;
		getPropertiesContent().document.frames.orgChooseTree.location.href="orgChooseTree.jsp?type="+type;
		getPropertiesContent().document.frames.saveMenuGrant.location.href="saveMenuGrant.jsp?type="+type;
		getPropertiesContent().document.frames.menuTree.location.href="menuTree.jsp?type="+type;
	}
</SCRIPT>
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  scroll="no">
<%if(isAdminOrOrgManager){ %>
	<form action="" target="userOrRoleFrame" method="post" name="chooseForm">
		<table cellspacing="0" id="table2" cellpadding="0" border="0" width="100%">
			<tr>
				<td width="50%">
				 	��ѡ��Ҫ����Ķ���:
				</td>
				<td>
					<select id="choose" name="choose" onchange="chooseUR()" style="width: 100px">
						<option value="1" selected>�û�</option>
						<option value="2">��ɫ</option>
					</select>
				</td>
			</tr>
		</table>
	</form>
	<iframe src="orgByUserFrame.jsp" width="100%" height="100%"
	 marginWidth=0 marginHeight=0 id="userOrRoleFrame" />
<%}else{ %>
<div align="center">û��Ȩ�ޣ�</div>
<%} %>
</body>
</html>

