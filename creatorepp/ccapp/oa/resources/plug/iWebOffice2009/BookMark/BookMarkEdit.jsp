<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<html>
<head>
<title>��ǩ����</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color=ff0000>��ǩ��������ǩ�޸ġ�</font></div>
<hr size=1>
<br>
<%
String mBookMarkID=new String(request.getParameter("BookMarkID"));
String mBookMarkName=new String(request.getParameter("BookMarkName").getBytes("8859_1"));
String mBookMarkDesc=new String(request.getParameter("BookMarkDesc").getBytes("8859_1"));
String mBookMarkText=new String(request.getParameter("BookMarkText").getBytes("8859_1"));
boolean mResult=false;

DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mSql="select BookMarkName from BookMarks where BookMarkID<>"+ mBookMarkID +" and BookMarkName='" + mBookMarkName + "'";
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
        mSql="Update BookMarks Set BookMarkName = '"+ mBookMarkName +"',BookMarkDesc = '"+ mBookMarkDesc +"',BookMarkText='"+ mBookMarkText +"' where BookMarkID="+ mBookMarkID;
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