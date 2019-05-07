<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
/**
 * 
 * <p>Title: 资源反查询，查询条件页面</p>
 *
 * <p>Description: 资源反查询，查询条件页面</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-11-4
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.config.model.ResourceInfo"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>

<%
	AccessControl control = AccessControl.getInstance();
	if(!control.checkManagerAccess(request, response)){
		return;
	} 
	
	ResourceManager resManager = new ResourceManager();
	List resQueue = resManager.getResourceInfos();
	List resList = new ArrayList();
	String name = "";
	for(int i = 0; i < resQueue.size(); i ++){
		ResourceInfo res = (ResourceInfo)resQueue.get(i);
		name = res.getId(); 
		if(name.equals("report_column")
			|| name.equals("cs_column")
			|| name.equals("column")){
			resList.add(res);
		}
	}
	//设置资源类型列表
	request.setAttribute("resList",resQueue);
%>

<html>
<head>
	<title>资源操授予查询</title>
	<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	
	<script type="text/javascript" language="Javascript">
		//根据资源类型的改变，来改变操作类型下拉选择项。注：不同的资源类型有不同的资源操作项，由配置文件config-manager.xml配置而成
		function getOperateType(){
			var restypeIdValue = document.all.restypeId.value;
			var restypeIdValues = restypeIdValue.split("$$");
			var restypeId = restypeIdValues[0]; 
			var auto = restypeIdValues[1];
			var maintaindata = restypeIdValues[2];
			 
			if(restypeId == "column" || restypeId == "report_column" || restypeId == "cs_column"){
				document.all.objsel.innerText = "选择菜单：";
			}else if(restypeId == "orgunit"){
				document.all.objsel.innerText = "选择机构：";
			}else if(restypeId == "role"){
				document.all.objsel.innerText = "选择角色：";
			}else if(restypeId == "job"){
				document.all.objsel.innerText = "选择岗位：";
			}else if(restypeId == "group"){
				document.all.objsel.innerText = "选择用户组：";
			}else if(restypeId == "dict"){
				document.all.objsel.innerText = "选择字典：";
			}else if(restypeId == "app_column"){
				document.all.objsel.innerText = "选择站点应用：";
			}else if(maintaindata == "true" && auto == "false"){
				document.all.objsel.innerText = "自定义资源：";
			}else if(restypeId.substring(0,7) == "channel"){
				document.all.objsel.innerText = "选择频道：";
			}else if(restypeId.substring(0,4) == "site"){
				document.all.objsel.innerText = "选择站点：";
			}else{
				document.all.objsel.innerText = "请输入res_id：";
			}
			getopergroup.location.href = "resChange.jsp?restypeId="+restypeId;
			document.all.resId.value = "";
			document.all.resName.value = "";
		}
		//选择不同的授予对象
		function objChange(){
			var typeval = document.all.type.value;
			document.all.selname.value = "";
			document.all.selid.value = "";
			if(typeval == "user" || typeval == "org" || typeval == "orgjob"){
				document.all.objName.innerText = "选择机构：";
				document.all.divProcessing.style.display = "block";
			}
			if(typeval == "role"){
				document.all.objName.innerText = "选择角色类别：";
				document.all.divProcessing.style.display = "none";
			}
		}
		//选择菜单
		function selectMenu(){
			var restypeIdValue = document.all.restypeId.value;
			var restypeIdValues = restypeIdValue.split("$$");
			var restypeId = restypeIdValues[0];
			
			//channel
			var auto = restypeIdValues[1];
			var maintaindata = restypeIdValues[2];
			if(restypeId==""){
				alert("请先选择资源类型！");
				return;
			}
			var returnvalue = "";
			if(restypeId == "column" || restypeId == "report_column" || restypeId == "cs_column"){
				returnvalue = window.showModalDialog('select_menu.jsp?restypeId='+restypeId,window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}else if(restypeId == "orgunit"){
				returnvalue = window.showModalDialog('select_org.jsp?restypeId='+restypeId,window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}else if(restypeId == "role"){
				returnvalue = window.showModalDialog('select_roletype.jsp',window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}else if(restypeId == "job"){
				returnvalue = window.showModalDialog('select_job.jsp',window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}else if(restypeId == "dict"){
				returnvalue = window.showModalDialog('select_dict.jsp',window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}else if(restypeId == "group"){
				returnvalue = window.showModalDialog('select_group.jsp',window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}else if(restypeId == "app_column"){
				returnvalue = window.showModalDialog('select_siteApp.jsp?restypeId='+restypeId,window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
				//window.open('select_siteApp.jsp?restypeId='+restypeId);
			}else if(maintaindata == "true" && auto == "false"){
				returnvalue = window.showModalDialog('select_list_res.jsp?restypeId='+restypeId,window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}else if(restypeId.substring(0,7) == "channel"){
				returnvalue = window.showModalDialog('select_channel.jsp?restypeId='+restypeId,window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}else if(restypeId.substring(0,4) == "site"){
				returnvalue = window.showModalDialog('select_site.jsp?restypeId='+restypeId,window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}else{
				returnvalue = window.showModalDialog('input_res.jsp?restypeId='+restypeId,window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=300,height=200,top=150,left=250');
			}
			if(returnvalue != "" && returnvalue != undefined){
				var val = returnvalue.split(":"); 
				document.all.resId.value = val[0];
				document.all.resName.value = val[1]; 
				if(val.length == 3){
					getopergroup.location.href = "resChange.jsp?restypeId="+restypeId+"&global="+val[2];
				}else{
					getopergroup.location.href = "resChange.jsp?restypeId="+restypeId+"&global=op";
				}
			} 
		}
		//资源查询
		function queryRes(){
			var resName = document.all.resName.value;
			var selname = document.all.selname.value;
			var typeval = document.all.type.value;
			var restypeIdValue = document.all.restypeId.value;
			var restypeIdValues = restypeIdValue.split("$$");
			var restypeId = restypeIdValues[0]; 
			var auto = restypeIdValues[1];
			var maintaindata = restypeIdValues[2];
			if(resName == ""){
				if(restypeId == "column" || restypeId == "report_column" || restypeId == "cs_column"){
					alert("请选择菜单！");
				}else if(restypeId == "orgunit"){
					alert("请选择机构！");
				}else if(restypeId == "role"){
					alert("请选择角色！");
				}else if(restypeId == "job"){
					alert("请选择岗位！");
				}else if(restypeId == "dict"){
					alert("请选择字典！");
				}
				document.all.selname.focus();
				return;
			}
			if(selname == ""){
				if(typeval == "user" || typeval == "org" || typeval == "orgjob"){
					alert("请选择机构！");
					document.all.selname.focus();
					return;
				}
			}
			var isRecursionobj = document.all.isRecursion;
			var isRecursion = 0;
			if(isRecursionobj){
				if(isRecursionobj.checked){
					isRecursion = 1;
				}
			}
			queryCondition.target="forDocList";
			queryCondition.action="res_querylist.jsp?isRecursion="+isRecursion;
			queryCondition.submit();
		}
		
		function chooseorg_role(){
			var typeval = document.all.type.value;
			var selid = document.all.selid.value;
			var returnvalue = "";
			if(typeval == "user" || typeval == "org" || typeval == "orgjob"){
				returnvalue = window.showModalDialog('select_org.jsp',window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}
			if(typeval == "role"){
				returnvalue = window.showModalDialog('select_role.jsp?role_id='+selid,window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
			}
			if(returnvalue != "" && returnvalue != undefined){
				var val = returnvalue.split(":"); 
				document.all.selid.value = val[0];
				document.all.selname.value = val[1];
			}
			
		}
		
		
	</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >

<form action="" method="post" name="queryCondition">
	<table width="100%" border="0"   cellpadding="0" cellspacing="0" class="thin">
		<tr>
			<td align="right" width="15%">资源类型：</td>
			<td width="15%">
			    <select class="select" id="restypeId" name="restypeId" onChange="getOperateType()">
			      	<option value="">--请选择--</option>
			      	<pg:list requestKey="resList" needClear="false">
					    <option value="<pg:cell colName="id"/>$$<pg:cell colName="auto"/>$$<pg:cell colName="maintaindata"/>">
					        <pg:cell colName="name"/>
						</option>
					</pg:list>
				</select>
			</td>
			
			<td id="objsel" align="right" width="10%">选择：</td>
			<td width="20%">
				<input name="resName" width="100%" type="text" readonly="true" onclick="selectMenu()"/>
				<input name="resId" type="hidden" value=""/>
			</td>
			
			<td align=right width="15%">操作类型：</td>
			<td width="15%">
				<select class="select" name="operategroup" id="operategroup">
					<option value="">--请选择--</option>
				</select>
			</td>
		</tr>
		
		<tr>
			<td align="right" width="15%">授予对象</td>
			<td width="15%">
				<select class="select" name="type" onchange="objChange()">
					<option value="user">用户</option>
					<option value="role">角色</option>
					<%
					if(ConfigManager.getInstance().getConfigBooleanValue("enableorgrole", false)){
					%>
						<option value="org">机构</option>
					<%
					}
					%>
					<%
					if(ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", true)){
					%>
						<option value="orgjob">机构岗位</option>
					<%
					}
					%>
				</select>
			</td>
			
			<td id="objName" align="right" width="10%">选择机构：</td>
			<td id="objInput" width="20%">
				<input name="selname" value="" type="text" onclick="chooseorg_role()" width="100%" readonly="true"/>
				<input name="selid" value="" type="hidden"/>
				
			</td>
			<td align="left">
			<div  id="divProcessing" style="display:block">
				<input name="isRecursion" type="checkbox"/>是否递归
				</div>
				</td>
			
			<td colspan="1" align="right">
			<input name="querysub" value="查询" onclick="queryRes()"  type="button" class="input"/>
			<input name="reset" type="reset" class="input" value="重设">
			</td>
		</tr>
	</table>
</form>
<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
</body>
</html>