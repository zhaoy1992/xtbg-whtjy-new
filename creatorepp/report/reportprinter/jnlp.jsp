<%@ page contentType="application/x-java-jnlp-file; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.epp.reportmanage.ReportUtil"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.epp.reportmanage.cache.ReportCacheManager"%>
<%

	//过滤器里面添加了该4项，但是对于该contentType是不需要该四项
	//所以要覆盖掉，注意：过滤器定义几项就覆盖几项，不能少也不能多

	//全部设置为空值或0  modify by limao

	response.setHeader("Cache-Control", null);
	response.setHeader("Pragma", null);
 	response.setDateHeader("Expires", 0);
	response.setDateHeader("max-age", 0);
	
	
	AccessControl acc = AccessControl.getInstance();
	acc.checkAccess(request,response);
	String appid = (String)request.getSession().getAttribute(com.chinacreator.framework.Framework.SUBSYSTEM);
	String dbname = com.chinacreator.epp.util.EgpManager.getAppDBNameByAppID(appid);
	String params = request.getParameter("params");
	System.out.println("jnlp:["+params+"]");
	//由于填报报表的特殊性，我们需要将新填报的参数值覆盖原有的值

	String fillParams = request.getParameter("fileparams")==null?"null":request.getParameter("fileparams");
	String fillString= (String)ReportCacheManager.getInstance().getObject(request.getParameter("returnid"));
	if("isfill".equals(fillParams)){
		//params = ReportUtil.replaceMapString(request,params,true);
		params= ReportUtil.addFillParameterTOMap(fillString,params);
	}
	//params = ReportUtil.urlEncodeGBK(params);
	String serverUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
	String jarUrl = serverUrl + "/report/reportprinter";
	String remoteServletUrl = serverUrl+"/servlet/ReportRemoteServlet";
	
	
	String rmi_ip = com.chinacreator.ireport.server.IreportConfig.getProperties("RMI_SERVER_IP");
	if(StringUtils.isBlank(rmi_ip) || "127.0.0.1".equals(rmi_ip.trim()) || "localhost".equals(rmi_ip.trim().toLowerCase())){
		rmi_ip = java.net.InetAddress.getLocalHost().getHostAddress();
	}
	
	String rmi_port = com.chinacreator.ireport.server.IreportConfig.getProperties("RMI_PRINT_SERVER_PORT");

	String jnlpString = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
	+"<jnlp codebase=\""+serverUrl+"\">"
	+"<information>"
	+"<title>湖南科创信息技术股份有限公司</title>"
	+"<vendor>湖南科创信息技术股份有限公司</vendor>"
	+"<homepage href=\"http://www.chinacreator.com\"/>"
	+"<icon href=\"app_logo.jpg\"/>"
	+" <icon kind=\"splash\" href=\"creatorLogo.jpg\"/>"
	+"<offline-allowed/>"
	+"</information>"
	+"<resources><j2se version=\"1.5+\" href=\"http://java.sun.com/products/autodl/j2se\"/>"
	+"<jar href=\""+jarUrl+"/reportprinter.jar\" download=\"lazy\"/>"
	+"<jar href=\""+jarUrl+"/commons-collections-2.1.jar\" download=\"lazy\"/>"
	+"<jar href=\""+jarUrl+"/commons-digester-1.7.jar\" download=\"lazy\"/>"
	+"<jar href=\""+jarUrl+"/commons-logging-1.0.2.jar\" download=\"lazy\"/>"
	+"<jar href=\""+jarUrl+"/jasperreports-3.0.0.jar\" download=\"lazy\"/>"
	+"<jar href=\""+jarUrl+"/swing-layout-1.0.3.jar\" download=\"lazy\"/>"
	+"</resources>"
	+"<application-desc main-class=\"com.chinacreator.report.printer.PrinterMainStart\">"
	+"<argument>"+fillParams+"</argument>"
	+"<argument>"+params+"</argument>"
	+"<argument>"+fillParams+"</argument>"
	+"<argument>"+dbname+"</argument>"
	+"<argument>"+rmi_ip+"</argument>"
	+"<argument>"+rmi_port+"</argument>"
	+"</application-desc>"
	+"<security>"
	+"<all-permissions/>"
	+"</security>"
	+"</jnlp>";
	out.print(jnlpString);
%>