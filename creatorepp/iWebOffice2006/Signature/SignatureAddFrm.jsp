<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,
                 java.text.*,
                 java.util.*,
                 java.sql.*,
                 com.chinacreator.iWebOffice2006.iDBManager2000.*" %>
<html>
<head>
<title>ǩ�¹���</title>
<!-- link rel='stylesheet' type='text/css' href='../test.css'-->
<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
			
<script language=javascript>
function Check(theForm){
	if (theForm.MarkName.value == ""){
		alert("������ӡǩ��.");
		theForm.MarkName.focus();
		return (false);
	}
	return (true);
}
</Script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin">

<form name="webform" method="post" enctype="multipart/form-data" action="SignatureAdd.jsp" onsubmit="return Check(this)">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
<tr>
			<td height='30' class="detailtitle" align="center" colspan="9">
				<b>ǩ�¹�������ǩ�¡�</b>
			</td>
		</tr>
<tr>
  <td nowrap align=center  width=64>�û�����</td>
  <td class="TDStyle" width="90%"><input type="text" name="UserName" size="50" maxlength="32" class="IptStyle" value=""></td>
</tr>
<tr>
  <td nowrap align=center  width=64>�û�����</td>
  <td class="TDStyle" width="90%"><input type="text" name="PassWord" size="50" maxlength="32" class="IptStyle" value=""></td>
</tr>
<tr>
  <td nowrap align=center width=64>ǩ������</td>
  <td class="TDStyle" width="90%"><input type="text" name="MarkName" size="50" maxlength="32" class="IptStyle" value=""></td>
</tr>
<tr>
  <td nowrap align=center width=64>ǩ���ļ�</td>
  <td class="TDStyle"><input type="file" name="MarkFile" size="50" maxlength="60" class="IptStyle"></td>
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
