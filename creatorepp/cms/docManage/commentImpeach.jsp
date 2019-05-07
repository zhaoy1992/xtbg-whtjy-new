<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.docCommentManager.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%	
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	String commentId = request.getParameter("commentId");
	
	DocCommentManager ddm = new DocCommentManagerImpl();
	DocComment comment = new DocComment();
	comment = ddm.getCommentByComId(Integer.parseInt(commentId.trim()));
	String docComment = comment.getComment();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<title>�ٱ���Ϣ����</title>
	<script src="../inc/js/func.js"></script>
	<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
	<link href="inc/css/cms.css" rel="stylesheet" type="text/css">
	<style type="text/css">
		.STYLE1 {color: blue}
	</style>
	<script language="javascript">
		function sub(){
			if(myForm.impeacher.value==""){
				alert("������д������");
				return;
			}
			var flag = false;
			var radios = document.getElementsByName("reason");
			for(var i=0;i<radios.length;i++){
				if(radios[i].checked)
					flag = true;
			}
			if(flag == false){
				alert("����ѡ��ٱ�ԭ��");
				return;
			}
			if(myForm.email.value!="" && myForm.email.value.search(/\w*@w*/i)==-1){
				alert("������д��ȷ�����䣬�Ա�����������ϵ��");
				return;	
			}
			myForm.action="addImpeachHandleDefault.jsp?commentId=<%=commentId%>";
			myForm.submit();		
		}
	</script>
</head>
<body scroll=no leftmargin=0>
	<form method="post" target="addCommentIframe" name="myForm">
		<table width="90%"  align="center">
		  <tr>
		  	<td colspan="8">			��л���������ǽ��в�����Ϣ��������������ǽ�������ϸ�Ĵ������ύ�����ݡ�����������������з�����ɫ�顢����������һЩΥ������ݣ�����д����ı����������ǣ����ڴ˱���д����ϸ��Ϣ���������Ǹ��õĽ��в�֤������			</td>
		  </tr>
		  <tr>
		  	<td colspan="8" style="word-break:break-all;word-wrap:break-word;">����:<br>&nbsp;&nbsp;<%=docComment.length()>200?docComment.substring(0,200)+"...":docComment%></td>
		  </tr>
		  <tr>
			<td width="14%">��������:</td>
			<td width="44%"><input type="text" name="impeacher" size="15"></td>
			<td width="42%"><font color="#FF0000">����</font></td>
		  </tr>
		  <tr>
			<td width="14%">��������:</td>
			<td width="44%"><input type="text" name="email" size="15"></td>
			<td width="42%">��д�����Ա����Ǹ�����ϵ��</td>
		  </tr>
		  <tr>
			<td width="14%">�ٱ�ԭ��:</td>
			<td width="44%">
							<input type="radio" name="reason" id="reason" value="0">����
							<input type="radio" name="reason" id="reason" value="1">ɫ��
							<input type="radio" name="reason" id="reason" value="2">����
							<input type="radio" name="reason" id="reason" value="3">��Ȩ
			<input type="radio" name="reason" id="reason"  value="4">����			</td>
			<td width="42%"><font color="#FF0000">��ѡ</font></td>
		  </tr>
		  <tr>
		  	<td>�ٱ�������</td>
			<td colspan="5" height="100" align="left"><textarea style="width:100%; height:100;" name="description"></textarea></td>
		  </tr>
		  <tr>
			<td colspan="5" align="center">
				<input type="button" name="button" onClick="sub()"  class = "cms_button" value="�ύ">&nbsp;
				<input type="button" name="button" onClick="window.close()"  class = "cms_button" value="ȡ��">			</td>
		  </tr>
		</table>
	</form>
	<div height=0 width=0 style="display:none">
		<iframe name="addCommentIframe"></iframe>
	</div>
</body>
</html>