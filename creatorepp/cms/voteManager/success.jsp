
<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>�޸ĳɹ�</title>
  </head> 
  <body>
  </body>
  <script language="javascript">
      window.onload=function success(){
          alert("�޸ĳɹ�!");
          window.opener.location.reload();
          window.close();
      }
  </script>
</html>
