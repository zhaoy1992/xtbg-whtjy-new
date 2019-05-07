<%
/*
 * <p>Title: 修改用户组角色</p>
 * <p>Description: 修改用户组角色</p>
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
		
		//用户组管理写操作日志
        String operSource=control.getMachinedID();
        String openModle="用户组管理";
        String userName = control.getUserName();
        String description="";
        LogManager logManager = SecurityDatabase.getLogManager();
        String groupName_Log = LogGetNameById.getGroupNameByGroupId(groupId);
        String operContent=userName +" 对用户组 "+groupName_Log+" 进行了角色权限操作";
        logManager.log(control.getUserAccount(),operContent,openModle,operSource,description);
        boolean success=false;
        GroupManager groupManager=SecurityDatabase.getGroupManager();
        //对提交方式进行判断
        
        if(flag.equals("add"))
        {
            //对当前组下的角色进行新增
            String[] roleIds=roleId.split(",");
			success=groupManager.insertGroupRole(groupId,roleIds);
		}
		else
		{
			//对当前组下的角色进行删除
			success=groupManager.deleteGroupRole(groupId,roleId);
		}
%>
<script language="javascript">
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
