<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", -1);
	response.setDateHeader("max-age", 0);

%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>ģ�����</title>
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<script src="../inc/js/func.js"></script>

	<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url(../images/grayline_bg.jpg);
}
.topDIV {
	background-image: url(../images/toolbar_common_func_template.jpg);
	height:82px;
}
.btDIV{
	padding-top: 7px;
	padding-left: 55px;
	height:22px;
}
.anniuDIV{
	height:60px;
	padding-bottom: 8px;
}

</style>
<script language="javascript">
var tplNavFrame = null; //Navigator���
var tplTagFrame = null; //ģ���ǩ�����
var openWin = window.dialogArguments;
//�ύform�����һ��ģ��
function addTpl(){
	var openWin = window.dialogArguments;
	document.all.addTpltForm.save.blur();
	document.all.addTpltForm.content2.value = eWebEditor1.getTemplateText();
	document.all.addTpltForm.submit();
}
<%
	String siteId = request.getParameter("siteId");
	String templateId = request.getParameter("templateId");
	try {
		DBUtil conn = new DBUtil();

		String sql = "select TEMPLATE_ID,NAME,DESCRIPTION,"
					+"HEADER,TEXT,TYPE from td_cms_template where template_id ='"+templateId+"'";

		conn.executeSelect(sql);
		if (conn.size()>0){
			pageContext.setAttribute("templateId",""+conn.getInt(0,"template_id"));
			pageContext.setAttribute("name",conn.getString(0,"name"));
			pageContext.setAttribute("type",""+conn.getInt(0,"type"));			
			pageContext.setAttribute("description",conn.getString(0,"description").replaceAll("\"","&quot;"));
			pageContext.setAttribute("header",conn.getString(0,"header").replaceAll("\"","&quot;"));
			pageContext.setAttribute("text",conn.getString(0,"text").replaceAll("\"","&quot;"));
		}else{
			out.println("alert('�������ģ��id["+templateId+"],û��ȡ��ģ����Ϣ��,�޷��༭ģ��');");
			out.println("top.close();");
		}
	} catch (Exception e) {
		e.printStackTrace();
		out.println("alert('�������ģ��id["+templateId+"]ȡģ����Ϣ�����쳣,�޷��༭ģ��');");
		out.println("top.close();");
	}
%>
</script>
</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="topDIV">
		<tr>
			<td class="btDIV">
				�༭ģ��
			</td>
		</tr>
		<tr>
			<td align="right" valign="bottom" class="anniuDIV">
				<form action="template_createdo.jsp" method="post"
					name="addTpltForm" id="addTpltForm" target="blockbox">
					<input type="hidden" name="templateId" id="templateId" value="<%=pageContext.getAttribute("templateId")%>"/>
					<input type="hidden" name="templateName" id="templateName"  value="<%=pageContext.getAttribute("name")%>"/>
					<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
					<input type="hidden" name="templateType" id="templateType" value="<%=pageContext.getAttribute("type")%>"/>
					<input type="hidden" name="templateDesc" id="templateDesc" value="<%=pageContext.getAttribute("description")%>"/>
					<input type="hidden" name="tb_templateHead" id="tb_templateHead" value="<%=pageContext.getAttribute("header")%>"/>
					<input type="hidden" name="content2" id="content2" value="" />
					<input type="button" class="cms_button" id="save" onClick="addTpl()"
						class="cms_button" value="����" />
					&nbsp;
					<input type="button" class="cms_button" class="cms_button" onClick="window.close()"
						value="�ر�" />
				</form>

			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="20" align="left">
				ģ������:
			</td>
			<td height="600" rowspan="2">
				<iframe id="template_navigator" frameborder="0" width="234"
					src="template_navigator_edit.jsp" height="100%"></iframe>
			</td>
		</tr>
		<tr>
			<td height="580" align="right">
				<form id="form2" name="form2">

					<input type="hidden" name="content" id="content"  value="<%=pageContext.getAttribute("text")%>">
					<input type="hidden" name="siteId" id="siteId"
						value="<%=siteId%>">
					<iframe id="eWebEditor1" src="eWebeditor/eWebEditor.jsp?id=content&style=standard&siteId=<%=siteId%>"
						frameborder="0" scrolling="no" width="766" height="100%"></iframe>
				</form>
			</td>
		</tr>
	</table>
	<iframe id="blockbox" name="blockbox" style="display:none"></iframe>
</body>
</html>
