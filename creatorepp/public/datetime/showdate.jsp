<%@ page language="java" contentType="text/html;charset=GBK"%>
<HTML>
<HEAD>
<TITLE>ѡ��ʱ��</TITLE>
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


<%@ include file="/epp/css/cssControl.jsp"%><body  onload="setday(obj);" scroll="no">
</BODY>
</HTML>
