<%-- 
	描述：用户调动部门拖动处理页面
	作者：肖杰
	版本：1.0
	日期：2013-11-11
 --%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OrgCache"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.UserManagerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.OrgManagerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String userids = request.getParameter("userid");
	UserCacheBean userbean=UserCache.getUserCacheBean(userids);
	String orgusers="";
	if(userbean!=null){
		orgusers=userbean.getOrg_id();
	}
	String orgids=request.getParameter("orgid");
	String[] userid = userids.split(",");
	String[] orgid= orgids.split(",");
	
	UserManager userManager = SecurityDatabase.getUserManager();
	OrgManager orgManager = SecurityDatabase.getOrgManager();

	UserManagerServiceIfc service=new UserManagerServiceImpl();
	boolean flag =false; //service.setUserOrder(userids,orgid);
	if(!StringUtil.isBlank(orgusers)){
		boolean state2 =orgManager.deleteOrg_UserJob(orgusers, userid);
		if(state2){
			flag = userManager.storeBatchUserOrg(userid, orgid, true);//保存用户主机构与岗位
			//用户调出 特检院 OA 个性化修改 把调出的机构ID 修改为当前用户角色的机构ID start
			OrgManager orgmanager = new OrgManagerImpl();
			flag = orgmanager.updateOrg_UserRole(orgid,userid);
			//用户调出 特检院 OA 个性化修改 把调出的机构ID 修改为当前用户角色的机构ID end
		}
	}else{
		flag = userManager.storeBatchUserOrg(userid, orgid, true);//保存用户主机构与岗位
	}
	try {	
		if(flag){
			UserCache userCache = new UserCache();
		    OrgCache orgCache = new OrgCache();
			orgCache.init();
			userCache.init();
			 
	        out.print("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
	    }else{
	        out.print("{\"flag\":\"false\",\"msg\":\"移动节点失败\"}");  
	    }
	} catch (Exception e) {
		out.print("{\"flag\":\"false\",\"msg\":\"移动节点失败!\"}");
	} 


	
%>
