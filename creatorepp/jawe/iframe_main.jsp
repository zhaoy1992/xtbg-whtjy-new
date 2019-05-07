<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%
//本页面仅用于applet关闭时刷新父页面
	java.net.URL url = new java.net.URL("http://localhost:8081/dzzwpt/jawe/iframe_main.jsp");
	System.out.println(url.getFile());
	System.out.println(url.getProtocol());
	System.out.println(url.getHost());
	System.out.println(url.getPort());
	System.out.println(url.getPath());
	System.out.println(request.getContextPath());
%>
<html>
	<head>
	<title></title>
		<script type="text/javascript">
			//applet关闭时刷新父页面
			function refParent()
			{
				window.parent.location.reload();
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body onload="refParent()">
	</body>
</html>