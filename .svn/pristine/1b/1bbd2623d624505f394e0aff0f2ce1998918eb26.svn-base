<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>
<html>
<head>
<%@ include file="/epp/css/cssControl.jsp"%>
<script type="text/javascript">
		
function xml2pt(){
	var userFileUrl = document.getElementById("userFileUrl").value;
	var orgFileUrl = document.getElementById("orgFileUrl").value;
	var orgUserFileUrl = document.getElementById("orgUserFileUrl").value;
	if(userFileUrl==""){
		alert("请选择用户表文件");
		return false;
	}
	if(orgFileUrl==""){
		alert("请选择机构表文件");
		return false;
	}
	if(orgUserFileUrl==""){
		alert("请选择机构用户关联表文件");
		return false;
	}
	document.getElementById("type").value = "imp";
	if(confirm("同步将更改平台机构用户数据，确定同步吗？")){
		document.xmlForm.submit();
	}
}		
function pt2xml(){
	var savePath = document.getElementById("savePath").value;
	if(savePath==""){
		alert("请选择导出目录");
		return false;
	}
	//if(verify(tt)
		document.getElementById("type").value = "exp";
		if(confirm("确定导出吗？")){
			document.xmlForm.submit();
		}
	//}
}
function check(sb){
	//var userFileUrl = document.getElementById('userFileUrl').value;
	//var orgFileUrl = document.getElementById('orgFileUrl').value;
	//var orgUserFileUrl = document.getElementById('orgUserFileUrl').value;
	//var userJobFileUrl = document.getElementById('userJobFileUrl').value;
	//if(sb=='td_sm_user'){
	//	var file = document.getElementById('userFileUrl');
	//	if(userFileUrl.indexOf('.xml')<=0){
	//		clearFileInput(file);
	//		alert('你选择的文件格式不对，请重新选择');
	//		return false;
	//	}
	//	if(userFileUrl.indexOf(sb)<0){
	//		clearFileInput(file);
	//		alert('你选择的不是用户表文件，请重新选择');
	//		return false;
	//	}
	//	if(userFileUrl.indexOf(sb+"job")>0){
	//		clearFileInput(file);
	//		alert('你选择的不是用户表文件，请重新选择');
	//		return false;
	//	}
	//}
//	if(sb=='td_sm_organization'){
//		var file = document.getElementById('orgFileUrl');
//		if(orgFileUrl.indexOf('.xml')<=0){
//			clearFileInput(file);
//			alert('你选择的文件格式不对，请重新选择');
//			return false;
//		}
//		if(orgFileUrl.indexOf(sb)<0){
//			clearFileInput(file);
//			alert('你选择的不是机构表文件，请重新选择');
//			return false;
//		}
//	}
//	if(sb=='td_sm_orguser'){
//		var file = document.getElementById('orgUserFileUrl');
//		if(orgUserFileUrl.indexOf('.xml')<=0){
//			clearFileInput(file);
//			alert('你选择的文件格式不对，请重新选择');
//			return false;
//		}
//		if(orgUserFileUrl.indexOf(sb)<0){
//			clearFileInput(file);
//			alert('你选择的不是机构用户关系表文件，请重新选择');
//			return false;
//		}
//	}

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
//function verify(tt){         
//　　	var pattern =/^([a-zA-Z]){1}:(\\[a-zA-Z])*(\\)?$/;
//	flag = pattern.test(tt);     
//	if(flag){
//		return true;  
//	}else{     
//		alert("格式不对!"); 
//		return false;    
//	}     
//}    
function onsub(){
	document.getElementById("sub").disabled=true;
} 
</script>
</head>
<body class="contentbodymargin" >
<form name="uploadForm" method="post" action="xmlupload_do.jsp" enctype="multipart/form-data" target="uploadframe" onsubmit="onsub();">
		<input type="hidden" name="type" value=""/>
			<table cellspacing="0" cellpadding="0" border="0" bordercolor="#EEEEEE" align="center" width=100% class="thin">
				<tr>
					<td align="center" colspan=3><b>机构用户XML文件</b></td>
				</tr>
				<tr align="center">
					<td nowrap width="33%">
					XML文件压缩包：<input name="xmlfile" type="file" value="" onchange="check('xmlfile')" size="80"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="sub" name="sub" type="submit" value="上传xml压缩包" class="input">
					</td>
					<%--<td nowrap width="33%">
					用户表文件：<input name="userFileUrl" type="file" value="" onchange="check('td_sm_user')"/>
					</td><td nowrap width="33%">
					机构表文件：<input name="orgFileUrl" type="file" value="" onchange="check('td_sm_organization')"/>
					</td>
					<td nowrap width="33%">
					关联表文件：<input name="orgUserFileUrl" type="file" value="" onchange="check('td_sm_orguser')"/>
					</td>--%><%--<td nowrap width="33%">
					岗位表文件：<input name="userJobFileUrl" type="file" value="" onchange="check('td_sm_userjoborg')"/>
					</td>
				--%></tr>
				<%--<tr>
					<td nowrap>
					导出文件目录：<input name="savePath" type="text" value="D:\"/>
					<font color=red>将导出平台(用户，机构，用户机构关联表)3个xml文件到输入的目录下，文件根据【表名+当前时间】命名</font>
					<input id="imp_bt" type="button" value="导出" class="input" onclick="pt2xml()"/>
					</td>
				</tr>
					
			--%></table>
	</form>
	<iframe name="uploadframe" width="0" height="0" style="display: none;"></iframe>
</body>
</html>