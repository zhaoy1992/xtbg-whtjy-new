<%
/*
 * <p>Title: ���������ɫ����ҳ��</p>
 * <p>Description: ���������ɫ����ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-24
 * @author liangbing.tao
 * @version 1.0
 */
 %>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
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
	
		String roleId = request.getParameter("roleId");	
		String id = request.getParameter("id");	
		String orgId = request.getParameter("orgId");	
		// System.out.println("id" + id);
		//System.out.println("roleId" + roleId);
		
		// Ȩ���Ƿ��������
		// ��ʢ 2011-3-15 
		boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
		
		boolean flag = true;
		if(roleId!=null){
			String roleIds[] =roleId.split("\\,") ;
			String idso[] =id.split("\\,") ;
			UserManager userManager = SecurityDatabase.getUserManager();
			//--
			String userNames_log = LogGetNameById.getUserNamesByUserIds(idso);
			String roleNames_log = LogGetNameById.getRoleNamesByRoleIds(roleIds);
			String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
			operContent="���û���"+userNames_log+" �ڻ���:"+orgName_log+"  �����ɫ��"+roleNames_log; 						
			description="";
			logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          
			//--	end	 --
			try{
				if(isrolerelatedorg){
					flag = userManager.storeAlotUserRole(idso,roleIds,control.getUserID(),orgId);
				}else{
					userManager.storeAlotUserRole(idso,roleIds);
				}
			}catch(Exception e){
				e.printStackTrace();
				flag = false;
			}
		 }
		 out.print(String.valueOf(flag));
%>