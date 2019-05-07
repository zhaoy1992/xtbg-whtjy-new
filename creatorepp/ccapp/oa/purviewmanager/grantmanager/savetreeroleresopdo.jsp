<%--
描述：菜单授权保存页面
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.PurviewManager"%>
<%@page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	boolean sucess = false;
	try{
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkManagerAccess(request,response);
		
		String resTypeId = StringUtil.deNull(request.getParameter("resTypeId"));
		String currRoleId = StringUtil.deNull(request.getParameter("currRoleId"));
		String role_type = StringUtil.deNull(request.getParameter("role_type"));
		String[] checkedValues = StringUtil.deNull(request.getParameter("checkValues")).split(",");
		String[] un_checkValues = StringUtil.deNull(request.getParameter("un_checkValues")).split(",");
		String opId = StringUtil.deNull(request.getParameter("opId"));
		String isBatch = StringUtil.deNull(request.getParameter("isBatch"));
		String currOrgId = StringUtil.deNull(request.getParameter("currOrgId"));
		
		PurviewManager purviewManager = new PurviewManagerImpl();
		// 权限是否关联机构
		// 彭盛 2011-3-15 
		boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
		if(isBatch.equals("false")){
			// 彭盛 2011-3-15 
			if(isrolerelatedorg){
				sucess = purviewManager.saveTreeRoleresop(opId,resTypeId,checkedValues,currRoleId,role_type,resTypeId,un_checkValues,currOrgId);
			}else{
				sucess = purviewManager.saveTreeRoleresop(opId,resTypeId,checkedValues,currRoleId,role_type,resTypeId,un_checkValues);
			}
		}else{
			// 彭盛 2011-3-15 
			if(isrolerelatedorg){
				sucess = purviewManager.batchSaveTreeRoleresop(opId,resTypeId,checkedValues,currRoleId,role_type,currOrgId);
			}else{
				sucess = purviewManager.batchSaveTreeRoleresop(opId,resTypeId,checkedValues,currRoleId,role_type);
			}
		}
	}catch(Exception e){
		sucess = false;
		e.printStackTrace();
	}
%>		
<script type="text/javascript">
	var mes;	
	var bool = true;
	if(<%=sucess %>){
		mes = "操作成功！";
	}else{
		bool = false;
		mes = "操作失败！";
	}
	
	window.top.alert(mes);
</script>