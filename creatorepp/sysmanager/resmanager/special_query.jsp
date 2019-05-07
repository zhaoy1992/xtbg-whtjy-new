<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.chinacreator.config.model.ResourceInfo"%>
<%@ page import="com.chinacreator.config.ResourceInfoQueue"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager"%>
<%@ page import="com.chinacreator.config.model.Operation"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);


//查询资源列表
List resQueue = null;
ResourceManager resManager = new ResourceManager();
resQueue = resManager.getResourceInfos();
 for(int i = 0; i < resQueue.size(); i ++)
        {
            ResourceInfo res = (ResourceInfo)resQueue.get(i);
            if(!res.isUsed())
                continue;
            String listId = res.getId();
            String listName = res.getName();
		 }
request.setAttribute("resList",resQueue);
%>
<html>
<head>    
 <title>属性容器</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">
function getSpecial(){
	var special = document.all.special.value;
	if(special == "unprotected"){
		document.all.theTitle.innerHTML = "<b>系统中未受保护的资源<b>";
	}else if(special == "exclude"){
		document.all.theTitle.innerHTML = "<b>只有超级管理员才有的资源<b>";
	}
}
function sub(){
		getSpecial()
		orgreslist.action = "special_querylist.jsp?special="+document.all.special.value+"&opId="+document.all.operategroup.value;
		orgreslist.submit();
}
function getOpGroup(){
	getopergroup.location.href = "../user/resChange.jsp?restypeId="+document.all.restypeId.value;
}
</SCRIPT>
<link href="../css/windows.css" rel="stylesheet" type="text/css">
<link href="../css/contentpage.css" rel="stylesheet" type="text/css">
<link href="../css/tab.winclassic.css" rel="stylesheet" type="text/css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="sub()">
<div id="contentborder" align="center">
	<form  name = "orgreslist" id="orgreslist" method="post" target="querylist">
		<table width="100%" border="0"  cellpadding="0" cellspacing="1" class="thin">
			<tr>
				<td height='20' colspan="4">
					<div id="theTitle" name="theTitle" align="center"></div>
				</td>
			</tr>
			<tr class="labeltable_middle_td">
				<td height='20'  colspan="4">
					请选择您要查询的资源:
					<select name="special" id="special" onchange="">
						<option value="unprotected">系统中未受保护的资源</option>
						<option value="exclude">只有超级管理员才有的资源</option>
					</select>
					资源标识：<input type="text" name="resId" id="resId" value=""/>
					资源名称：<input type="text" name="resName" id="resName" value=""/>
				</td>
			</tr>
			
			<tr>
				<td height='20' colspan="3" nowrap>

					<select id="restypeId" name="restypeId" onchange="getOpGroup()">
						<option value="">--请选择资源类型--</option>
				      	<pg:list requestKey="resList" needClear="false">
					    	<option value="<pg:cell colName="id"/>">
					        	<pg:cell colName="name"/>
							</option>
						</pg:list>
					</select>
					<select id="operategroup" name="operategroup">
						<option value="">--请选择操作类型--</option>
					</select>
				</td>
				<td height='20'>
					<input type="button" class="input" value="确定" onclick="sub()"/>
					<input type="reset" class="input" value="重置"/>
				</td>
			</tr>
		</table>	
	</form>	
</div>
<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
</body>

</html>