<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.OrgJobAction"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%
    //---------------START--�û������д������־
    AccessControl control = AccessControl.getInstance();
    control.checkAccess(request,response);
    //��¼��־
    String operContent="";        
    String operSource=control.getMachinedID();
    String openModle="�û�����";
    String userName = control.getUserName();
    String description="";
    LogManager logManager = SecurityDatabase.getLogManager();   
    
    String userId3 = request.getParameter("userId");
    String orgId = request.getParameter("orgId");
    String[] userId = null;
    if(userId3 != null && userId3.length() >0){
        userId = userId3.split(",");
    }
    if(userId != null && userId.length > 0){
        String orgName_log = LogGetNameById.getOrgNameByOrgId(orgId);
        operContent="�����������û������򣺻�������"+orgName_log;                         
        description="";
        logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);
        OrgJobAction.storeOrgUserOrder(orgId,userId);        
    }else{
        out.print("��ȡ�����µ��û��쳣!");
    }
%>
<script>
	window.onload = function prompt(){
        //alert("�����ɹ�!");
        parent.divProcessing.style.display="none";
        parent.document.all.button1.disabled = false;
        parent.document.all.button2.disabled = false;
        parent.document.all.button3.disabled = false;
        parent.document.all.button4.disabled = false;
        parent.document.all.b1new.disabled = false;
    }
</script>