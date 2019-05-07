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
<title>签章管理</title>
<!-- link rel='stylesheet' type='text/css' href='../test.css'-->
<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
<script language="javascript">
function ConfirmDel(FileUrl){
	if (confirm('是否确定删除该印签！')){
		location.href=FileUrl;
	}
}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
	<tr>
			<td height='30' class="detailtitle" align="center" colspan="9">
				<b>签章管理</b>
			</td>
		</tr>
	<tr>
		<td colspan=5 height='20' nowrap align="right">
		  <input type=button name="Add" value="增加签章"  onclick="javascript:location.href='SignatureAddFrm.jsp'">
		  <!-- input type=button name="Return" value="返 回"  onclick="javascript:location.href='../DocumentList.jsp';"-->
		</td>
	</tr>
	<tr>
		<td nowrap align=center class="headercolor" height="20">编号</td>
		<td nowrap align=center class="headercolor" height="20">用户名称</td>
		<td nowrap align=center class="headercolor" height="20">签章名称</td>
		<td nowrap align=center class="headercolor" height="20">签章类型</td>
		<td nowrap align=center class="headercolor" height="20">操作</td>
	</tr>
	<%
          iDBManager2000 DbaObj=new iDBManager2000();
           if (DbaObj.OpenConnection())
           {
             try
             {
               ResultSet result=DbaObj.ExecuteQuery("select SignatureID,UserName,MarkName,MarkType from "+appUserName+"TD_OCTL_Signature order by SignatureID desc") ;
               while ( result.next() )
               {
                String mSignatureID=result.getString("SignatureID");
        %>
	<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">
		<td height='20' align=center class="tablecells"><%=result.getString("SignatureID")%>&nbsp;</td>
		<td height='20' align=center class="tablecells"><%=result.getString("UserName")%>&nbsp;</td>
		<td height='20' align=center class="tablecells"><%=result.getString("MarkName")%>&nbsp;</td>
		<td height='20' align=center class="tablecells"><%=result.getString("MarkType")%>&nbsp;</td>
		<td height='20' align=center class="tablecells" width=148 nowrap>
			<input type=button onclick="javascript:location.href='SignatureEditFrm.jsp?SignatureID=<%=mSignatureID%>';" name="Edit" value=" 修 改 ">
			<input type=button onclick="javascript:ConfirmDel('SignatureDel.jsp?SignatureID=<%=mSignatureID%>');" name="Del" value=" 删 除 ">
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
</body>
</html>
