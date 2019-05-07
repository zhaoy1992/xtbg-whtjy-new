<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.epp.reportmanage.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String reportId = (String)request.getParameter("reportId");
	String reportName = (String)request.getParameter("reportName");
	
	if(reportId == null)
	
    {
		reportId = "";
	}
	if(reportName == null)
    {
		reportName = "";
	}
	
%>
<html>
	<head>
		<title>��������</title>
		<script src="report.js"></script>
		<script type="text/javascript">
			function myclear()
			{
				document.all.reportId.value="";
				document.all.reportName.value="";
			}
			
			//����ǰ�����
			function openDesigner()
			{
				window.open("<%=request.getContextPath()%>/report/reportDesign_do.jsp");
			}
			
			
			//�޸ı�����Ϣ
			function editReport(rep_id,ec_id)
			{
				var retx=window.showModalDialog("<%=request.getContextPath()%>/report/report_modify.jsp?repId="+rep_id);
				if(retx=="true") {
					window.location.reload();
				}
			}
			//�鿴��ʷ�汾
			function showReportHistory(repId)
			{
				var retx=window.showModalDialog("report_history.jsp?repId="+repId);
				//if(retx) window.location.reload();
			}
			//���б���
			function runReport(repId,type,reportName)
			{
				window.open("<%=request.getContextPath()%>/report/showreport.jsp?raq="+repId+"&type_lm="+type+"&reportname_lm="+reportName);
			}

			//��������
			function publish(repId,userName)
			{
				var retX=SendHttp("<%=request.getContextPath()%>/report/reportglobalservlet?@action=publisher&operator=p&repId="+repId+"&userName="+userName);
				alert(retX);
				window.location.reload();
			}
			
			//ȡ������
			function cancelPublish(repId)
			{
				var retX=SendHttp("<%=request.getContextPath()%>/report/reportglobalservlet?@action=publisher&operator=c&repId="+repId);
				alert(retX);
				window.location.reload();
			}
			//����ǰ����
			function designReport(repId)
			{
				window.open("<%=request.getContextPath()%>/report/reportopen_do.jsp?repId="+repId);
			}
			//��jasper����
  			function openJrxml(rep_id,rep_type)
  			{
  				window.open("<%=request.getContextPath()%>/report/ireporthandle.jsp?rep_id="+rep_id+"&rep_type="+rep_type);
  			}
			//��Զ�������
			function openJrxmlDesigner(){
				window.open("<%=request.getContextPath()%>/report/ireportRemoteDesigner/jnlp.jsp");
			}
			
			
		</script>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
	</head> 

	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no"
		onLoad="">
		<div id="contentborder" align="center">
			<form name="ApplyForm" action="default.jsp" method="post">
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							�����ţ�
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="reportId" style="width:70%" value="<%= reportId%>">
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="10%" align=right>
							�������ƣ�
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="reportName" style="width:70%" value="<%= reportName%>">
						</td>
					</tr>
					<tr>
						<td width="16%">
						</td>
						<td class="detailcontent" width="30%" align="right">
							<input name="Submit4" type="submit" class="input" value="��ѯ">
							<input name="Submit22" type="button" class="input" value="���" onclick="myclear();">
						</td>
					</tr>
				</table>
				<hr width="100%">
				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=10>
							<b>�����б�</b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.epp.reportmanage.menu.ReportList" keyName="reportList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="reportList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--���÷�ҳ��ͷ-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P>
							</td>
							<td height='20' class="headercolor">
								������
							</td>
							<td height='20' class="headercolor">
								��������
							</td>
							<td height='20' class="headercolor">
								��������
							</td>
							<td height='20' class="headercolor">
								��������
							</td>
							<td height='20' class="headercolor">
								�汾
							</td>
							<td height='20' class="headercolor">
								����״̬
							</td>
							<td height='20' class="headercolor">
								������
							</td>
							<td height='20' class="headercolor">
								����ʱ��
							</td>
							<td height='20' class="headercolor">
								�޸�
							<input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string" maxlength="100" value="false"/>
							</td>
						</tr>

						<pg:param name="ec_id" />

						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									��ʱû�б���
								</td>
							</tr>
						</pg:notify>


						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'"
								>
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="checkbox" name="checkBoxOne"
											onclick="checkOne('checkBoxAll','checkBoxOne')"
											value='<pg:cell colName="rep_id" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<pg:cell colName="rep_id" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<pg:cell colName="rep_name" defaultValue="" maxlength="15"/>
								</td>
									<td height='20' align="left" class="tablecells" onclick="">
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_GROU0P %>">
											��Ǭ
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_GROU0P_ARG %>">
											��Ǭ
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ %>">
											��Ǭ
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ_ARG %>">
											��Ǭ
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT %>">
											jasper
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION %>">
											jasper(javabean)
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_FILL %>">
											jasper(�)
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT %>">
											jasper(�ӱ���)
										</pg:equal>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="rep_desc" defaultValue="" maxlength="15"/>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="rep_ver" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:equal colName="publishstate" value="0">
										δ����
									</pg:equal>
									<pg:equal colName="publishstate" value="1">
										�ѷ���
									</pg:equal>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="publisher" defaultValue="" />
								</td>

								<td height='20' align="left" class="tablecells">
									<pg:cell colName="publishtime" defaultValue="" dateformat="yyyy-MM-dd HH:mm:ss"/>
								</td>

								<td height='20' align="left" class="tablecells">
									<pg:equal colName="publishstate" value="0">
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_GROU0P %>">
											<input type="button" value="�޸��ļ�" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_GROU0P_ARG %>">
											<input type="button" value="�޸��ļ�" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ %>">
											<input type="button" value="�޸��ļ�" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ_ARG %>">
											<input type="button" value="�޸��ļ�" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT %>">
											<input type="button" value="�޸��ļ�" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION %>">
											<input type="button" value="�޸��ļ�" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_FILL %>">
											<input type="button" value="�޸��ļ�" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT %>">
											<input type="button" value="�޸��ļ�" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										
										<input type="button" value="����" onclick="publish('<pg:cell colName="rep_id" defaultValue="" />','<%=control.getUserName()%>')"/>
									</pg:equal>
									<pg:equal colName="publishstate" value="1">
										<input type="button" value="����" onclick="runReport('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>','<pg:cell colName="rep_name" defaultValue="" />')"/>
										<input type="button" value="ȡ��" onclick="cancelPublish('<pg:cell colName="rep_id" defaultValue="" />')"/>
									</pg:equal>
									<input type="button" value="�޸���Ϣ" onclick="editReport('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="ec_id" defaultValue=""/>')"/>
								</td>
								</tr>
						</pg:list>


						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								��
								<pg:rowcount />
								����¼
								<pg:index />
								<%
									if(ReportConfig.getPropertiesBoolean("USE_RUNQIAN")){
									%>
									<br>
								<input name="Submit" type="button" class="input" value="����Ǭ�����"
									onClick="openDesigner()"/>
									<%}%>
										<%
									if(ReportConfig.getPropertiesBoolean("USE_JASPERREPORT")){
									%>
								    <input name="Submit" type="button" class="input" value="��Ireport�����"
									onClick="openJrxmlDesigner()"/>
									<%}%>
							</td>
						</tr>
					</pg:pager>

				</table>
			</form>
		</div>
	</body>
</html>