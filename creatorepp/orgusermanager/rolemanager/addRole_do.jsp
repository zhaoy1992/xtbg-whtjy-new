<%
/**
 * <p>Title: ��ӽ�ɫ����ҳ��</p>
 * <p>Description: ��ӽ�ɫ����ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author baowen.liu
 * @version 1.0
 **/
 %>
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.sysmgrcore.manager.*,
com.chinacreator.sysmgrcore.entity.Role,com.chinacreator.sysmgrcore.manager.SecurityDatabase,
com.frameworkset.common.poolman.DBUtil,com.chinacreator.sysmgrcore.manager.LogManager"%>
<%
try {
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	String rolename = request.getParameter("roleName");
	String roledesc = request.getParameter("roleDesc");
	String roletype = request.getParameter("roleType");
	
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	Role role = new Role();
	DBUtil db = new DBUtil();
	String sql ="select  count(*) from td_sm_role where role_name ='"+ rolename +"'";
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
		
		//������־ 2009.7.22
		String operContent = "";
		String operSource = control.getMachinedID();
		String openModle = "��ɫ����";
		String userName = control.getUserName();
		String description = "";
		LogManager logManager = SecurityDatabase.getLogManager();
		operContent = userName + " �����˽�ɫ " + role.getRoleName();
		description = "";
		logManager.log(control.getUserAccount() ,
						operContent, openModle, operSource, description);
	%>
<script language="javascript">
	alert("������ɫ�ɹ�!");
</script>
<%
	}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<script>
    window.onload = function prompt()
    {        parent.document.all.update.disabled=false;
				parent.document.all.calc[0].disabled=false;
				parent.document.all.calc[1].disabled=false;
        parent.divProcessing.style.display="none";
    }
</script>
