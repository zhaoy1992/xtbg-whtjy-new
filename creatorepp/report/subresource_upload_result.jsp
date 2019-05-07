<%@ page contentType="text/html; charset=GBK"%>
<%
	String uploadMessage=(String)request.getParameter("uploadMessage");
	uploadMessage=(uploadMessage.equals("success"))?"上传成功":"上传失败";
	String resource_type=(String)request.getParameter("resource_type");
	resource_type=(resource_type.equals("1"))?"报表":"图片";
%>
<script language="javascript">
		alert("<%=resource_type%><%=uploadMessage%>");
		window.close();
		window.returnValue="refresh";
</script>