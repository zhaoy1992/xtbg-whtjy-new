<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.CMSManager"%>
<%@ page import="com.chinacreator.cms.templatemanager.*" %>
<%@ page import="java.util.List" %>

<%
	
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", -1);
	response.setDateHeader("max-age", 0);
	CMSManager cmsmanager = new CMSManager();
	cmsmanager.init(request,session,response,control);
	String siteId =  cmsmanager.getSiteID();
	//��ѡ�е�ģ���ļ�
	String filename = request.getParameter("filename");	
	String impfile = request.getParameter("impfile");
	String htmlfile = request.getParameter("htmlfile");
	String tmplzipname = request.getParameter("tmplzipname");
	impfile = impfile==null?"":impfile;
	htmlfile = htmlfile==null?"":htmlfile;
	tmplzipname = tmplzipname==null?"":tmplzipname;
	siteId = siteId==null?"":siteId;
	filename = filename==null?"":filename;
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
<title>ģ��������Ϣ</title>
</head>
<base target="_self">
<script language="javascript">
function submitForm(){
	var f = document.all.TemplateForm;
	var actionstr = "import_template_prepare.jsp?siteId=<%=siteId%>&tmplzipname=<%=tmplzipname%>";
	var templateName = f.templateName.value;
	if(templateName.replace(/\s/ig,"")==""){
		alert("������ģ����.");
		return;
	}	

	var templateDesc = f.templateDesc.value;
	if(templateDesc.replace(/\s/ig,"")==""){
		alert("������ģ��ļ�����.");
		return;
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
		alert("��ѡ����ߵ�ģ���ļ�����!");
		return;
	}

	if(fileName.search(/(\.html|\.htm){1}$/img)<=0){
		alert("��ģ���ļ�����չ��������.htm,.html.");
		return;		
	}
	
	//document.all("divProcessing").style.display = "";
	var templateType = f.templateType[f.templateType.selectedIndex].value;
	//ͨ��post�������ļ�һ�𴫹�ȥ�ڷ�������ȡ������
	actionstr = actionstr + "&templateName="+templateName
			+"&templateDesc="+templateDesc
			+"&templateType="+templateType
			+"&uri="+uri
			+"&fileName="+fileName
			+"&action=import"
			+"&repeatTmplName="+getRadioValue("repeatTmplName")
			+"&repeatTmplAtt="+getRadioValue("repeatTmplAtt");
	f.action=actionstr;
	
	f.submit();
}
function previous(){
    window.returnValue = "previous";
    window.close();
}
function getRadioValue(radioName){
    var radioValue = "";
    var arr = new Array();
    arr = document.all(radioName);
    for(var i=0;i<arr.length;i++){
        if(arr[i].checked){
            radioValue = arr[i].localvalue;
            break;
        }   
    }
    return radioValue;
}
    
</script>
<body  bottommargin="0"  bgcolor="#F3F4F9" rightmargin="0" leftmargin="0" topmargin="0">
<form method="post"  name="TemplateForm"  id="TemplateFrm">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="77" colspan="4" valign="top" background="../images/toolbar_common_func_template.jpg"><div class="templateCTitle">ģ�嵼��</div></td>
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
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="140" height="25" align="right" nowrap class="STYLE5">ģ������:</td>
					<td>
						<input name="templateName" type="text" class="cms_text" id="templateName" size="48" />
						<span class="red_star">*</span>
					</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap class="STYLE5">ģ������:</td>
					<td>
						<input name="templateDesc" type="text" class="cms_text" id="templateDesc" size="48" />
						<span class="red_star">*</span>
					</td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap class="STYLE5">&nbsp;ģ������:</td>
					<td><select name="templateType" class="cms_select" id="templateType">						
						<option value="0">��ҳ</option>
						<option value="1" selected>����</option>
						<option value="2">ϸ��</option>
					</select></td>
				</tr>
				<tr>
					<td width="140" height="25" align="right" nowrap class="STYLE5">&nbsp;ģ����:</td>
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
					<td width="140" height="25" align="right" nowrap class="STYLE5">����ģ���ŵ�·��:</td>
					<td>
						<input name="uri" type="text" id="uri" size="20" maxlength="40"  class="cms_text">
						( <span class="red_star">Ĭ�ϵ����ڸ�Ŀ¼��</span> )
					</td>
				</tr>
				<tr>
					<td width="140" height="25" readonly="true" align="right" nowrap class="STYLE5">��ģ���ļ�������:</td>
					<td>
						<input name="fileName" type="text" id="fileName" readonly="readonly" size="20" maxlength="40"  
								value="<%=filename%>" class="cms_text">
						<span class="red_star">*</span>(��ѡ����ߵ�index.htmlģ���ļ�)
					</td>
				</tr>	
				<tr>
					<td width="140" height="25" readonly="true" align="right" nowrap class="STYLE5">ģ���ظ�:</td>
					<td>
					    &nbsp<INPUT TYPE="radio" NAME="repeatTmplName" localvalue="cover">��������ģ��&nbsp&nbsp
					    <INPUT TYPE="radio" NAME="repeatTmplName" localvalue="rename" checked>����������ģ��
					</td>
				</tr>
				<tr>
					<td width="140" height="25" readonly="true" align="right" nowrap class="STYLE5">ģ�帽���ظ�:</td>
					<td>
						&nbsp<INPUT TYPE="radio" NAME="repeatTmplAtt" localvalue="cover">�������и���&nbsp&nbsp
						<INPUT TYPE="radio" NAME="repeatTmplAtt" localvalue="useold" checked>ʹ�����и���
					</td>
				</tr>
				<tr align="center">
					<td height="22" colspan="2">					    
						<input name="btn_ok" type="button" class="cms_button"  value="����ģ��" onClick="submitForm()"/>
						<input name="btn_close" type="button" class="cms_button"  onclick="window.close();" value="�ر�" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
<div id=divProcessing style="width:200px;height:30px;position:absolute;left:200px;top:330px;display:none">
	<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
	    <tr>
		    <td bgcolor=#3A6EA5>
			    <marquee align="middle" behavior="alternate" scrollamount="5">
				    <font color=#FFFFFF>...������...��ȴ�...</font>
				</marquee>
			</td>
		</tr>
	</table>
</div>

</body>
</html>
