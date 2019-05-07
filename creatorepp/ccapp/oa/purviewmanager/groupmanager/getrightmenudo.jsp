
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>
<%@page import="com.chinacreator.config.ConfigManager"%><%-- 
	描述：机构排序处理页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-23
 --%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.OrgManagerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String user_id = request.getParameter("user_id");
	String user_name = request.getParameter("user_name");
	String org_id = request.getParameter("org_id");
	String currentOrgId = accesscontroler.getChargeOrgId();
	String curUserId = accesscontroler.getUserID();
	
	OrgAdministratorImpl orgAdministratorImpl = new OrgAdministratorImpl();
	
	//岗位功能开关
	boolean isJobOpen = ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", false);
	
	//是否出现  "是否税管员" 复选框
	boolean istaxmanager = ConfigManager.getInstance().getConfigBooleanValue("istaxmanager", false);
	//是否允许用户存在多个机构下
	boolean isUserOrgs = ConfigManager.getInstance().getConfigBooleanValue("sys.user.enablemutiorg", false);
	//用户组开关
	boolean isGroup = ConfigManager.getInstance().getConfigBooleanValue("enablergrouprole", false);
	
  	//判断是否禁用机构用户增删改菜单开关
  	//minghua.guo[2010-12-13]
  	boolean orguser_modify_forbidden = ConfigManager.getInstance().getConfigBooleanValue("orguser.modify.forbidden",false);
  	
  	// 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
  	

	//是否是管理员
	boolean isOrgManager = false;
	if(isrolerelatedorg){							
		isOrgManager = orgAdministratorImpl.isOrgAdmin(user_id,org_id);
	}else{
		isOrgManager = orgAdministratorImpl.isOrgManager(user_id);
	}
	//是否拥有超级管理员角色
	boolean isRoleAdmin = accesscontroler.isAdminByUserid(user_id);
	//列表中的用户是否是自己
	boolean isSelf = user_id.equals(curUserId);
	//列表中的用户是否是同级部门管理员
	boolean isSisterOrgManager = currentOrgId.equals(org_id) && isOrgManager;
	String isRoleAdminOrOrgManager = "";//是否拥有超级管理员角色与部门管理员角色
	if(isOrgManager && isRoleAdmin){
		isRoleAdminOrOrgManager = "(部门管理员；超级管理员角色)";
	}else if(isRoleAdmin){
		isRoleAdminOrOrgManager = "(超级管理员角色)";
	}else if(isOrgManager){
		isRoleAdminOrOrgManager = "(部门管理员)";
	}
	//屏蔽被借调用户  彭盛 2011-3-10							
	boolean isSecondUserByOrg = !UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(""+user_id,org_id,null);
	boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUser(""+user_id,null);
	// 是否主机构 彭盛 2011-3-10
	boolean isMainOrg = UserCheckOrgFactory.getIUserCheckOrgInstance().isMainOrg(""+user_id,org_id);	
	String letfIds = "";
	
	if("1".equals(curUserId)){//如果当前登陆用户为admin
		//基本信息修改菜单
		if(!orguser_modify_forbidden && isMainOrg){ //判断是否禁用机构用户增删改菜单开关
			if(isSelf) {
				letfIds += "1-2,";
			}
		} else {
			letfIds += "1-2,";
		}
	
		//权限授予菜单
		if(isSecondUserByOrg) {//屏蔽被借调用户
			if(isRoleAdmin || isSelf) {//如果选中的用户是拥有超级管理员角色或自己
				letfIds += "1-3,";
			}
		
			//权限回收菜单,角色设置菜单
			if(isSelf) {//如果是自己
				letfIds += "1-4,1-5,";
			}
		} else {
			letfIds += "1-3,1-4,1-5,";
		}
		
		
	} else if(!"1".equals(curUserId) && accesscontroler.isAdmin()) { //如果当前登陆用户为拥有超级管理员的用户且不是admin
		//基本信息修改菜单
		if(!orguser_modify_forbidden && isMainOrg){ //判断是否禁用机构用户增删改菜单开关
			if(isSelf) {
				letfIds += "1-2,";
			}
		} else {
			letfIds += "1-2,";
		}
	
		//权限授予菜单,权限回收菜单,角色设置菜单
		if(isSecondUserByOrg) {//屏蔽被借调用户
			if(isRoleAdmin || isSelf) {//如果选中的用户是拥有超级管理员角色或自己
				letfIds += "1-3,1-4,1-5,";
			}
		} else {
			letfIds += "1-3,1-4,1-5,";
		}
	
		
	} else { //如果登陆用户为部门管理员时
		boolean state = false;
		if(isSisterOrgManager || isRoleAdmin){
			state = true;
		}else{
			state = isSelf;
		}
		
		//基本信息修改菜单
		if(!orguser_modify_forbidden && isMainOrg){ //判断是否禁用机构用户增删改菜单开关
			if(accesscontroler.checkPermission("orgunit","userupdate",AccessControl.ORGUNIT_RESOURCE)) {
				if(state) {
					letfIds += "1-2,";
				}
			} else {
				letfIds += "1-2,";
			}
		} else {
			letfIds += "1-2,";
		}
		
		//权限授予菜单
		if(isSecondUserByOrg) {//屏蔽被借调用户
			boolean isPurset = accesscontroler.checkPermission("orgunit","purset",AccessControl.ORGUNIT_RESOURCE);
			if(isPurset){
				if(state) {
					letfIds += "1-3,1-4,";
				}
			} else {
				letfIds += "1-3,1-4,";
			}
			
			if(state) {
				letfIds += "1-5,";
			}
		} else {
			letfIds += "1-3,1-4,1-5,";
		}
	}
	
	
	if(letfIds.length() > 0) {
		letfIds = letfIds.substring(0,letfIds.length() - 1);
	}
	
	try {	
		   String returnjsonstr = "{\"flag\":\""+letfIds+"\",\"msg\":\"操作成功\"}";
		   System.out.println(returnjsonstr);
	       out.print(returnjsonstr);  
	} catch (Exception e) {
		out.print("{\"flag\":\"false\",\"msg\":\"操作失败!\"}");
	} 


	
%>
