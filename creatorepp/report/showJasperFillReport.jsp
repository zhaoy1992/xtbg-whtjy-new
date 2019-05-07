<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page errorPage="error.jsp"%>
<%@ page import="net.sf.jasperreports.engine.*"%>
<%@ page import="net.sf.jasperreports.j2ee.servlets.*"%>
<%@ page import="com.chinacreator.epp.reportmanage.cache.*" %>
<%@page
	import="com.chinacreator.epp.reportmanage.*,com.chinacreator.epp.reportmanage.vo.*"%>
<%@taglib prefix="c" uri="/WEB-INF/reportconfig/c.tld"%>
<%

	String openUrlKey= (String)request.getParameter("openUrlKey");
	String openUrl= (String)ReportCacheManager.getInstance().getObject(openUrlKey);
	pageContext.setAttribute("openUrl",openUrl);
	
	JasperPrint jasperPrint = (JasperPrint)session.getAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE);
	String page_num = (String) request.getParameter("page");
	String printParams = request.getParameter("printParams");
	Tb_report report = (Tb_report)ReportCacheManager.getInstance().getObject("report");
	//Tb_report report = (Tb_report) request.getAttribute("report");
	pageContext.setAttribute("printParams", printParams);
	pageContext.setAttribute("report", report);
	jasperPrint.setName(report.getRep_name());
	String reportName64 = ReportUtil.getBASE64(report.getRep_name());

	pageContext.setAttribute("reportName", reportName64);

	ReportPageBean rpb = new ReportPageBean();
	pageContext.setAttribute("rpb", rpb);

	String sbuffer = (rpb.pageReport(jasperPrint, page_num)).toString();
	sbuffer = sbuffer.replaceAll(ReportUtil.DIV_BEFORE_REP + "",
			ReportUtil.DIV_BEFORE);
	sbuffer = sbuffer.replaceAll(ReportUtil.DIV_END_REP + "",
			ReportUtil.DIV_END);

	pageContext.setAttribute("sbu", sbuffer);
%>

<html>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<head>
		<style type="text/css">
a {
	text-decoration: none
}
</style>
		<script type="text/javascript" src="<%=request.getContextPath()%>/report/s2u.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/report/jquery1.2.6.min.js"></script>
		<title>${report.rep_name} 填报报表展示</title>

	</head>
	<body text="#000000" link="#000000" alink="#000000" vlink="#000000"
		onload="init()">
		<script language="javascript">
function init(){

 document.onkeydown=keyDown;
 document.onkeyup=keyUp;

}
function keyDown(DnEvents){

  var key=window.event.keyCode;
 if(key==13){
  return false;

 }

}
function keyUp(UpEvents){

 return false;
}
</script>


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
							</td>
							<td>
								<a
									href="showJasperFillReport.jsp?reload=true&raq=${report.rep_id}"><img
										src="reportImages/reload.GIF" border="0">
								</a>
							</td>
							<td>
								<a href="#" onclick="openxls();"><img
										src="reportImages/newexcel.gif" border="0" title="导出为excel">
								</a>
							</td>
							<td>
	        				&nbsp;<a href="#" onclick="opendoc();"><img src="reportImages/newword.gif" border="0" title="导出为word"></a>
	       					</td>
							<td>
								&nbsp;<a href="#" onclick="openpdf();"><img
										src="reportImages/newpdf.gif" border="0" title="导出为PDF">
								</a>
							</td>
							<td>

								&nbsp;
								<a href="#" onclick="openprinter()"><img
										src="reportImages/newprint.gif" border="0" title="打印">
								</a>
							</td>
							<td>
								&nbsp;&nbsp;&nbsp;
							</td>

							<c:choose>
								<c:when test="${rpb.pageIndex>0}">
									<td>
										<a
											href="showJasperFillReport.jsp?page=0&raq=${report.rep_id}&filename=${report.rep_name}"><img
												src="reportImages/first.GIF" border="0">
										</a>
									</td>
									<td>
										<a
											href="showJasperFillReport.jsp?page=${rpb.pageIndex-1}&raq=${report.rep_id}&filename=${report.rep_name}"><img
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
											href="showJasperFillReport.jsp?page=${rpb.pageIndex+1}&raq=${report.rep_id}&filename=${report.rep_name}"><img
												src="reportImages/next.GIF" border="0">
										</a>
									</td>
									<td>
										<a
											href="showJasperFillReport.jsp?page=${rpb.lastPageIndex}&raq=${report.rep_id}&filename=${report.rep_name}"><img
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

							<td width="100%">
								&nbsp;
							</td>
							<td width="100%"></td>
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
					${sbu }
				</td>
				<td width="20%">
					&nbsp;
				</td>
			</tr>
		</table>
	</body>
	
	
	<script type="text/javascript">
	function openprinter(){
		var divs = document.getElementsByTagName('div');
		var url = '${openUrl}';
		var filledString = "";
			for(var i = 0;i<divs.length;i++){
				if(divs[i].id.substring(0,2) == 'p_' || divs[i].id.substring(0,2) == 'P_'){
				filledString= filledString + ('@'+divs[i].id +'='+ toUN.on(divs[i].innerHTML));
				}
			}
		$.ajax({
		type:'POST',
		async: false,
 		url:   "<%=request.getContextPath()%>/report/fillreportparam.jsp",
 		data:  '&filledString='+filledString,
 		success: function(data){
 		//alert(data);
 			url = url+'&fileparams=isfill&returnid='+data;
 			window.open(url);
 		},
 		error : function(){
 			alert('构建打印数据失败！');
 		}   
		});		
		
	}
	
	function getParamsStr(){
		var divs = document.getElementsByTagName('div');
		var url = '';
		for(var i = 0;i<divs.length;i++){
			if(divs[i].id.substring(0,2) == 'p_' || divs[i].id.substring(0,2) == 'P_'){
			url= url + ('&'+divs[i].id +'='+ toUN.on(divs[i].innerHTML));
			}
		}
		return url;
	}
	
	function openxls(){
		var url = "<%=request.getContextPath()%>/jasperreport/xls?isfill=1&repid=${report.rep_id}&filename=${reportName}&params=${printParams}"+getParamsStr();
		window.open(url);
	}
	
   function openpdf(){
		var url = "<%=request.getContextPath()%>/jasperreport/pdf?isfill=1&repid=${report.rep_id}&filename=${reportName}&params=${printParams}"+getParamsStr();
		window.open(url);
	}
	
	function opendoc(){
		var url = "<%=request.getContextPath()%>/jasperreport/rtf?isfill=1&repid=${report.rep_id}&filename=${reportName}&params=${printParams}"+getParamsStr();
		window.open(url);
	}
	</script>
</html>