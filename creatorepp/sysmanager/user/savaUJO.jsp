<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.UserManagerAction,com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.UserJobManagerAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%

		//---------------START--
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="�û�����";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 		
		//---------------END
		
		String uid = request.getParameter("uid");
		String orgId = request.getParameter("orgId1");
		String jobId = request.getParameter("jobId");
		String flag = request.getParameter("flag");
		if(jobId!=null){
			String jobIds[] =StringUtil.split(jobId,"\\,");
			String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
			String userName_log = LogGetNameById.getUserNameByUserId(uid);
			String jobNames_log = LogGetNameById.getJobNamesByJobIds(jobIds);
			UserManager userManager = SecurityDatabase.getUserManager();
			if(flag.equals("1")){
				//--
				operContent="�����Ա: "+userName_log+"��λ: "+jobNames_log+" �ͻ���: "+orgName_log+"�Ĺ�ϵ"; 
				description="";
				logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
				//--	end	 --
				//UserJobManagerAction.storeUJOAjax(uid,jobIds,orgId);		
				
				userManager.storeUJOAjax(uid, jobIds, orgId);					
			}	
			if(flag.equals("0")){
				//--
				operContent="ɾ����Ա��"+userName_log+"��λ: "+jobNames_log+" �ͻ���: "+orgName_log+"�Ĺ�ϵ"; 
				description="";
				logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
				//--	end	 --
				//UserJobManagerAction.deleteUJOAjax(uid,jobIds,orgId);
				//userManager.storeUJOAjax(uid, jobIds, orgId);					
				userManager.deleteUJOAjax(uid,jobIds,orgId);
			
			}
		}
	
    

%>

<script language="javascript">
	parent.divProcessing.style.display = "none";
</script>