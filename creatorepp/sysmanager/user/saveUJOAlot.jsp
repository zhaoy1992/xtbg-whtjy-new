<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.UserManagerAction,com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.UserJobManagerAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
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
			UserJobManagerAction ujm = new UserJobManagerAction();
			String jobIds[] =StringUtil.split(jobId,"\\,");
			String idso[] = StringUtil.split(uid,"\\,");	
			String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
			String jobNames_log = LogGetNameById.getJobNamesByJobIds(jobIds);
			String userNames_log = LogGetNameById.getUserNamesByUserIds(idso);
			if(flag.equals("1")){
				//--
				operContent="����û�����������λ,�û�:"+userNames_log+"������"+orgName_log+",��λ;"+ jobNames_log;
				description="";
				logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
				//--	end	 --
				
				ujm.storeUJOAjax_batch(idso,jobIds,orgId);
			}	
			if(flag.equals("0")){
				//--
				operContent="�ӻ�������λɾ���û�,�û�:"+userNames_log+"������"+orgName_log+",��λ;"+ jobNames_log;			
				description="";
				logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
				//--	end	 --
				ujm.deleteUJOAjax_batch(idso,jobIds,orgId);	
						
			}
		}
		
    
	
%>