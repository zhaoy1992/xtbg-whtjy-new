<%
/*
 * <p>Title: �����û������û����ҳ��</p>
 * <p>Description: �����û������û����ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%
	
		//---------------START--
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
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
		String orgId = request.getParameter("orgId");
		
		// Ȩ���Ƿ��������
		// ��ʢ 2011-3-15 
		boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
		boolean isSuccess = false;
		
		if(groupId!=null)
		{
		    UserManager userManager = SecurityDatabase.getUserManager();
			String groupIds[] =groupId.split("\\,") ;
			String userName_log = LogGetNameById.getUserNameByUserId(userId);
			String groupNames_Log = LogGetNameById.getGroupNamesByGroupIds(groupIds);
			if(flag.equals("1"))
			{
				//--
				operContent="����û���"+userName_log+" ���飺"+groupNames_Log;					
				description="";
				logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);          
				//--	end	 --
				
				// ��ʢ 2011-3-15 
				if(isrolerelatedorg){
					isSuccess = userManager.addUsergroup(uid,groupIds,orgId);
				}else{
					isSuccess = userManager.addUsergroup(uid,groupIds);
				}				
			}
			
			if(flag.equals("0"))
			{
				//--
				operContent="ɾ���û���"+userName_log+" ���飺"+groupNames_Log;					
				description="";
				logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);          
				//--	end	 --
				
				// ��ʢ 2011-3-15 
				if(isrolerelatedorg){
					isSuccess = userManager.deleteUsergroup(uid,groupIds,orgId);
				}else{
					isSuccess = userManager.deleteUsergroup(uid,groupIds);
				}
			}
		 }	
%>

<script>
    window.onload = function prompt()
    {
        if("true"=="<%=isSuccess%>"){
        	alert("�����ɹ�!");
        }else{
        	alert("����ʧ��!");
        }
        parent.divProcessing.style.display="none";
        
        parent.document.all("button1").disabled = false;
        parent.document.all("button2").disabled = false;
        parent.document.all("button3").disabled = false;
        parent.document.all("button4").disabled = false;
        parent.document.all("back").disabled = false;
    }
</script>