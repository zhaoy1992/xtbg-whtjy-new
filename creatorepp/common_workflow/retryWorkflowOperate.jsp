<%@ page language="java" contentType="text/html; charset=GBK" 
			import="com.chinacreator.security.AccessControl,
			com.chinacreator.commonworkflow.transaction.task.WfRedeemInvoke"%>
			
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String logId = request.getParameter("logId");
	if(logId!=null && !"".equals(logId)){
		String result = WfRedeemInvoke.getInstance().retryWorkflowOperate(logId);
		if("beingPassed".equals(result)){
			out.println("流程已重新执行成功");
		}else if("true".equals(result)){
			out.println("流程执行成功");
		}else if("false".equals(result)){
			out.println("流程执行失败，具体请查看日志信息");
		}else if("".equals(result)){
			out.println("流程执行完毕！");
		}else{
			out.println("流程已成功转入下一步活动："+result);
		}
	}else{
		out.println("请指定失败的日志ID参数");
	}
%>