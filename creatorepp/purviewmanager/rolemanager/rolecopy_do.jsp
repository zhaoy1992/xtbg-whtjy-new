<%
/*
 * <p>Title: ��ɫ���ƴ���ҳ��</p>
 * <p>Description: ��ɫ���ƴ���ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author liangbing.tao
 * @version 1.0
 */
 %>



<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.manager.RoleManager,
				com.chinacreator.sysmgrcore.manager.LogManager,
				com.chinacreator.sysmgrcore.entity.Role,
				com.chinacreator.sysmgrcore.manager.SecurityDatabase,
				com.chinacreator.sysmgrcore.manager.LogGetNameById"%>


<%
				
		boolean tag = false ;
		//---------------START--��ɫ����д������־
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��ɫ����";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager(); 		
		//---------------END
	    
		String rolecopyId = request.getParameter("rolecopyId");
		String[] id = request.getParameterValues("checkBoxOne");
		request.setAttribute("roleId", rolecopyId);
		
		RoleManager roleManager = SecurityDatabase.getRoleManager();
		try
		{
			
			roleManager.copyResOfRole(rolecopyId,id);
			tag = true ;
		}
		catch(Exception e)
		{
			tag = false ;
			e.printStackTrace() ;
		}
		
		
		//--��ɫ����д������־	
		operContent="���ƽ�ɫ: "+	LogGetNameById.getRoleNameByRoleId(rolecopyId);			
		description="";
		logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);  
	
%>	

<script language="javascript">
	if(<%=tag%>)
	{
		alert("��ɫ���Ƴɹ�!");
	}
	else
	{
		alert("��ɫ����ʧ��!");
	}
	
	parent.document.getElementById("copy").disabled = false ;
	parent.document.getElementById("back").disabled = false ;
	parent.document.all.divProcessing.style.display = "none";
</script>
	

	