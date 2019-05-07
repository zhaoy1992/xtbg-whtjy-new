<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(pageContext);
	
	String root = request.getContextPath();
	
	
	String[] columnModuleValue = request.getParameterValues("columnModuleValue");
	if(columnModuleValue == null || columnModuleValue.length == 0){
		out.print("<div>应用模块发布，请选择菜单模块！</div>");
		return;		
	}
	int length = columnModuleValue.length;
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>MQ服务器信息列表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="../../purviewmanager/css/windows.css" rel="stylesheet"
			type="text/css">
		<script src="<%=path %>/include/validateForm.js"></script>
		<script language="javascript" type="text/javascript">
		
		
		function queryTest(){
			var area = document.all.areaType.value;
			window.open("<%=root%>/test/menu/testMain.jsp?areaType="+area);
		}
		
		function queryArea(i){
			document.form1.action="module_area_query.jsp?i="+i;
			document.form1.target="_blank";
			document.form1.submit();
		}
		
		function issueDo(){
			var s = document.all.portletIframeName.value;
			if(/[^\x00-\xff]/g.test(s)){
		    	//含有汉字
		    	alert(document.all.portletIframeName.cnname + ",不能填写中文字符！");
		    	document.all.portletIframeName.focus();
		    	return;
		    }
			if(validateForm(form1)){
				document.form1.action="templateIssue_configure_do.jsp";
				document.form1.target="hiddenFrame";
				document.form1.submit();
			}
		}
		

</script>
	    <style type="text/css">
<!--
.STYLE1 {color: #999999}
-->
        </style>
</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body>
		<form method="post" name="form1">
			<table width="100%" height="30" border="0" cellpadding="0"
					cellspacing="0" class="thin">
					<tr>
						<td align="center" valign="middle" colspan="2">
							应用菜单模块发布
						</td>
					</tr>
					<tr>
						<td width="120" align="right">portlet war包名称：</td>
						<td><input name="portletIframeName" type="text" value="" size="50"  validator="stringLegal" cnname="portlet war包名称"/><font color="red">*</font></td>
					</tr>
			</table>
			<div align="right">
				<tr>
				<td align="right"><input name="issueAppSub" type="button" value="发布成portlet iframe war包" class="input"
					onclick="issueDo()"/></td>
				</tr>
			</div>
          <input name="moduleCount" value="<%=length %>" type="hidden">
		  <% 
           	String subsystemid = null;
           	String[] columnModuleValues = null; 
           	for(int i = 0; i < length; i++){
           		columnModuleValues = columnModuleValue[i].split("\\^-\\^");
           		subsystemid = columnModuleValues[0].substring(0,columnModuleValues[0].indexOf("::")); 
          %>
          <fieldset>
            <legend ><font class="label">模块[<%=columnModuleValues[1] %>]配置</font></legend>
           
           <input name="moduleName<%=i %>" value="<%=columnModuleValues[1] %>" type="hidden">
          <table width="100%" height="30" border="0" cellpadding="0"
				cellspacing="0" class="thin">
            <tr>
            	<td>portlet唯一标识</td><td><input name="portalId<%=i %>" value="<%=i+1 %>" type="text" readonly/></td>
            	<td>portlet名称：</td><td><input name="portalName<%=i %>" value="<%=columnModuleValues[1] %>" type="text"/></td>
            	
            </tr>
            <tr>
            <td>是否多实例化：</td><td><select name="instanceable<%=i %>">
            	<option value="1" selected>多实例</option>
            	<option value="0">单实例</option>
            </select></td>
            <td>子系统id：</td><td><input name="subsystemid<%=i %>" value="<%=subsystemid %>" type="text"  readonly/>
            <select name="subsystemidstate<%=i %>">
            	<option value="1" selected>只读</option>
            	<option value="0">可修改</option>
            </select>
            </td>
            </tr>
            <tr>
            	<td >应用模块地址：</td><td colspan="3"><input size="80" name="appModuleSrc<%=i %>" value="<%=columnModuleValues[0] %>"  readonly type="text"/>
            		<select name="appModuleSrcstate<%=i %>">
		            	<option value="1" selected>只读</option>
		            	<option value="0">可修改</option>
		            </select>
            	</td>
			</tr>
			<tr>
            	<td>Httpcontext：</td><td colspan="3"><input size="80" name="httpcontext<%=i %>" value="<%=basePath %>" type="text"/>
            		<select name="httpcontextstate<%=i %>">
		            	<option value="1" selected>只读</option>
		            	<option value="0">可修改</option>
		            </select>
            	</td>
			</tr>		
			<tr>
				<td>发布区域：</td><td colspan="1">
				<select name="issueArea<%=i %>">
					<option value="main">main</option>
					<% 
						if(columnModuleValues.length==3){
							String[] areaType = columnModuleValues[2].split(":");
							for(int j = 0; j < areaType.length; j++){
					%>
						<option value="<%=areaType[j] %>"><%=areaType[j] %></option>
					<%	
							}
						} 
					%>
					<option value="perspectiveContent" selected>perspectiveContent</option>
					
				</select>
				</td>
				<td colspan="2"><input name="" type="button" class="input" value="查看所选区域效果" 
					onClick="queryArea(<%=i %>)"/>
				</td>
              
            </tr>
          </table>
          </fieldset>
           <br>
            <% 
            	}
            %>
          
	</form>
		<iframe name="hiddenFrame" height="0" width="0"></iframe>
	</body>
</html>
