<%@ page contentType="text/html; charset=gb2312" %>
<html>
<head>
<title>��ǩ����</title>
<!-- link rel='stylesheet' type='text/css' href='../test.css'-->
<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
<script language=javascript>
function Check(theForm){
	if (theForm.BookMarkName.value == ""){
		alert("�������ǩ��.");
		theForm.BookMarkName.focus();
		return (false);
	}
	return (true);
}
</Script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin">

<form name="webform" method="post" action="BookMarkAdd.jsp" onsubmit="return Check(this)">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
		<tr>
			<td height='30' class="detailtitle" align="center" colspan="9">
				<b>��ǩ�������ӱ�ǩ��</b>
			</td>
		</tr>
<tr>
  <td nowrap align=center  width=64>��ǩ����</td>
  <td  width="90%"><input type="text" name="BookMarkName" size="80" maxlength="32" class="IptStyle" value=""></td>
</tr>
<tr>
  <td nowrap align=center  width=64>��ǩ˵��</td>
  <td ><input type="text" name="BookMarkDesc" size="80" maxlength="60" class="IptStyle"></td>
</tr>
<tr>
  <td nowrap align=center  width=64>��ǩ��ע</td>
  <td><input type="text" name="BookMarkText" size="80" maxlength="150" class="IptStyle"></td>
</tr>
<tr>
  <td colspan=2 nowrap>
    <input type=submit name="Save" value="�� ��">
    <input type=reset name="Reset" value="�� ��">
    <input type=button name="Return" value="�� ��"  onclick="javascript:history.back();">
  </td>
</tr>
</table>
</form>
</body>
</html>
