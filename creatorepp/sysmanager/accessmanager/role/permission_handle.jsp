<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkManagerAccess(request,response);

			String global = request.getParameter("global");
			boolean globalTag = true;//�����ȫ����Դ����ˢ��ߵ���Դ��
			if (global == null) {
				global = "";
			}
			if (global.equals("yes")) {
				globalTag = false;
			}

			String[] opids = request.getParameterValues("alloper");
			String resTypeId = request.getParameter("resTypeId");
			String resid = request.getParameter("resid");
			String resname = request.getParameter("resName");
			
			String roleid = request.getParameter("roleid");
			String[] roleids = roleid.split(",");
			String role_type = request.getParameter("role_type");
			
			System.out.println("role_type: " + role_type);
 
			//���ݽ�ɫidȡ��ɫ����
			boolean success = false;
			RoleManager roleManager = SecurityDatabase.getRoleManager();
			if(role_type!= null && role_type.equals("user") && roleids!=null && roleids.length>1)
			{
				//���û�����������Դ��������ʱ��ִ���������
				success = roleManager.grantRoleresopForBatch(opids, resid, roleids,resTypeId, resname, role_type, true);
			}
			else
			{
				success = roleManager.grantRoleresop(opids, resid, roleids,resTypeId, resname, role_type, true);
			}

			%>

<script language="javascript">
	if(<%=success%>){
	    alert("��������ɹ���");
	    //ˢ����ߵ���Դ��
	    if(<%=globalTag%>)
	    {
	    	//ˢ������������--resdefault.jsp
	    	//parent.parent.orgTree.resource_bridge.location = parent.parent.orgTree.resource_bridge.location;
	    }
	}
	else
	{
		alert("��������ʧ�ܣ�");
	}
</script>