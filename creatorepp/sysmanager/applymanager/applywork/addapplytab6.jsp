<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String app_id = request.getParameter("app_id") != null ? request.getParameter("app_id") : "";
	String isEdit = request.getParameter("isEdit") != null ? request.getParameter("isEdit") : "";
%>
<head>
	<title>清理表单文件</title>
	<link href="../../css/windows.css" rel="stylesheet" type="text/css">
	<link href="../../css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
	<!-- dwr begin-->
	<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
	<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'> </script>
	<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
	<!-- dwr end -->
	<script language="javascript" type="text/javascript" src="../../../eformsys/fceform/js/fcpub.js" />
	<script language="javascript" type="text/javascript" src="../pageGrey.js" />
</head>
<html>
	<script language="javascript" type="text/javascript" src="sysmanager/scripts/validateForm.js"></SCRIPT>
	<script language="javascript" type="text/javascript">
	<!--//
	//应用ID
	var app_id = "<%=app_id%>";
	//是否修改状态		
	var isEdit = "<%=isEdit%>";	
	//如果是修改状态或上个页面,给页面赋值
	if(isEdit=="true"||isBack=="true"){
		fillDate();		
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
				form.remark.value = objs[7];
		}
	}

	//关闭模态窗口并刷新父页面
	function winClose(){
		window.close();
		window.returnValue="refresh";
	}
	
	//按下关闭按钮时刷新父窗口
	function window.onbeforeunload()
	{
	    if(event.clientX>360&&event.clientY<0||event.altKey)
	       	winClose();
	}
	function clearAppForms(){
	    var delType = document.getElementById("delType").value;
	    var confirmVal = "";
	    if(delType == "1")
	       var confirmVal = window.confirm("确认要删除本应用的所有表单文件吗？");
	    else if(delType == "2")
	       var confirmVal = window.confirm("确认要删除非本应用的所有表单文件吗？");
		
		if(confirmVal == true){
			var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/DbTools?param=noUse&key=clearAppForms&delType="+document.getElementById("delType").value);
			alert(retX);
		}
	}	
//-->
</script>
	<body class="contentbodymargin" scroll="no">
		<div align="center">
			<br />
			<form action="" method="post">
				<pg:beaninfo requestKey="Apply">

					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2"> 基本属性</FONT>
						</LEGEND>
						<br />
						<table width="85%" height="35" border="0" align="center" cellpadding="0" cellspacing="1" class="thin">
							<tr>
								<td width="20%" height="35" class="detailtitle">
									应用ID
								</td>
								<td nowrap="NOWRAP" class="detailcontent">
									<%
										if (isEdit.equals("true")) {
									%>
										<input type="text" value="<%=app_id%>" size="40" maxlength="20" disabled="disabled">
									<%
										} else {
									%>
										<input type="text" name="appid" size="40" maxlength="20" disabled="disabled">
									<%
										}
									%>
								</td>
							</tr>
							<tr>
								<td width="20%" height="35" class="detailtitle">
									应用名称
								</td>
								<td nowrap="NOWRAP" class="detailcontent">
									<input name="app_name" id="app_name" type="text" size="40" maxlength="20" disabled="disabled"/>
								</td>
							</tr>
							<tr>
								<td height="35" class="detailtitle">
									<span class="style1">&nbsp;</span>应用描述
								</td>
								<td class="detailcontent">									
									<textarea name="remark" cols="29" rows="3" maxlength="200" disabled="true"></textarea>
								</td>
							</tr>
						</table>
					</fieldset>
					<br/>
					<br/>
					<div>
						<FIELDSET id=delType value="1" style="WIDTH: 90%;">
						<LEGEND align=center><FONT size="2">表单文件清理</FONT></LEGEND>
						<br/>
						<INPUT onclick="document.getElementById('delType').value=1" checked type=radio value=1 name=RGdelType text="清理属于本应用的所有表单文件">
						<SPAN onclick="RGdelType[0].checked=true;document.getElementById('delType').value=RGdelType[0].value;RGdelType[0].focus();">清理属于本应用的所有表单文件</SPAN>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<INPUT onclick="document.getElementById('delType').value=2" type=radio value=2 name=RGdelType text="清理不属于本应用的所有表单文件">
						<SPAN onclick="RGdelType[1].checked=true;document.getElementById('delType').value=RGdelType[1].value;RGdelType[1].focus();">清理不属于本应用的所有表单文件</SPAN>
						<br/>
						<br/>
						</FIELDSET>
					</div>
					<br />
					<br />
					<div align="center">
						<table width="35%" border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<div align="left">
										<%
										if (isEdit.equals("true")) {
										%>
											<input name="Submit" type="button" class="input" value="确定" onClick="clearAppForms()">&nbsp;&nbsp;
											<input name="button" type="button" class="input" value="取消" onClick="window.close()">
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

