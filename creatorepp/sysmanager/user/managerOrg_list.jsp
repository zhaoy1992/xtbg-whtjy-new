<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

String userId=request.getParameter("userId");
String userRealName = "";
String userName = "";
if(userId != null)
 {
 	userId = request.getParameter("userId");
 	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(userId);
	userRealName= user.getUserRealname();
	userName = user.getUserName();
}
String remark5 = request.getParameter("remark5");
String orgnumber = request.getParameter("orgnumber");
if(remark5 == null)remark5="";
if(orgnumber == null)orgnumber="";
%>
<html>
<head>    
 <title>�û���<%=userRealName%>���ɹ����Ĳ����б�</title>

<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<script language="JavaScript">
	function resetSearch()
	{
		document.all.remark5.value = "";
		document.all.orgnumber.value = "";
	}
	
	function sub(){
		var orgName = document.all.remark5.value;
		var orgnumber = document.all.orgnumber.value;
		var tablesFrame= document.getElementsByName("orgList");
		tablesFrame[0].src = "managerOrg_list_iframe.jsp?userId=<%=userId%>&orgName=" + orgName + "&orgnumber=" + orgnumber;
	}
</script>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder" align="center" >
<form name="Org" action="" method="post">

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
  <tr>
    <td>��������</td>
    <td class="detailcontent"><input type="text" name="remark5" value="<%=remark5%>"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td >�������</td>
    <td class="detailcontent"><input type="text" name="orgnumber" value="<%=orgnumber%>"></td>
    <td>
    	<div align="center">
            <input name="Submit4" type="button" class="input" value="��ѯ" onclick="sub()">                
            <input name="Submit22" type="button" class="input" value="����" onclick="resetSearch()" >
            <input name="Submitc" type="button" class="input" value="�ر�" onclick="window.close();" >
        </div>
    </td>
  </tr>      
</table>
<hr width="100%">	    
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin" height="100%">
	
	<tr><td height='30' align=center colspan=4><b>�����б�<%if(accesscontroler.isAdmin(userName)){%><font color="red">(���û�ӵ��administrator��ɫ���ɹ������еĲ���)</font><%}%></b></td></tr>
	<tr><td colspan="4">
		<iframe name="orgList" src="managerOrg_list_iframe.jsp?userId=<%=userId%>" style="width:100%" height="100%" scrolling="no" frameborder="0" marginwidth="1" marginheight="1">
		</iframe>
	</td></tr>		
	</table>	
  </form> 
</div>
</body>

</html>