<%@ page contentType="text/html; charset=GBK" language="java"
	import="java.util.List"%>
<%@ page
	import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.documentmanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*,java.util.List"%>
<%@ page
	import="com.chinacreator.cms.container.Template,com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.docsourcemanager.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String channelname = request.getParameter("channelName");
	String siteid = request.getParameter("siteid");
	String channelId = request.getParameter("channelId");
	SiteManager siteManager = new SiteManagerImpl();
	String sitename = siteManager.getSiteInfo(siteid).getName();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>���ݹ��������</title>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript"
			src="../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
		<script type="text/javascript" src="../../public/datetime/calender.js"
			language="javascript"></script>
		<script type="text/javascript"
			src="../../public/datetime/calender_date.js" language="javascript"></script>
		<script language="javascript"><!--
		function queryUser()
		{	
			//��ѯ
			if(validate()){
				form1.action="<%=rootpath%>/cms/docManage/doc_list.jsp?flag=query&siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>"
				form1.target="forDocList";
				form1.submit();	
			}
		}
		function queryUserAll()
		{	//��ѯ����
			form1.action="<%=rootpath%>/cms/docManage/doc_list.jsp?siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>"
			form1.target="forDocList";
			form1.submit();	
		}
		//Ĭ�Ϲ��ͣ�����ĵ����������
		function document.onreadystatechange(){
			if (document.readyState!="complete") return;
			document.all.form1.title.focus();
		}
		function validate(){
			if(form1.all.createTimeBegin.value != "" && form1.all.createTimeEnd.value != "" && form1.all.createTimeBegin.value > form1.all.createTimeEnd.value){
				alert("����ʱ����������ʼʱ��");
				return false;
			}
			return true;
		}
		function commonQuery(){	
			form1.action="<%=rootpath%>/cms/docManage/queryFrame.jsp?siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>"
			form1.target="forQuery";
			form1.submit();	
		}
--></script>
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
	<body leftmargin="0" topmargin="0" rightmargin="0">
		<form id="form1" name="form1" method="post" action="">
			<table width="100%" height="100%" border="0" cellpadding="0"
				align="center" cellspacing="0">
				<tr>
					<td width="5" valign="top" bgcolor="#ffffff">
						<img src="../images/querybox_left.gif" width="5" height="62">
					</td>
					<td style="background: url(../images/querybox_bg.gif) repeat-x top">
						<table width="100%" border="0" cellpadding="4" cellspacing="0">
							<tr>
								<td height="23">
									&nbsp; ��ǰλ��:
									<%=sitename%>
									վ�� >>
									<%=channelname%>
									Ƶ��
								</td>
								<td align="right" nowrap="nowrap">
									<a style="cursor: hand; color: '#9A2F2F'; padding-top: 5px"
										class="cms_button" onClick="commonQuery()">��ͨ��ѯ</a>
								<td>
							</tr>
						</table>

						<table width="100%" border="0" align="center" cellpadding="2"
							cellspacing="0" class="query_table">
							<tr>
								<td height='24' align="right">
									�� �� �� �� ��
								</td>
								<td height='0' align="left" valign='middle'>
									<div align="left">
										<input name="title" type="text" size="16" class="cms_text">
									</div>
								</td>
								<td height='0' align="right">
									�� �� �ˣ�
								</td>
								<td height='0' align="left" valign='middle'>
									<select name="userid" class="cms_select" style="width: 118">
										<option value="">
											--��ѡ�񷢸���--
										</option>
										<%
											List list = null;
											DocumentManager dmi = new DocumentManagerImpl();
											list = dmi.getDistributeList(channelId);
											request.setAttribute("dblist", list);
										%>
										<pg:list requestKey="dblist">
											<option value="<pg:cell colName="user_id"/>">
												<pg:cell colName="user_name" />
										</pg:list>
									</select>
								</td>
								<td height='0' align="right">
									�� &nbsp;&nbsp;&nbsp;�ߣ�
								</td>
								<td height='0' align="left" valign='middle'>
									<input name="author" type="text" size="16" class="cms_text">
								</td>
								<td rowspan="3" align="left" valign='middle'></td>
							</tr>
							<tr>
								<td height='24' align="right">
									�� �� ״ ̬ ��
								</td>
								<td height='0' align="left" valign='middle'>
									<select name="status" class="cms_select" style="width: 107">
										<option value="">
											--��ѡ��״̬--
										</option>
										<%
											List statuslist = dmi.getStatusList();
											request.setAttribute("dslist", statuslist);
										%>
										<pg:list requestKey="dslist">
											<option value="<pg:cell colName="status_id"/>">
												<pg:cell colName="status_name" />
										</pg:list>
									</select>
								</td>
								<td height='0' align="right">
									�ĵ����ͣ�
								</td>
								<td height='0' align="center" valign='middle'>
									<div align="left">
										<select name="doctype" class="cms_select" style="width: 118">
											<option value="">
												--��ѡ������--
											</option>
											<option value="0">
												��ͨ�ĵ�
											</option>
											<option value="1">
												�ⲿ����
											</option>
											<option value="3">
												�ۺ��ĵ�
											</option>
										</select>
									</div>
								</td>
								<td height='0' align="right">
									ժ &nbsp;&nbsp;&nbsp;Ҫ��
								</td>
								<td height='0' align="left" valign='middle'>
									<input name="docAbstract" type="text" size="16"
										class="cms_text">
								</td>
							</tr>
							<tr>
								<td height='24' align="right">
									�� �� �� Դ ��
								</td>
								<td align="left" valign='middle'>
									<span class="cms_title_blue"> <select name="docsorid"
											class="cms_select" style="width: 107">
											<option value="">
												--��ѡ����Դ--
											</option>
											<%
												List dslist = null;
												dslist = dmi.getDocSourceList();
												request.setAttribute("dslist", dslist);
											%>
											<pg:list requestKey="dslist">
												<option value="<pg:cell colName="srcname"/>">
													<pg:cell colName="srcname" />
											</pg:list>
										</select> </span>
								</td>
								<td align="right">
									��&nbsp;��&nbsp;�ʣ�
								</td>
								<td align="left" valign='middle'>
									<input name="keyword" type="text" size="18" class="cms_text">
								</td>
								<td align="right">
									�ĵ����ݣ�
								</td>
								<td align="left" valign='middle'>
									<input name="content" type="text" size="16" class="cms_text">
								</td>

							</tr>
							<tr>
								<td width="0" height='24' align="right">
									׫д��ʼʱ�̣�
								</td>
								<td width="0" height='0' align="left" valign='middle'>
									<input name="createTimeBegin" type="text" size="16"
										class="cms_text">
									<input name="button" type="button"
										onClick="showdate(document.all('createTimeBegin'))"
										value="..." />
									<!--									  			<input name="button3" type="button" onClick="selectTime('form1.createTimeBegin',0)" value=".">											-->
								</td>
								<td width="0" height='0' align="right">
									����ʱ�̣�
								</td>
								<td width="0" height='0' align="left" valign='middle'>
									<input name="createTimeEnd" type="text" size="18"
										class="cms_text">
									<input name="button" type="button"
										onClick="showdate(document.all('createTimeEnd'))" value="..." />
									<!--							      	      		<input name="button" type="button" onClick="selectTime('form1.createTimeEnd',0)" value=".">											-->
								</td>
								<td width="0" height='0' align="right">
									�ĵ�����
								</td>
								<td width="0" height="0">
									<select name="docLevel" class="cms_select" style="width: 107">
										<option value="">
											--��ѡ�񼶱�--
										</option>
										<%
											List doclevellist = null;
											doclevellist = dmi.getDocLevelList();
											request.setAttribute("doclevellist", doclevellist);
										%>
										<pg:list requestKey="doclevellist">
											<option value="<pg:cell colName="id"/>">
												<pg:cell colName="name" />
										</pg:list>
									</select>
								</td>
							</tr>

							<tr>
								<td height='24' align="right">
									�� �� ״ ̬ ��
								</td>
								<td align="left" valign='middle'>
									<span class="cms_title_blue"> <select name="iscomment"
											class="cms_select" style="width: 140">
											<option value="">
												--��ѡ��--
											</option>
											<option value="0">
												��ͨ
											</option>
											<option value="1">
												�ر�
											</option>
										</select> </span>
								</td>
								<td colspan="5" align="right" valign='middle'>
									<div align="right">
										<input name="search" type="button" class="cms_button"
											value="��ѯ" onClick="queryUser()">
										<input name="searchall" type="button" class="cms_button"
											value="��ʾ����" onClick="queryUserAll()">
										<input name="reset" type="reset" class="cms_button" value="����">
									</div>
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


