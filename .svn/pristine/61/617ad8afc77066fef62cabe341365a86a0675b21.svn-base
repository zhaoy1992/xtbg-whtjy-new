<%
/**
 * 
 * <p>Title: 树形--保存资源</p>
 *
 * <p>Description: 树形--保存资源处理页面</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
 <%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@page import="com.chinacreator.security.AccessControl,
			com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl,
			com.chinacreator.sysmgrcore.purviewmanager.PurviewManager"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String resTypeId = request.getParameter("resTypeId");
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String[] checkedValues = request.getParameter("checkValues")==null?null:request.getParameter("checkValues").split(",");
	String[] un_checkValues = request.getParameter("un_checkValues")==null?null:request.getParameter("un_checkValues").split(",");
	String opId = request.getParameter("opId");
	String isBatch = request.getParameter("isBatch");
	String currOrgId = request.getParameter("currOrgId");
	
	PurviewManager purviewManager = new PurviewManagerImpl();
	
	// 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
		
	boolean state = false;
	if(isBatch.equals("false")){
		// 彭盛 2011-3-15 
		if(isrolerelatedorg){
			state = purviewManager.saveTreeRoleresop(opId,resTypeId,checkedValues,currRoleId,role_type,resTypeId,un_checkValues,currOrgId);
		}else{
			state = purviewManager.saveTreeRoleresop(opId,resTypeId,checkedValues,currRoleId,role_type,resTypeId,un_checkValues);
		}
	}else{
		// 彭盛 2011-3-15 
		if(isrolerelatedorg){
			state = purviewManager.batchSaveTreeRoleresop(opId,resTypeId,checkedValues,currRoleId,role_type,currOrgId);
		}else{
			state = purviewManager.batchSaveTreeRoleresop(opId,resTypeId,checkedValues,currRoleId,role_type);
		}
	}
%>		
<%
	if(state){
%>
<script language="Javascript">
	alert("操作成功！");
</script>
<%}else{%>
<script language="Javascript">
	alert("授权失败！");
</script>
<%}%>