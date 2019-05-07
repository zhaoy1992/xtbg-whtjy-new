<%@ page language="java" pageEncoding="GBK"%>
<%@page import="java.io.*,com.chinacreator.config.ConfigManager" %>
<%
		String allplugRemark = "";
		String jreRemark = "";
		String iWebOfficeRemark = "";
		String rtxRemark = "";
		String eformRemark = "";
		try {
			File file = new File(ConfigManager.getInstance().getConfigValue("approot")+"/pluginsRemark.txt");
			FileInputStream fis = new FileInputStream(file);
			InputStreamReader isr = new InputStreamReader(fis);
			BufferedReader br = new BufferedReader(isr);
			String temp = "";
			while ((temp = br.readLine()) != null) {
				if(temp.startsWith("全部插件安装包")){
					allplugRemark = temp.substring("全部插件安装包".length()+1,temp.length()).trim();
				}else if(temp.startsWith("jre1.5.0.06安装包")){
					jreRemark = temp.substring("jre1.5.0.06安装包".length()+1,temp.length()).trim();
				}else if(temp.startsWith("iWebOffice安装包")){
					iWebOfficeRemark = temp.substring("iWebOffice安装包".length()+1,temp.length()).trim();
				}else if(temp.startsWith("RTX客户端安装包")){
					rtxRemark = temp.substring("RTX客户端安装包".length()+1,temp.length()).trim();
				}else if(temp.startsWith("客户端运行加速组件安装包")){
					eformRemark = temp.substring("客户端运行加速组件安装包".length()+1,temp.length()).trim();
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
 %>
<html>
	<head>
		<link href="<%=request.getContextPath()%>/sysmanager/css/windows.css"
			rel="stylesheet" type="text/css">

		<title>插件安装</title>
		<!--<object id="plugins"
			classid="clsid:8B23EA28-723C-402F-92C4-59BE0E063499"
			codebase="<%=request.getContextPath()%>/epp/eppTemplate/plugins/allplugins.cab#version=1,0,0,1">
		</object>
		
		
		--><!-- 提交后页面变灰 -->
		<!-- 
		<script language="javascript" type="text/javascript" src="cachloader/pre_load.js"></script>
		-->
		<script language="javascript" type="text/javascript"
			 src="<%=request.getContextPath()%>/epp/eppTemplate/pageGrey.js"></script>
		
		<script language="javascript" type="text/javascript">
		//	function load(){
		//		//提交后页面变灰
		//	    popSignFlow(1);
		//	    
		//	    //页面变灰恢复正常				
		//		window.setTimeout("cancelSign()",3000);
		//	}
		</script>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<br />
			<br />
			<fieldset style="width: 90%;">
				<LEGEND align=center>
					<FONT size="2">插件下载</FONT>
				</LEGEND>
				<br />
				<br />
				<p align="center">
					如果控件无法运行，请手动下载安装
				</p>
				<table width="85%" height="35" border="0" cellpadding="0"
					cellspacing="1" class="thin">
					<tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/allplugins.exe"
								target="download" title="<%=allplugRemark %>">下载全部插件安装包</a>
						</td>
					</tr>
					<tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/jre1506.exe"
								target="download" title="<%=jreRemark %>">下载jre1.5.0.06安装包</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span id="java_message" />
						</td>
					</tr>
					<%--<tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/gaeditor.exe"
								target="download">下载gaeditor安装包</a>
						</td>
					</tr>
					--%><tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/iWebOffice.exe"
								target="download" title="<%=iWebOfficeRemark %>">下载iWebOffice安装包</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span id="iWebOffice_message" />
						</td>
					</tr>
					<tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/RTX.exe"
								target="download" title="<%=rtxRemark %>">下载RTX客户端安装包</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span id="RTX_message" />
						</td>
					</tr>
					<tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/eppControlInstall.exe"
								target="download" title="<%=eformRemark %>">下载客户端运行加速组件安装包</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span id="eform_message"/> 
						</td>
					</tr>
					<tr class="tr" style="display:none">
						<td height="35" class="detailtitle" align="center">
							<a
								href="javascript:clearAllCachData(); alert('执行刷新操作完毕！！');"
								target="download"  title="清空本地缓存的加速数据">刷新本地缓存的运行加速数据</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</table>
				<br />
				<table width="85%" height="35" border="0" cellpadding="0"
					cellspacing="1">
				<tr><td>说明：</td></tr>
				<tr><td>1. 本控件只能在Internet Explorer浏览器5.0以上版本、Windows 98/XP/2000操作系统下运行；</td></tr>
				<tr><td>2. 要求浏览器的安全设置为中级或中级以下。</td></tr>
				<tr><td>3. 如果您的电脑安装了防火墙或者类似的软件，请暂时关闭这些软件，以免影响插件安装，甚至使插件安装无法进行。</td></tr>
				</table>
				<br />
			</fieldset>
			<input type="button" class="input" value="关闭窗口" onclick="window.close();">
		</div>
	</body>
	<iframe name="download" style="display: none;"></iframe>
	<script type="text/javascript">
		try{
		    var isJava = new ActiveXObject("JavaWebStart.isInstalled.1.5.0.0");	
	    	document.getElementById("java_message").innerHTML = "已安装";
		}
		catch(e){
			document.getElementById("java_message").innerHTML = "未安装";
			document.getElementById("java_message").style.color="red";		    
		}
		
		try{
		    var isIWebOffice = new ActiveXObject("iWebOffice2006.HandWriteCtrl");	
	    	document.getElementById("iWebOffice_message").innerHTML = "已安装";
		}
		catch(e){
			document.getElementById("iWebOffice_message").innerHTML = "未安装";
	    	document.getElementById("iWebOffice_message").style.color="red";		    
		}
		
		try{
		    var isRTX = new ActiveXObject("RTXClient.RTXAPI");	
	    	document.getElementById("RTX_message").innerHTML = "已安装";
		}
		catch(e){
			document.getElementById("RTX_message").innerHTML = "未安装";
	    	document.getElementById("RTX_message").style.color="red";		    
		}
		
		try{
		    var isJwCltActivex = new ActiveXObject("JWCLTACTIVEX.JwCltActivexCtrl.1");	
	    	document.getElementById("eform_message").innerHTML = "已安装";
		}
		catch(e){
			document.getElementById("eform_message").innerHTML = "未安装";
	    	document.getElementById("eform_message").style.color="red";		    
		}
		
		/***
		if(typeof(jwVerCtlObject) != "undefined")
		{
			var bSucceed = __pre_loadjsFrame();		
			if(bSucceed)
			{
				initSave2local();
				initSaveForEpp();	
					
				if(typeof("eppDataWrObj") != "undefined")
				{			
					document.getElementById("eform_message").innerHTML = eppDataWrObj.isCanUse() ? "已安装" : "未安装";
					document.getElementById("eform_message").style.color = eppDataWrObj.isCanUse() ? "" : "#ff0000";
				}
			}
		}
		***/
		
		function clearAllCachData()
		{
			alert("暂不支持缓存清除操作！！！");
			//if(typeof(userDataWrObj) != "undefined") userDataWrObj.clearAllSource();
			//if(typeof(flashWrObj) != "undefined") flashWrObj.clearAllSource();
			//if(typeof(eppDataWrObj) != "undefined") eppDataWrObj.clearAllSource();				
		}
		
	</script>
</html>
