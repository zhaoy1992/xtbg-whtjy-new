<%@ page contentType="text/html; charset=GBK" language="java"%>
<jsp:directive.page import="com.chinacreator.epp.processmanage.dbmanager.ProcessManage"/>
<jsp:directive.page import="com.chinacreator.epp.processmanage.vo.Process"/>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
 %>
<%
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires",0);
%>
<% 
String pId = request.getParameter("pId");
if(pId==null)pId = "";
String remark = request.getParameter("remark");
if(remark==null)remark = "";
String isSaveActData = request.getParameter("isSaveActDataValue");
if(isSaveActData==null)isSaveActData = "0";
ProcessManage pm = new ProcessManage();
Process process = new Process();
process.setPId(pId);
process.setRemark(remark);
process.setIsSaveActData(isSaveActData);
String mes = pm.editProcessInfo(process);
%>
<script type="text/javascript">
alert('<%=mes%>');
parent.close();
</script>