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
  
String mSignatureID = new String(request.getParameter("SignatureID"));
boolean mResult=false;

iDBManager2000 DbaObj=new iDBManager2000();
if (DbaObj.OpenConnection())
{
  java.sql.PreparedStatement prestmt=null;
  String mSql = "Delete from "+appUserName+"TD_OCTL_Signature where SignatureID = " + mSignatureID;
  prestmt =DbaObj.Conn.prepareStatement(mSql);;
  DbaObj.Conn.setAutoCommit(true) ;
  prestmt.execute();
  DbaObj.Conn.commit();
  prestmt.close();
  mResult=true;
}
else
{
  mResult=false;
}
DbaObj.CloseConnection() ;

if (mResult)
{
  response.sendRedirect("SignatureList.jsp");
}

%>
