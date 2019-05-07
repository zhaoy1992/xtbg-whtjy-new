<%
/*
 * <p>Title: 角色修改的处理页面</p>
 * <p>Description: 角色修改的处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author liangbing.tao
 * @version 1.0
 */
 %>



<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.manager.*,
				com.chinacreator.sysmgrcore.entity.Role,
				com.chinacreator.sysmgrcore.manager.SecurityDatabase,
				com.frameworkset.common.poolman.DBUtil"
				%>


<%
	try
	{
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		String roleid = request.getParameter("roleId");
		String rolename = request.getParameter("roleName");
		String roledesc = request.getParameter("roleDesc");
		String roletype = request.getParameter("roleType");
		
		RoleManager roleManager = SecurityDatabase.getRoleManager();
		Role role = new Role();
		DBUtil db = new DBUtil();
		String sql ="select  count(*) from td_sm_role where role_name ='"+ rolename +"' and role_id !='"+roleid+"'";
		db.executeSelect(sql);
		if(db.getInt(0,0)>0)
		{
	%>
		<script language="javascript">
			alert("角色名称已存在，请另外取名!");		
		</script>	
	<%
		}	
		else
		{	
			role.setRoleId(roleid);		
			role.setRoleDesc(roledesc);
			role.setRoleName(rolename);
			role.setRoleType(roletype);
			roleManager.storeRole(role);
	%>
		<script language="javascript">
			alert("修改角色成功!");
		</script>
	<%
		}
	}
	catch (Exception e) 
	{
		e.printStackTrace();
	}
%>

<script>
    window.onload = function prompt()
    {
        parent.divProcessing.style.display="none";
        parent.document.all.update.disabled = false;
		parent.document.all.calc[0].disabled = false;
		parent.document.all.calc[1].disabled = false;
    }
</script>
