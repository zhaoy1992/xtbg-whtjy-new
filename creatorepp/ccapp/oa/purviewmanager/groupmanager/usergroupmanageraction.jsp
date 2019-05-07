<%
/*
 * <p>Title: 隶属组的处理</p>
 * <p>Description: 隶属组的处理</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page pageEncoding="GBK" contentType="text/html; charset=utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	
	String userId = request.getParameter("userId");
	String orgId = request.getParameter("orgId");
	
		if(userId == null)
		{
			request.getRequestDispatcher("nouser.jsp").forward(request,response);
		}
		else
		{
			try
			{
				String groupId = request.getParameter("groupId");
				
				request.setAttribute("userId",userId);
				request.setAttribute("orgId",orgId);
				// 权限是否关联机构
				// 彭盛 2011-3-15 
				boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
				
				GroupManager groupManager = SecurityDatabase.getGroupManager();
				User user = new User();
				user.setUserId(Integer.valueOf(userId));
				
				Group group1 = groupManager.getGroupByID(groupId);
				List allGroup = null;
				if (groupManager.isContainChildGroup(group1)) 
				{
					allGroup = groupManager
							.getGroupList("select * from td_sm_group o where o.PARENT_ID="
									+ groupId + " or o.GROUP_ID=" + groupId + "");
				}
				else 
				{
					allGroup = groupManager
							.getGroupList("select * from td_sm_group o where o.GROUP_ID="
									+ groupId + "");
				}
				// 彭盛 2011-3-15 
				List existGroup = new ArrayList();
				if(isrolerelatedorg){
					existGroup = groupManager.getGroupList(userId,orgId);
				}else{
					existGroup = groupManager.getGroupList(user);
				}
				
				request.setAttribute("allGroup", allGroup);
				request.setAttribute("existGroup", existGroup);
				
				request.getRequestDispatcher("changegroup_ajax.jsp").forward(request,response);
			}
			catch(Exception e)
			{
				e.printStackTrace();
				request.getRequestDispatcher("fail.jsp").forward(request,response);
			}
		}
%>