<%@ page contentType="text/html; charset=GBK" language="java"
	import="java.util.List"%>
<%@page import="com.chinacreator.cms.flowmanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page
	import="com.chinacreator.security.*,com.chinacreator.cms.documentmanager.*,com.chinacreator.cms.channelmanager.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>���ݹ��������</title>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
		<script type="text/javascript" src="../../public/datetime/calender.js"
			language="javascript"></script>
		<script type="text/javascript"
			src="../../public/datetime/calender_date.js" language="javascript"></script>
		<script language="javascript">
			function subQuery(){
				form1.action = "docPublishingList.jsp?flag=query";
				form1.target = "docPublishingListF";
				form1.submit();
			}
			function dispalyAll(){
				form1.action = "docPublishingList.jsp?flag=all";
				form1.target = "docPublishingListF";
				form1.submit();
				form1.reset();
			}
			function selChnl(){
				var reVlaue = openWin("multi_channel_select_frame.jsp?taskType=publish&siteid=",400,500);	
				if(reVlaue != undefined){
					document.all.channelNames.value = reVlaue.split(":")[0];
					document.all.channelIds.value = reVlaue.split(":")[1];
				}
			}
			function toempty(){
				document.form1.docTitle.value="";
				document.form1.publisher.value="";
				document.form1.channelNames.value="";
			}
		</script>
		<style type="text/css">
body {
	background-color: #ffffff;
}
</style>
	</head>
	<body topmargin="0" rightmargin="1" scroll=no leftmargin="1">
		<form id="form1" name="form1" method="post" action="">
			<table width="100%" height="100%" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="5" valign="top" bgcolor="#ffffff">
						<img src="../images/querybox_left.gif" width="5" height="62">
					</td>
					<td style="background: url(../images/querybox_bg.gif) repeat-x top">
						<table width="100%" border="0" align="center" cellpadding="3"
							cellspacing="0" class="query_table">
							<tr>
								<td height="60%" colspan="4">
								<td width="245">
							</tr>
							<tr>
								<td height="23" colspan="7">
									&nbsp; ��ǰλ��:���˹���̨ &nbsp;>> &nbsp;�������ĵ�
								</td>
							</tr>
							<tr>
								<td width="87" align="right">
									�ĵ����⣺
								</td>
								<td width="171" align="left" valign='middle'>
									<input name="docTitle" type="text" size="24" class="cms_text">
								</td>
								<td width="76" align="right">
									�����ˣ�
								</td>
								<td width="167" align="left" valign='middle'>
									<input name="publisher" type="text" size="20" class="cms_text">
							</tr>

							<tr>
								<td align="right" valign='middle'>
									����Ƶ����
								</td>
								<td align="left" colspan=3 valign='middle'>
									<input name="channelNames" type="text" size="40"
										class="cms_text" disabled="disabled">
									<input name="channelIds" type="hidden" size="16"
										class="cms_text">
									<input name="chnlSel" type="button" onClick="selChnl()"
										value="...">
								</td>
								<td rowspan="2" valign="bottom">
									<input name="subButton1" type="button" class="cms_button"
										value="��ѯ" onClick="subQuery()">
									&nbsp;
									<input name="subButton2" type="button" class="cms_button"
										value="��ѯ����" onClick="dispalyAll()">
									&nbsp;
									<input name="subButton2" type="button" class="cms_button"
										value="����" onClick="toempty()">	
								</td>
							</tr>
						</table>
					</td>
					<td width="6" valign="top" bgcolor="#ffffff">
						<img src="../images/querybox_right.gif" width="6" height="62">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>