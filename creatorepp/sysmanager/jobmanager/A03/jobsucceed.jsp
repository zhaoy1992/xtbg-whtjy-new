<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<html>
   <head>
   <title>岗位操作</title>
   <link rel="stylesheet" type="text/css" href="../../css/windows.css">
   <link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
     <script language="javascript">
  	getNavigatorContent().location.href ="../sysmanager/jobmanager/navigator_content.jsp?anchor=0&collapse=0&request_scope=session";
  	function updateAfter(){
		getNavigatorContent().location.href ="../sysmanager/jobmanager/navigator_content.jsp?anchor=0&expand=0&request_scope=session"; 
	}
    </script>
  </head>
   <%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
  <div id="contentborder" >
 <table>
 <tr>
 <td class="detailtitle">
操作岗位信息成功!!!
 </td>
 </tr>
 </table>
 </div>
 </body>
   
</html>
