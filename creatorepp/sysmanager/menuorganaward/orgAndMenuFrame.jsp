
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%><%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String idString = request.getParameter("idString");
	String type = request.getParameter("type");
	
	//��ǰ�û��Ƿ�ӵ�г�������ԱȨ���벿�Ź���ԱȨ��
	boolean isAdminOrOrgManager = false;
	//�Ƿ��ǹ���Ա
	boolean isOrgManager = new OrgAdministratorImpl().isOrgManager(accesscontroler.getUserID());
	boolean isAdmin = accesscontroler.isAdmin();
	if(isAdmin || isOrgManager){
		isAdminOrOrgManager = true;
	}
%>
<html>
<head>
<title>��Դ������ɼ���������</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<%if(isAdminOrOrgManager){ %>
<frameset name="urFrame" id="urFrame" value="" cols="50%,*" border="1" framespacing="2" >
	<frameset name="saveOrgFrame" rows="11%,*" border="0" framespacing="0">
		<frame src="saveOrgGrant.jsp" name="saveOrgGrant" id="saveOrgGrant" marginWidth=0 marginHeight=0 />
		<frame src="orgChooseTree.jsp?idString=<%=idString%>&type=<%=type%>" name="orgChooseTree" id="orgChooseTree" marginWidth=0 marginHeight=0 />
	</frameset>
	<frameset name="saveMenuFrame" rows="11%,*" border="0" framespacing="0">
		<frame src="saveMenuGrant.jsp" name="saveMenuGrant" id="saveMenuGrant" marginWidth=0 marginHeight=0 />
		<frame src="menuTree.jsp?idString=<%=idString%>&type=<%=type%>" name="menuTree" id="menuTree" marginWidth=0 marginHeight=0 />
	</frameset>
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
<%}else{ %>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<div align="center">û��Ȩ�ޣ�����ϵͳ����Ա��ϵ</div>
</body>
<%} %>
</html>
