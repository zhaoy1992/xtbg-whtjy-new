<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.security.AccessControl
				,com.chinacreator.message.impl.RtxImpl" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
    String account = accesscontroler.getUserAccount();
	String isStart = request.getParameter("isStrat")!=null?request.getParameter("isStrat"):"false";
	boolean bl = false;
	if("true".equals(isStart)){
		//bl = RtxImpl.rtxDataSynchronization();
	}
%>
<html>
<head>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body>
<div align="center" id="divv">
��ҳ���ǽ���RTX����ͬ��ҳ
<br/>
<%
	if("admin".equals(account)){
%>
<form action="" method="post">
<input type="hidden" name="isStrat" value="true">
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
		if(bl){
%>
<script type="text/javascript">
<!--
	alert("����ͬ���ɹ���");
//-->
</script>
<%}else{%>
<script type="text/javascript">
<!--
	alert("����ͬ��ʧ�ܣ�");
//-->
</script>
<%}}%>