<%--
描述：菜单授权页面
作者：黄艺平
版本：1.0
时间：2013-5-30
 --%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.purviewmanager.PurviewManager"%>
<%@ page import="com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<html>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<script language="javascript">
var bool = false;
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
       // alert("<%=promptStr%>");
<%        
    }else{
%>
		bool = true;

<%
    }
%>
</script>
<script>
if(bool) {
	mes = "操作成功";

	var ok=function(){
		window.parent.location.reload();
	}

	if(window.top.removeAlertWindows('',false,bool,mes,true)){
		if(bool){
			window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
		} else{
			window.top.alert(mes)
		}
	}
} else {
	alert("<%=promptStr%>");
}
</script>