<%
/*
 * <p>Title: ������������ҳ��</p>
 * <p>Description: ������������ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-24
 * @author liangbing.tao
 * @version 1.0
 */
 %>
 
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.UserOrgManagerAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>



<%
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);

		String uid = request.getParameter("userId");
		String orgIdNames = request.getParameter("orgIdName");
		
		//---------------START--
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="�û�����";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager(); 
        String userName_log = LogGetNameById.getUserNameByUserId(uid);
		operContent=userName+" �������û���"+userName_log+" ������λ"; 						
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,"");          
		//---------------END		
		if(orgIdNames!=null){
			out.println(UserOrgManagerAction.storeSetupOrg(Integer.valueOf(uid),orgIdNames));	
		 }
    
	
%>
