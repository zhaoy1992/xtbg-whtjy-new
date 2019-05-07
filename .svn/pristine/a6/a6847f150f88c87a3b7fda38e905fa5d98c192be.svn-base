<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,org.apache.commons.lang.StringUtils"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//String app_id = session.getAttribute("subsystem_id_nouse").toString();	
	String showmode = StringUtils.defaultString(request.getParameter("showmode"));
%>
<script type="text/javascript">
		function uf_ok(){
			var groups = groupTreeRadioFrame.document.getElementsByName("groupid");
			var groupIds = "";
			var groupNames = "";		
			for(var i=0;i<groups.length;i++){
				if(groups[i].checked){			
					var arr = new Array();
					arr = groups[i].value.split(",");
					groupIds = groupIds + arr[0] + ",";
					groupNames = groupNames  + arr[1] + ",";	
				}
			}
			groupIds = groupIds.substring(0,groupIds.length-1);				
			groupNames = groupNames.substring(0,groupNames.length-1);		
			window.close();
			window.returnValue=groupIds+";"+groupNames;
        }
</script>
<html>
	<head>
		<title>用户组选择</title>
	</head>	
	<body class="contentbodymargin">
		<div align="center">
			<br />
			<iframe name="groupTreeRadioFrame" height=85% width="100%" src="groupTreeRadioFrameSrc.jsp?showmode=<%=showmode %>" frameborder="0"></iframe>
			<br />
			<br />
			<div align="center">
				<table width="25%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<div align="left">
					     		<input name="Submit" type="button" class="input" value="确定" onClick="uf_ok()">
							</div>
						</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td>
							<div align="left">
						  		<input name="cancel" type="button" class="input" value="取消" onClick="window.close()">
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>
