<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*, com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %> 
<%
	String currGroupId = (String) session.getAttribute("groupId");
	String reFlush = "true";
	if (request.getAttribute("reFlush") != null) {
		reFlush = "false";
	}
%>
<html>
<head>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/opermanager/common.js" type="text/javascript"></script>
<SCRIPT language="JavaScript" SRC="<%=request.getContextPath()%>/sysmanager/opermanager/validateForm.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>系统管理</title>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
</head>

<script language="JavaScript" >
var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
var reFlush = "<%=reFlush%>";
if ( reFlush == "true" && parent.operList.operList != null)
{
	if (!baseNavigatorContent)
	   baseNavigatorContent = top.frames["base_navigator_content"];	    

	//getNavigatorContent().location.href.document.opergroupList.submit;
	getNavigatorContent().location.href="<%=rootpath%>/sysmanager/opermanager/navigator_content.jsp";
}

function storeOpergroup()
{
	if (validateForm(opergroupInfo) )
	{
		document.opergroupInfo.action="../opermanager/storeGroup.do?method=storeOpergroup";
		document.opergroupInfo.submit();
	}
}

function newOpergroup()
{
	document.opergroupInfo.action="../opermanager/operManager.do?method=newOpergroup";
	document.opergroupInfo.submit();
}

function reloadOpergroup(){
	document.opergroupInfo.submit();
}

function gotoOpgrouprestype(){
	document.opergroupInfo.action="../opermanager/operManager.do?method=getOpgroupAllRestype";
	document.opergroupInfo.submit();
}
function deleteoper(){
	if(window.confirm("你确定要删除吗？(删除后是不可以再恢复的)")){
	document.opergroupInfo.action="../opermanager/operManager.do?method=deleteOpergroup";
	document.opergroupInfo.submit();
	}
}

</script>

<%@ include file="/epp/css/cssControl.jsp"%><body  class="info">

<form name="opergroupInfo" method="post" action="">
<pg:beaninfo requestKey="currOpergroup">

<table width="100%" height="25" border="0" cellpadding="0" cellspacing="2">
  <tr>
    <td class="detailtitle" height="25" ><strong>　操作组名</strong></td>
    <td height="25"><input type="text" name="groupName" value="<pg:cell colName="groupName"  defaultValue=""/>" validator="string" cnname="组名" maxlength="200"></td>
    <td class="detailtitle" height="25" ><strong>　操作组描述</strong></td>
    <td height="25"><input type="text" name="groupDesc" value="<pg:cell colName="groupDesc"  defaultValue=""/>" validator="string" cnname="组描述" maxlength="100"></td>    
    <td>&nbsp;</td>
  </tr>
  <input type="hidden"  name="groupId" value="<pg:cell colName="groupId"  defaultValue=""/>" />    
</table>
</pg:beaninfo>
</form>

<hr width="100%"></hr>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="35%" border="0" align="right" cellpadding="0" cellspacing="0" >
        <tr>
          <td><div align="center">
            <input name="resave" type="button" class="input" value="新增" onclick="newOpergroup()">
          </div></td>        
          <td><div align="center">
            <input name="resave" type="button" class="input" value="保存" onclick="storeOpergroup()">
          </div></td>
          <td><div align="center">
          <input name="Submit32" type="submit" class="input" value="重置" onclick="reloadOpergroup()">
          </div></td>
          <td><div align="center">
          <input name="Submit32" type="submit" class="input" value="隶属资源类型" onclick="gotoOpgrouprestype()">
          </div></td>
          <td><div align="center">
          <input name="Submit33" type="submit" class="input" value="删除" onclick="deleteoper()">
          </div></td>
                  
        </tr>
    </table></td>
  </tr>
</table>
<%@ include file="../sysMsg.jsp"%>

</body>
</html>
