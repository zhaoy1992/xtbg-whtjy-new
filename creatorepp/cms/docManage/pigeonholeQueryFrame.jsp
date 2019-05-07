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
	DocumentManager docManager = new DocumentManagerImpl();
	String userId = accesscontroler.getUserID();
	String operate = request.getParameter("operate");
	String redict = "";
	String link = "�鵵����";
	if (operate.equals("pigeonholeQuery")) {
		redict = "pigeonholeListFrame.jsp?operate=" + operate;
		link = "�鵵����";
	} else if (operate.equals("toPigeonhole")) {
		redict = "publishedDocListFrame.jsp?operate=" + operate;
		link = "��������";
	}
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
		<script language="JavaScript"
			src="../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
		<script type="text/javascript" src="../../public/datetime/calender.js"
			language="javascript"></script>
		<script type="text/javascript"
			src="../../public/datetime/calender_date.js" language="javascript"></script>
		<script language="javascript">
	function queryUser()
	{	

	var startTime = document.all.startTime.value;
	var endTime = document.all.endTime.value;
	if(endTime.length>0 && startTime.length>0)
	if(endTime<startTime)
	{
		alert("����ʱ�䲻��С�ڿ�ʼʱ��!");
		return false;
	}
	//bug432:����ʱ�䲻��С�ڿ�ʼʱ��,weida

		//��ѯ
		form1.action = "<%=redict%>&flag=query";
		form1.target = "pigeonholeListFrame";
		form1.submit();	
	}
	function queryUserAll()
	{	
		//��ѯ����
		form1.action = "<%=redict%>";
		form1.target = "pigeonholeListFrame";
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
		<%
		if (operate.endsWith("pigeonholeQuery")
		&& (accesscontroler.isAdmin() || docManager
				.isPigeonholeManager(Integer.parseInt(userId)))) {
		%>
		document.form1.pigeonholer.value="";
		<%}%>
		document.form1.startTime.value="";
		document.form1.endTime.value="";
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
				align="center" cellspacing="0">
				<tr>
					<td width="5" valign="top" bgcolor="#ffffff">
						<img src="../images/querybox_left.gif" width="5" height="62">
					</td>
					<td style="background: url(../images/querybox_bg.gif) repeat-x top">
						<table width="100%" border="0" align="center" cellpadding="3"
							cellspacing="0" class="query_table">
							<tr>
								<td colspan="7" height="40">
									&nbsp; ��ǰλ�ã��鵵����&nbsp; >> &nbsp;<%=link%>
								</td>
							</tr>
							<tr>
								<td height='30' align="right">
									�ĵ����⣺
								</td>
								<td height='30' align="left" valign='middle'>
									<input name="title" type="text" size="16" class="cms_text">
								</td>
								<td height='30' align="center">
									�ĵ����̣�
								</td>
								<td height='30' align="left" valign='middle'>
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
											<option
												value="<pg:cell colName="flowid"/>                    
                                    ">
												<pg:cell colName="flowName" />
										</pg:list>
									</select>
								</td>
								<%
									if (operate.endsWith("pigeonholeQuery")
											&& (accesscontroler.isAdmin() || docManager
													.isPigeonholeManager(Integer.parseInt(userId)))) {
								%>
								<td height='30' align="right" valign='middle'>
									�� �� �ˣ�
								</td>
								<td height='30' align="left" valign='middle'>
									<select name="pigeonholer" class="cms_select" style="width: 90">
										<option value="">
											-ѡ�鵵��-
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
									}
								%>
							</tr>
							<tr>
								<td height="30" align="right" valign="middle">
									��ʼʱ�䣺
								</td>
								<td align="left" valign='middle'>
									<input name="startTime" type="text" size="16" class="cms_text">
									<input name="button" type="button"
										onClick="showdate(document.all('startTime'))" value="..." />
								</td>
								<td height="30" align="right" valign="middle">
									����ʱ�䣺
								</td>
								<td align="left" valign='middle'>
									<input name="endTime" type="text" size="16" class="cms_text">
									<input name="button" type="button"
										onClick="showdate(document.all('endTime'))" value="..." />
								</td>
								<td height='30' colspan=3 valign='bottom'>
								</td>
							</tr>
							<tr>
								<td height='30' align="right" valign='middle'>
									����Ƶ����
								</td>
								<td height='30' align="left" colspan="5" valign='middle'>
									<input name="channelNames" type="text" size="60"
										class="cms_text" disabled="disabled">
									<input name="channelIds" type="hidden" size="16"
										class="cms_text">
									<input name="chnlSel" type="button" onClick="selChnl()"
										value="...">
									&nbsp;&nbsp;
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



