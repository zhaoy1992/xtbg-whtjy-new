<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.OrgManAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%	
	//---------------START--�û������д������־
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	String operContent="";        
    String operSource=control.getMachinedID();
    String openModle="��������";
    String userName = control.getUserName();
    String description="";
    LogManager logManager = SecurityDatabase.getLogManager(); 		
	//---------------END		
	String orgId = request.getParameter("orgId");
	String roleIds = request.getParameter("roleId");
	String[] arrrole = roleIds.split(",");		
	String flag = request.getParameter("flag");
	for(int i=0;i<arrrole.length;i++){
	    String roleId = arrrole[i];
		//--�û������д������־		
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
		String roleName_log = LogGetNameById.getRoleNameByRoleId(roleId);
		operContent="ɾ�������Ľ�ɫ,����:"+orgName_log+" ��ɫ��"+roleName_log; 						
		description="";
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
		//--	end	 --	
		
	}	
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	orgManager.deleteOrgrole(orgId,arrrole,flag);
%>
<script>
    window.onload = function prompt(){
        //alert("�����ɹ�!");
        parent.divProcessing.style.display="none";
    }
</script>
