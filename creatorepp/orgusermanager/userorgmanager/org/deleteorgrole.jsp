<%
/*
 * <p>Title: ������ɫ�����ĺ�̨ɾ������ҳ��</p>
 * <p>Description:������ɫ�����ĺ�̨ɾ������ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-26
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


<%	
	//---------------START--�û������д������־
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	String operContent="";        
    String operSource=control.getMachinedID();
    String openModle="��������";
    String userName = control.getUserName();
    String description="";
    LogManager logManager = SecurityDatabase.getLogManager(); 		
	//---------------END	
	
		
	String orgId = request.getParameter("orgId");
	String roleIds = request.getParameter("roleId");
	String[] arrrole = roleIds.split(",");		
	String flag = request.getParameter("flag");
	
	for(int i=0;i<arrrole.length;i++)
	{
	    String roleId = arrrole[i];
	    
		//--�û������д������־		
		String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
		String roleName_log = LogGetNameById.getRoleNameByRoleId(roleId);
		operContent="ɾ�������Ľ�ɫ,����:"+orgName_log+" ��ɫ��"+roleName_log; 						
		description="";
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);          		
		//--	end	 --	
		
	}	
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	boolean tag = orgManager.deleteOrgrole(orgId,arrrole,flag);
%>
<script>
    window.onload = function prompt()
    {
    if("<%=tag%>")
    	{
    		alert("�����ɹ�!");
    	}
    	else
    	{
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
