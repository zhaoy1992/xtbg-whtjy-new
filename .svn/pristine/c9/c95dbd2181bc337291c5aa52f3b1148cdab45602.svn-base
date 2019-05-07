<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@page import="java.util.*, com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<%
	String currGroupId = (String) session.getAttribute("groupId");
	String reFlush = "true";
	if (request.getAttribute("reFlush") != null) {
		reFlush = "false";
	}
	String isOperExist = "false";
	if ( request.getAttribute("isOperExist") != null){
		isOperExist = "true";
	}	
	String setDisbaled = "";
	if ( request.getAttribute("opNameDisable") != null ){
		setDisbaled = "disabled = true";
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
	parent.operList.operList.submit();	
}	
var isOperExist = "<%=isOperExist%>";
if ( isOperExist == "true"){
	alert("操作名已存在，请重新输入操作名!");
}
	
function storeOper()
{
	if (validateForm(operInfo) )
	{
		document.operInfo.action="../opermanager/operManager.do?method=storeOper";
		document.operInfo.submit();
	}
}

function reloadOper(){
	document.operInfo.submit();
}

function newOper()
{
	document.operInfo.action="../opermanager/operManager.do?method=newOper";
	document.operInfo.submit();
}

function setDisable(v){
	v.disabled = false;
	if  ( document.operInfo.opId.value != "" )
	{
		v.disabled = true;
	}
}

</script>

<%@ include file="/epp/css/cssControl.jsp"%><body  style="contentbodymargin">

<form name="operInfo" method="post" action="">
<pg:beaninfo requestKey="currOper">

<table width="100%" height="25" border="0" cellpadding="0" cellspacing="2">
  <tr>
    <td height="25" class="detailtitle"><strong>　操作名</strong></td>
    <td height="25"><input type="text" name="opName" value="<pg:cell colName="opName"  defaultValue=""/>" validator="string" cnname="操作名" maxlength="50" <%=setDisbaled%> onfocus="setDisable(this)"></td>
  
    <td height="25" class="detailtitle"><strong>　操作描述</strong></td>
    <td height="25"><input type="text" name="opDes" value="<pg:cell colName="opDes"  defaultValue=""/>" validator="string" cnname="操作描述" maxlength="200"></td>
    <td height="25" class="detailtitle"><strong>　优先级</strong></td>
    <td height="25"><input type="text" name="priority" value="<pg:cell colName="priority"  defaultValue=""/>" validator="int" cnname="优先级" maxlength="10"></td>    
          <td><div align="center">
            <input name="new" type="button" class="input" value="新增" onclick="newOper()">
          </div></td>        
          <td><div align="center">
            <input name="save" type="button" class="input" value="保存" onclick="storeOper()">
          </div></td>
          <td><div align="center">
          <input name="reload" type="submit" class="input" value="重置" onclick="reloadOper()">
          </div></td>
    <td>&nbsp;</td>
  </tr>
  <input type="hidden"  name="opId" value="<pg:cell colName="opId"  defaultValue=""/>" />    
  <input name="groupId" value="<%=currGroupId%>" type="hidden" >  
</table>
</pg:beaninfo>
</form>
<%@ include file="../sysMsg.jsp"%>
</body>
</html>
