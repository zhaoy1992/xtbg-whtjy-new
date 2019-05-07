<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>�û��������Ϣ</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">

		<script language="javascript">
			function loadPage() {
				var form = document.forms[0];
				var act = form.action.value;

				if (act == 2) {
					form.groupId.value = "";
					form.groupName.value = "";
					form.groupDesc.value = "";
				}
				
				if (act == 1 || act == 2) {
					getNavigatorContent().location.href="../groupList.do";
				}

				form.action.value = 0;
			}
		</script>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="loadPage();">
		<div id="contentborder" align="center">
			<form action="">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="2">
					<tr>
						<td width="16%" height="25" class="detailtitle">
							<P align="center">
								<STRONG>�û������ƣ�</STRONG>
							</P>
						</td>
						<td width="907" height="25">
							<input type="text" name="groupName" style="width:30%">
							<input name="b1" type="submit" class="input" value="��ѯ">
						</td>
					</tr>
				</table>

				<hr width="98%">

				<table width="100%" cellpadding="1" cellspacing="1">
					<tr>
						<td class="detailtitle" align=center colspan=4>
							<b>��֯�б�</b>
						</td>
					</tr>
					<pg:listdata dataInfo="GroupList" keyName="GroupList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="5" scope="request" data="GroupList" isList="false">
						<tr>
							<!--���÷�ҳ��ͷ-->
							<pg:header>
								<pg:title title="�û�������" />
								<pg:title title="�û�������" />
							</pg:header>
						</tr>
						<pg:param name="orgName" />
						<pg:param name="code" />
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height="18px">
								<td colspan=100 align='center'>
									��ʱû���û���
								</td>
							</tr>
						</pg:notify>

						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<tr height="18px">
								<td align=center class="detailcontent">
									<pg:cell colName="groupName" defaultValue="" />
								</td>
								<td align=center class="detailcontent">
									<pg:cell colName="groupDesc" defaultValue="" />
								</td>
							</tr>
						</pg:list>
						<tr height="18px">
							<td colspan=100 align='center' class="detailcontent">
								<pg:index />
								<input type="hidden" name="queryString" value="<pg:querystring/>">
							</td>
						</tr>
					</pg:pager>
				</table>
			</form>
			<p></p>
		</div>
<%@ include file="../sysMsg.jsp"%>
	</body>
</html>
