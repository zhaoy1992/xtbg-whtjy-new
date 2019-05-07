<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>
<html>
<head>
<%@ include file="/epp/css/cssControl.jsp"%>
<script type="text/javascript">
function check(sb){
	var xmlfile = document.getElementById('xmlfile');
	if(sb=='xmlfile'){
		if(xmlfile.value.indexOf('.zip')<=0){
			clearFileInput(xmlfile);
			alert('你选择的文件格式不对，请重新选择!');
			return false;
		}
	}
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
function onsub(){
	document.getElementById("sub").disabled=true;
} 
function jumpPage(){
  	document.location.assign("../orgusersyninfo.jsp");
  }
</script>
</head>
<body class="contentbodymargin" >
<form name="uploadForm" method="post" action="xmlupload_do.jsp" enctype="multipart/form-data" onsubmit="onsub();">
		<input type="hidden" name="type" value=""/>
			<div id="contentborder" align="center">
			<br />
			<br />
			<fieldset style="width: 90%;">
				<LEGEND align=center>
					<FONT size="2">上传XML文件</FONT>
				</LEGEND>
				<br />
				<br />
					XML文件压缩包：<input name="xmlfile" type="file" value="" onchange="check('xmlfile')" size="80"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
	</fieldset>
	<div align="right">
	<input type=button name=bt1 value="上一步" class="input" onclick="jumpPage();"/>
	<input id="sub" name="sub" type="submit" value="下一步" class="input">
	<input type="button" value="关闭" class="input"	onclick="window.close();" />
	</div>
	</form>
</body>
</html>