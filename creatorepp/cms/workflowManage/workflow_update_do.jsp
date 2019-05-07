<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.workflowmanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	WorkflowManager workflowManager = new WorkflowManagerImpl();
	Workflow workflow = new Workflow();

	workflow.setWorkflowId(Integer.parseInt(request
			.getParameter("workflowId")));
	workflow.setWorkflowName(request.getParameter("workflowName"));

	boolean flag = false;
	boolean flag1 = false;
	WorkflowManagerImpl imp = new WorkflowManagerImpl();
	flag1 = imp.isRepeat(request.getParameter("workflowName"));
	if (!flag1) {
		flag = workflowManager.updateWorkflow(workflow);
	}

	//smi.logCreateChannel(chnlobj,request,response);
	if (flag) {
%>
<script language="javascript">
		alert("修改流程名称成功!");
		var str = window.dialogArguments.location.href;
		var strArray = str.slice(0,str.indexOf("?"));
		window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
		window.close();
		</script>
<%
	} else {
		if (flag1) {
%>
<script language="javascript">
		alert('流程名重复！');
		//防止二次提交
		//parent.window.document.all("button")[0].disabled = false;
		//parent.window.document.all("button")[1].disabled = false;
		</script>
<%
	} else {
%>
<script language="javascript">
		alert('修改流程名称出错！');
		//防止二次提交
		//parent.window.document.all("button")[0].disabled = false;
		//parent.window.document.all("button")[1].disabled = false;
		</script>
<%
	}
	}
%>
