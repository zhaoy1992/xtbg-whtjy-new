<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@include file="expmenuvo.jsp"%>
<head>
	<title>���Ӧ��</title>
	<style type="text/css">
<!--
.style1 {
	color: #CC0000
}
-->
</style>
	<link href="sysmanager/css/windows.css" rel="stylesheet"
		type="text/css">
	<link href="sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="sysmanager/css/contentpage.css" rel="stylesheet"
		type="text/css">
	<base target="_self">

	<!-- dwr begin-->
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/sysmanager/applymanager/dwr/util.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/interface/menuissueChange.js'></script>
	<!-- dwr end -->
	<!-- �ύ��ҳ���� -->
	<script language="javascript" type="text/javascript"
		src="../pageGrey.js" />

</head>
<html>

	<SCRIPT language="JavaScript" SRC="sysmanager/scripts/validateForm.js"></SCRIPT>
	<script language="JavaScript"
		src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
		type="text/javascript"></script>
	<SCRIPT LANGUAGE="JavaScript"> 
	
	function jumpPage(obj){
		if(obj=="back"){
			document.location.assign("expmenuselect.jsp");
		}else if(obj=="next"){
			//�ύ��ҳ����
			popSignFlow(1);
			
		    document.subform.moduleID.value = getModuleID();			
			document.subform.action="businessclassselect.jsp";
			document.subform.submit();
		}
	}
	
	function getModuleID(){
		var menuids = document.getElementsByName("menuid");
		var menuid = "";
		for(var i=0;i<menuids.length;i++)
		{
			if(menuids[i].checked)
			{
				menuid = menuid + ";" + menuids[i].value;
			}
		}
		return menuid;
	}
	
	function moduleconfig(){
		var sel = getModuleID().split(";");
		var max = 0;
		var moduleID = "";
		for(var i=0;i<sel.length;i++){
			if(sel[i].search(/item:/) > -1){
				max++;
				moduleID = sel[i].split("/")[1];
			}
		}
		if(max==0){
			alert("��ѡ��һ����Ҫ���õ�ģ��˵���");
			return;
		}else if(max>1){
			alert("��ֻѡ��һ����Ҫ���õ�ģ��˵���");
			return;
		}else{	
			openWin('<%=request.getContextPath()%>/eppissue/menuissue/expmenu/expmenuconfigmain.jsp?isFill=true&&moduleID='+moduleID,screen.availWidth-260,screen.availHeight-120);
		}
	}
	
	function clearmoduleconfig(){
		if (trim(getModuleID()).length == 0 ){
		 	alert("��ѡ����Ҫ������õ�ģ��˵���");
		 	return;
		 }
		 if(confirm("ȷ������ѹ�ѡģ���������?")){
		 	//�ύ��ҳ����
			popSignFlow(1);
		 	menuissueChange.clearConfig(getModuleID(),"<%=control.getCurrentSystemID()%>",clearmoduleconfigresult);
		 }
	}
	
	function clearmoduleconfigresult(obj){
		//ҳ���һָ�����
		cancelSign();
		if(obj=="true"){
			alert("����ɹ���");
		}else{
			alert("���ʧ�ܣ�");
		}
	}
	
	function expmenu(){
		 if (trim(getModuleID()).length == 0 ){
		 	alert("��ѡ����Ҫ������ģ��˵���");
		 	return;
		 }
		 var remark = document.addapplytab2.remark.value;
		 if(trim(remark).length>=1000){
		 	alert("��ע���ݳ���1000�֣������������");
		 	return;
		 }
	
		//�ύ��ҳ����
		popSignFlow("expmenulist.jsp");
		
		sh = setInterval("showLog()",1000);
			
		menuissueChange.expMenu(getModuleID(),"<%=control.getCurrentSystemID()%>",remark,expmenuresult);
	}
	
	function expmenuresult(obj){
		DWREngine.setPreHook(function() {});				
		DWREngine.setPostHook(function() {});
		
		setTimeout("clearInterval(sh)",1500);	
			
		if(obj=="true"){
			document.getElementById("showLogSub").style.display="block";									
		}else{
			document.getElementById("showLogRes").style.display="block";			
		}
		
		//ҳ���һָ�����
	//	cancelSign();
	//	if(obj[0]=="false"){
	//		alert(obj[1]);
	//	}else{
	//		alert("�����ɹ���");
	//		document.location.assign("expmenulist.jsp");
	//	}
	}
	
	//ȥ���ַ����ո�
	function trim(string){
		var temp="";
		string = ''+string;
		splitstring = string.split(" ");
		for(i=0;i<splitstring.length;i++){
			temp += splitstring[i];
		} 
		return temp;
	}
	
	function showLog(){
		document.getElementById("showLogDiv").style.display="block";
		menuissueChange.showLog(showLogResult);
	}
	
	function showLogResult(obj){
		document.getElementById("showLogDiv").innerHTML  = obj ;
		document.getElementById("showLogDiv").scrollTop=document.getElementById("showLogDiv").scrollHeight;			
	}
</SCRIPT>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="yes">
		<div align="center">
			<br />
			<form name="addapplytab2" action="" method="post">

				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2">�˵�ѡ��</FONT>
					</LEGEND>
					<br />
					<table id="moduletable" class="table" width="100%" border="0"
						cellpadding="0" cellspacing="1">
						<tr>
							<td class="detailtitle" align=left>
								<tree:tree tree="apply_menu_tree" node="apply_menu_tree.node"
									imageFolder="../../../sysmanager/images/tree_images/"
									collapse="true" includeRootNode="true" target="operList"
									dynamic="false" mode="static">
									<tree:param name="menuid" />
									<tree:checkbox recursive="true" name="menuid"
										partuprecursive="true" />
									<tree:treedata
										treetype="com.chinacreator.eppissue.menuissue.expmenu.menu.ExpMenumoduleSelectTree"
										scope="request" rootid="0" rootName="ƽ̨�˵���" expandLevel="1"
										showRootHref="false" needObserver="false" refreshNode="true" />
								</tree:tree>
								<hr/>
							</td>
						</tr>
						<tr>
							<td align="center">��ע:</td>
						</tr>
						<tr>
							<td align="center"><textarea name="remark" id="remark" rows="5" cols="80"></textarea></td>
						</tr>
					</table>
				</fieldset>
				<br />
				<div align="center">
					<table width="45%" border="0" align="right" cellpadding="0"
						cellspacing="0">
						<tr>
							<td>
								<div align="left">

									<input name="Submit" type="button" class="input" value="��һ��"
										onClick="jumpPage('back')">
									<input name="reset" type="reset" class="input" value="����">
									<input name="Submit" type="button" class="input" value="����"
										onClick="moduleconfig();">
									<input name="Submit" type="button" class="input" value="�������"
										onClick="clearmoduleconfig();">
									<input name="Submit" type="button" class="input" value="����"
										onClick="expmenu()">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
		<div id="selectmodule">
		</div>
		<div style="display: none;">
			<form action="" name="subform" method="post">
				<input type="hidden" name="isFill" value="true">
				<input type="hidden" name="moduleID" value="<%=moduleID%>">
				<input type="hidden" name="workclass" value="<%=workclass%>">
			</form>
		</div>
	</body>
</html>
