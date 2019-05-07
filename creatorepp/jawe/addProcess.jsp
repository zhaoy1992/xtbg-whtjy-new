<%@ page contentType="text/html; charset=GBK"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>新增流程</title>
			<link rel="stylesheet" type="text/css" href="../purviewmanager/css/windows.css">
			<link rel="stylesheet" type="text/css" href="../purviewmanager/css/treeview.css">
		<SCRIPT LANGUAGE="JavaScript"> 			
			function saveFormClass() {
			
				var process_name = document.getElementById("process_name").value;
				document.getElementById("divProcessing").style.display="block";
				alert("open 1111 "+process_name);
				//openXPDL("",process_name);
				newXPDL('111111');
				alert("open "+process_name);
			}
			
			function checkLength(e)
			{
				var elength = e.value.length;
				var v = e.value;				
				if(elength>=100)
				{
					e.value = v.substring(0,100);
				}
			}
			
			function validateFormValue() {
				
				var form = document.forms[0];
				
				var class_name = form.form_class_name.value;
				var upid = form.up_class_id.value;
				var remark = form.form_class_remark.value;
				
				if (class_name.length < 1 || class_name.replace(/\s/g,"")=="") {			
					alert("分类名称必须填写");
					return false;
				}
				if (upid.length < 1 || upid.replace(/\s/g,"")=="") {			
					alert("上级分类必须填写");
					return false;
				}
				
				if(class_name.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("分类名称不能有\\/|:*?<>\"'!等特殊字符");
					return false;
				}
				
				if(upid.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("上级分类不能有\\/|:*?<>\"'!等特殊字符");
					return false;
				}
				
				return true;
			}
			
			function openXPDL(path,file_name){
			
				var ap=document.applets.jawe;
				//ap.setPath(path);
				//ap.setFileName(file_name);
				//ap.setOpenUrl("http://172.16.168.195:8081/jawe/ttt.xpdl");
				ap.setSaveUrl("http://172.16.168.195:8081/dzzwpt/jawe/xpdl_save.jsp");
				ap.setEcId(ec_id);
				ap.setIsNew("false");
			}
			
			function newXPDL(ec_id)
			{
				var ap=document.applets.jawe;
				ap.setSaveUrl("http://172.16.168.195:8081/dzzwpt/jawe/xpdl_save.jsp");
				ap.setEcId(ec_id);
				ap.setIsNew('true');
			}
			
</SCRIPT>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" onload="" scroll="no">
		<div id="contentborder" align="center">
			<form method="post" name="formClassForm">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="20%" height="25" class="detailtitle" align="right">流程名称*：</td>
						<td height="25">
							<input type=text name="process_name" style="width=50%" maxlength="100" value=""/>
						</td>
					</tr>
					
					<tr class="tr">
						<td height="25" width="20%" class="detailtitle" align="right">流程描述：</td>
						<td height="25">
							<textarea name="process_remark" rows="4" cols="40" rows="5" onkeyup="checkLength(this)"></textarea>
						</td>
					</tr>
			</table>
            <hr width="100%">				
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
				<tr class="tr">
					<td class="td">
						<div align="center">								
							<input name="update" type="button" onClick="saveFormClass()" class="input" value="保存">
							<input name="calc" type="reset" class="input" value="清空">
							<input name="calc" type="button" class="input" value="返回" onClick="window.close();window.returnValue=true;">
					    </div>
					</td>
				</tr>
			  </table>
			</form>
		</div>

		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:100px;top:260px;display:none">
			<table border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
			<object classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" name="jawe" width="80px" height="60px" codebase="http://java.sun.com/products/plugin/1.2.2/jinstall-1_2_2-win.cab#Version=1,2,2,0">
				<param name="java_code" value="com.chinacreator.jawe.JaweApplet">
				<param name="java_codebase" value=".">
				<param name="java_archive" value="graph.jar">
				<param name="type" value="application/x-java-applet;">
				<comment>
				<embed type="application/x-java-applet;" name="jawe" width="80px" height="60px" pluginspage="http://java.sun.com/products/plugin/" java_code="com.chinacreator.jawe.JaweApplet" java_codebase="." java_archive="graph.jar" APP_ID="1"/>
				<noembed>
				
				</noembed>
				</comment>
			</object>
		</div>
	</body>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>