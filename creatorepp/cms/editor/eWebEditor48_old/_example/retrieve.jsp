<%@ page contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="java.util.*,java.text.*" %>

<HTML>
<HEAD>
<TITLE>eWebEditor �� ������ʾ��</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
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