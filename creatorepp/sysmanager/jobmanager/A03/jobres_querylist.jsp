<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.chinacreator.config.model.ResourceInfo,
								 com.chinacreator.sysmgrcore.manager.ResManager,
								 com.chinacreator.sysmgrcore.manager.SecurityDatabase,
								 org.frameworkset.spi.SPIException"%>
<%@ page import="com.chinacreator.config.ResourceInfoQueue"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

String jobId = (String)request.getParameter("jobId");
//String resTypeId = (String)request.getParameter("resTypeId");
//ResourceManager resourceManager = new ResourceManager();

//ResManager resManager = SecurityDatabase.getResourceManager();
//List UserResList = new ArrayList();
//UserResList = resManager.getJobRoleResList(jobId);
//request.setAttribute("UserResList", UserResList);
String[] checkValues = request.getParameterValues("permission");
if(checkValues != null && checkValues.length > 0){
	for(int i = 0; i < checkValues.length; i++){
		String opId = checkValues[i].substring(1, checkValues[i].indexOf("+", 1));
		checkValues[i] = checkValues[i].substring(checkValues[i].indexOf("+", 1));
		String resId = checkValues[i].substring(1, checkValues[i].indexOf("+", 1));
		checkValues[i] = checkValues[i].substring(checkValues[i].indexOf("+", 1));
		String roleId = checkValues[i].substring(1, checkValues[i].indexOf("+", 1));
		checkValues[i] = checkValues[i].substring(checkValues[i].indexOf("+", 1));
		String resTypeId = checkValues[i].substring(1, checkValues[i].indexOf("+", 1));
		checkValues[i] = checkValues[i].substring(checkValues[i].indexOf("+", 1));
		String types = checkValues[i].substring(1);
		try {
			ResManager resManager = SecurityDatabase.getResourceManager();
			resManager.deleteRoleResOp(opId, resId, roleId, resTypeId, types);
		} catch (SPIException e) {
			e.printStackTrace();
		}
	}
}
%>
<html>

<head>    
 <title>��������</title>
<link href="../../css/windows.css" rel="stylesheet" type="text/css">
<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
<link href="../../css/tab.winclassic.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
<script>
var isSucceed = "<%=request.getParameter("isSucceed")%>"
if(isSucceed=="1"){
	alert("ɾ����¼�ɹ�!");
}
function sub(){
	var isSelect = false;
	var outMsg;
	for(var i = 0; i < queryList.elements.length; i++){
		var e = queryList.elements[i];
		if(e.name == 'permission'){
			if(e.checked){
				isSelect = true;
				break;
			}
		}
	}
	if(isSelect){
		outMsg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)��";
		if (confirm(outMsg)){
			document.queryList.action = "jobres_querylist.jsp?jobId=<%=jobId%>&isSucceed=1";
			document.queryList.submit();
			return true;
		}
	}else{
		alert("����Ҫѡ��һ����¼��");
	}
}
</script>
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder" align="center">
	<form name="queryList" method=post action=""/>
		<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">
			
			
			<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.JobRoleList" keyName="JobRoleList"/>
			<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
			<pg:pager maxPageItems="17" scope="request" data="JobRoleList" isList="false">
			<tr class="labeltable_middle_td">
			<!--���÷�ҳ��ͷ-->
				<td height='20' class="headercolor"></td>
				<td height='20' class="headercolor">��Դ����</td>
				<td height='20' class="headercolor">��Դ��ʶ</td>
				<td height='20' class="headercolor">��Դ����</td>
				<td height='20' class="headercolor">��Դ����</td>
				<td height='20' class="headercolor">��ɫ����</td>
			</tr>
      		<pg:param name="jobId" />
      		<pg:param name="resName" />
      		<pg:param name="resid" />
      		<pg:param name="resTypeId" />
      		<pg:param name="opId" />
  
			<!--��⵱ǰҳ���Ƿ��м�¼-->
			<pg:notify>
			<tr height="18px" >
				<td class="detailcontent" colspan=100 align='center'>��ʱû����Դ</td>
			</tr>
			</pg:notify>			      
			<!--list��ǩѭ�����ÿ����¼-->			      
			<pg:list>	
			<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
				<%
					if(dataSet.getString("resTypeName") == "δ֪" || dataSet.getString("opName") == "δ֪" ){
				%>
				<td class="tablecells" align=left>
				<input type="checkbox" name="permission" value="+<pg:cell colName="opId" defaultValue=""/>+<pg:cell colName="resId" defaultValue=""/>+<pg:cell colName="roleId" defaultValue=""/>+<pg:cell colName="resTypeId" defaultValue=""/>+<pg:cell colName="types" defaultValue=""/>"/>
				</td>
				<td class="tablecells" align=left><font color=red><pg:cell colName="resTypeName" defaultValue=""/>(<pg:cell colName="resTypeId" defaultValue=""/>)</font></td>
				<td class="tablecells" align=left><font color=red><pg:cell colName="resid" defaultValue=""/></font></td>
				<td class="tablecells" align=left><font color=red><pg:cell colName="resName" defaultValue=""/></font></td>
				<td class="tablecells" align=left><font color=red><pg:cell colName="opName" defaultValue=""/>(<pg:cell colName="opId" defaultValue=""/>)</font></td>
				<td class="tablecells" align=left><font color=red><pg:cell colName="roleName" defaultValue=""/></font></td>
				<%	}else{	
				%>
				<td class="tablecells" align=left>
				<input disabled="true" type="checkbox" name="permission" value="+<pg:cell colName="opId" defaultValue=""/>+<pg:cell colName="resId" defaultValue=""/>+<pg:cell colName="roleId" defaultValue=""/>+<pg:cell colName="resTypeId" defaultValue=""/>+<pg:cell colName="types" defaultValue=""/>"/>
				</td>
				<td class="tablecells" align=left><pg:cell colName="resTypeName" defaultValue=""/>(<pg:cell colName="resTypeId" defaultValue=""/>)</td>
				<td class="tablecells" align=left><pg:cell colName="resId" defaultValue=""/></td>
				<td class="tablecells" align=left><pg:cell colName="resName" defaultValue=""/></td>
				<td class="tablecells" align=left><pg:cell colName="opName" defaultValue=""/>(<pg:cell colName="opId" defaultValue=""/>)</td>
				<td class="tablecells" align=left><pg:cell colName="roleName" defaultValue=""/></td>
				<%}%>

				
			</tr>
			</pg:list>
			<tr height="18px" >
				<td class="detailcontent" colspan=5 align='center'><pg:index/><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
				<td class="detailcontent" colspan=1 align='left'><input type="button" class="input" onClick="sub()" value="ɾ��" /></td>
			</tr>   			   	      
			</pg:pager>
		</table>	
	</form>	
</div>
<iframe id="getopergroup" name="getopergroup" height="0" width="0"></iframe>
</body>

</html>