<%@ page language="java" contentType="text/html; charset=GBK"
	import="com.chinacreator.security.AccessControl,com.chinacreator.workflow.shark.ProcessInstanceMonitor"%>

		<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);

			String procId = request.getParameter("procInsId");
			String monitor_only_show_started = request.getParameter("flag");
			monitor_only_show_started = monitor_only_show_started == null ? "" : monitor_only_show_started;

			ProcessInstanceMonitor processInstanceMonitor = new ProcessInstanceMonitor();

			String processDefintion = processInstanceMonitor
					.getWorkflowProcessDefine(procId,monitor_only_show_started);

			String processInstance = processInstanceMonitor
					.getProcessInstance(procId);
		%>
<html>
	<head>
		<title>流程实例监控</title>
		<script src="AC_OETags.js" language="javascript"></script>
		
		<script language="JavaScript" type="text/javascript">
		//<!--
		var requiredMajorVersion = 10;
		var requiredMinorVersion = 0;
		var requiredRevision = 32;
		
		var procDef = '<%=processDefintion%>';
		var procIns = '<%=processInstance%>';
		function initialData(){
			var processInstanceMonitor = document.getElementById("ProcessInstanceMonitor");
			if(processInstanceMonitor!=null){
				if(typeof processInstanceMonitor.initialData=="undefined"){
					setTimeout(initialData, 10);
				}else{
					processInstanceMonitor.initialData(procDef, procIns);
				}
			}
		}
		function window.onload(){
			initialData();
		}
		// -->
		</script>
	</head>

	<body scroll="no">
	<script language="JavaScript" type="text/javascript">
	<!--
	// Version check based upon the values defined in globals
	var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);
	if ( !hasRequestedVersion ) {
		// DO NOT MODIFY THE FOLLOWING FOUR LINES
		// Location visited after installation is complete if installation is required
		var MMPlayerType = (isIE == true) ? "ActiveX" : "PlugIn";
		var MMredirectURL = window.location;
	    document.title = document.title.slice(0, 47) + " - Flash Player Installation";
	    var MMdoctitle = document.title;
	
		AC_FL_RunSetup(
			"src", "ProcessInstanceMonitor",
			"width", "0",
			"height", "0",
			"id", "activex_plugin_object",
			"name", "activex_plugin_object",
			"allowScriptAccess","sameDomain",
			"type", "application/x-shockwave-flash",
			"pluginspage", "http://www.adobe.com/go/getflashplayer",
			"codebase", "swflash.cab"
		);
		window.location
		document.write("<p style=\"font-size:14px\">您的Flash播放器版本较低，为了正常浏览该页面，系统将自动为您下载FlashPlayer 10.0.32版本，请务必点击安装。</p>");
		document.writeln("<p>注意：安装完以后请点击刷新页面。<a href=\"javascript:window.location=window.location\">刷新页面</a></p>");
	} else {
	// if we've detected an acceptable version
	// embed the Flash Content SWF when all tests are passed
	AC_FL_RunContent(
			"src", "ProcessInstanceMonitor",
			"width", "100%",
			"height", "100%",
			"align", "middle",
			"id", "ProcessInstanceMonitor",
			"quality", "high",
			"bgcolor", "#869ca7",
			"name", "ProcessInstanceMonitor",
			"allowScriptAccess","sameDomain",
			"type", "application/x-shockwave-flash",
			"pluginspage", "http://www.adobe.com/go/getflashplayer"
	);
  }
	// -->
	</script>
	<noscript>
			<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
				id="ProcessInstanceMonitor" width="100%" height="100%"
				codebase="swflash.cab#version=10,0,32,18">
				<param name="movie" value="ProcessInstanceMonitor.swf" />
				<param name="quality" value="high" />
				<param name="bgcolor" value="#869ca7" />
				<param name="allowScriptAccess" value="sameDomain" />
			</object>
		</noscript>
	</body>
</html>