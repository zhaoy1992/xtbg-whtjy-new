<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ include file="../include/global1.jsp"%>
<%@page import="com.frameworkset.util.StringUtil"%>
<%
String restypeId = StringUtil.replaceNull(request.getParameter("restypeId"));
String restypeName = StringUtil.replaceNull(request.getParameter("restypeName"));
%>   
<html>
<head>
<script language="JavaScript">
function refreshtree(){
	//getNavigatorContent().location.href ="<%=rootpath%>/sysmanager/resmanager/navigator_content.jsp?anchor=0&expand=0&request_scope=session&selectedNode=<%=restypeId%>";
}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onLoad="refreshtree()" scroll="no">
</body>
</html>
<script language="JavaScript">
alert("������Դ��Ϣ�ɹ���");
parent.parent.res_list.location.href ="/cms/resManager/res_list.jsp?restypeId=<%=restypeId%>&restypeName=<%=restypeName%>";
</script>