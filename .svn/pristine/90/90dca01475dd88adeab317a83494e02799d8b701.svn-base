<%
/*
 * <p>Title: 角色授权删除处理页面</p>
 * <p>Description: 角色授权删除处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-21
 * @author liangbing.tao
 * @version 1.0
 */
 %>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%
	
    String roleId = request.getParameter("roleDelId");	
    String id = request.getParameter("id");	
    String orgId = request.getParameter("orgId");
   // System.out.println("id" + id);
	//System.out.println("roleId" + roleId);
	
	// 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	
	boolean flag = true;
	if(roleId!=null){
		String roleIds[] =roleId.split("\\,") ;
		String idso[] =id.split("\\,") ;
		//System.out.println("liumeiyu" + roleIds[0]);
		UserManager userManager = SecurityDatabase.getUserManager();
		try{
			if(isrolerelatedorg){
				flag=userManager.delAlotUserRole(idso,roleIds,orgId);
			}else{
				flag=userManager.delAlotUserRole(idso,roleIds);
			}
		}catch(Exception e){
			e.printStackTrace();
			flag = false;
		}
	 }
	 out.print(flag);
%>