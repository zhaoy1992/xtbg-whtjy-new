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
<title>��ǩ����</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body bgcolor="#ffffff">
<div align="center"><font size=4 color=ff0000>��ǩ������ǩ���桽</font></div>
<hr size=1>
<br>
<%
int mBookMarkID;
//String mBookMarkName=new String(request.getParameter("BookMarkName").getBytes("8859_1"));
//String mBookMarkDesc=new String(request.getParameter("BookMarkDesc").getBytes("8859_1"));
//String mBookMarkText=new String(request.getParameter("BookMarkText").getBytes("8859_1"));

String mBookMarkName=request.getParameter("BookMarkName");
String mBookMarkDesc=request.getParameter("BookMarkDesc");
String mBookMarkText=request.getParameter("BookMarkText");

boolean mResult=false;

iDBManager2000 DbaObj=new iDBManager2000();
mBookMarkID=DbaObj.GetMaxID(appUserName+"TD_OCTL_BookMarks","BookMarkID");
if (DbaObj.OpenConnection())
{
  String mSql="select BookMarkName from "+appUserName+"TD_OCTL_BookMarks where BookMarkName='" + mBookMarkName + "'";
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mSql) ;
    if (result.next())
    {
      out.write("����ʧ�ܣ����ݿ����Ѵ�����ͬ�ı�ǩ��"+mBookMarkName+"��<input type='button' value='�� ��' onclick='javascript:history.back();'");
      mResult=false;
    }
    else
    {

        java.sql.PreparedStatement prestmt=null;
        mSql="Insert Into "+appUserName+"TD_OCTL_BookMarks (BookMarkID,BookMarkName,BookMarkDesc,BookMarkText) values ('" +String.valueOf(mBookMarkID) + "','" + mBookMarkName + "','" + mBookMarkDesc + "','" + mBookMarkText + "')";
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
  DbaObj.CloseConnection() ;
}

if (mResult)
{
  response.sendRedirect("BookMarkList.jsp");
}
%>
</body>
</html>
