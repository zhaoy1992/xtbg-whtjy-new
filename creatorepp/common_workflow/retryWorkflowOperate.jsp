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
			out.println("����������ִ�гɹ�");
		}else if("true".equals(result)){
			out.println("����ִ�гɹ�");
		}else if("false".equals(result)){
			out.println("����ִ��ʧ�ܣ�������鿴��־��Ϣ");
		}else if("".equals(result)){
			out.println("����ִ����ϣ�");
		}else{
			out.println("�����ѳɹ�ת����һ�����"+result);
		}
	}else{
		out.println("��ָ��ʧ�ܵ���־ID����");
	}
%>