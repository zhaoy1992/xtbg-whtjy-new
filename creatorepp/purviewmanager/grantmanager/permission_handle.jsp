<%
/**
 * 
 * <p>Title: ��������Ȩ����ҳ��</p>
 *
 * <p>Description: ����-��������Ȩ����ҳ��</p>
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

<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
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
			String orgId = request.getParameter("orgId");
			String isBatch = request.getParameter("isBatch");
			
			// Ȩ���Ƿ��������
			// ��ʢ 2011-3-15 
			boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
			
			//System.out.println("role_type: " + role_type);
 
			//���ݽ�ɫidȡ��ɫ����
			boolean success = false;
			RoleManager roleManager = SecurityDatabase.getRoleManager();
			if(role_type!= null && role_type.equals("user") && roleids!=null && roleids.length>1)
			{
				//���û�����������Դ��������ʱ��ִ���������
				// ��ʢ 2011-3-15 
				if(isrolerelatedorg){
					success = roleManager.grantRoleresopForBatch(opids, resid, roleids,resTypeId, resname, role_type, true,orgId);
				}else{
					success = roleManager.grantRoleresopForBatch(opids, resid, roleids,resTypeId, resname, role_type, true);
				}
			}
			else
			{
				// ��ʢ 2011-3-15 
				if(isrolerelatedorg){
					success = roleManager.grantRoleresop(opids, resid, roleids,resTypeId, resname, role_type, true,orgId);
				}else{
					success = roleManager.grantRoleresop(opids, resid, roleids,resTypeId, resname, role_type, true);
				}
			}

			
			%>

<script language="javascript">
	
	if(<%=success%>){
	    alert("��������ɹ���");
	    //ˢ����ߵ���Դ��
	   <% if("false".equals(isBatch)){%>
	    if(<%=globalTag%>)
	    {
	    	//ˢ������������--resdefault.jsp
	    	//alert(parent.parent.frames[0].location);
	    	parent.parent.frames[0].location = parent.parent.frames[0].location;
	    }else{
	    	//parent.parent.location = parent.parent.location;
	    	parent.location = parent.location;
	    }
	    <%}%>
	}
	else
	{
		alert("��������ʧ�ܣ�");
	}
</script>