<%
/*
 * <p>Title: ������λ������ҳ��</p>
 * <p>Description: ������λ������ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-20
 * @author liangbing.tao
 * @version 1.0
 */
%>
<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
				 com.chinacreator.sysmgrcore.entity.*,
				 com.chinacreator.sysmgrcore.manager.SecurityDatabase,
				 com.chinacreator.sysmgrcore.manager.UserManager,
				 com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl,
				 java.util.List,
				 java.util.ArrayList"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	//��ǰ�û���������ID
     String curUserOrgId = accessControl.getChargeOrgId(); 
	String checks = request.getParameter("checks");
	
	String orgId = request.getParameter("orgId");
	String[] id =checks.split(",");
	
	//����Ա���Լ����������ɫ
    UserManager userManager = SecurityDatabase.getUserManager();
    OrgManagerImpl orgImpl = new OrgManagerImpl();	
     boolean tag = false;
     boolean tagSelf = false;
     String adminUsers = "�����û����ܽ��и�λ����:\\n";
     for(int j=0;j<id.length; j++){
		User adminUser = userManager.getUserById(id[j]);
		
		if(accessControl.isAdminByUserid(id[j])){//�й���Ա��ɫ		    
			tag = true;						
			adminUsers += adminUser.getUserName() + " �ǳ�������Ա\\n";
		}
		
		//û�й���Ա��ɫ, ���Ǹ��Լ���Ȩ
		if(accessControl.getUserID().equals(id[j])){
			tag = true;
			adminUsers += adminUser.getUserName() + " ���ܸ��Լ������λ\\n";
		}
		
		 //�ǲ��Ź���Ա, Ҳ��������Ȩ
		 // �����Ź���Ա�������ø�λ  baowen.liu 2008-3-21
		 boolean managerOrgs = accessControl.isOrganizationManager(id[j],orgId);
	     //boolean managerOrgs = orgImpl.isCurOrgManager(orgId, id[j]);
	      if(managerOrgs){
	         tag = true;
		     adminUsers += adminUser.getUserName() + " �ǲ��Ź���Ա���ܽ��и�λ����\\n";
	     }
     }
     
     if(tag)
     {
     	%>
     	<SCRIPT LANGUAGE="JavaScript">
		alert("<%=adminUsers%>"); 
		window.close();
		</script>
		<%
     }
%>
<%
	//���α�����û�  ��ʢ 2011-3-10
	StringBuffer secondUserName = new StringBuffer();
	boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(checks,orgId,secondUserName);
%>
<html>
  <head>
	  <title>������λ</title>
	  <script type="text/javascript">
	  	if("<%=isSecondUser%>"=="true"){
			alert("������û��ڸû����²��ܱ������λ��<%=secondUserName%>");
			window.close();
		}
	  </script>
  </head>
	<frameset rows="*" cols="100%" framespacing="3" frameborder="yes" border="0" >
		<frame src="allJob_ajax.jsp?orgId=<%=orgId%>&checks=<%=checks%>" name="lusersys1" id="lusersys1">
	</frameset>
</html>