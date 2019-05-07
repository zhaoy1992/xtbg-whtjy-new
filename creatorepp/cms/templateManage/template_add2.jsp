<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.templatemanager.TemplateStyleManager" %>
<%@ page import="com.chinacreator.cms.templatemanager.TemplateStyleManagerImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.chinacreator.cms.templatemanager.TemplateStyleInfo" %>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", -1);
	response.setDateHeader("max-age", 0);
%>
<html>
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>
<style type="text/css">
<!--
.STYLE5 {color: #486086; font-weight:bold}
-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ģ�嵼��</title>
</head>
<script language="javascript">

function submitForm(){
	var f = document.all.TemplateForm;
	var action = "template_add2_do.jsp?siteId=<%=request.getParameter("siteId")%>";
	var templateName = f.templateName.value;
	if(templateName.replace(/\s/ig,"")==""){
		alert("������ģ����.");
		return;
	}	
    if(templateName.length>30){
    alert("ģ�����ƹ���!");
    return false;
    }
	var templateDesc = f.templateDesc.value;
	if(templateDesc.replace(/\s/ig,"")==""){
		alert("������ģ��ļ�����.");
		return;
	}
    if(templateDesc.length>30){
    alert("ģ����������!");
    return false;
    }

	var uri = f.uri.value.replace(/\s/ig,"");

	if(uri.search(/\\{2,}/img)!=-1||uri.search(/\/{2,}/img)!=-1||uri.search(/\\\/{1,}/img)!=-1||uri.search(/\/\\{1,}/img)!=-1){
		alert("��������ȷ���൱·��");
		return;
	}
	if(uri.search(/[:\*\?"<>\|]/img)!=-1){
		alert("��������ȷ���൱·��");
		return;
	}
	uri = f.uri.value;
	
	var fileName = f.fileName.value;
	if(fileName.replace(/\s/ig,"")==""){
		alert("��������ģ���ļ�������.");
		return;
	}
	if(fileName.search(/(\.html|\.htm){1}$/img)<=0){
		alert("��ģ���ļ�����չ��������.htm,.html.");
		return;		
	}
    if(fileName.length>30){
    alert("��ģ���ļ������ƹ���!");
    return false;
    }	
	var templateTypes = document.getElementById("templateType");
	var templateType = templateTypes[templateTypes.selectedIndex].value;//ģ�����ͱ��
	var templateStyles = document.getElementById("templateStyle");
	var templateStyle = templateStyles[templateStyles.selectedIndex].value;//ģ������
	
	//ͨ��post�������ļ�һ�𴫹�ȥ�ڷ�������ȡ������
	action = action + "&templateName="+templateName
			+"&templateDesc="+templateDesc
			+"&templateType="+templateType
			+"&uri="+uri
			+"&fileName="+fileName
			+"&templateStyle="+templateStyle;
	f.action=action;
	//alert(f.action);
	f.submit();
}

</script>
<body  bottommargin="0"  bgcolor="#F3F4F9"  rightmargin="0" leftmargin="0" topmargin="0" >
<form method="post" name="TemplateForm" target="hidFrm" id="TemplateFrm">
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
	<tr>
		<td height="82" colspan="4" valign="top" background="../images/toolbar_common_func_template.jpg"><div  class="templateCTitle">ģ�嵼��</div></td>
	</tr>
	<tr >
		<td width="4%">&nbsp;</td>
		<td width="3%" height="20"><img src="../images/ico_point.gif" width="25" height="25"></td>
		<td width="93%" height="20" colspan="2">&nbsp;<span class="cms_title_blue">ģ�������Ϣ</span></td>
	</tr>
	<tr>
		<td height="8" colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="1"  class="Templateedittable">
				<tr>
					<td width="140" height="25" align="right" nowrap bgcolor="F3F4F9" class="STYLE5">ģ������:</td>
					<td>
						<input name="templateName" type="text" class="cms_text" id="templateName" size="48" />
						<span class="red_star">*</span>					</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap bgcolor="F3F4F9" class="STYLE5">ģ������:</td>
					<td>
						<input name="templateDesc" type="text" class="cms_text" id="templateDesc" size="48" />
						<span class="red_star">*</span>					</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap bgcolor="F3F4F9" class="STYLE5">&nbsp;ģ������:</td>
					<td><select name="templateType" style="width:54" class="cms_select" id="templateType">
							<option value="0">��ҳ</option>
							<option value="1" selected>����</option>
							<option value="2">ϸ��</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap bgcolor="F3F4F9" class="STYLE5">&nbsp;ģ����:</td>
					<td>
					<select name="templateStyle" class="cms_select" id="templateStyle" >
						<%
							TemplateStyleManager tsm = new TemplateStyleManagerImpl();
							List list = tsm.getAllTemplateStyleIdAndName();
							for(int i=0;i<list.size();i++){
								TemplateStyleInfo tsi = (TemplateStyleInfo)list.get(i);
						%>
								<option value="<%= tsi.getStyleId() %>"><%= tsi.getStyleName() %></option>
						<%
							}
						%>
					</select>
					</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap bgcolor="F3F4F9" class="STYLE5">����ģ���ŵ�·��:</td>
					<td>
						<input name="uri" type="text" id="uri" size="20" maxlength="40"  class="cms_text">
					</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap bgcolor="F3F4F9" class="STYLE5">ģ���ļ�������:</td>
					<td>
						<input name="fileName" type="text" id="fileName" size="20" maxlength="40"  class="cms_text">
						<span class="red_star">*</span>(��index.html)&nbsp;<input type="checkbox" id="coverFlag" name="coverFlag">&nbsp;���������ļ�</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap bgcolor="F3F4F9" class="STYLE5">ģ�������:</td>
					<td><textarea name="content" cols="130" rows="30" id="content"></textarea></td>
				</tr>					
				<tr align="center">
					<td height="22" colspan="2">
						<input name="btn_ok" type="button" class="cms_button"  value="ȷ��" onClick="submitForm()"/>
						<input name="btn_close" type="button" class="cms_button"  onclick="window.close();" value="�ر�" />
					</td>
				</tr>
		  </table>
		</td>
	</tr>
</table>
</form>
<iframe id="hidFrm" name="hidFrm" style="display:none"></iframe>
</body>
</html>
