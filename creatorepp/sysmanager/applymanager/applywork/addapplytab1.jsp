<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ include file="../../include/global1.jsp"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo = control.getUserAttribute("userAccount") + ":"
			+ control.getUserAttribute("userName") + "["
			+ control.getUserAttribute("userID") + "]  ";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();
	//应用ID
	String app_id = request.getParameter("app_id") != null ? request
			.getParameter("app_id") : "";
	//应用名称
	String app_name = request.getParameter("app_name") != null ? request
			.getParameter("app_name")
			: "";
	//是否修改状态	 "true"	可修改
	String isEdit = request.getParameter("isEdit") != null ? request
			.getParameter("isEdit") : "";
	//取消状态，是否取消时注销应用 "true" 可注销
	String isCancel = request.getParameter("isCancel") != null ? request
			.getParameter("isCancel")
			: "";
	//是否来自上个页面
	String isBack = request.getParameter("isBack") != null ? request
			.getParameter("isBack") : "";
	//应用登录路径
	String applypath = request.getRequestURL().toString();
%>
<head>
	<title>添加应用</title>
	<style type="text/css">
<!--
.style1 {
	color: #CC0000;
}
.style2 {
	cursor: hand;
	
}
-->
    </style>
	<link href="../../css/windows.css" rel="stylesheet" type="text/css">
	<link href="../../css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
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
		src='<%=request.getContextPath()%>/dwr/util.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
	<!-- dwr end -->

	<!-- 提交后页面变灰 -->
	<script language="javascript" type="text/javascript"
		src="../pageGrey.js" />
</head>
<html xmlns:ps>
	<script language="javascript" type="text/javascript"
		src="sysmanager/scripts/validateForm.js"></SCRIPT>
	<script language="javascript" type="text/javascript">
	<!--//
	//应用ID
	var app_id = "<%=app_id%>";
	//是否修改状态		
	var isEdit = "<%=isEdit%>";	
	//取消状态，是否取消时删除应用
	var isCancel = "<%=isCancel%>";
	//是否来自上个页面
	var isBack = "<%=isBack%>";
	//应用登录路径
	var applypath = "<%=applypath%>";
	
	//如果是修改状态或上个页面,给页面赋值
	if(isEdit=="true"||isBack=="true"){
		fillDate();		
	}else{
		fillOption();
	}
	
	//调用后台JAVA类,通过应用ID得到应用参数
	function fillDate(){
		applyChange.getApply(app_id,showDate);
	}
	
	//回调函数,通过返回参数给页面赋值
	function showDate(objs){
		if(objs!=null){
			var form = document.forms[0];							
				form.app_name.value = objs[0];							
				form.remark.value = objs[1];
				
				var dbname = new Array(objs[2]);
				DWRUtil.addOptions("dbname",dbname);
				
				form.dbname.disabled="disabled";
				fillDbContent(objs[2]);
		}
	}
	
	//调用后台JAVA类，得到缺省表空间和临时表空间下拉列表
	function fillOption(){
		applyChange.getDbName(showDbName);
		applyChange.getDeftablespace(showDeftablespaceOption);
		applyChange.getTemptablespace(showTemptablespaceOption);
	}
	
	//回调函数，通过返回参数给页面赋值
	function showDeftablespaceOption(objs){
		DWRUtil.addOptions("deftablespace",objs);
	}
	
	//回调函数，通过返回参数给页面赋值
	function showTemptablespaceOption(objs){
		DWRUtil.addOptions("temptablespace",objs);
	}
	
	//回调函数，通过返回参数给页面赋值
	function showDbName(objs){
		DWRUtil.addOptions("dbname",objs);
		fillDbContent(objs[0]);
	}
	
	//回调函数，通过返回参数给页面赋值
	function fillDbContent(objs){
		applyChange.getDbContentByDbName(objs,showDbContent);
	}
	
	//回调函数，通过返回参数给页面赋值
	function showDbContent(objs){
		document.getElementById("dburl").innerHTML = objs[0];
		document.getElementById("dbusername").innerHTML = objs[1];
	}
	
	function checkdbname(){
		fillDbContent(document.forms[0].dbname.value);
	}
	
	//验证数据、通过判断是否修改状态调用不同后台JAVA类方法
	function saveApply(isSave) {
				var form = document.forms[0];				
				var app_name=form.app_name.value;
				var remark=form.remark.value;
				var deftablespace=form.deftablespace.value;
				var temptablespace=form.temptablespace.value;
				var dbuser=form.dbuser.value;
				var dbpwd=form.dbpwd.value;
				var dbname=form.dbname.value;
				
				var appid = "<%=app_id%>";				
				if(isEdit!="true" && isEdit!="creat"){				
					appid = form.appid.value;
				}
				
				if (trim(appid).length == 0 ){
			    	document.getElementById("appid_message").innerHTML = "请录入应用id！"; 
			    return false;
			    }else{
			    	document.getElementById("appid_message").innerHTML = "";
			    }
			    
			    if(appid.search(/[^\w]/) !=-1){	
			    	var blank = "";
			    	for(var i=0;i<9;i++)
			    		blank += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";    	
			    	document.getElementById("appid_message").innerHTML = "应用id只能由数字、字母、"+"<br/>"+blank+ "或下划线组成！"; 
			    	return false;
			    }else{
			    	document.getElementById("appid_message").innerHTML = "";
		    	}			   	
				
				if (trim(app_name).length == 0 ){
			    	document.getElementById("app_name_message").innerHTML = "请录入应用名称！"; 
			    return false;
			    }else{
			    	document.getElementById("app_name_message").innerHTML = "";
			    }
			    
			    if(app_name.search(/[^\w\u4e00-\u9fa5]/) !=-1){	
			    	var blank = "";
			    	for(var i=0;i<31;i++)
			    		blank += "&nbsp;&nbsp;";    	
			    	document.getElementById("app_name_message").innerHTML = "应用名称只能由数字、字母、"+"<br/>"+blank+ "汉字或下划线组成！"; 
			    	return false;
			    }else{
			    	document.getElementById("app_name_message").innerHTML = "";
			    }			    
			    
			    if(getdbtype()=="dbname"){
			    	 if (trim(dbname).length == 0 ){
			    		document.getElementById("dbname_message").innerHTML = "请选择数据源！"; 
				   		return false;
				    }else{
				    	document.getElementById("dbname_message").innerHTML = "";
				    }
			    }else if(getdbtype()=="dbtable"){ 				   
				    if (trim(deftablespace).length == 0 ){
				    	document.getElementById("deftablespace_message").innerHTML = "请录入缺省表空间！"; 			    	
				    	return false;
				    }else{
				    	document.getElementById("deftablespace_message").innerHTML = "";
				    }
				    
				    if(deftablespace.search(/[^\w]/) !=-1){	
				    	var blank = "";
				    	for(var i=0;i<31;i++)
				    		blank += "&nbsp;&nbsp;";    	
				    	document.getElementById("deftablespace_message").innerHTML = "缺省表空间只能由数字、字母"+"<br/>"+blank+ "或下划线组成！"; 			    	
				    	return false;
				    }else{
				    	document.getElementById("deftablespace_message").innerHTML = "";
				    }
				    
				    if (trim(temptablespace).length == 0 ){
				    	document.getElementById("temptablespace_message").innerHTML = "请录入临时表空间！"; 
				    return false;
				    }else{
				    	document.getElementById("temptablespace_message").innerHTML = "";
				    }
				    
				    if(temptablespace.search(/[^\w]/) !=-1){	
				    	var blank = "";
				    	for(var i=0;i<31;i++)
				    		blank += "&nbsp;&nbsp;";    	
				    	document.getElementById("temptablespace_message").innerHTML = "临时表空间只能由数字、字母"+"<br/>"+blank+ "或下划线组成！"; 			    	
				    	return false;
				    }else{
				    	document.getElementById("temptablespace_message").innerHTML = "";
				    }
				    
				    
				    if (trim(dbuser).length == 0 ){
				    	document.getElementById("dbuser_message").innerHTML = "请录入数据库用户名！"; 
				    return false;
				    }else{
				    	document.getElementById("dbuser_message").innerHTML = "";
				    }
				    
	//			    if(dbuser.search(/[^\w]/) !=-1){	
	//			    	var blank = "";
	//			    	for(var i=0;i<31;i++)
	//			    		blank += "&nbsp;&nbsp;";    	
	//			    	document.getElementById("dbuser_message").innerHTML = "数据库用户名只能由数字、"+"<br/>"+blank+ "字母或下划线组成！"; 			    	
	//			    	return false;
	//			    }else{
	//			    	document.getElementById("dbuser_message").innerHTML = "";
	//			    }
					
				    if (trim(dbpwd).length == 0 ){
				    	document.getElementById("dbpwd_message").innerHTML = "请录入数据库密码！"; 
				    	return false;
				    }else{
				    	document.getElementById("dbpwd_message").innerHTML = "*注:缺省密码为：123456";
				    }
				}else{
					alert("数据库属性选择错误！");
					return false;
				}
			    //提交后页面变灰
			    popSignFlow(1);
			    
			    //生成应用状态
			    if(isSave == "save"){
			    	if("cms"==trim(appid).toLowerCase()){
			    		if(!confirm("应用ID为cms的应用为内容管理专用ID，确认新增该应用吗?")){
			    			//页面变灰恢复正常
							cancelSign();
							return;
			    		}
			    	}
			    	document.getElementById("Submit").disabled = true;			    				
					applyChange.addApply(appid,app_name,remark,deftablespace,temptablespace,dbuser,dbpwd,applypath,"<%=userInfo%>","<%=remoteAddr%>",dbname,getdbtype(),nextApply);				
				}
				//修改应用状态
				else if(isSave == "edit"){
					applyChange.updateApply(app_id,app_name,remark,"<%=userInfo%>","<%=remoteAddr%>",nextApply);				
				}
			}
	
	//回调函数，通过返回参数判断应用操作是否成功
	//如果成功跳往下一页面		
	function nextApply(objs){		
		
		document.getElementById("Submit").disabled = false;
				
		if(objs[0]=="appidNull"){
			//页面变灰恢复正常
			cancelSign();
			document.getElementById("appid_message").innerHTML = "输入有空值!";
		}else if(objs[0]=="appidErr"){
			//页面变灰恢复正常
			cancelSign();
			document.getElementById("appid_message").innerHTML = "应用ID已存在!";
		}else if(objs[0]=="stringNull"){
			//页面变灰恢复正常
			cancelSign();
			document.getElementById("app_name_message").innerHTML = "输入有空值!";
		}else if(objs[0]=="applyExist"){
			//页面变灰恢复正常
			cancelSign();
			document.getElementById("app_name_message").innerHTML = "应用已存在!";
		}else if(objs[0]=="applyErr"){
			//页面变灰恢复正常
			cancelSign();
			document.getElementById("app_name_message").innerHTML = objs[1];
		}else if(objs[0]=="addApplySucceed"){
				if(isEdit=="true"){
					alert("修改成功");
					//页面变灰恢复正常
					cancelSign();
				}else{
					var appid = "<%=app_id%>";				
					if(isEdit!="true" && isEdit!="creat"){				
						appid = document.forms[0].appid.value;
					}
					if("cms"==trim(appid).toLowerCase()){
						document.location.assign("addapplytab3.jsp?app_id="+objs[1]+"&&isCancel="+isCancel+'&&isEdit='+isEdit);
					}else{										
						document.location.assign("addapplytab2.jsp?app_id="+objs[1]+"&&isCancel="+isCancel+'&&isEdit='+isEdit);
					}
				}
		}		
	}		
		//弹出消息对话框，通过应用ID调用后台JAVA类注销应用
		function logoutApply()
		{	
			if(confirm("确认取消吗?\r取消同时将注销该应用!")){
				var app_id_arr = new Array;
				app_id_arr[0] = app_id;
				applyChange.updateApplyStatus(app_id_arr,0,"<%=userInfo%>","<%=remoteAddr%>",winClose);			
			}
		}
		
		//关闭模态窗口并刷新父页面
		function winClose(){
				window.close();
				window.returnValue="refresh";
		}
		
		//判断取消状态是否需要注销应用
		function cancel(){
			if(isCancel=="true"){
				logoutApply();
			}else{
				winClose();
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
		
		//按下关闭按钮时刷新父窗口
		function window.onbeforeunload()
		{
		    if(event.clientX>360&&event.clientY<0||event.altKey)
		    {
		       if(isCancel=="true"&&app_id!=""){
					logoutApply();
				}else{
					winClose();
				}
		    }
		}
		
		//当输入应用名称时,填充应用描述和数据库用户名
		function keyfill(){
				var form = document.forms[0];
				if(isEdit=="true"){						
					form.remark.value=form.app_name.value;
				}else{
					form.dbuser.value=form.remark.value=form.app_name.value;					
				}
		}
		
		function keyfullappid(){
			var form = document.forms[0];
			document.getElementById("dbuser_full").innerHTML = "app_"+form.appid.value;
		}
		
		//当点超链时跳转到相应页面
		function myclick(url){
			document.location.assign(url);
		}
		
		//调用后台JAVA类，得到自动生成的应用ID
		function autoAppId(){
			applyChange.getAutoAppId(showAutoAppId);
		}
		
		function showAutoAppId(obj){
			var form = document.forms[0];
			form.appid.value = obj;
			keyfullappid();
		}
		
		function checkdbtype(){
			if(getdbtype()=="dbname"){
				document.getElementById("tab_dbname").style.display="";
				document.getElementById("tab_dbtable").style.display="none";
			}else if(getdbtype()=="dbtable"){
				document.getElementById("tab_dbname").style.display="none";
				document.getElementById("tab_dbtable").style.display="";
			}
			return;
		}
		
		function getdbtype(){
			var r = document.forms[0].dbtype;
			for(var i = 0; i < r.length; i++){
				if(r[i].checked == true){
						return r[i].value;
					}
			}
		}		
		
		function res(){
			document.forms[0].reset();
			checkdbtype();
			keyfullappid();
		}
			
//-->
</script>

	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<div align="center">
			<form action="" method="post">
				<br>
				<pg:beaninfo requestKey="Apply">

					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2"> 基本属性</FONT>
						</LEGEND>
						<br />
						<table width="85%" height="35" border="0" align="center"
							cellpadding="0" cellspacing="1" class="thin">
							<tr>
								<td width="20%" height="35" class="detailtitle">
									<span class="style1">*</span>应用ID
									<br>
								</td>
								<td nowrap="NOWRAP" class="detailcontent">
									<%
									if (isEdit.equals("true") || isEdit.equals("creat")) {
									%>
									<input type="text" value="<%=app_id%>" size="40" maxlength="20"
										disabled="disabled">
									<%
									} else {
									%>
									<input type="text" name="appid" size="40" maxlength="20" onkeyup="keyfullappid();">
									<input type="button" value="自动生成" class="input"
										onclick="autoAppId();">
									<%
									}
									%>
									&nbsp;
									<span id="appid_message" class="style1" /> </span>
									<br>
								</td>
							</tr>
							<tr>
								<td width="20%" height="35" class="detailtitle">
									<span class="style1">*</span>应用名称
									<br>
								</td>
								<td nowrap="NOWRAP" class="detailcontent">
									<%
									if (isEdit.equals("creat")) {
									%>
									<input name="app_name" id="app_name" value="<%=app_name%>"
										type="text" size="40" maxlength="20" onkeyup="keyfill();" />
									<%
									} else {
									%>
									<input name="app_name" id="app_name" type="text" size="40"
										maxlength="20" onkeyup="keyfill();" />
									<%
									}
									%>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<span id="app_name_message" class="style1" /> </span>
									<br>
								</td>
							</tr>
							<tr>
								<td height="35" class="detailtitle">
									<span class="style1">&nbsp;</span>应用描述
									<br>
								</td>
								<td class="detailcontent">
									<textarea name="remark" cols="29" rows="3" maxlength="200"></textarea>
									<br>
								</td>
							</tr>
						</table>
					</fieldset>
					<br />
					<br />
					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2"> 数据库属性</FONT>
						</LEGEND>
						<table width="85%" height="35" border="0" align="center"
							cellpadding="0" cellspacing="1">
							<%
							if (isEdit.equals("true") || isEdit.equals("creat")) {
							%>
							<tr>
								<td height="35">
									<input type="radio" name="dbtype" value="dbname"
										checked="checked" onclick="checkdbtype();" disabled="disabled">
									选择数据源
									<br>
								</td>
								<td height="35">
									<input type="radio" name="dbtype" value="dbtable"
										onclick="checkdbtype();" disabled="disabled">
									自定义数据库
									<br>
								</td>
							</tr>
							<%
							} else {
							%>
							<tr>
								<td height="35">
									<input type="radio" name="dbtype" value="dbname"
										checked="checked" onclick="checkdbtype();">
									选择数据源
									<br>
								</td>
								<td height="35">
									<input type="radio" name="dbtype" value="dbtable"
										onclick="checkdbtype();">
									自定义数据库
									<br>
								</td>
							</tr>
							<%
							}
							%>
						</table>

						<table width="85%" height="35" border="0" align="center"
							cellpadding="0" cellspacing="1" class="thin" id="tab_dbname">
							<tr>
								<td colspan="2" align="center">
									该选项只使用选择的数据源，不会生成应用数据库
								</td>
							</tr>
							<tr>
								<td width="20%" height="35" class="detailtitle">
									<span class="style1">*</span>数据源选择
								</td>
								<td width="" class="detailcontent" nowrap="nowrap">
									<select name="dbname" class="cms_select"
										onchange="checkdbname();">
									</select>
									<span id="dbname_message" class="style1" /> </span>
								</td>
							</tr>
							<tr>
								<td width="20%" height="35" class="detailtitle">
									<span class="style1">&nbsp;</span>数据源地址
								</td>
								<td width="" class="detailcontent" nowrap="nowrap">
									<span id="dburl" />
								</td>
							</tr>
							<tr>
								<td width="20%" height="35" class="detailtitle">
									<span class="style1">&nbsp;</span>数据源用户名
								</td>
								<td width="" class="detailcontent" nowrap="nowrap">
									<span id="dbusername" />
								</td>
							</tr>
						</table>


						<table width="85%" height="35" border="0" align="center"
							cellpadding="0" cellspacing="1" class="thin"
							style="display: none;" id="tab_dbtable">
							<tr>
								<td colspan="2" align="center">
									该选项将生成应用数据库，并根据此信息生成一个新的数据源
								</td>
							</tr>
							<tr>
								<td width="20%" height="35" class="detailtitle">
									<span class="style1">*</span>缺省表空间
								</td>
								<td width="" class="detailcontent" nowrap="nowrap">
									<select name="deftablespace" class="cms_select">
									</select>
									<%--<%
									if (isEdit.equals("true")) {
									%>
									<input name="deftablespace" type="text" size="40"
										maxlength="20" value="dzzwpt" disabled="disabled" />
									<%
									} else {
									%>
									<input name="deftablespace" type="text" size="40"
										maxlength="20" value="dzzwpt" />
									<%
									}
									%>
									&nbsp;&nbsp;&nbsp;&nbsp;
									--%>
									<span id="deftablespace_message" class="style1" />
								</td>
							</tr>
							<tr>
								<td width="20%" height="35" class="detailtitle">
									<span class="style1">*</span>临时表空间
								</td>
								<td width="" class="detailcontent" nowrap="nowrap">
									<select name="temptablespace" class="cms_select">
									</select>
									<%--<%
									if (isEdit.equals("true")) {
									%>
									<input name="temptablespace" type="text" size="40"
										maxlength="20" value="temp" disabled="disabled" />
									<%
									} else {
									%>
									<input name="temptablespace" type="text" size="40"
										maxlength="20" value="temp" />
									<%
									}
									%>
									&nbsp;&nbsp;&nbsp;&nbsp;
									--%>
									<span id="temptablespace_message" class="style1" />
								</td>
							</tr>
							<tr>
								<td height="35" class="detailtitle" nowrap="nowrap">
									<span class="style1">*</span>数据库用户名
								</td>
								<td class="detailcontent">
									<%
									if (isEdit.equals("true")) {
									%>
									<input name="dbuser" type="text" size="40" maxlength="20"
										disabled="disabled" />
									<%
									} else {
									%>
									<!-- <input name="dbuser" type="text" size="40" maxlength="20" /> -->
									<span id="dbuser_full" >app_</span>
									<input type="hidden" name="dbuser">
									<%
									}
									%>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<span id="dbuser_message" class="style1" />
								</td>
							</tr>
							<tr>
								<td height="35" class="detailtitle">
									<span class="style1">*</span>数据库密码

								</td>
								<td class="detailcontent" nowrap="nowrap">
									<%
									if (isEdit.equals("true")) {
									%>
									<input name="dbpwd" type="password" size="40" maxlength="20"
										value="123456" disabled="disabled" />
									<%
									} else {
									%>
									<input name="dbpwd" type="password" size="40" maxlength="20"
										value="123456" />
									<%
									}
									%>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<span id="dbpwd_message" class="style1">*注:缺省密码为：123456</span>
								</td>
							</tr>
						</table>
						<span style="font-size: 12px;color: #CC0000;">*注:数据库属性生成后不可更改</span>
						<br />
						<br />
					</fieldset>
					<br />
					<br />
					<div align="center">
						<table width="35%" border="0" align="right" cellpadding="0"
							cellspacing="0">
							<tr>
								<td>
									<div align="left">
										<%
										if (isEdit.equals("true")) {
										%>

										<input name="Submit" type="button" class="input" value="修改"
											onClick="saveApply('edit')">
										<input name="button" type="button" class="input" value="重置"
											onclick="fillDate()">
										<input name="button" type="button" class="input" value="取消"
											onClick="cancel()">
										<%
										} else {
										%>
										<%
										if (isBack.equals("true")) {
										%>
										<input name="Submit" id="Submit" type="button" class="input"
											value="下一步" onClick="saveApply('edit')">
										<%
										} else {
										%>
										<input name="Submit" id="Submit" type="button" class="input"
											value="生成应用" onClick="saveApply('save')">
										<%
										}
										%>
										<input name="rsset" type="button" class="input" value="重置"
											onclick="res()">
										<input name="button" type="button" class="input" value="取消"
											onClick="winClose()">
										<%
										}
										%>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</pg:beaninfo>
			</form>
		</div>
	</body>
</html>
