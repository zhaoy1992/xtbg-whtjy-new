<%@ page contentType="text/html;charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*,java.text.*" %>

<HTML>
<HEAD>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<TITLE>eWebEditor �� ������ʾ��</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<link rel='stylesheet' type='text/css' href='example.css'>
</HEAD>
<BODY>

<p><b>���� �� <a href="default.jsp">ʾ����ҳ</a> &gt; ������ʾ��</b></p>
<p>������ʾ����ν��յ����ύ������HTML���룬����ʾ����</p>

<%
String sContent1 = request.getParameter("content1");

out.println("�༭�������£�<br><br>" + sContent1);
out.println("<br><br><p><input type=button value=' ���� ' onclick='history.back()'></p>");
%>

</BODY>
</HTML>