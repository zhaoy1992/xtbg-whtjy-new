<%
/**
 * <p>Title: ������ɫ����ҳ��</p>
 * <p>Description: ������ɫ����ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author baowen.liu
 * @version 1.0
 **/
 %>
<%@ page contentType="text/html; charset=GBK" language="java"  errorPage="" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<html>
<head>
<title>������ɫ����</title>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/treeview.css">

<SCRIPT language="javascript">
function save()
{   
	if(roletypeform.roletype.value.replace(/\s/g,"")=="" || roletypeform.roletype.length==0)
	{
		alert("��ɫ���Ͳ���Ϊ�գ�");
		return false;
	}
	if(roletypeform.typedesc.value.replace(/\s/g,"")=="" || roletypeform.typedesc.length==0)
	{
		alert("��ɫ��������Ϊ�գ�");
		return false;
	}
	document.all.Submit4.disabled=true;
	document.all.btn_close.disabled=true;
	document.all.divProcessing.style.display = "block";
	roletypeform.action = "roletype_add_do.jsp"
	roletypeform.target = "hiddenFrame"
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
           		<td height='20'valign='middle'>&nbsp;<strong>������ɫ����</strong></td>
         	</tr>	       
		   <tr>
	       	   <td>��ɫ����:
	           	<input name="roletype" type="text"  value="" size="22" />
	           </td>					
           </tr>
           <tr>
	           <td>��ɫ����:
	           	<textarea name="typedesc"  rows="5" style="width:400px;"></textarea>
	           </td>					
           </tr>
           <tr>
           	   <td>
               <div align="center">
               <input name="Submit4" type="button" value="����"  class="input"  onclick="save()">
               <input style=" cursor:hand;" name="btn_close" type="button"  class="input"  onClick="window.close();window.returnValue=true;" value="�ر�">
               </div>
               </td>
           </tr>    
      </table>
</form>
<div id=divProcessing style="width:200px;height:30px;position:absolute;left:150px;top:260px;display:none">
	<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
		<tr>
			<td bgcolor=#3A6EA5>
				<marquee align="middle" behavior="alternate" scrollamount="5">
					<font color=#FFFFFF>...������...��ȴ�...</font>
				</marquee>
			</td>
		</tr>
	</table>
</div>
</body>
<iframe name="hiddenFrame" width="0" height="0" style="display:none"></iframe>
</html>