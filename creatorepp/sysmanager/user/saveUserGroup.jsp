<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.UserGroupManagerAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
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
		//Integer uid = (Integer) session.getAttribute("currUserId");
		String userId = request.getParameter("userId");
		Integer uid = Integer.valueOf(userId);
		String groupId = request.getParameter("groupId");
		String flag = request.getParameter("flag");
		if(groupId!=null){
		    UserManager userManager = SecurityDatabase.getUserManager();
			String groupIds[] =groupId.split("\\,") ;
			String userName_log = LogGetNameById.getUserNameByUserId(userId);
			String groupNames_Log = LogGetNameById.getGroupNamesByGroupIds(groupIds);
			if(flag.equals("1")){
				//--
				operContent="����û���"+userName_log+" ���飺"+groupNames_Log;					
				description="";
				logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
				//--	end	 --
				userManager.addUsergroup(uid,groupIds);		
			}
			if(flag.equals("0")){
				//--
				operContent="ɾ���û���"+userName_log+" ���飺"+groupNames_Log;					
				description="";
				logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
				//--	end	 --
				userManager.deleteUsergroup(uid,groupIds);	

			}
		 }	
%>

<script>
    window.onload = function prompt(){
        //alert("�����ɹ�!");
        parent.divProcessing.style.display="none";
    }
</script>