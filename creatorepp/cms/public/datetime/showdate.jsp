<%@ page language="java" contentType="text/html;charset=GBK"%>
<HTML>
<HEAD>
<TITLE>—°‘Ò ±º‰</TITLE>
<%
	String retObj = request.getParameter( "retObj" );
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
var obj=window.dialogArguments.document.all( '<%=retObj%>' );
//-->
</SCRIPT>
<script language="javascript" src="meizzdate.js"></script>

</HEAD>


<BODY onload="setday(obj);" scroll="no">
</BODY>
</HTML>
