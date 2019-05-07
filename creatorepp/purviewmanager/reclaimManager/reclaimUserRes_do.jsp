



<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.purviewmanager.PurviewManager"%>
<%@ page import="com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<html>
<%@ include file="/epp/css/cssControl.jsp"%><body ></body>
<script language="javascript">

<%
    AccessControl control = AccessControl.getInstance();
   	control.checkManagerAccess(request,response);
    
    String userIds = request.getParameter("userIds") == null ? "":request.getParameter("userIds");
    String[] userIdList = userIds.split(",");
    //public parameter
    String directRes = request.getParameter("directRes") == null ? "":request.getParameter("directRes");
    String userRoleRes = request.getParameter("userRoleRes") ==null ? "":request.getParameter("userRoleRes");
    String userOrgJobRes = request.getParameter("userOrgJobRes") == null ? "":request.getParameter("userOrgJobRes");
    String userGroupRes = request.getParameter("userGroupRes") == null ? "":request.getParameter("userGroupRes");
    String orgId = request.getParameter("orgId");
    
    PurviewManager manager = new PurviewManagerImpl();
    boolean isReclaimDirectRes = "".equals(directRes) ? false:true;
    boolean isReclaimUserRoles = "".equals(userRoleRes) ? false:true;
    boolean isReclaimUserJobs = "".equals(userOrgJobRes) ? false:true;
    boolean isReclaimUserGroups = "".equals(userGroupRes)?false:true;
    
    // 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
    
    List optFailedList = null;
    if(isrolerelatedorg){
    	optFailedList=manager.reclaimUsersResources(control,userIdList,orgId,isReclaimDirectRes,isReclaimUserRoles,isReclaimUserJobs,isReclaimUserGroups);
    }else{
    	optFailedList=manager.reclaimUsersResources(control,userIdList,isReclaimDirectRes,isReclaimUserRoles,isReclaimUserJobs,isReclaimUserGroups);
    }
    String promptStr = "";    
    for(int i=0;i<optFailedList.size();i++){
        //格式 admin:业务1,业务2,
        if("".equals(promptStr)){
            promptStr = "以下用户资源回收失败:\\n";
            promptStr += String.valueOf(optFailedList.get(i)) + "\\n";
        }else{
            promptStr += String.valueOf(optFailedList.get(i)) + "\\n";
        }        
    }
    if(!"".equals(promptStr)){
%>
        alert("<%=promptStr%>");
<%        
    }else{
%>
        alert("操作成功!");
        window.returnValue = "";
        window.close();
<%
    }
%>
</script>