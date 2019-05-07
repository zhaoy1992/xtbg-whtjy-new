<%@ page contentType="text/html; charset=GBK" language="java"
	import="java.util.List"%>
<%@ page
	import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.documentmanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page
	import="com.chinacreator.security.*,com.chinacreator.cms.flowmanager.*,com.chinacreator.cms.channelmanager.*"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();

	com.chinacreator.cms.CMSManager cmsManager = new com.chinacreator.cms.CMSManager();
	cmsManager.init(request, session, response, accesscontroler);
	String currentSiteid = cmsManager.getSiteID();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>�鵵�ĵ���ѯ</title>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js"
			type="text/javascript"></script>
		<script language="javascript">
	function queryUser()
	{	
		//��ѯ
		form1.action = "<%=rootpath%>/cms/docManage/garbageListFrame.jsp?flag=query";
		form1.target = "garbageListFrame";
		form1.submit();	
	}
	function queryUserAll()
	{	
		//��ѯ����
		form1.action = "<%=rootpath%>/cms/docManage/garbageListFrame.jsp";
		form1.target = "garbageListFrame";
		form1.submit();
		form1.reset();	
	}
	//Ĭ�Ϲ��ͣ�����ĵ����������
	function document.onreadystatechange(){
		if (document.readyState!="complete") return;
		document.all.form1.title.focus();
	}
	function selChnl(){
		var reVlaue = openWin('multi_channel_select_frame.jsp?siteid=<%=currentSiteid%>',400,500);	
		if(reVlaue != undefined){
			document.all.channelNames.value = reVlaue.split(":")[0];
			document.all.channelIds.value = reVlaue.split(":")[1];
		}
	}
	function toEmpty(){
	document.form1.title.value="";
	document.form1.flowId.value="";
	document.form1.preStatus.value="";
	<%
	if (accesscontroler.isAdmin()) {
	%>
	document.form1.garbager.value="";
	<%}%>
	document.form1.channelNames.value="";
	}
</script>
		<style type="text/css">
body {
	background-color: #ffffff;
}

.STYLE1 {
	color: #0000FF
}

.STYLE2 {
	color: #000099
}

.style3 {
	font-size: 14px;
	font-weight: bold;
	color: #3300FF;
}

.operStyle {
	width: 17;
	height: 16;
}
</style>
	</head>
	<body topmargin="1" rightmargin="1" scroll=no leftmargin="1">
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
								<td colspan="7" height="40">
									&nbsp; ��ǰλ�ã�����վ&nbsp; >> &nbsp;���չ���
								</td>
							</tr>
							<tr>
								<td align="right">
									�ĵ����⣺
								</td>
								<td>
									<input name="title" type="text" size="16" class="cms_text">
								</td>
								<td align="right">
									�ĵ����̣�
								</td>
								<td align="left">
									<select name="flowId" class="cms_select" style="width: 107">
										<option value="">
											--��ѡ������--
										</option>
										<%
											FlowManager fm = new FlowManagerImpl();
											List flowlist = fm.getFlowList2();
											request.setAttribute("dslist", flowlist);
										%>
										<pg:list requestKey="dslist">
											<option value="<pg:cell colName="flowid"/>">
												<pg:cell colName="flowName" />
										</pg:list>
									</select>
								</td>
								<td align="right">
									ǰһ��״̬��
								</td>
								<td align="left" valign='middle'>
									<select name="preStatus" class="cms_select" style="width: 107">
										<option value="">
											--��ѡ��״̬--
										</option>
										<%
											List list = null;
											DocumentManagerImpl dmi = new DocumentManagerImpl();
											list = dmi.getStatusList();
											request.setAttribute("dslist", list);
										%>
										<pg:list requestKey="dslist">
											<option value="<pg:cell colName="status_id"/>">
												<pg:cell colName="status_name" />
										</pg:list>
									</select>
								</td>
								<%
									if (accesscontroler.isAdmin()) {
								%>
								<td align="right">
									�� �� �ˣ�
								</td>
								<td width="12%" align="left" valign='middle'>
									<select name="garbager" class="cms_select" style="width: 107">
										<option value="">
											-ѡ������-
										</option>
										<option value="1">
											����
										</option>
										<option value="2">
											����
										</option>
									</select>
								</td>
								<%
									} else {
								%>
								<td></td>
								<td></td>
								<%
									}
								%>
							</tr>
							<tr>
								<td align="right">
									����Ƶ����
								</td>
								<td colspan="7" align="left">
									<input name="channelNames" type="text" size="35"
										class="cms_text" disabled="disabled">
									<input name="channelIds" type="hidden" size="16"
										class="cms_text">
									<input name="chnlSel" type="button" onClick="selChnl()"
										value="...">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<input name="search" type="button" class="cms_button"
										value="��ѯ" onClick="queryUser()">
									&nbsp;
									<input name="searchall" type="button" class="cms_button"
										value="��ʾ����" onClick="queryUserAll()">
									&nbsp;
									<input name="searchall" type="button" class="cms_button"
										value="����" onClick="toEmpty()">
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



