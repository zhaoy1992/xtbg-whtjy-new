<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
try {
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);


	String workFlowFrom = request.getParameter("workFlowFrom");
	if(workFlowFrom==null || workFlowFrom.trim().length()==0){
		workFlowFrom = "0";
	}
	String channelId = request.getParameter("channelId");
	if(channelId == null || channelId.trim().length()==0){
		throw new ChannelManagerException("Ƶ��idΪnull,��֪��Ҫ�����Ǹ�Ƶ��������");
	}
	String workflow = request.getParameter("workFlow");
	if(workflow==null || workflow.trim().length()==0){
		workflow = "0";
	}

	ChannelManager cm = new ChannelManagerImpl();
	cm.changeWorkflow(channelId,Integer.parseInt(workflow),Integer.parseInt(workFlowFrom));
%>
<script language="javascript">
	alert("�༭Ƶ�����̳ɹ�!");
	parent.window.returnValue = true;
	parent.close();
</script>
<%}catch (ChannelManagerException e) {
		e.printStackTrace();
%>
<script language="javascript">
	alert('�༭Ƶ�����̳���,����!ԭ����:\n<%=e.getMessage().replaceAll("\n", "").replaceAll("'","")%>');
</script>
<%
}
%>
