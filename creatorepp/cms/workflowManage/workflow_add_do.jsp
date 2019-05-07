<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.workflowmanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%

	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	
	WorkflowManager workflowManager = new WorkflowManagerImpl();
	WorkflowManagerImpl imp = new WorkflowManagerImpl();
	Workflow workflow = new Workflow();

	workflow.setWorkflowName(request.getParameter("workflowName"));
	
	boolean flag = false;
	flag = imp.isRepeat(request.getParameter("workflowName"));

	try
	{   
	    int workflowId = 0;
	    if(!flag){
		workflowId = workflowManager.createWorkflow(workflow);
		}
		//smi.logCreateChannel(chnlobj,request,response);
		if(workflowId != 0)
		{
%>
		<script language="javascript">
			alert("新建流程成功!");
			var str = window.dialogArguments.location.href;
			var strArray = str.slice(0,str.indexOf("?"));
			window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
			window.close();
		</script>
<%		}else{%>
		<script language="javascript">
			alert('新建流程出错或重名！');
			//防止二次提交
			//parent.window.document.all("button")[0].disabled = false;
			//parent.window.document.all("button")[1].disabled = false;
		</script>
<%
		}
	}
	catch(Exception e)
	{
%>
	<script language="javascript">
		alert('新建流程出错！');
		//防止二次提交
		//parent.window.document.all("button")[0].disabled = false;
		//parent.window.document.all("button")[1].disabled = false;
	</script>
<%	}%>
