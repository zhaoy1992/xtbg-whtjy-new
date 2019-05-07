<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<html>
<head>
<%
String cebversion = OASystemCache.getContextProperty("cebversion");
%>
<title>金格科技-iWebOffice2006全文批注实例</title>
</head>
<body bgcolor="#ffffff" onload="Load()" onunload="UnLoad()">  <!--引导和退出iWebOffice ../../../../iWebOffice2006/DocumentSave.jsp-->
  <form name="webform" id="webform" method="post" action="iwebOffice2009.jsp?submit_flag=1" onsubmit="return SaveDocument();">  <!--保存iWebOffice后提交表单信息-->
 	<div id="webofficDiv" >
 	<OBJECT id="WebOffice" height="100%" width="100%" classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499" codebase="../resources/plug/iWebOffice2009/<%=cebversion %>"></OBJECT>
	</div>
  </form>
</body> 
</html>