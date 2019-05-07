<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

%>
<html>
<head>
<title>特殊权限资源查询</title>
</head> 
<frameset  rows="18%,*"  border="0"  >
  <frame src="special_query.jsp" name="query" id="query"  scrolling="No" noresize="noresize"/>
  <frame src="special_querylist.jsp" name="querylist"  noresize="noresize" id="querylist" />
</frameset>

<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>

</html>
