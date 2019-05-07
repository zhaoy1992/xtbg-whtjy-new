<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.epp.processmanage.dbmanager.ProcessManage"%>

<%
	ProcessManage pm=new ProcessManage();
	request.setCharacterEncoding("GBK");
	String pName = request.getParameter("pName");
	String wsdlAddress=pm.getWsdlAdress(pName);
	
%>
<html>
<head>
  <title></title>  
  <script type="text/javascript">
	window.location.href="<%=wsdlAddress%>";
  </script>
</head>
<body>
</body>
</html>
