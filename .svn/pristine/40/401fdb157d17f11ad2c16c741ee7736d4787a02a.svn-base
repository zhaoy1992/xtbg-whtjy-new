<%
/**
 * 
 * <p>Title: "角色授予"权限翻页处理页面</p>
 *
 * <p>Description: "角色授予"权限翻页处理页面</p>
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
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.purviewmanager.PurviewManager,
				com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>								
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
    PurviewManager purviewManager = new PurviewManagerImpl();
    
    String opId = request.getParameter("opId");
    String resTypeId = request.getParameter("resTypeId");
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String currOrgId = request.getParameter("currOrgId");
	//是否批量权限授予
	String isBatch = request.getParameter("isBatch");
	//String PAGE_QUERY_STRING = (String)request.getParameter("pager.PAGE_QUERY_STRING")==null?"":request.getParameter("pager.PAGE_QUERY_STRING");
	
	//选中的
    String checkValue = request.getParameter("checkValues");
    //System.out.println("checkValue = " + checkValue);
    String[] checkValues = null;
    if(!"".equals(checkValue)){
    	checkValues = checkValue.split(",");
    }
    //未选中的
    String un_checkValue = request.getParameter("un_checkValues");
    //System.out.println("un_checkValue = " + un_checkValue);
    String[] un_checkValues = null;
    if(!"".equals(un_checkValues)){
    	un_checkValues = un_checkValue.split(",");
    }
    // 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
    
    boolean state = false;
    if(isBatch.equals("false")){
    	// 彭盛 2011-3-15 
    	if(isrolerelatedorg){
    		state = purviewManager.saveRoleListRoleresop(opId,resTypeId,checkValues,un_checkValues,currRoleId,role_type,currOrgId);
    	}else{
    		state = purviewManager.saveRoleListRoleresop(opId,resTypeId,checkValues,un_checkValues,currRoleId,role_type);
    	}
    }else{
    	// 彭盛 2011-3-15 
    	if(isrolerelatedorg){
    		state = purviewManager.batchSaveRoleListRoleresop(opId,resTypeId,checkValues,currRoleId,role_type,currOrgId);
    	}else{
    		state = purviewManager.batchSaveRoleListRoleresop(opId,resTypeId,checkValues,currRoleId,role_type);
    	}
    }
    //System.out.println("state = " + state);
%>				
<%
	if(state){
%>
	<script language="Javascript">
		alert("保存成功！");
		<%if(isBatch.equals("false")){%>
		//parent.parent.document.location = parent.parent.document.location;
		//parent.document.location = parent.document.location;
		parent.document.location = "rolesetTree.jsp?resTypeId=<%=resTypeId%>&&currRoleId=<%=currRoleId%>&&currOrgId=<%=currOrgId%>&&role_type=<%=role_type%>&&isBatch=<%=isBatch%>";
		<%}%>
	</script>
<%
	}else{
%>
	<script language="Javascript">
		alert("保存失败");
	</script>
<%
	}
%>