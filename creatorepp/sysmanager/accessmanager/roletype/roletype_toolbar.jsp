<%@ include file="../../include/global1.jsp"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<html>
<head>
<title>��������������</title>
<link rel="stylesheet" type="text/css" href="../../css/toolbar.css">
<script language="javascript" src="../../scripts/toolbar.js"></script>
<style type="text/css">
<!--
.style1 {color: #000000}
-->
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">
<table width="100%" cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 ><img
			class="normal" src="../../images/actions.gif"></td>
		<td align="left" valign="middle" nowrap class="text">��ɫ���͹���</td>
		<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle"
			align="right" width="*" nowrap class="text">
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
