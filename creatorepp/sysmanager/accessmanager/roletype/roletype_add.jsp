<%@ page contentType="text/html; charset=GBK" language="java"  errorPage="" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<html>
<head>
<title>������ɫ����</title>
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">		
<SCRIPT language="javascript">
function save()
{
	if(roletypeform.roletype.value=="" || roletypeform.roletype.length==0)
	{
		alert("��ɫ���Ͳ���Ϊ�գ�");
		return false;
	}
	if(roletypeform.typedesc.value=="" || roletypeform.typedesc.length==0)
	{
		alert("��ɫ��������Ϊ�գ�");
		return false;
	}
	roletypeform.action = "roletype_add_do.jsp"
	roletypeform.target = "roletypeformF"
	roletypeform.submit();
}
</SCRIPT>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
%>
<form method="post" name="roletypeform">
		<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="thin"> 
		    <tr valign='top'>
           		<td height='20'valign='middle'><img src='../../images/edit.gif' width="16" height="16" border=0 align='middle'>&nbsp;<strong>������ɫ����</strong></td>
         	</tr>	       
		   <tr>
	       	   <td>��ɫ����:
	           	<input name="roletype" type="text"  value="" size="22" />
	           </td>					
           </tr>
           <tr>
	           <td>��������:
	           	<textarea name="typedesc"  rows="5" style="width:400px;"></textarea>
	           </td>					
           </tr>
           <tr>
           	   <td>
               <div align="center">
               <input name="Submit4" type="button" value="����"  class="input"  onclick="save()">
               <input style=" cursor:hand;" name="btn_close" type="button"  class="input"  onClick="window.close();" value="�ر�">
               </div>
               </td>
           </tr>    
      </table>
</form>
</body>
<iframe name="roletypeformF" width="0" height="0" style="display:none"></iframe>
</html>