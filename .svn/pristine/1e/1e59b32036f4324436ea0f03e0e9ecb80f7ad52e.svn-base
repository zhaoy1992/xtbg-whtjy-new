<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<html>
	<head>
		<title>属性容器</title>
		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<script language="JavaScript">
	function queryType()
	{	
		document.all.inputTypeList.src="inputTypeList.jsp?typeName="+document.all.typeName.value;
	}
    function resetForm(){
        document.all("typeDesc").value = "";
    }
</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
	<div id="contentborder" align="center">
					<table width="95%" border="0"  align="center" cellpadding="0" cellspacing="1" class="thin">
					<tr valign='top'>
           					<td height='30'valign='middle' colspan="5"><img src='<%=rootpath%>/sysmanager/images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>输入类型列表</strong></td>
         			</tr>
						<tr>
						<td class="detailtitle" width="10%" align="center">
							输入类型名称
						</td>
						<td class="detailcontent">
							<input type="text" name="typeName" style="width:220">
						</td>
						<td width="12%" align="center">
								<input name="search" type="button" class="input" value="查询" onClick="queryType()">
								<input name="Submit22" type="reset" class="input" value="重置" onClick="document.all.typeName.value='';">
						</td>
					</tr>
					</table>
					<table width="95%" height="600" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><iframe name="inputTypeList" frameborder="0" width="100%" height="580" src="inputTypeList.jsp"></iframe></td>
					</tr>
					</table>
	</div>
	</body>
</html>
