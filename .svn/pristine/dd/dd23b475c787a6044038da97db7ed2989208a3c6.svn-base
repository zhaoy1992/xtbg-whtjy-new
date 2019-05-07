<%-- 
描述：用户排序处理页面
作者：黄艺平
版本：1.0
日期：2013-05-28
 --%>
 
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.OrgJobAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>


<%
    //---------------START--用户组管理写操作日志
    AccessControl control = AccessControl.getInstance();
    control.checkManagerAccess(request,response);
    
    //记录日志
    String operContent="";        
    String operSource=control.getMachinedID();
    String openModle="用户管理";
    String userName = control.getUserName();
    String description="";
    LogManager logManager = SecurityDatabase.getLogManager();   
    
    String userId3 = request.getParameter("userId");
    String orgId = request.getParameter("orgId");
    String[] userId = null;
    boolean isSuccess = false;
    if(userId3 != null && userId3.length() >0){
        userId = userId3.split(",");
    }
    
    if(userId != null && userId.length > 0){
        String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
        operContent="调整机构下用户的排序：机构名称"+orgName_log;                         
        description="";
        logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);
        try{
             isSuccess = "success".equals(OrgJobAction.storeOrgUserOrder(orgId,userId));
        }catch(Exception e){
             e.printStackTrace();
             out.print("机构"+orgName_log+"下的用户排序失败!");
        }
    }else{
        out.print("获取机构下的用户异常!");
    }
%>
<script>
bool = false;
	    if(<%=isSuccess %>){
	    	bool = true;
        }else{
           alert("操作失败!");
           parent.close();
        }

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
	alert("操作失败");
}
</script>