<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.GroupManagerAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>

<%	
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		String groupId = request.getParameter("groupId");
		String roleId = request.getParameter("roleId");
		String flag = request.getParameter("flag");
		//�û������д������־
        String operSource=control.getMachinedID();
        String openModle="�û������";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager();
        String groupName_Log = LogGetNameById.getGroupNameByGroupId(groupId);
        String operContent=userName +" ���û��� "+groupName_Log+" �����˽�ɫȨ�޲���";
        logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);
        boolean success=false;
        GroupManager groupManager=SecurityDatabase.getGroupManager();
        //���ύ��ʽ�����ж�
        if(flag.equals("add"))
        {
            //�Ե�ǰ���µĽ�ɫ��������
            String[] roleIds=roleId.split(",");
			success=groupManager.insertGroupRole(groupId,roleIds);
		}
		else
		{
			//�Ե�ǰ���µĽ�ɫ����ɾ��
			success=groupManager.deleteGroupRole(groupId,roleId);
		}
%>
<script>
    if(<%=success%>)
    {alert("�����ɹ�!");}
    else
    {alert("����ʧ��!");}
    parent.divProcessing.style.display="none";
</script>
