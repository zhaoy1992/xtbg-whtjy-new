<%
/*
 * <p>Title: 用户排序后台处理页面</p>
 * <p>Description: 用户排序后台的处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-20
 * @author liangbing.tao
 * @version 1.0
 */
 %>
 
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
	window.onload = function prompt(){
	    if(<%=isSuccess %>){
        parent.divProcessing.style.display="none";
        parent.document.all.button1.disabled = false;
        parent.document.all.button2.disabled = false;
        parent.document.all.button3.disabled = false;
        parent.document.all.button4.disabled = false;
        parent.document.all.b1new.disabled = false;
        alert("操作成功！");
        parent.window.close();
        }else{
           alert("操作失败!");
           parent.close();
        }
    }
</script>