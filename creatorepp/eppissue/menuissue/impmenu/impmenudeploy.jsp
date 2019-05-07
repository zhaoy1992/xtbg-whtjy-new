<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.config.ConfigManager"%>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%!String loadFilePath = "";%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	//String isBackup = request.getParameter("isBackup") != null ? request
	//		.getParameter("isBackup")
	//		: "";

	String app_id = control.getCurrentSystemID();

	String isLoadFile = request.getParameter("isLoadFile") != null
			? request.getParameter("isLoadFile")
			: "";
	if (isLoadFile.equals("true")) {
		loadFilePath = request.getParameter("loadFilePath") != null
				? request.getParameter("loadFilePath")
				: "";
	}

	// 得到平台类型
	String egptype = ConfigManager.getInstance().getConfigValue(
			"egptype");
%>
<html>
	<head>
		<title>属性容器</title>

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>
		<!-- dwr begin-->
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/sysmanager/applymanager/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/menuissueChange.js'></script>
		<!-- dwr end -->

		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript"
			src="../pageGrey.js">
		</script>
		<script type="text/javascript">
		var sh;
		var isDel = "true";
		function impmenuShowContent(){
			//提交后页面变灰
			popSignFlow("impmenuload.jsp");				
			sh = setInterval("showLog()",1000);
			menuissueChange.impmenuShowContent("<%=loadFilePath%>",result);
		}
		
		function result(obj){			
			DWREngine.setPreHook(function() {});				
			DWREngine.setPostHook(function() {});
			setTimeout("clearInterval(sh)",1500);
			if(obj[0]=="false"){
				document.getElementById("showLogSub").style.display="block";
			}else{				
				document.getElementById("showLogRes").style.display="block";
				
				document.getElementById("type").innerHTML = obj[1];
				document.getElementById("time").innerHTML = obj[2];
				document.getElementById("workclass").innerHTML = obj[3];
				document.getElementById("eform").innerHTML = obj[4];
				document.getElementById("eform_warn").innerHTML = obj[5];				
				document.getElementById("jawe").innerHTML = obj[6];
				document.getElementById("jawe_warn").innerHTML = obj[7];	
				document.getElementById("report").innerHTML = obj[8];
				document.getElementById("report_warn").innerHTML = obj[9];
				document.getElementById("filename").innerHTML = obj[10];
				document.getElementById("filename_warn").innerHTML = obj[11];
				document.getElementById("remark").innerHTML = obj[12];
			}
		}
		
		//去除字符串空格
		function trim(string){
			var temp="";
			string = ''+string;
			splitstring = string.split(" ");
			for(i=0;i<splitstring.length;i++){
				temp += splitstring[i];
			} 
			return temp;
		}
		
		function delFile(){
			//提交后页面变灰
			popSignFlow(1);	
			menuissueChange.menudateDelFile("<%=loadFilePath%>",jump);			
		}		
		
		function jump(){
			document.location='impmenuload.jsp';
		}
		
		function showLog(){
			document.getElementById("showLogDiv").style.display="block";
			menuissueChange.showLog(showLogResult);
		}
		
		function showLogResult(obj){
			document.getElementById("showLogDiv").innerHTML  = obj ;
			document.getElementById("showLogDiv").scrollTop=document.getElementById("showLogDiv").scrollHeight;			
		}
		
		//按下关闭按钮时删除临时文件
		function window.onbeforeunload()
		{
		    if(event.clientX>360&&event.clientY<0||event.altKey)
		    {
		       if(isDel=="true"){
		       	menuissueChange.menudateDelFile("<%=loadFilePath%>");
				}
		    }
		}	
		
		
		function menudateDeploy(){
			var isLob = "false";
			if("devegp"=="<%=egptype%>" || "testegp"=="<%=egptype%>"){
				isLob = document.getElementById("isLob").checked?"true":"false";
			}
			
			//提交后页面变灰
			popSignFlow("impmenuinfo.jsp");				
			sh = setInterval("showLog()",1000);			
			menuissueChange.menudateDeploy("<%=app_id%>",isLob,"<%=loadFilePath%>",deployResult);
		}
		
		function deployResult(obj){
			DWREngine.setPreHook(function() {});				
			DWREngine.setPostHook(function() {});
			
			setTimeout("clearInterval(sh)",1500);		
				if(obj=="true"){
					isDel = "false";
					document.getElementById("showLogSub").style.display="block";									
				}else{
					document.getElementById("showLogRes").style.display="block";			
				}			
			}
						
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="auto"
		onload="impmenuShowContent();">
		<div id="contentborder" align="center">
			<table width="100%">
				<tr>
					<td align="center" colspan=2>
						<br />
						<br />
						<fieldset style="width: 90%;">
							<LEGEND align=center>
								<FONT size="2">更新包内容</FONT>
							</LEGEND>
							<br />
							<table align="left" width="100%" border="0" cellpadding="1"
								cellspacing="1" class="thin">
								<tr>
									<td width="20%" height="25">
										操作类型:
									</td>
									<td id="type" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										导出时间:
									</td>
									<td id="time" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										业务类别:
									</td>
									<td id="workclass" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										表单:
									</td>
									<td id="eform" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										表单警告:
									</td>
									<td id="eform_warn" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										流程:
									</td>
									<td id="jawe" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										流程警告:
									</td>
									<td id="jawe_warn" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										报表:
									</td>
									<td id="report" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										报表警告:
									</td>
									<td id="report_warn" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										其他文件:
									</td>
									<td id="filename" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										其他文件警告:
									</td>
									<td id="filename_warn" width="400"
										style="word-wrap: break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										备注:
									</td>
									<td id="remark" width="400" style="word-wrap: break-word;">
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
			<div align="center">
				<table width="100%" border="0" align="right" cellpadding="0"
					cellspacing="0">
					<%
						if ("devegp".equals(egptype) || "testegp".equals(egptype)) {
					%>
					<tr>
						<td align="center" colspan="3">
							<input type="checkbox" name="isLob" id="isLob" value="true">
							导入可编辑
						</td>
					</tr>
					<%
						}
					%>
					<tr>
						<td align="right">
							<input type="button" value="上一步" class="input"
								onclick="delFile();">
							<input type="button" value="导  入" class="input"
								onclick="menudateDeploy();">
						</td>
						<td>
							&nbsp;
						</td>
						<td>
							&nbsp;
						</td>
					</tr>
				</table>
			</div>
		</div>

	</body>
</html>
