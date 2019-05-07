<%@ page contentType="application/x-java-jnlp-file; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	//打开远程设计器
	//过滤器里面添加了该4项，但是对于该contentType是不需要该四项
	//所以要覆盖掉，注意：过滤器定义几项就覆盖几项，不能少也不能多
	//全部设置为空值或0  modify by limao
	response.setHeader("Cache-Control", null);
	response.setHeader("Pragma", null);
 	response.setDateHeader("Expires", 0);
	response.setDateHeader("max-age", 0);


	String appId = (String)request.getSession().getAttribute(com.chinacreator.framework.Framework.SUBSYSTEM);
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	String serverUrl = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
	String remoteDesignUrl = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/report/remoteDesigner";
	//String serverUrl = request.getContextPath()+"/report/remoteDesigner";
	//String remoteDesignUrl = request.getContextPath()+"/";
	String jnlpString = "<?xml version=\"1.0\" encoding=\"GBK\"?>"
	+"<jnlp spec=\"0.2 1.0\"codebase=\""+remoteDesignUrl+"\">"
	+"<information>"
	+"<title>北京润乾软件技术有限公司</title>"
	+"<vendor>北京润乾软件技术有限公司</vendor>"
	+"<homepage href=\"http://www.runqian.com.cn\"/>"
	+"<icon href=\"app_logo.jpg\"/>"
	+"<offline-allowed/>"
	+"</information>"
	+"<resources><j2se version=\"1.4.1+\" href=\"http://java.sun.com/products/autodl/j2se\"/><jar href=\"activation.jar\" download=\"lazy\"/>"
	+"<jar href=\"barcode.jar\" download=\"lazy\"/>"
	+"<jar href=\"db2java.jar\" download=\"lazy\"/>"
	+"<jar href=\"defaultLicense.jar\" download=\"lazy\"/>"
	+"<jar href=\"hsqldb.jar\" download=\"lazy\"/>"
	+"<jar href=\"itext2_rq.jar\" download=\"lazy\"/>"
	+"<jar href=\"iTextAsian.jar\" download=\"lazy\"/>"
	+"<jar href=\"jai_codec.jar\" download=\"lazy\"/>"
	+"<jar href=\"jai_core.jar\" download=\"lazy\"/>"
	+"<jar href=\"jaxp.jar\" download=\"lazy\"/>"
	+"<jar href=\"jbcl.jar\" download=\"lazy\"/>"
	+"<jar href=\"jdom.jar\" download=\"lazy\"/>"
	+"<jar href=\"listview.jar\" download=\"lazy\"/>"
	+"<jar href=\"log4j_128.jar\" download=\"lazy\"/>"
	+"<jar href=\"mail.jar\" download=\"lazy\"/>"
	+"<jar href=\"mlibwrapper_jai.jar\" download=\"lazy\"/>"
	+"<jar href=\"oracle9ijdbc.jar\" download=\"lazy\"/>"
	+"<jar href=\"parser.jar\" download=\"lazy\"/>"
	+"<jar href=\"pgslookandfeel.jar\" download=\"lazy\"/>"
	+"<jar href=\"poi2.jar\" download=\"lazy\"/>"
	+"<jar href=\"report4.jar\" main=\"true\" download=\"eager\"/>"
	+"<jar href=\"resource.jar\" download=\"lazy\"/>"
	+"<jar href=\"servlet.jar\" download=\"lazy\"/>"
	+"<jar href=\"sqlserver7jdbc.jar\" download=\"lazy\"/>"
	+"<jar href=\"startup_helper.jar\" download=\"lazy\"/>"
	+"<jar href=\"sybasejdbc5_5.jar\" download=\"lazy\"/>"
	+"<jar href=\"transfer3.5.jar\" download=\"lazy\"/>"
	+"<jar href=\"xalan.jar\" download=\"lazy\"/>"
	+"<jar href=\"xml-apis.jar\" download=\"lazy\"/>"
	+"<jar href=\"zipfile.jar\" download=\"lazy\"/>"
	+"<jar href=\"r4jdbcClient.jar\" download=\"eager\"/>"
	+"</resources>"
	+"<application-desc main-class=\"com.runqian.report4.ide.FrameMain\">"
	+"<argument>-semantic</argument>"
	+"<argument>runqianSemanticFile.xml</argument>"
	+"<argument>-url</argument>"
	+"<argument>"+serverUrl+"/remoteServer?appId="+appId+"</argument>"
	+"<argument>-user</argument>"
	+"<argument>"+control.getUserAccount()+"</argument>"
	+"<argument>-password</argument>"
	+"<argument>"+control.getUserAccount()+"</argument>"
	+"</application-desc>"
	+"<security>"
	+"<all-permissions/>"
	+"</security>"
	+"</jnlp>";

	//response.setContentType("application/x-java-jnlp-file;charset=GBK");
	//PrintWriter pw = response.getWriter();
	//pw.print(jnlpString);
	out.print(jnlpString);
%>