<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.UserManagerImpl"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.OrgJobAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%
	
		//---------------START--�û������д������־
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
        UserManagerImpl uimpl = new UserManagerImpl();
        
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��������";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 		
		//---------------END
		String jobId = request.getParameter("jobId");
		String userId1 = request.getParameter("userId1");
		String userId2 = request.getParameter("userId2");
		String orgId = request.getParameter("orgId");
		String jobSn = request.getParameter("jobSn");
		String userSn = request.getParameter("userSn");
	
		//upall or downall
		String userId3 = request.getParameter("userId");		
		String[] userId = null;
		if(userId3 != null && userId3.length() >0){
			userId = userId3.split(",");
		}
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
		String userNames_log = LogGetNameById.getUserNamesByUserIds(userId);
		
		if(userId != null && userId.length > 0)
		{
			//--�û������д������־	
			operContent="���ϵ���û���������֯,������"+orgName_log+" �û���"+userNames_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
			//--	end	 --	
			out.print(uimpl.storeAllUserSnJobOrg(orgId,jobId,jobSn,userId));
		}else{
			//--�û������д������־	
			operContent="�޸Ļ����¸�λ������,������ţ�"+orgName_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
			//--	end	 --	
			out.print(OrgJobAction.storeUserSnJobOrg(orgId, jobId, jobSn,userId1, userId2, userSn));
		}
%>
