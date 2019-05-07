<%@ page contentType="text/html; charset=GBK" language="java"%>
<jsp:directive.page import="com.chinacreator.epp.processmanage.dbmanager.ProcessManage"/>
<jsp:directive.page import="com.chinacreator.epp.processmanage.vo.Process"/>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
 %>
<%
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires",0);
%>
<% 
String pId = request.getParameter("pId");
if(pId==null)pId = "";
ProcessManage pm = new ProcessManage();
Process process = pm.getProcessByPid(pId);
String pName = process.getPName();
String processName = "";
processName = (pName.split("#"))[0];
%>
<html>
<head>
	<title>请输入流程名</title>
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/treeview.css">	
	<script src="xpdl.js"></script>
	<script>	
		function info_submit(){
			var iad = document.getElementById("isSaveActData").checked;
			if(iad){
				document.getElementById("isSaveActDataValue").value = "1";
			}else{
				document.getElementById("isSaveActDataValue").value = "0";
			}
			formClassForm.submit();
		}
		window.returnValue = "true";
	</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" onload="" scroll="no">
		<div>
			<form method="post" name="formClassForm" action="xpdl_edit_save.jsp" target="saveIfr">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">流程名称*：</td>
						<td height="25">
							<input type="text" name="xpdl_name" maxlength="100" readonly value="<%=processName %>"/>
						</td>
					</tr>
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">流程描述：</td>
						<td height="25">
							<textarea rows="3" cols="40" name="remark"><%=process.getRemark() %></textarea>
						</td>
					</tr>
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">是否保存流程活动数据：</td>
						<td height="25">
							<input type="checkbox" name="isSaveActData" <%if(process.getIsSaveActData().equals("1")){%> checked<%} %>/>保存
						</td>
					</tr>					
				</table>
				
            	<hr width="100%">	
            			
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">
								<input type="hidden" name="pId" value="<%=pId %>">	
								<input type="hidden" name="isSaveActDataValue">				
								<input name="save" type="button" class="input" value="保存" onClick="info_submit();">
								<input name="close" type="button" class="input" value="关闭" onClick="parent.close();">
						    </div>
						</td>
					</tr>
				  </table>
				  
			</form>
		</div>
	</body>
	<iframe id="saveIfr" name="saveIfr" width="0" height="0"></iframe>
</html>