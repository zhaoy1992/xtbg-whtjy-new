<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager,com.chinacreator.resource.ResourceManager"%>
<%
String roleId = (String)session.getAttribute("currRoleId");
String restypeId=request.getParameter("restypeId");
ResourceManager resManager = new ResourceManager();
List Operationslist = resManager.getOperations(restypeId);
if(Operationslist == null){
	Operationslist = new ArrayList();
}
request.setAttribute("Operationslist",Operationslist);



%>
<html>
<head>    
 <title>��������</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">
var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
function getJobInfo(e,roleId){
	jsAccessControl.setBackColor(e);
	document.all("selectId").value = roleId;
}
function sub(){
	var resdescribe = document.rolereslist.resdescribe.value;
	var operatetype = document.all("operatetype").value;
	var tablesFrame= document.getElementsByName("theIframe");
	tablesFrame[0].src = "rolereslist_iframe.jsp?roleId=<%=roleId%>&restypeId=<%=restypeId%>&resdescribe=" + resdescribe + "&operatetype=" + operatetype;
}
</SCRIPT>
<link href="../../sysmanager/css/windows.css" rel="stylesheet" type="text/css">
<link href="../../sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
<link href="../../sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder" align="center">
	<form name = "rolereslist" method="post">
		<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">
			<tr><td class="detailtitle" align=center colspan=5><b>��Դ��ѯ</b></td></tr>
			<tr>
				<td height='20'>
					<a>��Դ������</a><input type="text" name="resdescribe">
				    <select class="select" name="operatetype">
				      	<option value="">--��ѡ����Դ--</option>
				      	<pg:list requestKey="Operationslist" needClear="false">
					    	<option value="<pg:cell colName="id"/>">
					        	<pg:cell colName="name"/>
							</option>
						</pg:list>
					</select>
				</td>
				<td>
					<input name="search" type="button" class="input" value="��ѯ" onClick="sub()">
				</td>
			<tr><td class="detailtitle" align=center colspan=5><b>��Դ�б�</b></td></tr>
			<tr height="500">
			<td class="detailtitle" align=center colspan=5>
			<iframe src="rolereslist_iframe.jsp?roleId=<%=roleId%>&restypeId=<%=restypeId%>" width="100%" height="100%" name="theIframe"></iframe>
			</td>
			</tr>
		</table>	
	</form>	
</div>

</body>

</html>