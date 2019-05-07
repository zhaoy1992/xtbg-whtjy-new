<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*,
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
  
String mRecordID=request.getParameter("RecordID");
String curOrgID = request.getParameter("orgID"); 
String curOrgName = request.getParameter("orgName"); 
String initRecordID = (String)request.getParameter("recordID");
String initFileName = (String)request.getParameter("fileName");

iDBManager2000 DbaObj=new iDBManager2000();
if (DbaObj.OpenConnection())
{
  //删除模板
  java.sql.PreparedStatement prestmt=null;
  String mSql="Delete from "+appUserName+"TD_OCTL_Template_File where RecordID = '"+ mRecordID + "'";
  prestmt =DbaObj.Conn.prepareStatement(mSql);
  DbaObj.Conn.setAutoCommit(true) ;
  prestmt.execute();
  DbaObj.Conn.commit();
  prestmt.close();
  
  //删除对模板的授权
  mSql = "DELETE FROM "+appUserName+"td_octl_template_grant WHERE recordid = '"+mRecordID+"'";  
  DbaObj.ExecuteUpdate(mSql);
}
DbaObj.CloseConnection();
curOrgName = new String(curOrgName.getBytes("GBK"),"ISO8859_1");
response.sendRedirect("../../eformsys/fceform/WebOffice_content.jsp?orgID="+curOrgID+"&orgName="+curOrgName+"&recordID="+initRecordID+"&fileName="+initFileName);
%>

