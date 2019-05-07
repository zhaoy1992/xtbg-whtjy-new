<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.*"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String siteId = request.getParameter("siteId");

			com.chinacreator.cms.CMSManager cmsManager = new com.chinacreator.cms.CMSManager();
			cmsManager.init(request, session, response, accesscontroler);
			String currentSiteid = cmsManager.getSiteID();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>ģ���ѯ����ҳ��</title>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
		<script type="text/javascript" src="../../public/datetime/calender_date.js" language="javascript"></script>
		<script language="javascript">
	//����ģ�������� 
	function loadStyle(){
		var styleIFrames = document.getElementsByName("styleIFrame");
		
		styleIFrames[0].src = "templateStyle.jsp?templateType="+document.form1.type.value+"&select_width=108";
	}
	
	function queryTpl(){
			
		var TimeBgin = document.all.TimeBgin.value;
		var TimeEnd = document.all.TimeEnd.value;
		if(TimeEnd.length>0 && TimeBgin.length>0)
		if(TimeEnd<TimeBgin)
		{
			alert("����ʱ�䲻��С�ڿ�ʼʱ��!");
			return false;
		}
		//bug432:����ʱ�䲻��С�ڿ�ʼʱ��,weida

		//��ѯ
		form1.action="template_list.jsp?action=search&siteId=<%=siteId%>";
		form1.target="TplListFrame";
		form1.submit();	
	}
	function queryUserAll(){	//��ѯ����
		form1.action="template_list.jsp?action=getAll&siteId=<%=siteId%>";
		form1.target="TplListFrame";
		form1.submit();	
		form1.reset();
	}
	//Ĭ�Ϲ��ͣ�����ĵ����������
	function document.onreadystatechange(){
		if (document.readyState!="complete") return;
		document.all.form1.name.focus();
	}
	function advancedQuery(){
		//form1.action="<%=rootpath%>/cms/docManage/advancedQueryFrame.jsp?siteId=<%=siteId%>"
		//form1.target="forQuery";
		//form1.submit();
			
	}
	function selChnl(){
		var reVlaue = openWin('../docManage/multi_channel_select_frame.jsp?siteid=<%=currentSiteid%>',400,500);	
		if(reVlaue != undefined){
			document.all.channelNames.value = reVlaue.split(":")[0];
			document.all.channelIds.value = reVlaue.split(":")[1];
		}
	}
</script>
		<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 5px;
	margin-right: 0px;
	margin-bottom: 0px;
}
</style>
	</head>
	<body>
		<form id="form1" name="form1" method="post" action="">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="5" valign="top" bgcolor="#ffffff">
						<img src="../images/querybox_left.gif" width="5" height="62">
					</td>
					<td style="background:url(../images/querybox_bg.gif) repeat-x top">
						<table width="100%" border="0" cellpadding="3" cellspacing="0" class="query_table" style="margin-top:5px">
							<tr>
								<td width="70" height="18" align="right" valign="middle" nowrap>
									ģ�����ƣ�
								</td>
								<td height="18" align="left" valign="middle">
									<input name="name" type="text" class="cms_text" id="name" style="width:160px">
								</td>
								<td width="70" height="18" align="right" valign="middle" nowrap>
									�����ߣ�
								</td>
								<td height="18" align="left" valign="middle">
									<select name="creatorUser" class="cms_select" id="creatorUser" style="width:160">
										<option value="">
											--ѡ�񴴽���--
										</option>
										<%
											TemplateManagerImpl templageManagerM = new TemplateManagerImpl();
											List list = templageManagerM.getSiteTplCreator(siteId);
											request.setAttribute("dblist", list);
										%>
										<pg:list requestKey="dblist">
											<option value="<pg:cell colName="createUserName"/>">
												<pg:cell colName="createUserName" />
											</option>
										</pg:list>
									</select>
								</td>
								<td width="70" height="18" align="right" valign="middle" nowrap>
									ģ�����ͣ�
								</td>
								<td height="18" align="left" valign="middle">
									<select name="type" class="cms_select" id="type" style="width:108" onchange="loadStyle();">
										<option value="">
											--��������--
										</option>
										<option value="0">
											վ����ҳģ��
										</option>
										<option value="1">
											Ƶ������ģ��
										</option>
										<option value="2">
											�ĵ�ϸ��ģ��
										</option>
									</select>
								</td>
								<td colspan="2">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input name="search" type="button" class="cms_button" value="��ѯ" onClick="queryTpl()">
								</td>
							</tr>
							<tr>
								<td width="70" height="18" align="right" valign="middle" nowrap>
									��ʼʱ�䣺
								</td>
								<td height="18" align="left" valign="middle">
									<input type="text" name="TimeBgin" size="18" class="cms_text" readonly>
									<input name="button1" type="button" onClick="showdate(document.all('TimeBgin'))" value="...">
								</td>
								<td width="70" height="18" align="right" valign="middle" nowrap>
									����ʱ�䣺
								</td>
								<td height="18" align="left" valign="middle">
									<input type="text" name="TimeEnd" size="18" class="cms_text" readonly>
									<input name="button2" type="button" onClick="showdate(document.all('TimeEnd'))" value="...">
								</td>
								<td width="70" height="18" align="right" valign="middle" nowrap>
									ģ����:
								</td>
								<td height="18" align="left" valign="middle">
									<select name="templateStyle" class="cms_select" id="templateStyle" width="108">
										<option value="-2">
											���з��
										</option>
										<%
											TemplateStyleManager tsm = new TemplateStyleManagerImpl();
											List list1 = tsm.getAllTemplateStyleIdAndName();
											for (int i = 0; i < list1.size(); i++) 
											{
												TemplateStyleInfo tsi = (TemplateStyleInfo) list1.get(i);
						
										%>
										<option value="<%= tsi.getStyleId() %>">
											<%=tsi.getStyleName()%>
										</option>
										<%
											}
										%>
									</select>
								</td>
								<td colspan="2">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input name="searchall" type="button" class="cms_button" value="��ʾ����" onClick="queryUserAll()">
								</td>
								<!--  <td width="90" height="18" align="right" valign="middle" nowrap>ʹ��Ƶ����</td>
		<td height="18" align="left" valign="middle">
		<input name="channelNames" type="text" size="18"  class="cms_text" disabled="disabled">
		<input name="channelIds" type="hidden" size="10"  class="cms_text" >
		<input name="chnlSel" type="button" onClick="selChnl()" value="...">                        	                            
		</td>	-->
							</tr>
						</table>
					</td>
					<td width="6" valign="top">
						<img src="../images/querybox_right.gif" width="6" height="62">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>


