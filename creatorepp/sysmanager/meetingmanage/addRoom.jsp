<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);     	
    String userId = accesscontroler.getUserID();
   
%>
<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="validateForm.js"></SCRIPT>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>����������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
.style2 {
	font-family: Tahoma, Verdana, Arial, Helvetica;
	font-weight: bold;
	font-size: medium;
}
.style3 {font-size: medium}
-->
        </style>
</head>

<script language="JavaScript">
function goBack(){		
	document.location.href="../meetingmanage/meetingroominformation.jsp";
	}
function submitAPP(){
         if(document.all.item("name").value == "" )
		{
			alert("����д����������!!!");
			return;
		}
	    document.forms[0].action="../meetingmanage/meetingManager.do?method=addMeetingRoom";
		document.forms[0].submit();	
	}	
	
</script>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="info">

	<form name="RoomForm"  action="" method="post">
			<pg:beaninfo requestKey="newRoom">
			<div align="center" class="detailtitle style3">
					<p class="style4">
						<br>
						<span class="style2">����������</span>
						<br>
						<br>
					</p>
				</div>								 
			<table width="100%" height="206" border="0" cellpadding="0" cellspacing="2">
              <tr>
                <td height="23" class="detailtitle" width="20%"><strong> ����������</strong></td>
                <td>
                <input name="name" type="text" 
				value="<pg:cell colName="name"  defaultValue=""/>">
              
                </td>
                <td height="23" class="detailtitle" width="20%"><strong> �����ҵص�</strong></td>
                <td height="23" width="29%"> <input name="place" type="text" 
				 value="<pg:cell colName="place"  defaultValue=""/>">
                </td>
                <td width="1%">&nbsp;</td>
              </tr>
              <tr>
                <td height="23" class="detailtitle"><strong> ��������Ա</strong></td>
                <td height="23" width="29%"> <input name="capacity" type="text" 
				 value="<pg:cell colName="capacity"  defaultValue=""/>">
                </td>
                <td height="23" class="detailtitle" width="20%"><strong> ������λ��</strong></td>
                 <td height="23" width="29%"> <input name="seatnumber" type="text" 
				 value="<pg:cell colName="seatnumber"  defaultValue=""/>">
                </td>
                <td align="right">&nbsp;</td>
              </tr>
              <tr>
                <td height="30" class="detailtitle"><strong> �������Ӳ��˵��</strong></td>
                <td height="30" width="30%"><textarea name="hardware" cols="50" rows="3"></textarea></td>
              </tr>
              <tr>
                <td height="55" class="detailtitle"><strong> ��ע</strong></td>
                <td height="55" width="30%"><textarea name="remark" cols="50" rows="6"></textarea></td>
              </tr>
           
            </table>
			</pg:beaninfo>
		<p>&nbsp;</p>
		<hr width="98%">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
			  <td align="right">
				  <INPUT type="button"  value="�ύ" align=right onclick="submitAPP()">				 
                  <INPUT type="button" value="ȡ��"  align=right onclick="goBack()">
                  <INPUT type="reset"  value="����"  align=right >
</td>
 <td width="5%">&nbsp;</td>
			</tr>
		</table>
	</form>
	</body>
</html>
