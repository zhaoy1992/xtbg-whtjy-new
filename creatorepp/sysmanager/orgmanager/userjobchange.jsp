<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.OrgJobAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
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
		String jobId = request.getParameter("jobId");
		String orgId = request.getParameter("orgId");
		String jobSn = request.getParameter("jobSn");
		String auserId = request.getParameter("auserId");
		String userIds = request.getParameter("userId");
		String[] userList = null;
		if(userIds != null && userIds.length() > 0){
			userList = userIds.split(",");
		}
		
		String userNames_log = LogGetNameById.getUserNamesByUserIds(userList);
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);	
		//ɾ��
	
				
		if(userList!= null && userList.length > 0){	
			//--�û������д������־	
			operContent="�ӻ�����֯ɾ��ϵ���û�,������"+orgName_log+" �û���"+userNames_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
			//--	end	 --	
			out.print(OrgJobAction.deleteUserOrgJob(orgId, jobId,userList));		
		}
		//���
		else{
			//--�û������д������־	
			operContent="���ϵ���û���������֯,������"+orgName_log+" �û���"+userNames_log; 					
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
			//--	end	 --	
			out.print(OrgJobAction.storeUserOrgJob(orgId, jobId,auserId,jobSn));
		}
	
%>
