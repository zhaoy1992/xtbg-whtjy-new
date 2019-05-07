<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<% 
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userName = accesscontroler.getUserAccount();
	
	String moduleId = request.getParameter("moduleId"); //模块id
	String actInsId = request.getParameter("actInsId"); //活动实例id
	String mgrName = request.getParameter("mgrName");   //流程名需要转换格式
	String cc_form_instanceid = request.getParameter("cc_form_instanceid"); //业务id
	String procDefId = request.getParameter("procDefId"); //流程定义id
	String actDefName = request.getParameter("actDefName"); //活动名称
	String procInsId = request.getParameter("procInsId"); //流程实id例
%>

<html>
	<head>
	<script type="text/javascript">
	function doComplete(){
		var url = "do1.jsp";
    	document.processForm.action=url;
		document.processForm.submit();
	}
	</script>
	</head>
	<body>
		<form name="processForm" method="post" action="">
			模块id:<input type="text" name="moduleId" value="<%=moduleId %>"/>
			活动实例id：<input type="text" name="actInsId" value="<%=actInsId %>"/>
			流程名称：<input type="text" name="mgrName" value="<%=mgrName %>"/>
			业务id：<input type="text" name="cc_form_instanceid" value="<%=cc_form_instanceid %>"/>
			流程定义id：<input type="text" name="procDefId" value="<%=procDefId %>"/>
			活动名称：<input type="text" name="actDefName" value="<%=actDefName %>"/>
			流程实例id：<input type="text" name="procInsId" value="<%=procInsId %>"/>
			<input type="hidden" name="flag" value="complete"/>
			
			<input type="button" value="完成活动" onclick="doComplete();"/>
		</form>
	</body>
</html>