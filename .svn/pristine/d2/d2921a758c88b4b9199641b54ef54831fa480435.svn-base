<%@page contentType="text/html; charset=utf-8" isErrorPage="true"%>
<%@page import="java.io.PrintWriter"%>
<html>
<head><title>错误处理页面</title></head>
<body>
      <H1>网页发生错误：</H1><%=exception%>
      <H2>显示例外堆叠追踪：</H2>
      <%
          exception.printStackTrace(new PrintWriter(out));
      %>
</body>
</html>

