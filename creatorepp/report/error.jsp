<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page isErrorPage="true" %>
<%@ page import="java.io.*" %>

<html>
<head>
<script type="text/javascript">
	function showHideMsg()
	{
		if(document.all.button1.value=="查看详情")
		{
			document.all.err_msg.style.display='block';
			document.all.button1.value="隐藏详情";
		}
		else
		{
			document.all.err_msg.style.display='none';
			document.all.button1.value="查看详情";
		}
	}
</script>
<title>
报表运行错误
</title>
<link rel="stylesheet" type="text/css" href="../stylesheet.css" title="Style">
</head>

<body bgcolor="white">
<span class="bnew">报表文件运行出错，原因是 :</span>
<pre>
<%=exception.getMessage() %>
</pre>
<input type="button" id="button1" value="查看详情" onclick="showHideMsg()"/>
<div id="err_msg" style="display:none">
<% exception.printStackTrace(new PrintWriter(out)); %>
</div>
</body>
</html>
