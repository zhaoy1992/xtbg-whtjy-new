<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page isErrorPage="true" %>
<%@ page import="java.io.*" %>

<html>
<head>
<script type="text/javascript">
	function showHideMsg()
	{
		if(document.all.button1.value=="�鿴����")
		{
			document.all.err_msg.style.display='block';
			document.all.button1.value="��������";
		}
		else
		{
			document.all.err_msg.style.display='none';
			document.all.button1.value="�鿴����";
		}
	}
</script>
<title>
�������д���
</title>
<link rel="stylesheet" type="text/css" href="../stylesheet.css" title="Style">
</head>

<body bgcolor="white">
<span class="bnew">�����ļ����г���ԭ���� :</span>
<pre>
<%=exception.getMessage() %>
</pre>
<input type="button" id="button1" value="�鿴����" onclick="showHideMsg()"/>
<div id="err_msg" style="display:none">
<% exception.printStackTrace(new PrintWriter(out)); %>
</div>
</body>
</html>
