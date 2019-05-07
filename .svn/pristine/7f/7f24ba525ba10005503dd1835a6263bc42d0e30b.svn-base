<%@ page contentType="text/html; charset=GBK"%>
<%
	String uploadMessage=(String)request.getParameter("uploadMessage");
	uploadMessage=(uploadMessage.equals("sucess"))?"成功":"失败";
	String op=(String)request.getParameter("op");
	op=(op.equals("add"))?"新建报表":"修改报表";
%>
<script language="javascript">
		alert("<%=op%><%=uploadMessage%>");
		window.close();
		window.returnValue="refresh";
</script>