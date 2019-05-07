
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
	/** �������̵Ĳ�����ʼ*/
	//ҵ��id
	String cc_form_instanceid = request
			.getParameter("cc_form_instanceid");
	//���̶���id
	String workflowId = request.getParameter("workflowId");
	//���̶�������
	String mgrName = request.getParameter("mgrName");
	//�����id
	String actDefId = request.getParameter("actDefId");
	//���������
	String actDefName = request.getParameter("actDefName");
	//ģ��id
	String moduleId = request.getParameter("moduleId");
	/** �������̵Ĳ�������*/

	//����ʵ��id
	String procInsId = request.getParameter("procInsId");
	procInsId = procInsId == null ? "" : procInsId;
	//�������ͣ���daiban��ʾ�Ǵ��������
	String operType = request.getParameter("operType");
	operType = operType == null ? "" : operType;
	if(operType.equals(""))operType="nosend";
	//�ʵ��id
	String actInsId = request.getParameter("actInsId");
	actInsId = actInsId == null ? "" : actInsId;

	String action = request.getParameter("action");
	//��ȻҲ���Ի�ȡ�Զ���Ĳ���
//##################################################################################

	WorkflowManager workflowManager = (WorkflowManager)BaseSPIManager.getProvider("workflowManager");
	//��ȡ���°汾��������
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


	//����������
	java.util.Map map = new java.util.HashMap();
	try{
		if("start_form".equals(action)){//��������
			workflowManager.startWorkflowWrapperReturn(userName, mgrName,map,cc_form_instanceid,"",moduleId);
		}else if("handle_form".equals(action)){//��ɻ
			workflowManager.completeActWrapper(map,userName,actInsId,cc_form_instanceid,moduleId,"false");
		}else if("terminate_form".equals(action)){//��ֹ����
			workflowManager.terminateProcessByProcId(userName,procInsId,"");
		}else if("suspend_form".equals(action)){//��������
			workflowManager.suspendProcessByProcId(userName,procInsId,"");
		}else if("resume_form".equals(action)){//�ָ�����
			workflowManager.resumeProcessByProcId(userName,procInsId,"");
		}else if("suspend_act_form".equals(action)){//����
			workflowManager.suspendProcess(userName,actInsId,"");
		}else if("resume_act_form".equals(action)){//�ָ��
			workflowManager.resumeProcess(userName,actInsId,"");
		}else if("tobe_form".equals(action)){//�ݴ�
			if(procInsId!=null && !procInsId.equals("") && actInsId!=null && !actInsId.equals("")){
				workflowManager.WorkflowNotCompleteActWrapperWithRet(procInsId,actInsId,userName, mgrName,cc_form_instanceid,"","","","");
			}else{
				workflowManager.startWorkflowNotCompleteFirstActWrapperWithRet(userName, mgrName,cc_form_instanceid,"","","","",moduleId);
			}
		}else if("back_form".equals(action)){//����
			workflowManager.backAct(userName,actInsId,cc_form_instanceid);
		}else if("recycle_form".equals(action)){//�ջ�
			workflowManager.recycleAct(userName,actInsId);
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>
<html>
	<head>
		<title>���̽ӿ�ʹ��Demo1</title>
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
						<b>���̽ӿ�ʹ��Demo1<input class="input" type="button" value="�鿴Դ��" /></b>
					</td>
				</tr>
				<tr>
					<td>
					<font color="red">������Ҫ�������̽ӿڣ��������̡���ɻ�����������ݴ桢�������ݴ桢�������̡��ָ����̡����ˡ��ջء���ֹ���̡�����Ȩ��ͳһ��ѯ�ȡ�</font><br/>
					������ʹ�õ��Զ���jsp���������Զ���jsp���Լ�ʵ�������̲�����ť��������Ҫ��ƽ̨�Դ��İ�ť���ص�������jsp֮ǰҪ���У�
					parent.parent.document.workflowform.style.display="none";</td>
				</tr>
				<%--<tr>
					<td>���Ʊ�����<input type="text" name="control_text" value=""/></td>
				</tr>
				--%><tr>
					<td>���̽ӿ��༰��ʵ����ʵ����������<br/>
					�ӿڣ�com.chinacreator.spi.api.WorkflowManager<br/>
					ʵ������WorkflowManager impl = (WorkflowManager)org.frameworkset.spi.BaseSPIManager.getProvider("workflowManager");<br/>
					 ��ʵ������workflowmanager-provider.xml�����á�<br/>
					</td>
				</tr>
				<tr>
					<td align="left">
						<% 
						if(procInsId == null || "".equals(procInsId)){
						%>
						<input class="input" type="button" name="start_form" value="��������"
							onClick="startForm()">
						<%}else{ if("true".equals(isShowCompleteWorkflow)){ %>
							<input class="input" type="button" name="handle_form" value="��ɻ"
								onClick="handleForm()">
						<%}if("true".equals(isShowTerminate)){ %>
							<input class="input" type="button" name="terminate_form" value="��ֹ����"
								onClick="terminateForm()">
						<%}} %>
						<%if("true".equals(isShowSuspend)){ %>
							<input class="input" type="button" name="suspend_form" value="��������"
								onClick="suspendForm()">
							<input class="input" type="button" name="suspend_act_form" value="����"
								onClick="suspendActForm()">
						<%}if("true".equals(isShowResume)){ %>
							<input class="input" type="button" name="resume_form" value="�ָ�����"
								onClick="resumeForm()">
							<input class="input" type="button" name="resume_act_form" value="�ָ��"
								onClick="resumeActForm()">
						<%}if("true".equals(isShowTempSaveForm)){ %>
							<input class="input" type="button" name="tobe_form" value="�ݴ�"
								onClick="tobeForm()">
						<%}if("true".equals(isShowBackButton)){ %>
							<input class="input" type="button" name="back_form" value="����"
								onClick="backForm()">
						<%}if("true".equals(isShowRecycle)){ %>
							<input class="input" type="button" name="recycle_form" value="�ջ�"
								onClick="recycleForm()">
						<%}%>
						&nbsp;&nbsp;��ǰ���<%=actDefId %>
					</td>
				</tr>
					<% 
					if(procInsId == null || "".equals(procInsId)){
					%>
				<tr>
					<td style="color:#8080FF">
						<font color=red>�������̽ӿ�˵����</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('start').style.display=='none'){document.getElementById('start').style.display=''}else{document.getElementById('start').style.display='none'}"><br/>
<div id="start" style="display:none">
java.lang.String startWorkflowWrapperReturn(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String mgrName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.util.Map map,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String busiId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String moduleId<br/>
)throws java.lang.Exception<br/>
 �������������̲�����ɵ�һ��� ��������ʵ��id ��¼���̲�����־����������� <br/>

������<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - �û���<br/>
&nbsp;&nbsp;&nbsp;&nbsp;mgrName - ������ ����ʽΪ�����̰�ID#���̰汾��#���̶���id��<br/>
&nbsp;&nbsp;&nbsp;&nbsp;map - ���������Ʋ�������̬�����ߣ�DYNAMICPERFORMER��ָ����һ���NEXT_ACT�������˶�ִ�У�ALLUSERSEXCUTE �ȣ�<br/>
&nbsp;&nbsp;&nbsp;&nbsp;busiId - ҵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - ����ip��ַ<br/>
&nbsp;&nbsp;&nbsp;&nbsp;moduleId - ģ��(����)ID <br/>
���أ�
String <br/>
�׳��� 
java.lang.Exception<br/>
</div>
					</td>
				</tr>
						<%}else{ if("true".equals(isShowCompleteWorkflow)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>��ɻ�ӿ�˵����</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('complete').style.display=='none'){document.getElementById('complete').style.display=''}else{document.getElementById('complete').style.display='none'}"><br/>
<div id="complete" style="display:none">
int completeActWrapper(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.util.Map map,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String busiId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String isFirstAct)<br/>
                       throws java.lang.Exception<br/>
                       ��������ɻ������װ����װ����ɻ�Ĺ��������롣 ���������ȡģ�����ƣ� <br/>


������<br/>
&nbsp;&nbsp;&nbsp;&nbsp;map - ���������Ʋ�������̬�����ߣ�DYNAMICPERFORMER��ָ����һ���NEXT_ACT�������˶�ִ�У�ALLUSERSEXCUTE �ȣ�<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - ��ǰ�û�<br/>
&nbsp;&nbsp;&nbsp;&nbsp;actInsId - �ʵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;busiId - ҵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;isFirstAct - �Ƿ��һ���(true��false) <br/>
�׳��� 
java.lang.Exception<br/>
</div>
					</td>
				</tr>
						<%}if("true".equals(isShowTerminate)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>��ֹ���̽ӿ�˵����</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('termi').style.display=='none'){document.getElementById('termi').style.display=''}else{document.getElementById('termi').style.display='none'}"><br/>
<div id="termi" style="display:none">
void terminateProcessByProcId(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String procInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr)<br/>
throws java.lang.Exception<br/>
��������ֹ���̣�����������ֹ <br/>
������<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - �û���<br/>
&nbsp;&nbsp;&nbsp;&nbsp;procInsId - ����ʵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - ����ip��ַ <br/>
�׳��� 
java.lang.Exception
</div>					
					</td>
				</tr>
						<%}} %>
						<%if("true".equals(isShowSuspend)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>�������̽ӿ�˵����</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('suspend').style.display=='none'){document.getElementById('suspend').style.display=''}else{document.getElementById('suspend').style.display='none'}"><br/>
<div id="suspend" style="display:none">
void suspendProcessByProcId(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String procInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr)<br/>
                            throws java.lang.Exception<br/>
							��������<br/> 
������<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - �û���<br/>
&nbsp;&nbsp;&nbsp;&nbsp;procInsId - ����ʵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - ����ip��ַ <br/>
�׳��� 
java.lang.Exception
</div>					
					</td>
				</tr>
				<tr>
					<td style="color:#8080FF">
						<font color=red>�����ӿ�˵����</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('suspend_act').style.display=='none'){document.getElementById('suspend_act').style.display=''}else{document.getElementById('suspend_act').style.display='none'}"><br/>
<div id="suspend_act" style="display:none">
void suspendProcess(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr)<br/>
                            throws java.lang.Exception<br/>
							����<br/> 
������<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - �û���<br/>
&nbsp;&nbsp;&nbsp;&nbsp;procInsId - �ʵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - ����ip��ַ <br/>
�׳��� 
java.lang.Exception
</div>					
					</td>
				</tr>
						<%}if("true".equals(isShowResume)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>�ָ����̽ӿ�˵����</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('resume').style.display=='none'){document.getElementById('resume').style.display=''}else{document.getElementById('resume').style.display='none'}"><br/>
<div id="resume" style="display:none">
void resumeProcessByProcId(<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String procInsId,<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String remoteAddr)<br/> 
throws java.lang.Exception<br/> �ָ����� <br/> 
������<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;userName - �û���<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;procInsId - ����ʵ��id<br/> 
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - ����ip��ַ <br/> 
�׳��� 
java.lang.Exception
</div>					
					</td>
				</tr>
						<%}if("true".equals(isShowTempSaveForm)){ if(procInsId == null || "".equals(procInsId)){%>
				<tr>
					<td style="color:#8080FF">
						<font color=red>���������ݴ�ӿ�˵����</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('temp').style.display=='none'){document.getElementById('temp').style.display=''}else{document.getElementById('temp').style.display='none'}"><br/>
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
throws java.lang.Exception<br/>��������ʱ�ݴ棬�����̿��Ʋ����ͷ���ֵ <br/>
������<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - �û���<br/>
&nbsp;&nbsp;&nbsp;&nbsp;mgrName - ������ ����ʽΪ�����̰�ID#���̰汾��#���̶���id��<br/>
&nbsp;&nbsp;&nbsp;&nbsp;busiId - ҵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - ����ip��ַ<br/>
&nbsp;&nbsp;&nbsp;&nbsp;dynamicperformer - ��̬ѡ�˲���:һ�������û�����ɣ�����ɶ���(��,��)����������Ϊ��<br/>
&nbsp;&nbsp;&nbsp;&nbsp;next_act - ��һ�����������һ�������id������Ϊ��<br/>
&nbsp;&nbsp;&nbsp;&nbsp;andsplitusers - ���֧ѡ�˲���:��ʽ=�����id1:userName1,userName2;�����id2:userName3,userName4<br/>
&nbsp;&nbsp;&nbsp;&nbsp;moduleId - ģ��(����)ID <br/>
���أ�
����ʵ��id <br/>
�׳��� 
java.lang.Exception		
</div>			
					</td>
				</tr>
				<%}else{ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>�������ݴ�ӿ�˵����</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('temp1').style.display=='none'){document.getElementById('temp1').style.display=''}else{document.getElementById('temp1').style.display='none'}"><br/>
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
throws java.lang.Exception<br/>���̻���ݴ棬�����̿��Ʋ����ͷ���ֵ <br/>
������<br/>
&nbsp;&nbsp;&nbsp;&nbsp;procInsId - ����ʵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;actInsId - �ʵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - �û���<br/>
&nbsp;&nbsp;&nbsp;&nbsp;mgrName - ������ ����ʽΪ�����̰�ID#���̰汾��#���̶���id��<br/>
&nbsp;&nbsp;&nbsp;&nbsp;busiId - ҵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;remoteAddr - ����ip��ַ<br/>
&nbsp;&nbsp;&nbsp;&nbsp;dynamicperformer - ��̬ѡ�˲���:һ�������û�����ɣ�����ɶ���(��,��)����<br/>
&nbsp;&nbsp;&nbsp;&nbsp;next_act - ��һ�����������һ�������id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;andsplitusers - ���֧ѡ�˲���:��ʽ=�����id1:userName1,userName2;�����id2:userName3,userName4 <br/>
���أ�
String ����ʵ��id <br/>
�׳��� 
java.lang.Exception	
</div>			
					</td>
				</tr>
						<%}}if("true".equals(isShowBackButton)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>���˻�ӿ�˵����</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('back').style.display=='none'){document.getElementById('back').style.display=''}else{document.getElementById('back').style.display='none'}"><br/>
<div id="back" style="display:none">
void backAct(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String busiId)<br/>
throws java.lang.Exception<br/>�������˻ػ������ǰ��˻�����һ� <br/>
������<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - �û���<br/>
&nbsp;&nbsp;&nbsp;&nbsp;actInsId - �ʵ��id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;busiId - ҵ��id <br/>
�׳��� 
java.lang.Exception
</div>				
					</td>
				</tr>
						<%}if("true".equals(isShowRecycle)){ %>
				<tr>
					<td style="color:#8080FF">
						<font color=red>�ջػ�ӿ�˵����</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('recycle').style.display=='none'){document.getElementById('recycle').style.display=''}else{document.getElementById('recycle').style.display='none'}"><br/>
<div id="recycle" style="display:none">
void recycleAct(<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId)<br/>
throws java.lang.Exception<br/>
�������ջ�������������һ�����û��ִ�У���ô��һ���ִ���˿��Խ������ջ� <br/>
������<br/>
&nbsp;&nbsp;&nbsp;&nbsp;userName - �û�id<br/>
&nbsp;&nbsp;&nbsp;&nbsp;actInsId - �ʵ��id <br/>
�׳��� 
java.lang.Exception
</div>					
					</td>
				</tr>
						<%}%>
				<tr>
					<td style="color:#8080FF">
					<font color=red>����Ȩ�޵Ȳ�ѯ�ӿڣ�ͨ���˽ӿ����������̲���Ȩ�ޣ����Ƿ���ʾ���˵�...��</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('query').style.display=='none'){document.getElementById('query').style.display=''}else{document.getElementById('query').style.display='none'}"><br/>
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
                                                      ���������ͳһ������ڣ������ж�ĳ��ť�Ƿ���ʾ�����ݻʵ��id�õ�����ʵ��id�ȵȣ� <br/>
					������<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;userName - �û���<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;opType - ��Ҫ��ѯ�Ĳ����������ѯ������@�ָ���Ŀǰ֧�����²�����<br/> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{getActName-���ݻʵ��id�õ�����ʵ��id<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;getActObject-��ȡ������䷵�ظ�ʽ:
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;actDefId||actName||createdDate||procInsId||version||actInsId<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;getProcInsId-���ݻʵ��id�õ�����ʵ��id<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowActSelectText-�Ƿ�����ѡ����һ������䷵�ظ�ʽ:
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowActSelectText:true/false;isShowAndActSelectText:true/false;�����id:�����<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowUserText-�Ƿ�����̬ѡ��;<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowBackButton-�Ƿ��������<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowRecycle-�Ƿ������ջ�<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowSuspend-�Ƿ��������<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowResume-�Ƿ�����ָ�<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowCompleteWorkflow-�Ƿ�������ɻ<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowTempSaveForm-�Ƿ������ݴ�<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isShowTerminate-�Ƿ�������ֹ����<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isRoute-�Ƿ�Ϊ·�ɻ<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hasOnlyOnePerformer-��Ƿ�ֻ��һ��������<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isactivityonuse-��Ƿ�����ʹ��}<br/>					
					&nbsp;&nbsp;&nbsp;&nbsp;mgrName - ������ ����ʽΪ�����̰�ID#���̰汾��#���̶���id��<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;actInsId - �ʵ��id<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;procInsId - ����ʵ��id<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;operType - �������ͣ�Ŀǰ���������ͣ�<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{daiban-�����б�<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nosend-�ݴ��б�<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;readonly-�Ѱ��б�<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;suspend-�����б�<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;onuse-����ʹ��}<br/>
					
					&nbsp;&nbsp;&nbsp;&nbsp;actDefId - �����id<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;moduleId - ģ��(����)ID <br/>
					���أ�<br/>
					String ��ѯ����������ѯ���֮����@�ָ� <br/>
					�׳��� <br/>
					java.lang.Exception<br/>		
					</div>
					</td>
				</tr>
				<tr>
					<td style="color:#8080FF">
					<font color=red>�����̰󶨵�jsp����λ�ȡ���̲�������ʵ�ܼ򵥣����´��룺</font>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('param').style.display=='none'){document.getElementById('param').style.display=''}else{document.getElementById('param').style.display='none'}"><br/>
					<div id="param" style="display:none">	
					String rootPath = request.getContextPath();<br/>
					String userName = accesscontroler.getUserAccount();<br/>
					/** �������̵Ĳ�����ʼ*/<br/>
					//ҵ��id<br/>
					String cc_form_instanceid = request
							.getParameter("cc_form_instanceid");<br/>
					//���̶���id<br/>
					String workflowId = request.getParameter("workflowId");<br/>
					//���̶�������<br/>
					String mgrName = request.getParameter("mgrName");<br/>
					//�����id<br/>
					String actDefId = request.getParameter("actDefId");<br/>
					//���������<br/>
					String actDefName = request.getParameter("actDefName");<br/>
					//ģ��id<br/>
					String moduleId = request.getParameter("moduleId");<br/>
					/** �������̵Ĳ�������*/<br/>
				
					//����ʵ��id<br/>
					String procInsId = request.getParameter("procInsId");<br/>
					procInsId = procInsId == null ? "" : procInsId;<br/>
					//�������ͣ���daiban��ʾ�Ǵ��������<br/>
					String operType = request.getParameter("operType");<br/>
					operType = operType == null ? "" : operType;<br/>
					if(operType.equals(""))operType="nosend";<br/>
					//�ʵ��id<br/>
					String actInsId = request.getParameter("actInsId");<br/>
					actInsId = actInsId == null ? "" : actInsId;<br/>
				
					String action = request.getParameter("action");<br/>
					//��ȻҲ���Ի�ȡ�Զ���Ĳ���<br/>
					���Բ鿴����ҳ��url��ֻҪurl���еĲ������ܴ�request�л�ȡ��
					</div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

