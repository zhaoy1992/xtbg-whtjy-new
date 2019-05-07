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
<title>标签管理</title>
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
		alert("请输入标签名.");
		theForm.BookMarkName.focus();
		return (false);
	}
	return (true);
}

function ConfirmDel(FileUrl){
	if (confirm('是否确定删除该标签！')){
		location.href=FileUrl;
	}
}
</Script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin">
<%
String mBookMarkID=request.getParameter("BookMarkID");
boolean mResult=false;

iDBManager2000 DbaObj=new iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mSql="select * from "+appUserName+"TD_OCTL_BookMarks where BookMarkID = " + mBookMarkID;
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mSql) ;
    if (result.next())
    {

%>
<form name="webform" method="post" action="BookMarkEdit.jsp" onsubmit="return Check(this)">
<input type="hidden" name="BookMarkID" value="<%=mBookMarkID%>">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
 <tr>
			<td height='30' class="detailtitle" align="center" colspan="9">
				<b>标签管理〖修改标签〗</b>
			</td>
		</tr>
<tr>
  <td nowrap align=center width=64>标签名称</td>
  <td width="90%"><input type="text" name="BookMarkName" size="80" maxlength="32"  value="<%=result.getString("BookMarkName")%>"></td>
</tr>
<tr>
  <td nowrap align=center width=64>标签说明</td>
  <td ><input type="text" name="BookMarkDesc" size="80" maxlength="60"  value="<%=result.getString("BookMarkDesc")%>"></td>
</tr>
<tr>
  <td nowrap align=center width=64>标签备注</td>
  <td ><input type="text" name="BookMarkText" size="80" maxlength="150"  value="<%=result.getString("BookMarkText")%>"></td>
</tr>
<tr>
  <td colspan=2 nowrap>
    <input type="submit" name="Edit" value="修 改">
    <input type="button" name="Del" value="删 除" onclick="javascript:ConfirmDel('BookMarkDel.jsp?BookMarkID=<%=mBookMarkID%>');">
    <input type="reset" name="Reset" value="重 填">
    <input type="button" name="Return" value="返 回"  onclick="javascript:history.back();">
  </td>
</tr>
</table>
</form>
<%
    }
    else
    {
       out.write("数据库中不存在该标签。<input type='button' value='返 回' onclick='javascript:history.back();'");
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
