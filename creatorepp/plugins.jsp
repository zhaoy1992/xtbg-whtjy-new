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
				if(temp.startsWith("ȫ�������װ��")){
					allplugRemark = temp.substring("ȫ�������װ��".length()+1,temp.length()).trim();
				}else if(temp.startsWith("jre1.5.0.06��װ��")){
					jreRemark = temp.substring("jre1.5.0.06��װ��".length()+1,temp.length()).trim();
				}else if(temp.startsWith("iWebOffice��װ��")){
					iWebOfficeRemark = temp.substring("iWebOffice��װ��".length()+1,temp.length()).trim();
				}else if(temp.startsWith("RTX�ͻ��˰�װ��")){
					rtxRemark = temp.substring("RTX�ͻ��˰�װ��".length()+1,temp.length()).trim();
				}else if(temp.startsWith("�ͻ������м��������װ��")){
					eformRemark = temp.substring("�ͻ������м��������װ��".length()+1,temp.length()).trim();
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

		<title>�����װ</title>
		<!--<object id="plugins"
			classid="clsid:8B23EA28-723C-402F-92C4-59BE0E063499"
			codebase="<%=request.getContextPath()%>/epp/eppTemplate/plugins/allplugins.cab#version=1,0,0,1">
		</object>
		
		
		--><!-- �ύ��ҳ���� -->
		<!-- 
		<script language="javascript" type="text/javascript" src="cachloader/pre_load.js"></script>
		-->
		<script language="javascript" type="text/javascript"
			 src="<%=request.getContextPath()%>/epp/eppTemplate/pageGrey.js"></script>
		
		<script language="javascript" type="text/javascript">
		//	function load(){
		//		//�ύ��ҳ����
		//	    popSignFlow(1);
		//	    
		//	    //ҳ���һָ�����				
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
					<FONT size="2">�������</FONT>
				</LEGEND>
				<br />
				<br />
				<p align="center">
					����ؼ��޷����У����ֶ����ذ�װ
				</p>
				<table width="85%" height="35" border="0" cellpadding="0"
					cellspacing="1" class="thin">
					<tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/allplugins.exe"
								target="download" title="<%=allplugRemark %>">����ȫ�������װ��</a>
						</td>
					</tr>
					<tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/jre1506.exe"
								target="download" title="<%=jreRemark %>">����jre1.5.0.06��װ��</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span id="java_message" />
						</td>
					</tr>
					<%--<tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/gaeditor.exe"
								target="download">����gaeditor��װ��</a>
						</td>
					</tr>
					--%><tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/iWebOffice.exe"
								target="download" title="<%=iWebOfficeRemark %>">����iWebOffice��װ��</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span id="iWebOffice_message" />
						</td>
					</tr>
					<tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/RTX.exe"
								target="download" title="<%=rtxRemark %>">����RTX�ͻ��˰�װ��</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span id="RTX_message" />
						</td>
					</tr>
					<tr class="tr">
						<td height="35" class="detailtitle" align="center">
							<a
								href="<%=request.getContextPath()%>/epp/eppTemplate/plugins/eppControlInstall.exe"
								target="download" title="<%=eformRemark %>">���ؿͻ������м��������װ��</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span id="eform_message"/> 
						</td>
					</tr>
					<tr class="tr" style="display:none">
						<td height="35" class="detailtitle" align="center">
							<a
								href="javascript:clearAllCachData(); alert('ִ��ˢ�²�����ϣ���');"
								target="download"  title="��ձ��ػ���ļ�������">ˢ�±��ػ�������м�������</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</table>
				<br />
				<table width="85%" height="35" border="0" cellpadding="0"
					cellspacing="1">
				<tr><td>˵����</td></tr>
				<tr><td>1. ���ؼ�ֻ����Internet Explorer�����5.0���ϰ汾��Windows 98/XP/2000����ϵͳ�����У�</td></tr>
				<tr><td>2. Ҫ��������İ�ȫ����Ϊ�м����м����¡�</td></tr>
				<tr><td>3. ������ĵ��԰�װ�˷���ǽ�������Ƶ����������ʱ�ر���Щ���������Ӱ������װ������ʹ�����װ�޷����С�</td></tr>
				</table>
				<br />
			</fieldset>
			<input type="button" class="input" value="�رմ���" onclick="window.close();">
		</div>
	</body>
	<iframe name="download" style="display: none;"></iframe>
	<script type="text/javascript">
		try{
		    var isJava = new ActiveXObject("JavaWebStart.isInstalled.1.5.0.0");	
	    	document.getElementById("java_message").innerHTML = "�Ѱ�װ";
		}
		catch(e){
			document.getElementById("java_message").innerHTML = "δ��װ";
			document.getElementById("java_message").style.color="red";		    
		}
		
		try{
		    var isIWebOffice = new ActiveXObject("iWebOffice2006.HandWriteCtrl");	
	    	document.getElementById("iWebOffice_message").innerHTML = "�Ѱ�װ";
		}
		catch(e){
			document.getElementById("iWebOffice_message").innerHTML = "δ��װ";
	    	document.getElementById("iWebOffice_message").style.color="red";		    
		}
		
		try{
		    var isRTX = new ActiveXObject("RTXClient.RTXAPI");	
	    	document.getElementById("RTX_message").innerHTML = "�Ѱ�װ";
		}
		catch(e){
			document.getElementById("RTX_message").innerHTML = "δ��װ";
	    	document.getElementById("RTX_message").style.color="red";		    
		}
		
		try{
		    var isJwCltActivex = new ActiveXObject("JWCLTACTIVEX.JwCltActivexCtrl.1");	
	    	document.getElementById("eform_message").innerHTML = "�Ѱ�װ";
		}
		catch(e){
			document.getElementById("eform_message").innerHTML = "δ��װ";
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
					document.getElementById("eform_message").innerHTML = eppDataWrObj.isCanUse() ? "�Ѱ�װ" : "δ��װ";
					document.getElementById("eform_message").style.color = eppDataWrObj.isCanUse() ? "" : "#ff0000";
				}
			}
		}
		***/
		
		function clearAllCachData()
		{
			alert("�ݲ�֧�ֻ����������������");
			//if(typeof(userDataWrObj) != "undefined") userDataWrObj.clearAllSource();
			//if(typeof(flashWrObj) != "undefined") flashWrObj.clearAllSource();
			//if(typeof(eppDataWrObj) != "undefined") eppDataWrObj.clearAllSource();				
		}
		
	</script>
</html>
