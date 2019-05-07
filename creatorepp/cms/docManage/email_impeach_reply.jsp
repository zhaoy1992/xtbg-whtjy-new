
<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.bean.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.security.authorization.AuthUser"%>
<%@ page import="com.chinacreator.cms.docCommentManager.*"%>
<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    DocumentManager docManager = new DocumentManagerImpl();
    String toEmail = request.getParameter("email");
    String toName = request.getParameter("toName"); 

    String impeachId = request.getParameter("impeachId");   
    String commentId = request.getParameter("commentId");
    String reasonDsp = request.getParameter("reasonDsp"); 
    System.out.println(reasonDsp);
    DocCommentManager ddm = new DocCommentManagerImpl();
    int  docId = ddm.getCommentByComId(Integer.parseInt(commentId)).getDocId();
    DocumentManager dm = new DocumentManagerImpl();
    String docTitle = dm.getDoc(docId+"").getSubtitle();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>�ٱ��ʼ��ظ�</title>
		<script src="../inc/js/func.js"></script>
		<script language="javascript">
		function sendEmail(){
			myForm.action = "docCommentHandle.jsp?action=emailReply&toEmail=<%=toEmail%>&toName=<%=toName%>&impeacheId=<%=impeachId%>";
			myForm.submit();
		}	
		</script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
	</head>
	<base target="_self">
	<body>
	<form name="myForm" target="docComIframe" method="post">
		<table width="100%" border="0">
		  <tr>
			<td align="left">
				�ظ��ˣ�����Ա
			</td>
		  </tr>
		  <tr>
			<td align="left">
				���⣺<input id="subject" name="subject" value="����<%=docTitle%>�ĵ�������<%=reasonDsp%>����" size="40">
			</td>
		  </tr>
		  <tr>
		  <td align="left">
				�ٱ��ʼ��ظ���Ϣ��
			</td>
		  </tr>
		  <tr>
			<td align="center">
				<textarea name="msg" rows="25" cols="60"></textarea>
			</td>
		  </tr>
		  <tr>
			<td align="center" colspan="2">
				<input name="closewin" type="button" class="cms_button" value="����" onClick="sendEmail()">
				&nbsp;
				<input name="closewin" type="button" class="cms_button" value="����" onClick="window.close()">			
			</td>
		  </tr>
		</table>
	</form>
	<div height="0" width="0" style="display:none">
			<iframe name="docComIframe"></iframe>
	</div>
	</body>
</html>