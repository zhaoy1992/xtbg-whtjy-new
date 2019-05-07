<%@page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String operName = accesscontroler.getUserName();

			DocumentManager dm = new DocumentManagerImpl();
			String userid = accesscontroler.getUserID();
			String docidStr = request.getParameter("docidStr");

			String docTitles = "";
			//�õ��ĵ�id����,Ϊ�ַ�������
			if (docidStr != null) {
				String[] docid = docidStr.split(":");
				for (int i = 0; i < docid.length; i++) {
					docTitles = docTitles + dm.getDoc(docid[i]).getSubtitle()
							+ ";";
				}
			}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>�汾ע��</title>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="javascript">
			function sub(){
				addverLableForm.action="add_doc_version_handle.jsp?docidStr=<%=docidStr%>";
				addverLableForm.target="verCommentFrame";
				addverLableForm.submit();
			}
		</script>
	</head>
	<body scroll=no leftmargin=0>
		<form action="" method="post" name="addverLableForm">
			<table width="100%" height="100%" border="0" align="center" bgcolor="#FFFFFF">
				<tr>
					<td align="left" height="20">
						�ĵ����⣺
						<input value=<%=docTitles%> disabled type="text" name="docTitles" size="40">
					</td>
				</tr>
				<tr>
					<td align="left" height="20">
						�汾��ǩ��
						<input  type="text" name="verLable" size="40">
					</td>
				</tr>
				<tr>
					<td align="left" height="20">
						 �汾ע�ͣ�
					</td>
				</tr>
				<tr>
					<td align="center" height="150">
						<textarea name="verComment" cols="55" rows="20"></textarea>
					</td>
				</tr>
				<tr>
					<td align="left" height="20">
						�����ˣ�<%=operName%>
					</td>
				</tr>
				<tr>
					<td align="center">
						<input type="button" name="subButton" value="ȷ��" onClick="sub()">
						<input type="button" name="cnlButton" value="����" onClick="window.close()">
					</td>
				</tr>
			</table>	
		</form>
	</body>
	<div style="display:none" height=0 width=0>
		<iframe name="verCommentFrame"></iframe>
	</div>
</html>