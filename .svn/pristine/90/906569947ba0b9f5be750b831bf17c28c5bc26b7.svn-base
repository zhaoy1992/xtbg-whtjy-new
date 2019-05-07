<%--
描述：角色权限回收处理页面
作者：黄艺平
版本：1.0
时间：2013-5-30
 --%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.purviewmanager.PurviewManager"%>
<%@ page import="com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl"%>
<%@ page import="com.chinacreator.security.AccessControl, java.util.*"%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<html>
<%@ include file="/epp/css/cssControl.jsp"%><body ></body>
<script language="javascript">
<%
    AccessControl control = AccessControl.getInstance();
   	control.checkManagerAccess(request,response);
    String[] roleIds = null;
    if(request.getParameterValues("ID")!=null){ 
        roleIds = request.getParameterValues("ID");
    }else if(request.getParameter("roleId") != null){
        roleIds = new String[1];
        roleIds[0] = request.getParameter("roleId");
    }
    PurviewManager manager = new PurviewManagerImpl();
    List optFailedList = manager.reclaimRoleResources(roleIds);
    String fialedInfos = "";
    for(int i=0;optFailedList!=null && i<optFailedList.size();i++){
        if("".equals(fialedInfos)){
            fialedInfos = "以下角色资源回收失败:\\n";
            fialedInfos += String.valueOf(optFailedList.get(i)) + "\\n"; 
        }else{
            fialedInfos += String.valueOf(optFailedList.get(i)) + "\\n";
        }
    }
    if("".equals(fialedInfos)){
%>
		var bool = true;
	//alert("操作成功!");
      //parent.window.location.reload();
      
      //window.parent.location.href=parent.window.location.href ;
<%        
    }else{
%>
        alert("<%=fialedInfos%>");
<%        
    }
%>
</script>

<script>
if(bool) {
	mes = "操作成功";
    alert(mes);
	
} else {
	alert("<%=fialedInfos%>");
}
</script>