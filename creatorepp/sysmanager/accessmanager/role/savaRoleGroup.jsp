<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.RoleManagerAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>

<%
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		String roleId = request.getParameter("roleId");
		String groupId = request.getParameter("groupId");
		String tag = request.getParameter("tag");
		
		//---------------START--��ɫ����д������־
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��ɫ����";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager(); 	
		String roleName_log = LogGetNameById.getRoleNameByRoleId(roleId);
		operContent=userName+" �Խ�ɫ  "+ roleName_log+"  ��Ӧ���û�������˲���"; 						
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,"");          
		//---------------END
		
		//if(groupId!=null){
		//	String groupIds[] =groupId.split("\\,");
		//}
		if((tag == "add") || (tag.equals("add"))){
			String sql = "select e.* from td_sm_grouprole e where e.group_id='" + groupId + "' and e.role_id='" + roleId + "'";
			DBUtil dBUtil = new DBUtil();
			try{
				dBUtil.executeSelect(sql);
				if(dBUtil.size() == 0){
					sql = "insert into td_sm_grouprole values('" + groupId + "', '" + roleId + "')";
					dBUtil.executeInsert(sql);
				}
			}catch(Exception e){}
		}
		if((tag == "delete") || (tag.equals("delete"))){
			String sql = "delete from td_sm_grouprole f where f.group_id='" + groupId + "' and f.role_id='" + roleId + "'";
			DBUtil dBUtil = new DBUtil();
			try{
				dBUtil.executeDelete(sql);
			}catch(Exception e){}
		}
			//out.print(RoleManagerAction.storeRoleGroupAjax(roleId,groupIds));	
		
%>
<script>
    window.onload = function prompt(){
        //alert("�����ɹ�!");
        parent.divProcessing.style.display="none";
    }
</script>