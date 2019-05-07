<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<html>
	<head>
	<title></title>
		<script type="text/javascript">
			function _close()
			{
				window.returnValue=true;
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body onunloade="_close();">
	<%
		boolean isEdit=(request.getParameter("isEdit")!=null)?(request.getParameter("isEdit").equals("true")?true:false):false;
		if(isEdit){
	%>
		<iframe src="<%=request.getContextPath()%>/report/report_new.jsp?ec_id=<%=request.getParameter("ec_id") %>&repId=<%=request.getParameter("repId") %>&isEdit=<%=isEdit %>" width="100%" height="100%"></iframe>
	<%}else{ %>
		<iframe src="<%=request.getContextPath()%>/report/report_new.jsp?ec_id=<%=request.getParameter("ec_id") %>" width="100%" height="100%"></iframe>
	<%}%>
	</body>
</html>