<%@ page contentType="text/html; charset=UTF-8" language="java" isErrorPage="true" %>
<%
   response.setStatus(HttpServletResponse.SC_OK);
   String css_path = "default";
   String path = request.getContextPath();
%>
<html>
	<head>
		<title>错误信息提示</title>
	</head>
	<body>
		<form>
		
			<table align="center">
				<tr>
					<td></td>
					<td align=center  style="height=380;width: 380" background="<%=path%>/eformsys/fceform/images/error.gif"></td>
				</tr>
			</table>
			<table align="center">
			</table>
			<h3> 错误码：</h3> <%=request.getAttribute("javax.servlet.error.status_code")%> <br>
    		<h3> 信息：</h3> <%=request.getAttribute("javax.servlet.error.message")%> <br>
    		<h3> 异常：</h3> <%=request.getAttribute("javax.servlet.error.exception_type")%> <br>
		</form>
	</body>
</html>