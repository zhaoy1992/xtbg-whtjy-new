<%
/**
 * <p>Title: ��ɫɾ��ҳ��</p>
 * <p>Description: ��ɫɾ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author baowen.liu
 * @version 1.0
 **/
 %>
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*
				,com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<html>
<head>
<title>��ɫɾ��</title>

<style type="text/css">
<!--
.STYLE2 {	color: #263F77;
	font-weight: bold;
}
.STYLE3 {color: #FF0000}
-->
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<%			
			AccessControl accessControl = AccessControl.getInstance();
			accessControl.checkManagerAccess(request,response); //ҳ���¼����

			boolean tag = true;
			String notice = "";

			//ɾ������
			RoleTypeManager rtm = new RoleTypeManager();
			String id = request.getParameter("role_id");			
			
			if ((id != null) && (id.length() > 0)) {
				String[] ids = id.split(";");
					
				RoleManager roleManager = SecurityDatabase.getRoleManager();
				
				//--��ɫ����д������־	
				String operSource=accessControl.getMachinedID();
    			String openModle="��ɫ����";
				String operContent="ɾ����ɫ,��ɫid�� " + id; 						
				String description="";
				LogManager logManager = SecurityDatabase.getLogManager(); 
				logManager.log(accessControl.getUserAccount(),operContent,openModle,operSource,description);       
				//--
					
				tag = roleManager.deleteRoles(ids);
				if(tag)
				{
					notice = "ɾ���ɹ���";
				}
				else
				{
					notice= "ɾ��ʧ�ܣ�";
				}
			}

		%>
</body>
</html>
<script language="javascript">
	window.alert("<%=notice%>");
    window.onload = function prompt()
    {        	
        //parent.divProcessing.style.display="none";
        //parent.location.reload();
        document.location.assign("role.jsp");
    }
</script>
