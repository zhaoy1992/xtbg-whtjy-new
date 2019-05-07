/**
 * 
 * <p>Title: 删除岗位操作</p>
 *
 * <p>Description: 岗位删除处理页面</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author gao.tang
 * @version 1.0
 */ 
 <%@ include file="../../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.entity.Job,
				com.chinacreator.sysmgrcore.manager.LogManager,
				com.chinacreator.sysmgrcore.manager.SecurityDatabase,
				com.chinacreator.sysmgrcore.purviewmanager.BussinessCheck,
				com.chinacreator.sysmgrcore.purviewmanager.DefaultBussinessCheckImpl" %>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(pageContext);
	String operContent="";        
    String operSource=control.getMachinedID();
    String openModle="岗位管理";
    String userName = control.getUserName();
    String description="";  
    LogManager logManager = SecurityDatabase.getLogManager();
    BussinessCheck bussinessCheck = new DefaultBussinessCheckImpl();
    
    //request start
    String jobId = request.getParameter("jobId");
    String jobName = request.getParameter("jobName");
    //reauest end
    boolean state = bussinessCheck.jobDeleteCheck(jobId);
    if(state){
		//--岗位管理写操作日志	
		operContent="删除岗位："+jobName; 						
		description="";
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,description);
%>
	<script language="Javascript">
		alert("删除岗位成功！");
		var content  = getNavigatorContent();
		if(content){
			getNavigatorContent().location.href="../navigator_content.jsp";
		}
		parent.location.href = "jobinfo.jsp";
	</script>
<%
	}else{
%>
	<script language="Javascript">
		alert("删除失败！需删除机构岗位关系才能删除");
		var url = "orgsetjobList.jsp?jobId=<%=jobId%>";
		window.showModalDialog(url,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
	</script>
<%
	}
%>
