<%@page contentType="text/html;charset=GBK"%>
<%@page import="java.io.*" %>
<%@page import="com.chinacreator.epp.processmanage.dbmanager.ProcessManage,com.chinacreator.workflow.bean.ProcessDefinitionBean"%>
<%@page import="com.chinacreator.workflow.shark.*"%>
<%@page import="com.chinacreator.jawe.ZipUtil"%>
<%@page import="java.util.Calendar" %>

<%
	//将指定的文件打包，然后下载
	String filePath = request.getRealPath("")+"\\WEB-INF\\repository\\external";
	String zipFilePath = request.getRealPath("")+"\\jawe\\";
	String expkgids = request.getParameter("expkgids");
	String[] names = expkgids.split(",");
	String fileNames ="";
	for(int i=0;i<names.length;i++)
	{
		fileNames += filePath+"\\"+names[i].split("~")[0]+".xpdl"+",";
	}
	ZipUtil zip = new ZipUtil();
	Calendar rightNow = Calendar.getInstance();
	String zipFileName = new Long(rightNow.getTimeInMillis()).toString();
	try
	{	
		zip.zipFile(fileNames,zipFilePath+zipFileName+".zip","");
	}
	catch(Exception ee)
	{
		System.out.println(ee.getMessage());
		ee.printStackTrace();
	}
	System.out.println(zipFileName+".zip");
	out.print(zipFileName+".zip");
%>