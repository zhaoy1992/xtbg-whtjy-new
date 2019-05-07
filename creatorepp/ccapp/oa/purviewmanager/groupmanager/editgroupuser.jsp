<%
/*
 * <p>Title: 隶属用户的后台处理</p>
 * <p>Description: 隶属用户的后台处理</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=utf-8"%>
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
		
		// 权限是否关联机构
		// 彭盛 2011-3-15 
		boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
		
		//用户组管理写操作日志
        String operSource=control.getMachinedID();
        String openModle="用户组管理";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager();
        String groupName_Log = LogGetNameById.getGroupNameByGroupId(groupId);
        String operContent=userName +" 对用户组 "+groupName_Log+" 下的隶属用户进行了操作";
        logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);
        
		boolean success=false;
		GroupManager groupManager=SecurityDatabase.getGroupManager();
		
		//对提交方式进行判断
        if(flag.equals("add"))
        {
            String[] userIds=userId.split(",");
            // 彭盛 2011-3-15 
            if(isrolerelatedorg){
            	success = groupManager.insertGroupUser(groupId,userIds,orgid);
            }else{
				success=groupManager.insertGroupUser(groupId,userIds);
			}
		}
		else
		{
		 	// 彭盛 2011-3-15 
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
    	alert("操作成功!");
    }
    else
    {
    	alert("操作失败!");
    }
    
    parent.divProcessing.style.display="none";
    parent.document.all("button1").disabled = false; 
	parent.document.all("button2").disabled = false;
	parent.document.all("button3").disabled = false;
	parent.document.all("button4").disabled = false;
	parent.document.all("back").disabled = false;
</script>
