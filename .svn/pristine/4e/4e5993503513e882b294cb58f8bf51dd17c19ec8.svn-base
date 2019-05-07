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
%>                               
<%!
iDBManager2000 DbaObj=new iDBManager2000();

//列出所有模版
public String GetTemplateList(String ObjType, String FileType,String appUserName)
  {
    String mTemplateList,mstr="";
    mTemplateList = "<select name=" + ObjType + " >";
    mTemplateList = mTemplateList +  "<option value=''>--------不用模版--------</option>";
    String Sql = "select RecordID,Descript from "+appUserName+"TD_OCTL_Template_File where FileType='" + FileType + "'"; //打开数据库
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          mstr="selected";
          while (result.next()) {
            mTemplateList = mTemplateList + "<option value='" + result.getString("RecordID") + "'"+mstr+">" + result.getString("Descript") + "</option>";
          }
          result.close();
        }
        catch (SQLException sqlex) {
          System.out.println(sqlex.toString());
        }
      }
      else {
        System.out.println("GetTemplateList: OpenDatabase Error");
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    mTemplateList = mTemplateList + "</select>";
    return (mTemplateList);
  }
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>从模板新建文档</title>
    <link rel="stylesheet" type="text/css" href="../purviewmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/treeview.css">		
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin">
  	<div>
    	<form>
    		<table width="95%" border="0" cellpadding="0" cellspacing="1" class="thin" align="center">    			
    			<tr class="tr">
  					<td height="25" class="detailtitle" align="center" width="60%">
    					请选择模版:<%=GetTemplateList("doc",".doc",appUserName)%>
    				</td>
    				<td height="25" class="detailtitle" align="center" width="40%">
    					<input type=button value="新建word文档" size="20" onclick="window.returnValue='FileType=.doc&Template='+doc.value; window.close();"/>
    				</td>
    			</tr>
    			<tr class="tr">
    				<td height="25" class="detailtitle" align="center" width="60%">
    					请选择模版:<%=GetTemplateList("xls",".xls",appUserName)%>
    				</td>
    				<td height="25" class="detailtitle" align="center" width="40%">
    					<input type=button value="新建excel文档" size="20" onclick="window.returnValue='FileType=.xls&Template='+xls.value; window.close();"/>
    				</td>
    			</tr>
    			<tr class="tr">
    				<td height="25" class="detailtitle" align="center" width="60%">
    					请选择模版:<%=GetTemplateList("wps",".wps",appUserName)%>
    				</td>
    				<td height="25" class="detailtitle" align="center" width="40%">
    					<input type=button value="新建wps文档  " size="20"   onclick="window.returnValue='FileType=.wpsTemplate='+wps.value; window.close();"/>
    				</td>
    			</tr>
    			<tr class="tr">
    				<td height="25" class="detailtitle" align="center" width="60%">
    					请选择模版:<%=GetTemplateList("et",".et",appUserName)%>
    				</td>
    				<td height="25" class="detailtitle" align="center" width="40%">	
    					<input type=button value="新建金山表格 " size="20" onclick="window.returnValue='FileType=.et&Template='+et.value; window.close();"/>
    				</td>
    			</tr>
    			<tr class="tr">
    				<td height="25" class="detailtitle" align="center" width="60%">
    					请选择模版:<%=GetTemplateList("ppt",".ppt",appUserName)%>
    				</td>
    				<td height="25" class="detailtitle" align="center" width="40%">
    					<input type=button value="新建ppt文档  " size="20" onclick="window.returnValue='FileType=.ppt&Template='+ppt.value; window.close();"/>
    				</td>
    			</tr>
    			<tr class="tr">
    				<td height="25" class="detailtitle" align="center" width="60%">
    					请选择模版:<%=GetTemplateList("vsd",".vsd",appUserName)%>
    				</td>
    				<td height="25" class="detailtitle" align="center" width="40%">
    					<input type=button value="新建visio文档 " size="20"  onclick="window.returnValue='FileType=.vsd&Template='+vsd.value; window.close();"/>
  					</td>
  				<tr>  				
    		</table>
    	</form>
    </div>
  </body>
</html>
