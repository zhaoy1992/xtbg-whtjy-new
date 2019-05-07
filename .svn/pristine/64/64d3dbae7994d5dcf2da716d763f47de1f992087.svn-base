<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);

			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);
			response.setDateHeader("max-age", 0);

			String flag = request.getParameter("flag");

		%>
<html>
	<head>
		<title>模板管理</title>
	</head>
	<frameset name="userOrgFrame" cols="18%,*" border=0 framespacing="0">
		<frame frameborder=1 scrolling="yes" name="org_tree" src="../../eformsys/fceform/WebOffice_orgTree.jsp" marginWidth=0 marginHeight=0 >
		</frame>
		<frame frameborder=1 scrolling="no" name="org_templateList" src="../../eformsys/fceform/WebOffice_content.jsp" marginWidth=0 marginHeight=0 >
		</frame>
	</frameset>
</html>

<%--
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
%>                 
<html>
<head>
<title>模板管理</title>
<!-- link rel='stylesheet' type='text/css' href='../test.css'-->
<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
			
<script language="javascript">
function ConfirmDel(FileUrl){
	if (confirm('是否确定删除该模板！')){
		location.href=FileUrl;
	}
}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin">
	<div id="contentborder" align="center">
		<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
			<tr>
				<td class="detailtitle" width="10%" align=right>
					模板编号：
				</td>
				<td class="detailcontent" width="90%">
					<input type="text" name="djid" style="width:70%" value="">
				</td>
			</tr>
			<tr>
				<td class="detailtitle" width="10%" align=right>
					模板名称：
				</td>
				<td class="detailcontent" width="90%">
					<input type="text" name="djname" style="width:70%" value="">
				</td>
			</tr>
			<tr>
				<td width="16%">
				</td>
				<td class="detailcontent" width="30%" align="right">                             
					<input name="Submit4" type="submit" class="input" value="查询" onClick="queryForm()">
					<input name="Submit22" type="reset" class="input" value="重置">
				</td>
			</tr>
        </table>
        
		<hr width="100%">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
		    <!-- 
		    <tr>
				<td height='30' class="detailtitle" align="center" colspan="9">
						<b>模板管理</b>
				</td>
			</tr>
			-->
			<tr>
				<td colspan=5 nowrap align="right">
				  <input type=button name="AddDocTemplate" value="新建word模板"  onclick="javascript:location.href='TemplateEdit.jsp?FileType=.doc';">
				  <input type=button name="AddXslTemplate" value="新建excel模板" onclick="javascript:location.href='TemplateEdit.jsp?FileType=.xls';">
				  <input type=button name="AddXslTemplate" value="新建wps模板" onclick="javascript:location.href='TemplateEdit.jsp?FileType=.wps';">
				  <input type=button name="AddDocTemplate" value="新建金山表格模板"  onclick="javascript:location.href='TemplateEdit.jsp?FileType=.et';">
				  <input type=button name="AddXslTemplate" value="新建ppt模板" onclick="javascript:location.href='TemplateEdit.jsp?FileType=.ppt';">
				  <input type=button name="AddXslTemplate" value="新建visio模板" onclick="javascript:location.href='TemplateEdit.jsp?FileType=.vsd';">
				  <!-- <input type=button name="Return" value="返 回"  onclick="javascript:location.href='../DocumentList.jsp';"-->
				</td>
				<!-- td colspan=2 class="TDTitleStyle">&nbsp;</td-->
			</tr>
			<tr>
				<td nowrap align=center class="headercolor" height="20">编号</td>
				<td nowrap align=center class="headercolor">模板名称</td>
				<td nowrap align=center class="headercolor">模板类型</td>
				<td nowrap align=center class="headercolor">模板说明</td>
				<td nowrap align=center class="headercolor">操作</td>
			</tr>
			<%
			  iDBManager2000 DbaObj=new iDBManager2000();
			  if (DbaObj.OpenConnection())
			  {
			    try
			    {
			      ResultSet result=DbaObj.ExecuteQuery("Select RecordID,FileName,FileType,Descript From "+appUserName+"TD_OCTL_Template_File order by TemplateID desc") ;
			      while ( result.next() )
			      {
			        String mRecordID=result.getString("RecordID");
			        String mFileName=result.getString("FileName");
			        String mFileType=result.getString("FileType");
			        String mDescript=result.getString("Descript");
			%>
			<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">
				<td height='20' align=center class="tablecells"><%=mRecordID%>&nbsp;</td>
				<td height='20' align=center class="tablecells"><%=mFileName%>&nbsp;</td>
				<td height='20' align=center class="tablecells"><%=mFileType%>&nbsp;</td>
				<td height='20' align=center class="tablecells"><%=mDescript%>&nbsp;</td>
				<td height='20' align=center class="tablecells">
					<input type=button onclick="javascript:location.href='TemplateEdit.jsp?RecordID=<%=mRecordID%>&FileType=<%=mFileType%>';" name="Edit" value=" 修 改 ">
					<input type=button onclick="javascript:ConfirmDel('TemplateDel.jsp?RecordID=<%=mRecordID%>');" name="Del" value=" 删 除 ">
				</td>
			</tr>
			<%
			      }
			      result.close() ;
			    }
			    catch(Exception e)
			    {
			      System.out.println(e.toString());
			    }
			    DbaObj.CloseConnection() ;
			  }
			  else
			  {
			    out.println("OpenDatabase Error") ;
			  }
			%>
       </table>
     </div>  
</body>
</html>
--%>
