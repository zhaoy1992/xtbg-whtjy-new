<%
/*
 * <p>Title: ��ɫ�����û��Ĵ���ҳ��</p>
 * <p>Description: ��ɫ�����û��Ĵ���ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-24
 * @author liangbing.tao
 * @version 1.0
 */
 %>

<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.db.RoleManagerImpl,
				com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%
	
		
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
	
		String roleId = request.getParameter("roleId");
		String userId = request.getParameter("userId");
		String orgId = request.getParameter("orgId");
		String tag = request.getParameter("tag"); 
		
		//---------------START--��ɫ����д������־
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��ɫ����";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager(); 	
		String roleName_log = LogGetNameById.getRoleNameByRoleId(roleId);
		operContent=userName+" �Խ�ɫ  "+ roleName_log+"  ��Ӧ���û������˲���"; 						
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,"");          
		//---------------END
		
		//if(userId!=null){
		//	String userIds[] =userId.split("\\,");
		//	out.print(RoleManagerAction.storeRoleUserAjax(roleId,userIds,orgId));	
	 	//}
	 	
	 	// Ȩ���Ƿ��������
		// ��ʢ 2011-3-15 
		boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	 	
		RoleManager roleManager = new RoleManagerImpl(); 
		String msg = "";
		boolean success = false;
    	if(tag.equals("add")){
    		String[] uids = userId.split(",");
    		try
    		{
    			// ��ʢ 2011-3-15 
    			if(isrolerelatedorg){
    				roleManager.grantRoleToUsers(uids,roleId,control.getUserID(),orgId);
    			}else{
    				roleManager.grantRoleToUsers(uids,roleId);
    			}
				success = true;
			}
			catch(Exception e){
				msg = "����ʧ�ܣ�" + e.getMessage();
			}
		}
		
		if(tag.equals("delete")){
			String[] uids = userId.split(",");
			try{
				// ��ʢ 2011-3-15 
    			if(isrolerelatedorg){
					success = roleManager.deleteUsersOfRole(uids,roleId,orgId);
				}else{
					success = roleManager.deleteUsersOfRole(uids,roleId);
				}
				if(!success)
				{
					msg = "����ʧ��";
				}
				
			}catch(Exception e){
				msg = e.getMessage();
			}
		}
%>
<script>
	<%
		if(success)
		{
	%>
			alert("�����ɹ�!");
	<%
		}
	%>
	
    window.onload = function prompt(){
    	<%
    	if(!msg.equals(""))
    	{
    	%>
	        alert("<%=msg%>");
        <%
        }
        %>
       parent.divProcessing.style.display="none";
       
       parent.document.all("button1").disabled = false;
	   parent.document.all("button2").disabled = false;
	   parent.document.all("button3").disabled = false;
	   parent.document.all("button4").disabled = false;
	   
	   parent.document.all("back").disabled = false;
	   
    }
</script>