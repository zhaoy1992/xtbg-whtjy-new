<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.sysmgrcore.manager.*,
com.chinacreator.sysmgrcore.entity.Role,com.chinacreator.sysmgrcore.manager.SecurityDatabase,
com.frameworkset.common.poolman.DBUtil"%>
<%
try {
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String rolename = request.getParameter("roleName").trim();
	String roledesc = request.getParameter("roleDesc");
	String roletype = request.getParameter("roleType");
	
	System.out.println("..........."+rolename);
	System.out.println("..........."+roledesc);
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	Role role = new Role();
	DBUtil db = new DBUtil();
	String sql ="select  count(*) from td_sm_role where role_name ='"+ rolename +"'";
	//System.out.println("..........."+sql);
	db.executeSelect(sql);
	if(db.getInt(0,0)>0){
	%>
		<script language="javascript">
		alert("��ɫ�����Ѵ��ڣ�������ȡ��!");
		
		</script>	
	<%}	else{			
		role.setRoleDesc(roledesc);
		role.setRoleName(rolename);
		role.setOwner_id(Integer.parseInt(control.getUserID()));
		role.setRoleType(roletype);
		roleManager.insertRole(role);
	%>
<script language="javascript">
	alert("������ɫ�ɹ�!");
	window.dialogArguments.location.href ="../userManage/main.jsp";
	//parent.window.returnValue = true;
	window.close();
</script>
<%
}
	} catch (Exception e) {
	e.printStackTrace();


}
%>
