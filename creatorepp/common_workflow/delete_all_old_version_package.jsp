<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK" import="com.chinacreator.security.AccessControl
    						,com.chinacreator.spi.impl.local.WorkflowManagerImpl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
    String account = accesscontroler.getUserAccount();
    boolean flag = false;
    
    String isStart = request.getParameter("isStrat")!=null?request.getParameter("isStrat"):"false";

	if("true".equals(isStart)) {
		WorkflowManagerImpl workflow = new WorkflowManagerImpl();
		String delFlag = request.getParameter("flag");
		if ("true".equals(delFlag)) {			
			flag = workflow.deleteAllOldVersionPackage(true);
		} else {
			flag = workflow.deleteAllOldVersionPackage(false);
		}
	}
	
	
%>
<html>
<head>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body>
<div align="center" id="divv">
��ҳ���ǽ���������ʷ�汾����
<br/>
<%
	if("admin".equals(account)){
%>
<form action="" method="post">
<input type="hidden" name="isStrat" value="true">
<input type="checkbox" name="flag" value="true">�Ƿ�ǿ��ɾ��
<input type="submit" value="��ʼ" class="input">
</form>
<%}else{%>
<br/>
����ϵͳ����Ա��ݵ�¼���ٽ��д˲���
<%} %>
</div>
</body>
</html>
<%
	if("true".equals(isStart)){
	if(flag){
%>
<script type="text/javascript">
<!--
	alert("ɾ���ɹ���");
//-->
</script>
<%}else{%>
<script type="text/javascript">
<!--
	alert("ɾ��ʧ�ܣ����Ժ����ԣ�");
//-->
</script>
<%}}%>