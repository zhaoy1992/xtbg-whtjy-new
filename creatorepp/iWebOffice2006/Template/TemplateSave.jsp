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
//String mFileName=new String(request.getParameter("FileName").getBytes("8859_1"));
//String mDescript=new String(request.getParameter("Descript").getBytes("8859_1"));
String curOrgID = request.getParameter("orgID"); 
String curOrgName = request.getParameter("orgName");
String mFileName=request.getParameter("FileName");
String mDescript=request.getParameter("Descript");
String modify=request.getParameter("modify");
String ids_str="",names_str="",grantType="";
String[] ids_arr=null,names_arr=null;
ids_str = request.getParameter("ids");
names_str = request.getParameter("names"); 
grantType = request.getParameter("grantType");

//System.out.println("ids_str:"+ids_str+" name_str:"+names_str+" grantType:"+grantType);

iDBManager2000 DbaObj=new iDBManager2000();
if (DbaObj.OpenConnection())
{
  //保存模板
  java.sql.PreparedStatement prestmt=null;
  String mSql="Update "+appUserName+"TD_OCTL_Template_File Set FileName = '"+ mFileName +"',Descript = '"+ mDescript +"',org_id = '"+ curOrgID +"' Where RecordID='"+ mRecordID +"'";
  if(modify!=null && modify.equals("true")){
	  mSql="Update "+appUserName+"TD_OCTL_Template_File Set FileName = '"+ mFileName +"',Descript = '"+ mDescript +"' Where RecordID='"+ mRecordID +"'";
  }
  prestmt =DbaObj.Conn.prepareStatement(mSql);
  DbaObj.Conn.setAutoCommit(true) ;
  prestmt.execute();
  DbaObj.Conn.commit();
  
  //权限控制(如果之前已对此模板设置了权限，则先将它删除再设置新的权限)
  ids_arr = ids_str.split(",");
  names_arr = names_str.split(",");
  
  ResultSet result=DbaObj.ExecuteQuery("SELECT * FROM "+appUserName+"td_octl_template_grant WHERE recordid = '"+mRecordID+"'") ;
  if(result.next())
  {
	  mSql = "DELETE FROM "+appUserName+"td_octl_template_grant WHERE recordid = '"+mRecordID+"'";
	  DbaObj.ExecuteUpdate(mSql);
  }
  
  if("user".equalsIgnoreCase(grantType))
  {
	  for(int i=0; i<ids_arr.length; i++)
	  {
	 	   mSql = "Insert INTO "+appUserName+"td_octl_template_grant(user_id,user_realname,granttype,recordid) VALUES('"+ids_arr[i]+"','"+names_arr[i]+"','user','"+mRecordID+"')";
		   System.out.println(mSql);
		   DbaObj.ExecuteUpdate(mSql);
	  }
  }
  else if("role".equalsIgnoreCase(grantType))
  {
  	  for(int i=0; i<ids_arr.length; i++)
	  {
	 	   mSql = "Insert INTO "+appUserName+"td_octl_template_grant(role_id,role_name,granttype,recordid) VALUES('"+ids_arr[i]+"','"+names_arr[i]+"','role','"+mRecordID+"')";
		   System.out.println(mSql);
		   DbaObj.ExecuteUpdate(mSql);
	  }
  }
   prestmt.close();
}
DbaObj.CloseConnection();
%>
<script type="text/javascript">
  		alert("保存成功！");
  		url="./TemplateEdit.jsp?RecordID=<%= mRecordID%>&orgID=<%= curOrgID%>&orgName=<%= curOrgName%>";
  		window.location.replace(url);
</script>

<%--
<jsp:forward page="TemplateEdit.jsp">
	<jsp:param name="RecordID" value="<%= mRecordID%>"/>
</jsp:forward>
--%>
