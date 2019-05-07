<%@ page contentType="application/x-java-jnlp-file; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.epp.reportmanage.ReportUtil"%>
<%

	//过滤器里面添加了该4项，但是对于该contentType是不需要该四项
	//所以要覆盖掉，注意：过滤器定义几项就覆盖几项，不能少也不能多
	//全部设置为空值或0  modify by limao

	String myip = request.getParameter("myip");
	response.setHeader("Cache-Control", null);
	response.setHeader("Pragma", null);
 	response.setDateHeader("Expires", 0);
	response.setDateHeader("max-age", 0);

	AccessControl acc = AccessControl.getInstance();
	acc.checkAccess(request,response);
	String username = acc.getUserName();
	String userId = acc.getUserAccount();
	
	String appid = (String)request.getSession().getAttribute(com.chinacreator.framework.Framework.SUBSYSTEM);
	String dbname = com.chinacreator.epp.util.EgpManager.getAppDBNameByAppID(appid);
	
	String rep_id =  request.getParameter("rep_id");
	String rmi_ip = com.chinacreator.ireport.server.IreportConfig.getProperties("RMI_SERVER_IP");
	if(StringUtils.isBlank(rmi_ip) || "127.0.0.1".equals(rmi_ip.trim()) || "localhost".equals(rmi_ip.trim().toLowerCase())){
		rmi_ip = java.net.InetAddress.getLocalHost().getHostAddress();
	}
	
	String rmi_port = com.chinacreator.ireport.server.IreportConfig.getProperties("RMI_SERVER_PORT");
	String ip = ReportUtil.getIpAddr(request);

	if(!StringUtils.isBlank(myip)){
		ip = myip;
	}

	String serverUrl = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
	String remoteDesignUrl = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/report/ireportRemoteDesigner";

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
	+"<jar href=\""+remoteDesignUrl+"/ireport_fat.jar\" download=\"lazy\"/>"
	+"</resources>"
	+"<application-desc main-class=\"com.chinacreator.ireport.Start\">"
	+"<argument>"+rmi_ip+"</argument>"
	+"<argument>"+rmi_port+"</argument>"
	+"<argument>"+rep_id+"</argument>"
	+"<argument>"+username+"</argument>"
	+"<argument>"+ip+"</argument>"
	+"<argument>"+userId+"</argument>"
	+"<argument>"+dbname+"</argument>"
	+"</application-desc>"
	+"<security>"
	+"<all-permissions/>"
	+"</security>"
	+"</jnlp>";

	out.print(jnlpString);
%>