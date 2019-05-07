<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<html>
<head>
	<title>请输入服务名</title>
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/treeview.css">	
	<script src="xpdl.js"></script>
	<script>	  	
		//设置mgr_name,pid
		function setMgrName()
		{
			var mgrName = "<%=request.getParameter("mgr_name")%>";
			var pid = "<%=request.getParameter("pid")%>";
			var reg=/~/g;
			//mgrName=mgrName.replace(reg,"#");
			document.all.mgr_name.value=mgrName;
			document.all.pid.value=pid;
		}
		
		function submit_form()
		{
			var soa_name=document.all.soa_name.value;
			var mgr_name=document.all.mgr_name.value;
			var pid = document.all.pid.value;
			var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=publishSoa&mgr_name="+mgr_name+"&soa_name="+soa_name+"&pid="+pid);
			alert(retX);
			if(retX=="服务发布成功！")
			{
				window.returnValue = soa_name;
				window.close();
			}
		}
	</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" onload="setMgrName()" scroll="no">
		<div>
			<form method="post" name="formClassForm" action="publish_soa.jsp?isPost=true">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">服务名称*：</td>
						<td height="25">
							<input type="text" name="soa_name" maxlength="100" value=""/>
							<input type="hidden" name="mgr_name"/>
							<input type="hidden" name="pid"/>
						</td>
					</tr>					
				</table>
				
            	<hr width="100%">	
            			
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">								
								<input name="button" type="button" class="input" value="确定" onclick="submit_form();">
						    </div>
						</td>
					</tr>
				  </table>
				  
			</form>
		</div>
	</body>
	
</html>