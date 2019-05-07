<%
/*
 * <p>Title: 用户组的后台处理页面</p>
 * <p>Description: 对用户组的添、删和改操作</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>


<%
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		int userId = Integer.parseInt(control.getUserID());
		
		//状态
		int flag = Integer.parseInt(request.getParameter("flag"));
		
		String parentId = request.getParameter("parentId");	
		
		//对新增子组是否是一级组还是子组,进行不同的操作
		String son = request.getParameter("son");
		son = son == null ? "" : son;
		
						
		if(parentId == "" || parentId == null)
		{
			parentId="0";
		}
		
		String groupId = request.getParameter("groupId");	
		
		String groupName = request.getParameter("groupName");
		
		String oldGroupName = request.getParameter("oldGroupName");
		
		String groupDesc = request.getParameter("groupDesc");
		
		
		GroupManager groupManager=SecurityDatabase.getGroupManager();	
		
		
		Group group=new Group();	
		String info="操作失败";	
		
		 String operContent = "";
		 String operSource = control.getMachinedID();
		 String openModle = "用户组管理";
		 String userName = control.getUserName();
		 String description = "";
		 LogManager logManager = SecurityDatabase.getLogManager();
		 description = "";
		
		//对操作状态进行判断
		switch(flag)
		{
			//新增
			case 1:
			group.setOwner_id(userId);
			group.setParentId(Integer.parseInt(parentId));			
			group.setGroupName(groupName);
			group.setGroupDesc(groupDesc);
			info=groupManager.saveGroup(group,control.getUserID());		
			groupId=group.getGroupId() + "";	
			//增加日志 2009.7.22
		    operContent = userName + " 新增一级组 " + group.getGroupName();
		    logManager.log(control.getUserAccount() ,
						operContent, openModle, operSource, description);
						
			break;
			
			//修改
			case 2:
			group.setGroupId(Integer.parseInt(groupId));
			group.setGroupName(groupName);
			group.setGroupDesc(groupDesc);	
			info=groupManager.updateGroup(group,oldGroupName);	
			
		    operContent = userName + " 修改用户组 " + group.getGroupName();
		    logManager.log(control.getUserAccount() ,
						operContent, openModle, operSource, description);
					
			break;
			
			//删除
			case 3:
			group.setGroupId(Integer.parseInt(groupId));
			
			operContent = userName + " 删除用户组 " + groupManager.getGroupByID(groupId).getGroupName();
		    logManager.log(control.getUserAccount() ,
						operContent, openModle, operSource, description);
							
			if(groupManager.deleteGroup(group))
			{
				info="操作成功";
			}
			
			break;
		}
%>

<script language="javascript">
	
   	alert("<%=info%>");
   	
   	if(<%=flag%> != 3)
   	{
		parent.document.all.divProcessing.style.display = "none";
		parent.document.all.SaveButton.disabled = false;
		parent.document.all.BackButton.disabled = false;
   	}
   	else
   	{
   		parent.document.location.reload(true);
   	}
</script>

