<%
/**
 * 
 * <p>Title: �������Ź���Ա����ҳ��</p>
 *
 * <p>Description: �������Ź���Ա����ҳ�棬��¼���ò��Ź���Ա����־</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgAdministrator"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Organization,com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
String orgId1 = request.getParameter("orgId1");
String userId = request.getParameter("userId");
String[] userIds = userId.split("\\,");
String tag = request.getParameter("tag");
String exceptionMessage = null;
if(tag.equals("add")){
 	OrgAdministrator orgAdministrator = new OrgAdministratorImpl();
	String operContent="";        
    String operSource=accesscontroler.getMachinedID();
    String openModle="��������";
    String userName = accesscontroler.getUserName();
    LogManager logManager = SecurityDatabase.getLogManager(); 		
	String userName_log = "";
	for(int i = 0; i < userIds.length; i++){
		if(!"".equals(userName_log)){
			userName_log += "," + SecurityDatabase.getUserManager().getUserById(userIds[i]).getUserRealname();
		}else{
			userName_log = SecurityDatabase.getUserManager().getUserById(userIds[i]).getUserRealname();
		}
	}
	try{
		orgAdministrator.addOrgAdmin(userIds, orgId1, accesscontroler.getUserID());
		//log start
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		Organization org = orgManager.getOrgById(orgId1);			
		operContent=userName+" ���û���"+userName_log+"������Ϊ������"+org.getOrgName()+"���Ĳ��Ź���Ա"; 				
		logManager.log(accesscontroler.getUserAccount(),operContent,openModle,operSource,"");          
		//--	end	 --
	}catch(Exception e){
		e.printStackTrace();
		exceptionMessage = e.getMessage();
		if(exceptionMessage != null)
        {
        	exceptionMessage = exceptionMessage.replaceAll("\\n","\\\\n");
        	exceptionMessage = exceptionMessage.replaceAll("\\r","\\\\r");
        }
	}	
}
else if(tag.equals("delete")){
	try{
		OrgAdministrator orgAdministrator = new OrgAdministratorImpl();
		//---------------START--
		
			String operContent="";        
	        String operSource=accesscontroler.getMachinedID();
	        String openModle="��������";
	        String userName = accesscontroler.getUserName();
	        LogManager logManager = SecurityDatabase.getLogManager(); 		
			String userName_log = "";
			for(int i = 0; i < userIds.length; i++){
				if(!"".equals(userName_log)){
					userName_log += "," + SecurityDatabase.getUserManager().getUserById(userIds[i]).getUserRealname();
				}else{
					userName_log = SecurityDatabase.getUserManager().getUserById(userIds[i]).getUserRealname();
				}
			}
			//String tmp[] = orgIdNames.split(";");
			OrgManager orgManager = SecurityDatabase.getOrgManager();
			Organization org = orgManager.getOrgById(orgId1);			
			operContent=userName+" ȡ�����û���"+userName_log+"���ڻ�����"+org.getOrgName()+"���µĲ��Ź���Ա��ɫ"; 						
			logManager.log(accesscontroler.getUserAccount(),operContent,openModle,operSource,"");          
		//--	end	 --	
		orgAdministrator.deleteOrgAdmin(userIds, orgId1);
	}catch(Exception e){
		e.printStackTrace();
		exceptionMessage = e.getMessage();
		if(exceptionMessage != null)
        {
        	exceptionMessage = exceptionMessage.replaceAll("\\n","\\\\n");
        	exceptionMessage = exceptionMessage.replaceAll("\\r","\\\\r");
        }
	}
}
%>
<script>
    window.onload = function prompt(){
    	<%if(exceptionMessage == null){%>
        	parent.divProcessing.style.display="none";
        	alert("�����ɹ���");
        <%}else{%>
        	parent.divProcessing.style.display="none";
        	alert("����ʧ�ܣ�");
        <%}%>
    }
</script>