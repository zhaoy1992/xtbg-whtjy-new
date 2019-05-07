<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.epp.reportmanage.ReportConfig"%>
<%@ page import="java.util.*"%>
<%@page import="java.io.*" %>
<%@page errorPage="error.jsp" %>
<%@ page import="com.chinacreator.epp.reportmanage.vo.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.service.*" %>
<%@ page import="net.sf.jasperreports.j2ee.servlets.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.ReportUtil" %>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@page import="com.chinacreator.epp.reportmanage.RunReportUtil" %>
<%@page import="com.chinacreator.epp.reportmanage.cache.ReportCacheManager" %>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.epp.reportmanage.factory.ReportBeanFactory"%>
<%@taglib prefix="c" uri="/WEB-INF/reportconfig/c.tld"%>    

<html>
<body>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response,false);
	String userAccount = accessControl.getUserAccount();
%>
<% 
	String strategy= ReportConfig.getProperties("SEARCH_STRATEGY"); 
	String report_view= ReportConfig.getProperties("DEFAULT_VIEW"); 
	
	RunReportUtil runUtil= new RunReportUtil(); 
	ReportManage rm = ReportBeanFactory.getReportManager(); 
	String reportId = request.getParameter("raq"); 
	//判断是否是子资源报表展示
	String isSubResource= request.getParameter("type");
	if(reportId== null) {
		out.println("报表ID不能为空......");
		throw new RuntimeException();
	}
	Tb_report report = null; 
	
	String reportType = request.getParameter("type_lm"); 
	if(StringUtils.isBlank(reportType) && isSubResource == null){
		report = rm.getReport(reportId);
		if(report== null){
			out.println("查无此报表，请确认报表ID是否正确");
			return;
		}
		reportType = report.getRep_stype()+"";
	}
	if(ReportUtil.REPORT_TYPE_RAQ.equalsIgnoreCase(reportType) || ReportUtil.REPORT_TYPE_RAQ_ARG.equalsIgnoreCase(reportType)
	|| ReportUtil.REPORT_TYPE_GROU0P.equalsIgnoreCase(reportType) || ReportUtil.REPORT_TYPE_GROU0P_ARG.equalsIgnoreCase(reportType)
	){
		response.sendRedirect("http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/report/showRunQianReport.jsp?raq="+reportId);
		return;	
	}
	
	if(report == null){
		report = rm.getReport(reportId);
	}
	 
	JasperPrint jasperPrint = null; 
	JasperReport jasperReport= null; 
	
	
	String reportName= request.getParameter("reportname_lm"); 
	
	
	if(report == null) {
		report= new Tb_report();
	}
	
	if(StringUtils.isBlank(reportName)){
		reportName = report.getRep_name();
	}
	
	//封装参数MAP
	
	Map<String,String> params = new HashMap<String,String>(); 
	//Map<String,String> printerparams = new HashMap<String,String>(); 
	Map<String,String[]> requestParams = request.getParameterMap(); 
	for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) { 
			    String name = iter.next(); 
			    String[] values =  requestParams.get(name); 
			    String valueStr = ""; 
			    for (int i = 0; i < values.length; i++) { 
			        valueStr = (i == values.length - 1) ? valueStr + values[i]: valueStr + values[i] + ","; 
			    } 
			    valueStr = new String(valueStr.getBytes("iso8859_1"),"GBK");     //转换字符集 
			    params.put(name, valueStr); 
	} 
	//封装打印MAP(注意: 必须在fillreport之前)
	String printMapString  = ReportUtil.mapToString(params);
	
	//记录相关日志信息 
	runUtil.logSomeInfo(strategy,params,report_view); 
	
	//预设全局文件搜索路径
	ReportUtil.setCreatorFileResolver();
	
	String type= report.getRep_stype()+""; 
	
	String filePath = this.getServletContext().getRealPath(ReportUtil.REPORT_FILE_PATH)+File.separator; 
	 
	File jrxmlFile = new File(filePath+reportId+".jrxml"); 
	File reportFile = new File(filePath+reportId+".jasper"); 
	 
	 //进行子资源的展示
	 if(isSubResource != null && !(isSubResource.equals(""))) {
		type= "subresource";
		List list= ReportBeanFactory.getReportManager().findById(reportId).getDatas();
		if(list != null) {
			Td_report_subresource td= (Td_report_subresource)list.get(0);
			jasperReport= runUtil.compileSubReport(strategy,filePath,VoConversionHelper.td_report_subresourceToReportSubReource(td));
			jasperPrint= runUtil.getJasperPrint(jasperReport,td,params);
			request.setAttribute("subreport",td);
		}
	} 
	
	//把相关变量放入到范围对象域中 
	pageContext.setAttribute("type",type); 
	pageContext.setAttribute("fill",ReportUtil.REPORT_TYPE_JASPERREPORT_FILL); 
	pageContext.setAttribute("subreport",ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT); 
	pageContext.setAttribute("collection",ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION); 
	pageContext.setAttribute("jasper",ReportUtil.REPORT_TYPE_JASPERREPORT);
	pageContext.setAttribute("subresource","subresource");
	pageContext.setAttribute("report_view",report_view); 
	pageContext.setAttribute("flash","flash"); 
	pageContext.setAttribute("html","html"); 
	pageContext.setAttribute("reportName",reportName); 
	ReportCacheManager.getInstance().cacheObject("report",report);
	
	//设置默认加载策略file_db 
	if(strategy == null || strategy.equals("")) { 
		strategy= ReportUtil.STRATEGY_DB_FILE; 
	} 
	//设置报表默认展示方式 
	if(report_view== null || report_view.equals("")) { 
		report_view= ReportUtil.VIEW_FLASH; 
	} 
		
	 
	 //编译其相关子报表
	if(type.equals(ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT)) {
		//遍历其子资源，如果是报表就进行编译
		try{
			runUtil.compileSubReport(reportId,strategy,filePath);
		}catch(Exception e) {
			e.printStackTrace();
			out.println("报表运行出错，请确认其子资源是否已删除!");
			return;
		}
	}
	System.out.println("=========="+filePath);
	if(isSubResource == null || isSubResource.equals("")) {
		//判断搜索策略(file,db,file_db)，选择不同的搜索逻辑 
	if("file".equals(strategy)){ 
		if(reportFile.exists()) { 
			jasperReport= runUtil.getJasperReport(reportFile.getPath()); 
			 
		}else if(jrxmlFile.exists()) { 
			jasperReport= runUtil.getJasperReport(filePath+reportId+".jrxml",filePath+reportId+".jasper"); 
		}else { 
			out.println("报表文件"+reportName+".jrxml"+"不存在，请更换搜索策略!!!"); 
			return; 
		} 
		 
	}else if("db".equals(strategy)) { 
		jasperReport= runUtil.getJasperReport(filePath+reportId+".jrxml",filePath+reportId+".jasper",reportId); 
		 
	}else if("file_db".equals(strategy)) { 
		if(reportFile.exists()) { 
			jasperReport= runUtil.getJasperReport(reportFile.getPath()); 
			 
		}else if(jrxmlFile.exists()) { 
			jasperReport= runUtil.getJasperReport(filePath+reportId+".jrxml",filePath+reportId+".jasper"); 
		}else { 
			jasperReport= runUtil.getJasperReport(filePath+reportId+".jrxml",filePath+reportId+".jasper",reportId); 
		} 
	} 
	//参数报表的参数是需要预定义存储的 
	if(type.equals(ReportUtil.REPORT_TYPE_JASPERREPORT_FILL))  { 
		params = ReportUtil.reSetJasperParamsHTML(params,jasperReport); 
	} 
	 jasperPrint= runUtil.getJasperPrint(jasperReport,report,params);
	 
	}
	
	 	//-----组装打印参数---- 
		String serverUrl = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/report/reportprinter/jnlp.jsp?"; 
		
		String printParams = "params="+(printMapString==null?"":printMapString); 
		String openUrl = serverUrl + printParams; 
		openUrl = openUrl.replaceAll("\n","");
		openUrl = openUrl.replaceAll("\r","");
		//填报需要
		pageContext.setAttribute("printMapString",printMapString); 
		
		Long d= System.currentTimeMillis();
		String s= Long.toBinaryString(d);
		
		ReportCacheManager.getInstance().cacheObject(s, openUrl);
	 	ReportCacheManager.getInstance().cacheObject(printMapString, jasperPrint);
	 	ReportCacheManager.getInstance().cacheObject(s+"...", jasperPrint);
	 	session.setAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE, jasperPrint);
	 	
	 //根据报表类型跳转到不同页面进行展示 
	 	String base64ReportName = ReportUtil.getBASE64(reportName);
	 	pageContext.setAttribute("reportName64",base64ReportName); 
	 %>
	<c:choose>
		<c:when test="${type== jasper || type== collection || type== subreport}">
			<c:choose>
				<c:when test="${report_view== flash}">
					<jsp:forward page="showJasperReport_swf.jsp">
						<jsp:param name="openUrlKey" value="<%=s %>"/>
					</jsp:forward>
				</c:when>
				<c:when test="${report_view== html}">
					<jsp:forward page="showJasperReport.jsp">
						<jsp:param name="openUrlKey" value="<%=s %>"/>
					</jsp:forward>
				</c:when>
			</c:choose>
		</c:when>
		
		<c:when test="${type== subresource}">
			<c:choose>
				<c:when test="${report_view== flash}">
					<jsp:forward page="showSubReport_swf.jsp">
						<jsp:param name="openUrlKey" value="<%=s %>"/>
					</jsp:forward>
				</c:when>
				<c:when test="${report_view== html}">
					<jsp:forward page="showSubReport.jsp">
						<jsp:param name="openUrlKey" value="<%=s %>"/>
					</jsp:forward>
				</c:when>
			</c:choose>
		</c:when>
		
		<c:when test="${type== fill}">
			<jsp:forward page="showJasperFillReport.jsp">
			<jsp:param name="printParams" value="${printMapString}"/>
			<jsp:param name="reportName" value="${reportName64}"/>
			<jsp:param name="openUrlKey" value="<%=s %>"/>
			</jsp:forward>
		</c:when>
		
		<c:otherwise>
			<jsp:forward page="showRunQianReport.jsp"></jsp:forward>
		</c:otherwise>
	</c:choose>
	
</body>
</html>
