<%
/*
 * <p>Title: �޸��û����ɫ</p>
 * <p>Description: �޸��û����ɫ</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>

<%	
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
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
        logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);
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
<script language="javascript">
    if(<%=success%>)
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
    
</script>
