<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.config.model.ResourceInfo"%>
<%@ page import="com.chinacreator.security.AccessControl
				,com.chinacreator.config.ConfigManager"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.resource.ResourceManager"%>

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
String isUserRes = request.getParameter("isUserRes");//控制查询条件开关,为is时,查询用户为当前用户
String userName = "";
if("is".equals(isUserRes))
	userName = accesscontroler.getUserAccount();
	
String typeName = request.getParameter("typeName");	
	
%>
<html>
<head>    
 <title>权限资源查询</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">

function isUserRes(){
	var userName = "<%=userName%>";
	userreslist.action="../user/userres_querylist.jsp?opId="+document.all("operategroup").value
						+"&type=user&name="+userName+"&typeName=<%=typeName%>";
	userreslist.submit();
	
}
   
function sub(){
	//定义当前操作的对象提示
	var type = document.all("type").value;
	var typeName ;
	if(type == "user"){
		typeName = "用户";
	}else if(type == "role"){
		typeName = "角色";
	}else if(type == "org"){
		typeName = "机构";
	}else if(type == "job"){
		typeName = "岗位";
	}else if(type == "orgjob"){
		typeName = "机构岗位";
	}
	if(document.userreslist.name.length == 0 || document.userreslist.name.value == "") 
	{
		alert("请输入" + typeName + "名称!");
		document.userreslist.name.focus();	
		return false;	
	}
	
	//document.all.currentname.innerHTML = "当前查询的<B>"+typeName+"</B>为："+document.all.name.value;
	if(typeName=="用户"){
		typeName = "USER";
	}
	userreslist.action="../user/userres_querylist.jsp?opId="+document.all("operategroup").value+"&typeName="+typeName;
	userreslist.submit();
}

function del(){
	var type = document.all("type").value;
	delop.location.href = "../resmanager/delRedundance.jsp?type="+type;
 	var typeName ;
	if(type == "user"){
		typeName = "用户";
	}else if(type == "role"){
		typeName = "角色";
	}else if(type == "org"){
		typeName = "机构";
	}else if(type == "job"){
		typeName = "岗位";
	}else if(type == "orgjob"){
		typeName = "机构岗位";
	}
	alert("删除"+typeName+"冗余成功！"); 
}

function getOperateType(){
		getopergroup.location.href = "../user/resChange.jsp?restypeId="+document.all.restypeId.value;
}

function change(){
	document.all.typename.innerText = document.all.type.options[document.all.type.selectedIndex].text+"名称*：";
	document.all.name.value = "";
	document.all.name.title = "单击或按F1选择"+document.all.type.options[document.all.type.selectedIndex].text;
	if(document.all.type.value == "orgjob")
	{
		document.all.name.readonly = true;
	}
	else
	{
		document.all.name.readonly = false;
	}
}

function chooseorgjob()
{
	if(document.all.type.value == "orgjob")
	{
		var orgjob = document.all.orgjob.value;
		orgjob = orgjob.split(":");
		var returnValue = window.showModalDialog('../resmanager/orgJobTree.jsp?defaultValue='+orgjob,'newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
		if(returnValue){
			document.all.name.value = returnValue.substring(0,returnValue.indexOf(","));
			document.all.orgjob.value = returnValue.substring(returnValue.indexOf(",")+1,returnValue.length);
		}
	}
	if(document.all.type.value == "user")
	{
		var returnValue = window.showModalDialog('../resmanager/orgUserTree.jsp',window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
		if(returnValue){
			document.all.name.value = returnValue;
		}
	}
	if(document.all.type.value == "role")
	{
		var returnValue = window.showModalDialog('../resmanager/roleTree.jsp','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
		
		if(returnValue){
			document.all.name.value = returnValue;
		}
	}
	if(document.all.type.value == "org")
	{
		var orgNames = document.all.name.value; 
		var returnValue = window.showModalDialog('../resmanager/orgSelectTree.jsp?orgNames='+orgNames,'newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
		if(returnValue){
			document.all.name.value = returnValue.split("^")[0];
		}
	}
	
}

//F1
function window.onhelp(){  
  chooseorgjob();
  return false;
}
</SCRIPT>
<link href="../css/windows.css" rel="stylesheet" type="text/css">
<style>

body{
    SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
	SCROLLBAR-SHADOW-COLOR: #ffffff;
	SCROLLBAR-3DLIGHT-COLOR: #ffffff;
	SCROLLBAR-ARROW-COLOR: #ffffff;
	SCROLLBAR-TRACK-COLOR: #ffffff;
	SCROLLBAR-DARKSHADOW-COLOR: #ffffff;
	SCROLLBAR-FACE-COLOR: #ffffff;	
}
</style>
</head>
<% if("is".equals(isUserRes)){ %>
	<%@ include file="/epp/css/cssControl.jsp"%><body  scrolling="no" onLoad="isUserRes()">
<% }else{ %>
	<%@ include file="/epp/css/cssControl.jsp"%><body  scrolling="no" onLoad="change()">
<% } %>
<div id="contentborder" valign="top" align="center" >
	<form name = "userreslist" method="post" target="forDocList">
		<table width="100%" border="0"   cellpadding="0" cellspacing="0" class="thin">
		<% if("no".equals(isUserRes)){ %>
			<tr>
				<td height='20' colspan="1" nowrap align=right width="20%">
					请选择要查询的对象：
				</td>
				<td height='20' colspan="1" nowrap width="20%">
						<select class="select" name="type" id="type" onChange="change()">
							<option value="user">用户</option>
							<option value="role">角色</option>
							<!-- <option value="job">岗位</option> -->
							<%
							if(ConfigManager.getInstance().getConfigBooleanValue("enableorgrole", true))
							{
							%>
							<option value="org">机构</option>
							<%
							}
							%>
							<%
							if(ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", true))
							{
							%>
							<option value="orgjob">机构岗位</option>
							<%
							}
							%>
						</select>
				</td>
				<td height='20' colspan="2" nowrap align=center width="40%">
					<table border="0" height="100%" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td height="20" width="50%" align=right ><div name="typename" id="typename" style="width:100"></div></td>
							<td height="20" width="100%" >
								<input type="text" name="name" width="100%" id="name" readonly="true" onclick="chooseorgjob()" title="单击或按F1选择用户" >
								<input name="orgjob" type="hidden" value="" >
							</td>
						</tr>
					</table>				
			    </td>
				<!-- <td align=center width="20%">
					<div id="currentname" name="currentname"></div>
				</td> -->
				<td align=center width="20%">
				<% 
					if(ConfigManager.getInstance().getConfigBooleanValue("enablerresmanaer", false))
					{
				%>
				资源类别：<select class="select" name="auto" id="auto">
				      	<option value="">--资源类别--</option>
						<option value="0">系统资源</option>
						<option value="1">自定义资源</option>
					</select>
				<%} %>
				</td>
			</tr>
		<% } %>
			<tr>
				<td height='20' align=right width="20%">
					资源标识：
				</td>
				<td height='20' width="20%">
					<input type="text" name="resId"  />
				</td>
				<td height='20' align=right width="20%">
					资源名称：
				</td>
				<td height='20' width="20%">
					<input type="text" name="resName"/>
				</td>
				<td height='20' colspan="2" align=center width="20%" >
					<!-- <input type="button" value="删除冗余" class="input" onClick="del()"/> -->
				</td>
			</tr>
			<tr>
					<td align=right width="20%">
					资源类型：
					</td>
					<td width="20%">
				    <select class="select" id="restypeId" name="restypeId" onChange="getOperateType()">
				      	<option value="">--请选择--</option>
				      	<pg:list requestKey="resList" needClear="false">
				      		
						    	<option value="<pg:cell colName="id"/>">
						        	<pg:cell colName="name"/>
								</option>
							
						</pg:list>
					</select>
					</td>
					<td height='20' align=right width="20%">
					操作类型：
					</td>
					<td width="20%">
					<select class="select" name="operategroup" id="operategroup">
				      	<option value="">--请选择--</option>
						
					</select>
				</td>
				<td colspan="2" align=center width="20%">
				<% if("is".equals(isUserRes)){ %>
					<input name="search" type="button" class="input" value="查询" onClick="isUserRes()">
				<% }else{ %>
					<input name="search" type="button" class="input" value="查询" onClick="sub()">
				<% } %>
					<input name="reset" type="reset" class="input" value="重设">
				</td>
		  </tr>
		</table>
	</form>
</div>
<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
<iframe id="delop" src="" border="0" height="0" width="0"></iframe>
</body>

</html>