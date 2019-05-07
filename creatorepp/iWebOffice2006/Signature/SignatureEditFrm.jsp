<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,
                 java.text.*,
                 java.util.*,
                 java.sql.*,
                 com.chinacreator.iWebOffice2006.iDBManager2000,
                 com.chinacreator.security.AccessControl" %>
<%
  AccessControl control = AccessControl.getInstance();
  control.checkAccess(request,response);
  String currentSystemID = control.getCurrentSystemID();
  String appUserName = "";
  if(currentSystemID.equalsIgnoreCase("module")){
  	 appUserName = "";
  }else{
  	 appUserName = "APP_"+currentSystemID+".";
  }
%>                
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

function ConfirmDel(FileUrl){
	if (confirm('�Ƿ�ȷ��ɾ����ӡǩ��')){
		location.href=FileUrl;
	}
}
</Script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin">

<%
String mSignatureID=request.getParameter("SignatureID");
boolean mResult=false;

iDBManager2000 DbaObj=new iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mSql="select * from "+appUserName+"TD_OCTL_Signature where SignatureID = " + mSignatureID;
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mSql) ;
    if (result.next())
    {

%>
<form name="webform" method="post" enctype="multipart/form-data"  action="SignatureEdit.jsp" onsubmit="return Check(this)">
<input type="hidden" name="SignatureID" value="<%=result.getString("SignatureID")%>">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
<tr>
			<td height='30' class="detailtitle" align="center" colspan="9">
				<b>ǩ�¹����޸�ǩ�¡�</b>
			</td>
		</tr>
<tr>
  <td nowrap align=center width=64>�û�����</td>
  <td class="TDStyle" width="90%"><input type="text" name="UserName" size="50" maxlength="32" value="<%=result.getString("UserName")%>"></td>
</tr>
<tr>
  <td nowrap align=center width=64>�û�����</td>
  <td class="TDStyle" width="90%"><input type="text" name="PassWord" size="50" maxlength="32" value="<%=result.getString("PassWord")%>"></td>
</tr>
<tr>
  <td nowrap align=center width=64>ǩ������</td>
  <td  width="90%"><input type="text" name="MarkName" size="50" maxlength="32" value="<%=result.getString("MarkName")%>"></td>
</tr>
<tr>
  <td nowrap align=center  width=64>ǩ���ļ�</td>
  <td ><input type="file" name="MarkFile" size="50" maxlength="60" ></td>
</tr>
<tr>
  <td colspan=2 nowrap>
    <input type="submit" name="Edit" value="�� ��">
    <input type="button" name="Del" value="ɾ ��" onclick="javascript:ConfirmDel('SignatureDel.jsp?SignatureID=<%=mSignatureID%>');">
    <input type="reset" name="Reset" value="�� ��">
    <input type="button" name="Return" value="�� ��"  onclick="javascript:history.back();">
  </td>
</tr>
</table>
</form>
<%
  }
      else
      {
         out.write("���ݿ��в����ڸñ�ǩ��<input type='button' value='�� ��' onclick='javascript:history.back();'");
      }
      result.close();
    }
    catch(Exception e)
    {
        System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
}
%>
</body>
</html>
