<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String docId = request.getParameter("docId");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>���ݹ��������</title>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
		<script type="text/javascript" src="../../public/datetime/calender.js" language="javascript"></script>
		<script type="text/javascript" src="../../public/datetime/calender_date.js" language="javascript"></script>
		<script language="javascript">
			function queryCitedDoc(queryFlag){
				queryForm.action = "<%=rootpath%>/cms/docManage/doc_comment_list.jsp?docId=<%=docId%>&queryFlag="+queryFlag;
				queryForm.target = "docCommentDocListF";
				queryForm.submit();
			}
		</script>
	</head>
	<body leftmargin="0" topmargin="0">
	 <form name="queryForm" method="post">
	 <input type="hidden" name="allComments" id="allComments" value="0"/>
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="5" valign="top"><img src="../images/querybox_left.gif" width="5" height="62"></td>
    <td  style="background:url(../images/querybox_bg.gif) repeat-x top">
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0"  style="margin-top:5px"   class="query_table">
		  <tr>
		  	<td  height="30" align="right">�������ݣ�</td>
			<td><input type="text" name="docComment"  size="18"  class="cms_text"></td>
			<td  height="30" align="right">�û�����</td>
			<td><input type="text" name="userName"  size="18"  class="cms_text"></td>
			<td  height="30" align="right">״̬��</td>
			<td>
				<select name="status" class="cms_select" style="width:120">
					<option value="">--��ѡ��״̬--</option>
					<option value="0">δ��</option>
					<option value="1">�ѷ�</option>
					<option value="2">����</option>
				</select>		
			</td>
		  </tr>
		  <tr>
			<td align="right">����ʱ�俪ʼ��</td>
			<td>
				<input type="text" name="subTimeBgin"  size="18"  class="cms_text" >
				<input name="button1" type="button" onClick="showdate(document.all('subTimeBgin'))" value="ʱ��" >		
			</td>
			<td align="right">������</td>
			<td>
				<input type="text" name="subTimeEnd"  size="18"  class="cms_text" >
				<input name="button2" type="button" onClick="showdate(document.all('subTimeEnd'))" value="ʱ��">			
			</td>
			<td  height="30" align="right">�ٱ���</td>
			<td>
				<select name="hasImpeach" class="cms_select" style="width:120">
					<option value="">--��ѡ��--</option>
					<option value="0">�޾ٱ�</option>
					<option value="1">�оٱ�</option>
				</select>		
			</td>
		  </tr>
		  <tr>
		  	<td colspan="6" align="right">
				<input type="button" name="query" class = "cms_button" value="��ѯ" onClick="queryCitedDoc('part')">
				<input type="button" name="back" class = "cms_button" value="��ѯ����" onClick="queryCitedDoc('all')">
				<input type="button" name="back" class = "cms_button" value="����" onClick="window.close()">			
			</td>	
		  </tr>
	   </table></td>
    <td width="6" valign="top"><img src="../images/querybox_right.gif" width="6" height="62"></td>
  </tr>
</table>

	 </form>
</body>
</html>
