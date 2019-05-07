<%@ page language="java" import="java.sql.*,
                                 com.chinacreator.iWebOffice2006.iDBManager2000,
                                 com.chinacreator.security.AccessControl" pageEncoding="GBK"%>
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
String fileType = request.getParameter("fileType");
userId = control.getUserID();
%>                               
<%!
String userId = "";	              
iDBManager2000 DbaObj=new iDBManager2000();

  //列出所有模版
  public String GetTemplateList(String ObjType, String FileType,String appUserName)
  {
    String mTemplateList,mstr="";
    mTemplateList = "<select name=" + ObjType + " >";
    mTemplateList = mTemplateList +  "<option value=''>--------不用模版--------</option>";
    //String Sql = "select RecordID,Descript from "+appUserName+"TD_OCTL_Template_File where FileType='"+FileType+"' AND recordid IN('"+recordIds+")"; //打开数据库
    try
    {
      if (DbaObj.OpenConnection())
      {
        try 
        {
          //丛权限表中取出有权使用的模板ID
          String recordIds = "";
          ResultSet result=DbaObj.ExecuteQuery("SELECT recordid FROM "+appUserName+"td_octl_template_grant WHERE user_id = '"+userId+"'") ;
    	  while(result.next())
    	  {
    	   	recordIds += result.getString(1) + ",";
    	  }
    	  //根据权限展现有权使用的模板
    	  if(recordIds.length()>0)
    	  {
    	  	recordIds = recordIds.substring(0,recordIds.length()-1);
           	String Sql = "select RecordID,Descript from "+appUserName+"TD_OCTL_Template_File where FileType='"+FileType+"' AND recordid IN("+recordIds+")";
          	result = DbaObj.ExecuteQuery(Sql);
          	mstr="selected";
          	while (result.next())
          	{
            	mTemplateList = mTemplateList + "<option value='" + result.getString("RecordID") + "'"+mstr+">" + result.getString("Descript") + "</option>";
         	}
          	result.close();
          }
        }
        catch (SQLException sqlex) 
        {
          System.out.println(sqlex.toString());
        }
      }
      else 
      {
        System.out.println("GetTemplateList: OpenDatabase Error");
      }
    }
    finally
    {
      DbaObj.CloseConnection();
    }
    mTemplateList = mTemplateList + "</select>";
    return (mTemplateList);
  }
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>请选择套红的模板</title>
    <link rel="stylesheet" type="text/css" href="../purviewmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/treeview.css">			
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin">
  	<div>
    	<form>
    		<table width="95%" border="0" cellpadding="0" cellspacing="1" class="thin" align="center">    			
    		<%if(fileType.equals(".doc")){ %>
    			<tr class="tr">
  					<td height="25" class="detailtitle" align="center" width="60%">
    					请选择模版:<%=GetTemplateList("doc",".doc",appUserName)%>
    				</td>
    				<td height="25" class="detailtitle" align="center" width="40%">
    					<input type=button value="word模板套红" size="20" onclick="window.returnValue=doc.value; window.close();"/>
    				</td>
    			</tr>
    		<%}else if(fileType.equals(".wps")){ %>
    			<tr class="tr">
    				<td height="25" class="detailtitle" align="center" width="60%">
    					请选择模版:<%=GetTemplateList("wps",".wps",appUserName)%>
    				</td>
    				<td height="25" class="detailtitle" align="center" width="40%">
    					<input type=button value="wps模板套红 " size="20"   onclick="window.returnValue=wps.value; window.close();"/>
    				</td>
    			</tr>
    		<%} %>    			
    		</table>
    	</form>
    </div>
  </body>
</html>
