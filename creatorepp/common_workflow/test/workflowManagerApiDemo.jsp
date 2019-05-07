
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.spi.api.WorkflowManager"%>
<%@ page import="org.frameworkset.spi.BaseSPIManager"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
//##################################################################################	
	String rootPath = request.getContextPath();
	String userName = accesscontroler.getUserAccount();
	/** 启动流程的参数开始*/
	//业务id
	String cc_form_instanceid = request
			.getParameter("cc_form_instanceid");
	//流程定义id
	String workflowId = request.getParameter("workflowId");
	//流程定义名称
	String mgrName = request.getParameter("mgrName");
	//活动定义id
	String actDefId = request.getParameter("actDefId");
	//活动定义名称
	String actDefName = request.getParameter("actDefName");
	//模块id
	String moduleId = request.getParameter("moduleId");
	/** 启动流程的参数结束*/

	//流程实例id
	String procInsId = request.getParameter("procInsId");
	procInsId = procInsId == null ? "" : procInsId;
	//操作类型，如daiban表示是待办进来的
	String operType = request.getParameter("operType");
	operType = operType == null ? "" : operType;
	if(operType.equals(""))operType="nosend";
	//活动实例id
	String actInsId = request.getParameter("actInsId");
	actInsId = actInsId == null ? "" : actInsId;

	String action = request.getParameter("action");
	//当然也可以获取自定义的参数
//##################################################################################

	WorkflowManager workflowManager = (WorkflowManager)BaseSPIManager.getProvider("workflowManager");
	//获取最新版本流程名字
	mgrName = workflowManager.getCurVerMgrNameByMgrName(mgrName);
	String opType = "isShowActSelectText@isShowUserText@isShowBackButton@isShowRecycle@isShowSuspend" + 
			"@isShowResume@isShowCompleteWorkflow@isShowTempSaveForm@isShowTerminate";
	String isShowActSelectText = "";
	String isShowUserText = "";
	String isShowBackButton = "";
	String isShowRecycle = "";
	String isShowSuspend = "";
	String isShowResume = "";
	String isShowCompleteWorkflow = "";
	String isShowTempSaveForm = "";
	String isShowTerminate = "";
	try{
		String ret = workflowManager.queryForWorkflowEngine(userName,opType,mgrName,actInsId,procInsId,operType,actDefId,moduleId);
		String[] rets = ret.split("@");
		isShowActSelectText = rets[0];
		isShowUserText = rets[1];
		isShowBackButton = rets[2];
		isShowRecycle = rets[3];
		isShowSuspend = rets[4];
		isShowResume = rets[5];
		isShowCompleteWorkflow = rets[6];
		isShowTempSaveForm = rets[7];
		isShowTerminate = rets[8];
		System.out.println("isShowActSelectText = " + isShowActSelectText);
		System.out.println("isShowUserText = " + isShowUserText);
		System.out.println("isShowBackButton = " + isShowBackButton);
		System.out.println("isShowRecycle = " + isShowRecycle);
		System.out.println("isShowSuspend = " + isShowSuspend);
		System.out.println("isShowResume = " + isShowResume);
		System.out.println("isShowCompleteWorkflow = " + isShowCompleteWorkflow);
		System.out.println("isShowTempSaveForm = " + isShowTempSaveForm);
		System.out.println("isShowTerminate = " + isShowTerminate);
	}catch(Exception e){
		e.printStackTrace();
	}


	//用来传变量
	java.util.Map map = new java.util.HashMap();
	try{
		if("start_form".equals(action)){//启动流程
			workflowManager.startWorkflowWrapperReturn(userName, mgrName,map,cc_form_instanceid,"",moduleId);
		}else if("handle_form".equals(action)){//完成活动
			workflowManager.completeActWrapper(map,userName,actInsId,cc_form_instanceid,moduleId,"false");
		}else if("terminate_form".equals(action)){//终止流程
			workflowManager.terminateProcessByProcId(userName,procInsId,"");
		}else if("suspend_form".equals(action)){//挂起流程
			workflowManager.suspendProcessByProcId(userName,procInsId,"");
		}else if("resume_form".equals(action)){//恢复流程
			workflowManager.resumeProcessByProcId(userName,procInsId,"");
		}else if("suspend_act_form".equals(action)){//挂起活动
			workflowManager.suspendProcess(userName,actInsId,"");
		}else if("resume_act_form".equals(action)){//恢复活动
			workflowManager.resumeProcess(userName,actInsId,"");
		}else if("tobe_form".equals(action)){//暂存活动
			if(procInsId!=null && !procInsId.equals("") && actInsId!=null && !actInsId.equals("")){
				workflowManager.WorkflowNotCompleteActWrapperWithRet(procInsId,actInsId,userName, mgrName,cc_form_instanceid,"","","","");
			}else{
				workflowManager.startWorkflowNotCompleteFirstActWrapperWithRet(userName, mgrName,cc_form_instanceid,"","","","",moduleId);
			}
		}else if("back_form".equals(action)){//回退
			workflowManager.backAct(userName,actInsId,cc_form_instanceid);
		}else if("recycle_form".equals(action)){//收回
			workflowManager.recycleAct(userName,actInsId);
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>
<html>
	<head>
		<title>流程接口使用Demo1</title>
		<script type="text/javascript">
			parent.parent.document.workflowform.style.display="none";
			
			function startForm(){
				document.getElementById("action").value = "start_form";
				workflow_form.submit();
				parent.parent.parent.document.location = "<%=rootPath%>/common_workflow/main.jsp";
			}
			
			function handleForm(){
				document.getElementById("action").value = "handle_form";
				workflow_form.submit();
				parent.parent.parent.document.location = "<%=rootPath%>/common_workflow/main.jsp";
			}
			
			function terminateForm(){
				document.getElementById("action").value = "terminate_form";
				workflow_form.submit();
				parent.parent.parent.document.location = "<%=rootPath%>/common_workflow/main.jsp";
			}
			
			function suspendForm(){
				document.getElementById("action").value = "suspend_form";
				workflow_form.submit();
				parent.parent.parent.document.location = "<%=rootPath%>/common_workflow/main.jsp";
			}
			
			function resumeForm(){
				document.getElementById("action").value = "resume_form";
				workflow_form.submit();
				parent.parent.parent.document.location = "<%=rootPath%>/common_workflow/main.jsp";
			}
			
			function suspendActForm(){
				document.getElementById("action").value = "suspend_act_form";
				workflow_form.submit();
				parent.parent.parent.document.location = "<%=rootPath%>/common_workflow/main.jsp";
			}
			
			function resumeActForm(){
				document.getElementById("action").value = "resume_act_form";
				workflow_form.submit();
				parent.parent.parent.document.location = "<%=rootPath%>/common_workflow/main.jsp";
			}
			
			function tobeForm(){
				document.getElementById("action").value = "tobe_form";
				workflow_form.submit();
				parent.parent.parent.document.location = "<%=rootPath%>/common_workflow/main.jsp";
			}
			
			function backForm(){
				document.getElementById("action").value = "back_form";
				workflow_form.submit();
				parent.parent.parent.document.location = "<%=rootPath%>/common_workflow/main.jsp";
			}
			
			function recycleForm(){
				document.getElementById("action").value = "recycle_form";
				workflow_form.submit();
				parent.parent.parent.document.location = "<%=rootPath%>/common_workflow/main.jsp";
			}
		</script>
<%@ include file="/epp/css/cssControl.jsp"%>
	</head>
	<body>
		<form name="workflow_form" action="workflowManagerApiDemo.jsp" mdthod="post">
			<table cellspacing="0" cellpadding="0" border="0"
				bordercolor="#EEEEEE" width=100% class="thin" readonly>
					<input type="hidden" name="cc_form_instanceid" value="<%=cc_form_instanceid%>">
					<input type="hidden" name="workflowId" value="<%=workflowId%>">
					<input type="hidden" name="mgrName" value="<%=mgrName %>">
					<input type="hidden" name="actDefId" value="<%=actDefId%>">
					<input type="hidden" name="actDefName" value="<%=actDefName%>">
					<input type="hidden" name="procInsId" value="<%=procInsId%>">
					<input type="hidden" name="moduleId" value="<%=moduleId%>">
					<input type="hidden" name="procInsId" value="<%=procInsId%>">
					<input type="hidden" name="operType" value="<%=operType%>">
					<input type="hidden" name="actInsId" value="<%=actInsId%>">
					<input type="hidden" name="action" value="">
				<tr>
					<td align="center">
						<b>流程接口使用Demo1<input class="input" type="button" value="查看源码" /></b>
					</td>
				</tr>
				<tr>
					<td>
					<font color="red">本例主要讲解流程接口：启动流程、完成活动、启动流程暂存、流程中暂存、挂起流程、恢复流程、回退、收回、终止流程、流程权限统一查询等。</font><br/>
					由于是使用的自定义jsp，并且在自定义jsp中自己实现了流程操作按钮，所以需要将平台自带的按钮隐藏掉，加载jsp之前要运行：
					parent.parent.document.workflowform.style.display="none";</td>
				</tr>
				<%--<tr>
					<td>控制变量：<input type="text" name="control_text" value=""/></td>
				</tr>
				--%><tr>
					<td>流程接口类及其实现类实例化方法：<br/>
					接口：com.chinacreator.spi.api.WorkflowManager<br/>
					实例化：WorkflowManager impl = (WorkflowManager)org.frameworkset.spi.BaseSPIManager.getProvider("workflowManager");<br/>
					 其实现类在workflowmanager-provider.xml中配置。<br/>
					</td>
				</tr>
				<tr>
					<td align="left">
						<% 
						if(procInsId == null || "".equals(procInsId)){
						%>
						<input class="input" type="button" name="start_form" value="启动流程"
							onClick="startForm()">
						<%}else{ if("true".equals(isShowCompleteWorkflow)){ %>
							<input class="input" type="button" name="handle_form" value="完成活动"
								onClick="handleForm()">
						<%}if("true".equals(isShowTerminate)){ %>
							<input class="input" type="button" name="terminate_form" value="终止流程"
								onClick="terminateForm()">
						<%}} %>
						<%if("true".equals(isShowSuspend)){ %>
							<input class="input" type="button" name="suspend_form" value="挂起流程"
								onClick="suspendForm()">
							<input class="input" type="button" name="suspend_act_form" value="挂起活动"
								onClick="suspendActForm()">
						<%}if("true".equals(isShowResume)){ %>
							<input class="input" type="button" name="resume_form" value="恢复流程"
								onClick="resumeForm()">
							<input class="input" type="button" name="resume_act_form" value="恢复活动"
								onClick="resumeActForm()">
						<%}if("true".equals(isShowTempSaveForm)){ %>
							<input class="input" type="button" name="tobe_form" value="暂存"
								onClick="tobeForm()">
						<%}if("true".equals(isShowBackButton)){ %>
							<input class="input" type="button" name="back_form" value="回退"
								onClick="backForm()">
						<%}if("true".equals(isShowRecycle)){ %>
							<input class="input" type="button" name="recycle_form" value="收回"
								onClick="recycleForm()">
						<%}%>
						&nbsp;&nbsp;当前活动：<%=actDefId %>
					</td>
				</tr>
					<% 
					if(procInsId == null || "".equals(procInsId)){
					%>
				<tr>
					<td style="color:#8080FF">
						<font color=red>启动流程接口说明：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('start').style.display=='none'){document.getElementById('start').style.display=''}else{document.getElementById('start').style.display='none'}"><br/>
<div id="start" style="display:none">
java.lang.String startWorkflowWrapperReturn(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String mgrName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.util.Map map,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String busiId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String moduleId<br/>
)throws java.lang.Exception<br/>
 描述：启动流程并且完成第一个活动 返回流程实例id 记录流程操作日志，带事物控制 <br/>

参数：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户名<br/>
&nbsp;&nbsp;&nbsp;&nbsp;mgrName - 流程名 （格式为：流程包ID#流程版本号#流程定义id）<br/>
&nbsp;&nbsp;&nbsp;&nbsp;map - 工作流控制参数（动态参与者：DYNAMICPERFORMER、指定下一活动：NEXT_ACT、所有人都执行：ALLUSERSEXCUTE 等）<br/>
&nbsp;&nbsp;&nbsp;&nbsp;busiId - 业务id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - 操作ip地址<br/>
&nbsp;&nbsp;&nbsp;&nbsp;moduleId - 模块(事项)ID <br/>
返回：
String <br/>
抛出： 
java.lang.Exception<br/>
</div>
					</td>
				</tr>
						<%}else{ if("true".equals(isShowCompleteWorkflow)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>完成活动接口说明：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('complete').style.display=='none'){document.getElementById('complete').style.display=''}else{document.getElementById('complete').style.display='none'}"><br/>
<div id="complete" style="display:none">
int completeActWrapper(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.util.Map map,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String busiId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String isFirstAct)<br/>
                       throws java.lang.Exception<br/>
                       描述：完成活动操作封装，封装了完成活动的工作流代码。 （待办标题取模块名称） <br/>


参数：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;map - 工作流控制参数（动态参与者：DYNAMICPERFORMER、指定下一活动：NEXT_ACT、所有人都执行：ALLUSERSEXCUTE 等）<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - 当前用户<br/>
&nbsp;&nbsp;&nbsp;&nbsp;actInsId - 活动实例id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;busiId - 业务id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;isFirstAct - 是否第一个活动(true或false) <br/>
抛出： 
java.lang.Exception<br/>
</div>
					</td>
				</tr>
						<%}if("true".equals(isShowTerminate)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>终止流程接口说明：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('termi').style.display=='none'){document.getElementById('termi').style.display=''}else{document.getElementById('termi').style.display='none'}"><br/>
<div id="termi" style="display:none">
void terminateProcessByProcId(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String procInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr)<br/>
throws java.lang.Exception<br/>
描述：终止流程，将该流程终止 <br/>
参数：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户名<br/>
&nbsp;&nbsp;&nbsp;&nbsp;procInsId - 流程实例id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - 操作ip地址 <br/>
抛出： 
java.lang.Exception
</div>					
					</td>
				</tr>
						<%}} %>
						<%if("true".equals(isShowSuspend)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>挂起流程接口说明：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('suspend').style.display=='none'){document.getElementById('suspend').style.display=''}else{document.getElementById('suspend').style.display='none'}"><br/>
<div id="suspend" style="display:none">
void suspendProcessByProcId(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String procInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr)<br/>
                            throws java.lang.Exception<br/>
							挂起流程<br/> 
参数：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户名<br/>
&nbsp;&nbsp;&nbsp;&nbsp;procInsId - 流程实例id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - 操作ip地址 <br/>
抛出： 
java.lang.Exception
</div>					
					</td>
				</tr>
				<tr>
					<td style="color:#8080FF">
						<font color=red>挂起活动接口说明：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('suspend_act').style.display=='none'){document.getElementById('suspend_act').style.display=''}else{document.getElementById('suspend_act').style.display='none'}"><br/>
<div id="suspend_act" style="display:none">
void suspendProcess(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr)<br/>
                            throws java.lang.Exception<br/>
							挂起活动<br/> 
参数：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户名<br/>
&nbsp;&nbsp;&nbsp;&nbsp;procInsId - 活动实例id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - 操作ip地址 <br/>
抛出： 
java.lang.Exception
</div>					
					</td>
				</tr>
						<%}if("true".equals(isShowResume)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>恢复流程接口说明：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('resume').style.display=='none'){document.getElementById('resume').style.display=''}else{document.getElementById('resume').style.display='none'}"><br/>
<div id="resume" style="display:none">
void resumeProcessByProcId(<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String procInsId,<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr)<br/> 
throws java.lang.Exception<br/> 恢复流程 <br/> 
参数：<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户名<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;procInsId - 流程实例id<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - 操作ip地址 <br/> 
抛出： 
java.lang.Exception
</div>					
					</td>
				</tr>
						<%}if("true".equals(isShowTempSaveForm)){ if(procInsId == null || "".equals(procInsId)){%>
				<tr>
					<td style="color:#8080FF">
						<font color=red>启动流程暂存接口说明：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('temp').style.display=='none'){document.getElementById('temp').style.display=''}else{document.getElementById('temp').style.display='none'}"><br/>
<div id="temp" style="display:none">
java.lang.String startWorkflowNotCompleteFirstActWrapperWithRet(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String mgrName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String busiId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String dynamicperformer,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String next_act,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String andsplitusers,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String moduleId)<br/>
throws java.lang.Exception<br/>启动流程时暂存，带流程控制参数和返回值 <br/>
参数：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户名<br/>
&nbsp;&nbsp;&nbsp;&nbsp;mgrName - 流程名 （格式为：流程包ID#流程版本号#流程定义id）<br/>
&nbsp;&nbsp;&nbsp;&nbsp;busiId - 业务id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - 操作ip地址<br/>
&nbsp;&nbsp;&nbsp;&nbsp;dynamicperformer - 动态选人参数:一个或多个用户名组成，多个由逗号(“,”)隔开，可以为空<br/>
&nbsp;&nbsp;&nbsp;&nbsp;next_act - 下一步活动参数：下一步活动定义id，可以为空<br/>
&nbsp;&nbsp;&nbsp;&nbsp;andsplitusers - 与分支选人参数:格式=活动定义id1:userName1,userName2;活动定义id2:userName3,userName4<br/>
&nbsp;&nbsp;&nbsp;&nbsp;moduleId - 模块(事项)ID <br/>
返回：
流程实例id <br/>
抛出： 
java.lang.Exception		
</div>			
					</td>
				</tr>
				<%}else{ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>流程中暂存接口说明：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('temp1').style.display=='none'){document.getElementById('temp1').style.display=''}else{document.getElementById('temp1').style.display='none'}"><br/>
<div id="temp1" style="display:none">
java.lang.String WorkflowNotCompleteActWrapperWithRet(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String procInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String mgrName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String busiId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String dynamicperformer,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String next_act,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String andsplitusers)<br/>
throws java.lang.Exception<br/>流程活动中暂存，带流程控制参数和返回值 <br/>
参数：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;procInsId - 流程实例id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;actInsId - 活动实例id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户名<br/>
&nbsp;&nbsp;&nbsp;&nbsp;mgrName - 流程名 （格式为：流程包ID#流程版本号#流程定义id）<br/>
&nbsp;&nbsp;&nbsp;&nbsp;busiId - 业务id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - 操作ip地址<br/>
&nbsp;&nbsp;&nbsp;&nbsp;dynamicperformer - 动态选人参数:一个或多个用户名组成，多个由逗号(“,”)隔开<br/>
&nbsp;&nbsp;&nbsp;&nbsp;next_act - 下一步活动参数：下一步活动定义id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;andsplitusers - 与分支选人参数:格式=活动定义id1:userName1,userName2;活动定义id2:userName3,userName4 <br/>
返回：
String 流程实例id <br/>
抛出： 
java.lang.Exception	
</div>			
					</td>
				</tr>
						<%}}if("true".equals(isShowBackButton)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>回退活动接口说明：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('back').style.display=='none'){document.getElementById('back').style.display=''}else{document.getElementById('back').style.display='none'}"><br/>
<div id="back" style="display:none">
void backAct(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String busiId)<br/>
throws java.lang.Exception<br/>描述：退回活动，将当前活动退回至上一活动 <br/>
参数：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户名<br/>
&nbsp;&nbsp;&nbsp;&nbsp;actInsId - 活动实例id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;busiId - 业务id <br/>
抛出： 
java.lang.Exception
</div>				
					</td>
				</tr>
						<%}if("true".equals(isShowRecycle)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>收回活动接口说明：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('recycle').style.display=='none'){document.getElementById('recycle').style.display=''}else{document.getElementById('recycle').style.display='none'}"><br/>
<div id="recycle" style="display:none">
void recycleAct(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId)<br/>
throws java.lang.Exception<br/>
描述：收回任务，如果活动的下一个活动还没有执行，那么上一活动的执行人可以将任务收回 <br/>
参数：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;actInsId - 活动实例id <br/>
抛出： 
java.lang.Exception
</div>					
					</td>
				</tr>
						<%}%>
				<tr>
					<td style="color:#8080FF">
					<font color=red>流程权限等查询接口，通过此接口来控制流程操作权限，如是否显示回退等...：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('query').style.display=='none'){document.getElementById('query').style.display=''}else{document.getElementById('query').style.display='none'}"><br/>
					<div id="query" style="display:none">	
					java.lang.String queryForWorkflowEngine(<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
                    &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String opType,<br/>
                    &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String mgrName,<br/>
                    &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
                    &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String procInsId,<br/>
                    &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String operType,<br/>
                    &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actDefId,<br/>
                    &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String moduleId)<br/>
                    throws java.lang.Exception<br/>
                                                      表单中请求的统一处理入口（比如判断某按钮是否显示，根据活动实例id得到流程实例id等等） <br/>
					参数：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户名<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;opType - 需要查询的参数，多个查询参数用@分隔，目前支持如下参数：<br/> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{getActName-根据活动实例id得到流程实例id<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;getActObject-获取活动对象，其返回格式:
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;actDefId||actName||createdDate||procInsId||version||actInsId<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;getProcInsId-根据活动实例id得到流程实例id<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowActSelectText-是否允许选择下一步活动，其返回格式:
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowActSelectText:true/false;isShowAndActSelectText:true/false;活动定义id:活动名称<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowUserText-是否允许动态选人;<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowBackButton-是否允许回退<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowRecycle-是否允许收回<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowSuspend-是否允许挂起<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowResume-是否允许恢复<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowCompleteWorkflow-是否允许完成活动<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowTempSaveForm-是否允许暂存<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowTerminate-是否允许终止流程<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isRoute-是否为路由活动<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hasOnlyOnePerformer-活动是否只有一个参与者<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isactivityonuse-活动是否正被使用}<br/>					
					&nbsp;&nbsp;&nbsp;&nbsp;mgrName - 流程名 （格式为：流程包ID#流程版本号#流程定义id）<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;actInsId - 活动实例id<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;procInsId - 流程实例id<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;operType - 操作类型：目前有以下类型：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{daiban-待办列表<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nosend-暂存列表<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;readonly-已办列表<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;suspend-挂起列表<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;onuse-正被使用}<br/>
					
					&nbsp;&nbsp;&nbsp;&nbsp;actDefId - 活动定义id<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;moduleId - 模块(事项)ID <br/>
					返回：<br/>
					String 查询结果，多个查询结果之间由@分隔 <br/>
					抛出： <br/>
					java.lang.Exception<br/>		
					</div>
					</td>
				</tr>
				<tr>
					<td style="color:#8080FF">
					<font color=red>在流程绑定的jsp中如何获取流程参数？其实很简单，如下代码：</font>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('param').style.display=='none'){document.getElementById('param').style.display=''}else{document.getElementById('param').style.display='none'}"><br/>
					<div id="param" style="display:none">	
					String rootPath = request.getContextPath();<br/>
					String userName = accesscontroler.getUserAccount();<br/>
					/** 启动流程的参数开始*/<br/>
					//业务id<br/>
					String cc_form_instanceid = request
							.getParameter("cc_form_instanceid");<br/>
					//流程定义id<br/>
					String workflowId = request.getParameter("workflowId");<br/>
					//流程定义名称<br/>
					String mgrName = request.getParameter("mgrName");<br/>
					//活动定义id<br/>
					String actDefId = request.getParameter("actDefId");<br/>
					//活动定义名称<br/>
					String actDefName = request.getParameter("actDefName");<br/>
					//模块id<br/>
					String moduleId = request.getParameter("moduleId");<br/>
					/** 启动流程的参数结束*/<br/>
				
					//流程实例id<br/>
					String procInsId = request.getParameter("procInsId");<br/>
					procInsId = procInsId == null ? "" : procInsId;<br/>
					//操作类型，如daiban表示是待办进来的<br/>
					String operType = request.getParameter("operType");<br/>
					operType = operType == null ? "" : operType;<br/>
					if(operType.equals(""))operType="nosend";<br/>
					//活动实例id<br/>
					String actInsId = request.getParameter("actInsId");<br/>
					actInsId = actInsId == null ? "" : actInsId;<br/>
				
					String action = request.getParameter("action");<br/>
					//当然也可以获取自定义的参数<br/>
					可以查看运行页面url，只要url中有的参数都能从request中获取。
					</div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

