<%
/*
 * <p>Title: �����û��ĺ�̨����</p>
 * <p>Description: �����û��ĺ�̨����</p>
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
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		String userId = request.getParameter("userId");
		String groupId = request.getParameter("groupId");	
		String flag = request.getParameter("flag");
		String orgid = request.getParameter("orgId");
		
		// Ȩ���Ƿ��������
		// ��ʢ 2011-3-15 
		boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
		
		//�û������д������־
        String operSource=control.getMachinedID();
        String openModle="�û������";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager();
        String groupName_Log = LogGetNameById.getGroupNameByGroupId(groupId);
        String operContent=userName +" ���û��� "+groupName_Log+" �µ������û������˲���";
        logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);
        
		boolean success=false;
		GroupManager groupManager=SecurityDatabase.getGroupManager();
		
		//���ύ��ʽ�����ж�
        if(flag.equals("add"))
        {
            String[] userIds=userId.split(",");
			// ��ʢ 2011-3-15 
            if(isrolerelatedorg){
            	success = groupManager.insertGroupUser(groupId,userIds,orgid);
            }else{
				success=groupManager.insertGroupUser(groupId,userIds);
			}
		}
		else
		{
			// ��ʢ 2011-3-15 
            if(isrolerelatedorg){
            	success = groupManager.deleteGroupUser(groupId,userId,orgid);
            }else{
				success=groupManager.deleteGroupUser(groupId,userId);
			}
		}
%>
<script>
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
