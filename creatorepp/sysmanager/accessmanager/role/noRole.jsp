<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<html>
<head>    
<%
String deleteRole = (String)session.getAttribute("deleteRole");
session.removeAttribute("deleteRole");
%>
<SCRIPT LANGUAGE="JavaScript">
if(<%=deleteRole%>)
{
	alert("操作成功！");
	getNavigatorContent().location.href="../sysmanager/accessmanager/role/navigator_content.jsp"; 
}
</SCRIPT>

  <title>属性容器</title>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
 </head>
 <%@ include file="/epp/css/cssControl.jsp"%><body   class="contentbodymargin" scroll="no">
 <div id="contentborder" >
 <table>
 <tr>
 <td class="detailtitle">
 请选择左边的角色再进行操作
 </td>
 </tr>
 </table>
 </div>
<%@ include file="../../sysMsg.jsp"%>
 </body>
 
 </html>