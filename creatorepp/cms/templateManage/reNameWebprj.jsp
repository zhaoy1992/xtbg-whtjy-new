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
	String tempuri = request.getParameter("tempuri");
	String viewtype = request.getParameter("viewtype");
	//String templateId=request.getParameter("templateId");//����һ��ģ��ID
	String fileFlag = request.getParameter("fileFlag");//�����ļ�ΪͼƬ����ý�壬��ҳ��
	if(tempuri==null || tempuri.trim().length()==0){
%>
		<script type="text/javascript">
			alert("��֪��Ҫ���ĸ��ļ�(���ļ���),�����б���ѡ��һ���ļ�(���ļ���).");
			top.close();
		</script>
<%	
		return;
	}
%>
<style type="text/css">
<!--
body,td,th {
	font-family: Verdana, ����;
	font-size: 12px;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script language="javascript">
var win = window.dialogArguments;
function reName(){
	var fileFlag = "<%=fileFlag%>";
	var pattern=/\.(gif|jpeg|jpg)$/i;
	
	var filename = document.form1.fileName.value;
	if(filename.search(/\S/img)==-1){
		alert("�������µ��ļ�(���ļ���)����.");
		return;
	}
	else
	{
		if(fileFlag == "" || fileFlag == "pic")//ͼƬ
		{
			if(filename.search(/\S/)==-1){
				alert("�������µ��ļ�(���ļ���)����.");
				return;
			}
			if(!pattern.test(filename)){
				alert("�����ͼƬ��׺��ֻ��Ϊ.gif,.bmp,.jpeg,.jpg!");
				return;
			}
		}
		if(fileFlag == "" || fileFlag == "media")//��ý���ļ�
		{
			pattern=/\.(rm|mp3|wav|mid|midi|ra|avi|mpg|mpeg|asf|asx|wma|mov|wmv|rmvb)$/i;
			if(filename.search(/\S/)==-1){
				alert("�������µ��ļ�(���ļ���)����.");
				return;
			}
			if(!pattern.test(filename)){
				alert("����Ķ�ý���ļ���׺��ֻ��Ϊrm|mp3|wav|mid|midi|ra|avi|mpg|mpeg|asf|asx|wma|mov|wmv|rmvb!");
				return;
			}
		}
		if(fileFlag == "" || fileFlag == "1")//��ҳ�ļ�
		{
			pattern=/\.(html|htm|jsp)$/i;
			if(filename.search(/\S/)==-1){
				alert("�������µ��ļ�(���ļ���)����.");
				return;
			}
			if(!pattern.test(filename)){
				alert("�������ҳ�ļ���׺��ֻ��Ϊhtml|htm|jsp!");
				return;
			}
		}
	}
	
	document.form1.action = "reNameWebprj_do.jsp?viewtype=<%=viewtype%>";
	document.form1.submit();
}
</script>
</head>
<body>
<form action="reName_do.jsp" method="post" name="form1" target="hidFrm">
<table width="400" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="300" colspan="2" align="center" valign="middle">
		<table width="400" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="25" align="right" valign="middle">ԭ���ļ�(��)��:</td>
				<td height="25" align="left" valign="middle"><%=tempuri%></td>
			</tr>
			<tr>
				<td height="25" align="right" valign="middle">���ļ�(��)��:</td>
				<td height="25" align="left" valign="middle"><input name="fileName" type="text" id="fileName">
						<input name="uri" type="hidden" id="uri" value="<%=(uri==null?"":uri)%>">
						<input name="oldFileName" type="hidden" id="oldFileName" value="<%=tempuri%>">
						<input type="button" class="cms_button" name="Submit" value="ȷ��" onClick="reName()">
						<input type="button" class="cms_button" name="quxiao" value="ȡ��" onClick="window.close()">
				</td>
			</tr>
		</table></td>
		</tr>
</table>
</form>
<iframe id="hidFrm" name="hidFrm" style="display:none"></iframe>
</body>
</html>
