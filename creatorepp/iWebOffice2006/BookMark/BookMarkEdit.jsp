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
<link rel='stylesheet' type='text/css' href='../test.css'>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body bgcolor="#ffffff">
<div align="center"><font size=4 color=ff0000>标签管理〖标签修改〗</font></div>
<hr size=1>
<br>
<%
String mBookMarkID=new String(request.getParameter("BookMarkID"));
//String mBookMarkName=new String(request.getParameter("BookMarkName").getBytes("8859_1"));
//String mBookMarkDesc=new String(request.getParameter("BookMarkDesc").getBytes("8859_1"));
//String mBookMarkText=new String(request.getParameter("BookMarkText").getBytes("8859_1"));

String mBookMarkName=request.getParameter("BookMarkName");
String mBookMarkDesc=request.getParameter("BookMarkDesc");
String mBookMarkText=request.getParameter("BookMarkText");
boolean mResult=false;

iDBManager2000 DbaObj=new iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mSql="select BookMarkName from "+appUserName+"TD_OCTL_BookMarks where BookMarkID<>"+ mBookMarkID +" and BookMarkName='" + mBookMarkName + "'";
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mSql) ;
    if (result.next())
    {
      out.write("保存失败，数据库中已存在相同的标签〖"+mBookMarkName+"〗<input type='button' value='返 回' onclick='javascript:history.back();'");
      mResult=false;
    }
    else
    {
        java.sql.PreparedStatement prestmt=null;
        mSql="Update "+appUserName+"TD_OCTL_BookMarks Set BookMarkName = '"+ mBookMarkName +"',BookMarkDesc = '"+ mBookMarkDesc +"',BookMarkText='"+ mBookMarkText +"' where BookMarkID="+ mBookMarkID;
        prestmt =DbaObj.Conn.prepareStatement(mSql);;
        DbaObj.Conn.setAutoCommit(true) ;
        prestmt.execute();
        DbaObj.Conn.commit();
        prestmt.close();
        mResult=true;
    }
    result.close();
  }
  catch(Exception e)
  {
      System.out.println(e.toString());
  }
  DbaObj.CloseConnection();
}

if (mResult)
{
  response.sendRedirect("BookMarkList.jsp");
}
%>
</body>
</html>
