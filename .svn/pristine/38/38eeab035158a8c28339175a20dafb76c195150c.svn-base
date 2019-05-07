<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page errorPage="error.jsp"%>
<%@ page import="net.sf.jasperreports.engine.*"%>
<%@ page import="com.chinacreator.epp.reportmanage.cache.*"%>

<%@ page import="net.sf.jasperreports.j2ee.servlets.*"%>
<%@ page import="com.chinacreator.epp.reportmanage.*"%>
<%@ page import="com.chinacreator.epp.reportmanage.vo.Tb_report"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ taglib prefix="c" uri="/WEB-INF/reportconfig/c.tld"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
  accesscontroler.checkAccess(request, response);
  String appPath = "app_"+accesscontroler.getCurrentSystemID();
  String appId = accesscontroler.getCurrentSystemID();
  String djid=request.getParameter("djid");
  		String cssfolder = "creatorBlue";
		StringBuffer sql = new StringBuffer();
		DBUtil dBUtil = new DBUtil();
		dBUtil.executeSelect("select t.cssfolder from tb_form t where t.djid="+djid);
		if(dBUtil.size()>0){
		  cssfolder=dBUtil.getString(0,"cssfolder");
		 // System.out.println("fff:"+cssfolder);
		}
%>

<%
	String openUrlKey = (String) request.getParameter("openUrlKey");
	//JasperPrint jasperPrint = (JasperPrint)session.getAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE);
	JasperPrint jasperPrint = (JasperPrint) ReportCacheManager
			.getInstance().getObject(openUrlKey + "...");
	Tb_report report = (Tb_report) ReportCacheManager.getInstance()
			.getObject("report");
	jasperPrint.setName(report.getRep_name());
	ReportPageBean rpb = new ReportPageBean();
	pageContext.setAttribute("rpb", rpb);
	String sbuffer = (rpb.pageReport(jasperPrint, request
			.getParameter("page"))).toString();
	pageContext.setAttribute("sbu", sbuffer);

	String openUrl = (String) ReportCacheManager.getInstance()
			.getObject(openUrlKey);
%>

<html>

	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<head>
		<style type="text/css">
a {
	text-decoration: none
}
</style>
		<title>${report.rep_name} HTML报表展示</title>
	</head>


	<body text="#000000" link="#000000" alink="#000000" vlink="#000000"
		onload="">

		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td width="20%">
					&nbsp;
				</td>
				<td align="left">
					<hr size="1" color="#000000">
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>

							<td>
								<a
									href="showJasperReport.jsp?openUrlKey=<%=openUrlKey%>&reload=true&raq=${report.rep_id}"><img
										src="reportImages/reload.GIF" border="0">
								</a>
							</td>
							<td>
								&nbsp;
								<a
									href="../jasperreport/xls?jasperprintkey=<%=openUrlKey%>&filename=<%=report.getRep_name()%>"><img
										src="reportImages/newexcel.gif" border="0" title="导出为excel">
								</a>
							</td>
							<td>
								&nbsp;
								<a
									href="../jasperreport/rtf?jasperprintkey=<%=openUrlKey%>&filename=<%=report.getRep_name()%>"><img
										src="reportImages/newword.gif" border="0" title="导出为word">
								</a>
							</td>
							<td>
								&nbsp;
								<a
									href="../jasperreport/pdf?jasperprintkey=<%=openUrlKey%>&filename=<%=report.getRep_name()%>"><img
										src="reportImages/newpdf.gif" border="0" title="导出为pdf">
								</a>
							</td>
							<td>
								&nbsp;
								<a href="#" onclick="openprinter()"><img
										src="reportImages/newprint.gif" border="0" title="打印">
								</a>
							</td>
							<td>
								&nbsp;
							</td>

							<c:choose>
								<c:when test="${rpb.pageIndex>0}">
									<td>
										<a
											href="showJasperReport.jsp?openUrlKey=<%=openUrlKey%>&page=0&raq=${report.rep_id }&filename=${report.rep_name }"><img
												src="reportImages/first.GIF" border="0">
										</a>
									</td>
									<td>
										<a
											href="showJasperReport.jsp?openUrlKey=<%=openUrlKey%>&page=${rpb.pageIndex - 1}&raq=${report.rep_id }&filename=${report.rep_name }"><img
												src="reportImages/previous.GIF" border="0">
										</a>
									</td>
								</c:when>

								<c:otherwise>
									<td>
										<img src="reportImages/first_grey.GIF" border="0">
									</td>
									<td>
										<img src="reportImages/previous_grey.GIF" border="0">
									</td>
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${rpb.pageIndex < rpb.lastPageIndex}">
									<td>
										<a
											href="showJasperReport.jsp?openUrlKey=<%=openUrlKey%>&page=${rpb.pageIndex + 1 }&raq=${report.rep_id }&filename=${report.rep_name }"><img
												src="reportImages/next.GIF" border="0">
										</a>
									</td>
									<td>
										<a
											href="showJasperReport.jsp?openUrlKey=<%=openUrlKey%>&page=${rpb.lastPageIndex }&raq=${report.rep_id }&filename=${report.rep_name }"><img
												src="reportImages/last.GIF" border="0">
										</a>
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<img src="reportImages/next_grey.GIF" border="0">
									</td>
									<td>
										<img src="reportImages/last_grey.GIF" border="0">
									</td>
								</c:otherwise>
							</c:choose>
							<td width="50%">
								&nbsp;
							</td>
							<td align="right" width="30%">
								第${rpb.pageIndex+1}页&nbsp;共${rpb.lastPageIndex+1}页
							</td>
						</tr>

					</table>
					<hr size="1" color="#000000">
				</td>
				<td width="20%">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td width="20%">
					&nbsp;
				</td>
				<td align="center">
					${sbu}
				</td>
				<td width="20%">
					&nbsp;
				</td>
			</tr>

		</table>

	</body>
	<script type="text/javascript">
	function openprinter(){
		window.open("<%=openUrl%>");
	}
	</script>
</html>