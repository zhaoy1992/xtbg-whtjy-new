<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title>
<% 
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String uri = request.getParameter("uri");
	String type = request.getParameter("type");
%>
<style type="text/css">
<!--
body,td,th {
	font-family: Verdana, ����;
	font-size: 12px;
}
body {
   background:F2FAFF;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

input{ border:1px  #999999 solid; height:18px; color:#666666}
-->
</style>
<script language="javascript">
var win = window.dialogArguments;
var type = '<%=(type==null?"":type)%>';
function checkForms(ob){
     var iu, iuu, regArray=new Array("","\'","\""); 
     iuu=regArray.length;
     for(iu=1;iu<=iuu;iu++){
        if (ob.value.indexOf(regArray[iu])!=-1){
           alert("���Ʋ����԰�����" + regArray[iu]+",����������!");
           ob.value="";
           ob.focus();
           return false;
        }
     }
     return true;              
}
function createFile(){
	var file = document.form1.fileName.value;
    ;  
	if(file.search(/\S/img)==-1){
		if('1'==type){
			alert("����½����ļ�����!");
		}else{
			alert("����½����ļ�������!");
		}
		return;
	}
    if(checkForms(document.form1.fileName)){
	    document.form1.submit();
    }
}
function initialForm()
{
	if(<%=type%>!="1")
	{
	  document.all.coverFlag.style.display="none";
	  document.all.lab.style.display="none";
	}
}
</script>
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
</head>
<body onload="initialForm()">
<form action="createFile_do.jsp" method="post" name="form1" target="hidFrm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td height="10"></td></tr>
	<tr>
		<td class="Template_CreateBox" align="left">
		&nbsp;&nbsp;
				<%if("1".equals(type)){
					out.println("�������ļ�������:");
				}else{
					out.println("�������ļ��е�����:");
				}
				%>
				<input name="fileName" type="text" id="fileName" size="20">
				<input name="uri" type="hidden" id="uri" value="<%=(uri==null?"":uri)%>">
				<input name="type" type="hidden" id="type" value="<%=(type==null?"":type)%>">
				<input type="checkbox" id="coverFlag" name="coverFlag">&nbsp;<label id="lab">���������ļ�</label>
	  </td>
	</tr>
	<tr>
	<td class="Template_CreateBox" align="center">
<input type="button" class="cms_button" name="Submit" value="ȷ��" onClick="createFile()">
				<input type="button" class="cms_button" name="quxiao" value="ȡ��" onClick="window.close()"></td>
	</tr>
</table>
</form>
<iframe id="hidFrm" name="hidFrm" style="display:none"></iframe>
</body>
</html>
