<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<html>
	<head>
		<title>excel机构用户导入</title>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css"><!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/orgusermanager/orgusersyn/impexcelorguser/pageGrey.js">
		</script>
		<script type="text/javascript">
			function impExcelOrgUser(){
				var excelUrl = document.getElementById('excelUrl').value;
				if(excelUrl==''){
					alert("请选择你要导入Excel文件");
					return false;
				}
				document.getElementById("impButton").disabled=true;
				document.ExcelForm.submit();
			}
			//清空file元素的值
			function clearFileInput(file){
			    var form=document.createElement('form');
			    document.body.appendChild(form);
			    //记住file在旧表单中的的位置
			    var pos=file.nextSibling;
			    form.appendChild(file);
			    form.reset();
			    pos.parentNode.insertBefore(file,pos);
			    document.body.removeChild(form);
			}
			function jumpPage(){
			  	document.location.assign("../orgusersyninfo.jsp");
			  }
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body>
		<form name="ExcelForm" action="imp_do.jsp" target="impIfr"
			method="post" enctype="multipart/form-data">
			<div id="contentborder" align="center">
			<br />
			<br />
			<fieldset style="width: 90%;">
				<LEGEND align=center>
					<FONT size="2">EXCEL导入平台</FONT>
				</LEGEND>
				<br />
				<br />
				<input type="file" style="width:80%" name="excelUrl"
							onchange="
							if(this.value.indexOf('.xls')<=0){
								clearFileInput(this);
								alert('你选择的文件格式不正确，请重新选择');
							}
						" />
			</fieldset>
			<div align="right">
			<input type=button name=bt1 value="上一步" class="input" onclick="jumpPage();"/>
			<input type="button" class="input" name="impButton" value="导入"
							onclick="impExcelOrgUser()" />
			<input type="button" value="关闭" class="input"	onclick="window.close();" />
			</div>			
		</form>
	</body>
	<iframe id="impIfr" name="impIfr" width="0" height="0"></iframe>
</html>
