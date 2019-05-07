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
		<title>属性容器</title>
		<script src="report.js"></script>
		<script type="text/javascript">
			function myclear()
			{
				document.all.reportId.value="";
				document.all.reportName.value="";
			}
			
			//打开润前设计器
			function openDesigner()
			{
				window.open("<%=request.getContextPath()%>/report/reportDesign_do.jsp");
			}
			
			
			//修改报表信息
			function editReport(rep_id,ec_id)
			{
				var retx=window.showModalDialog("<%=request.getContextPath()%>/report/report_modify.jsp?repId="+rep_id);
				if(retx=="true") {
					window.location.reload();
				}
			}
			//查看历史版本
			function showReportHistory(repId)
			{
				var retx=window.showModalDialog("report_history.jsp?repId="+repId);
				//if(retx) window.location.reload();
			}
			//运行报表
			function runReport(repId,type,reportName)
			{
				window.open("<%=request.getContextPath()%>/report/showreport.jsp?raq="+repId+"&type_lm="+type+"&reportname_lm="+reportName);
			}

			//发布报表
			function publish(repId,userName)
			{
				var retX=SendHttp("<%=request.getContextPath()%>/report/reportglobalservlet?@action=publisher&operator=p&repId="+repId+"&userName="+userName);
				alert(retX);
				window.location.reload();
			}
			
			//取消发布
			function cancelPublish(repId)
			{
				var retX=SendHttp("<%=request.getContextPath()%>/report/reportglobalservlet?@action=publisher&operator=c&repId="+repId);
				alert(retX);
				window.location.reload();
			}
			//打开润前报表
			function designReport(repId)
			{
				window.open("<%=request.getContextPath()%>/report/reportopen_do.jsp?repId="+repId);
			}
			//打开jasper报表
  			function openJrxml(rep_id,rep_type)
  			{
  				window.open("<%=request.getContextPath()%>/report/ireporthandle.jsp?rep_id="+rep_id+"&rep_type="+rep_type);
  			}
			//打开远程设计器
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
							报表编号：
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="reportId" style="width:70%" value="<%= reportId%>">
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="10%" align=right>
							报表名称：
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="reportName" style="width:70%" value="<%= reportName%>">
						</td>
					</tr>
					<tr>
						<td width="16%">
						</td>
						<td class="detailcontent" width="30%" align="right">
							<input name="Submit4" type="submit" class="input" value="查询">
							<input name="Submit22" type="button" class="input" value="清空" onclick="myclear();">
						</td>
					</tr>
				</table>
				<hr width="100%">
				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=10>
							<b>报表列表</b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.epp.reportmanage.menu.ReportList" keyName="reportList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="reportList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P>
							</td>
							<td height='20' class="headercolor">
								报表编号
							</td>
							<td height='20' class="headercolor">
								报表名称
							</td>
							<td height='20' class="headercolor">
								报表类型
							</td>
							<td height='20' class="headercolor">
								报表描述
							</td>
							<td height='20' class="headercolor">
								版本
							</td>
							<td height='20' class="headercolor">
								发布状态
							</td>
							<td height='20' class="headercolor">
								发布人
							</td>
							<td height='20' class="headercolor">
								发布时间
							</td>
							<td height='20' class="headercolor">
								修改
							<input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string" maxlength="100" value="false"/>
							</td>
						</tr>

						<pg:param name="ec_id" />

						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有报表
								</td>
							</tr>
						</pg:notify>


						<!--list标签循环输出每条记录-->
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
											润乾
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_GROU0P_ARG %>">
											润乾
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ %>">
											润乾
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ_ARG %>">
											润乾
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT %>">
											jasper
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION %>">
											jasper(javabean)
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_FILL %>">
											jasper(填报)
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT %>">
											jasper(子报表)
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
										未发布
									</pg:equal>
									<pg:equal colName="publishstate" value="1">
										已发布
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
											<input type="button" value="修改文件" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_GROU0P_ARG %>">
											<input type="button" value="修改文件" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ %>">
											<input type="button" value="修改文件" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ_ARG %>">
											<input type="button" value="修改文件" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT %>">
											<input type="button" value="修改文件" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION %>">
											<input type="button" value="修改文件" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_FILL %>">
											<input type="button" value="修改文件" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT %>">
											<input type="button" value="修改文件" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										
										<input type="button" value="发布" onclick="publish('<pg:cell colName="rep_id" defaultValue="" />','<%=control.getUserName()%>')"/>
									</pg:equal>
									<pg:equal colName="publishstate" value="1">
										<input type="button" value="运行" onclick="runReport('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>','<pg:cell colName="rep_name" defaultValue="" />')"/>
										<input type="button" value="取消" onclick="cancelPublish('<pg:cell colName="rep_id" defaultValue="" />')"/>
									</pg:equal>
									<input type="button" value="修改信息" onclick="editReport('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="ec_id" defaultValue=""/>')"/>
								</td>
								</tr>
						</pg:list>


						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
								<%
									if(ReportConfig.getPropertiesBoolean("USE_RUNQIAN")){
									%>
									<br>
								<input name="Submit" type="button" class="input" value="打开润乾设计器"
									onClick="openDesigner()"/>
									<%}%>
										<%
									if(ReportConfig.getPropertiesBoolean("USE_JASPERREPORT")){
									%>
								    <input name="Submit" type="button" class="input" value="打开Ireport设计器"
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