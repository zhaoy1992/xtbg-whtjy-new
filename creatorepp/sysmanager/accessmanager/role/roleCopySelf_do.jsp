<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role" %>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.manager.LogManager"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	String operContent="";        
    String operSource=control.getMachinedID();
    String openModle="��ɫ����";
    String userName = control.getUserName();
    String description="";
    LogManager logManager = SecurityDatabase.getLogManager(); 		
	//---------------END
    
	String rolecopyId = request.getParameter("rolecopyId");
	String checks = request.getParameter("checks");
	String roleName = request.getParameter("roleName");
	String[] id = checks.split(",");
	request.setAttribute("roleId", rolecopyId);
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	boolean state = roleManager.copyResOfRoleSelf(rolecopyId,id);
	//--��ɫ����д������־	
	operContent="���ƽ�ɫ: "+	roleName;			
	description="";
	logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);
%>

<script language="javascript">
<%if(state){%>
	alert("����Ȩ�޳ɹ���");
	parent.window.location.href=parent.window.location.href;
<%}else{%>
	alert("����Ȩ��ʧ�ܣ�");
<%}%>
</script>