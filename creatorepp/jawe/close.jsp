<%@page contentType="text/html;charset=GBK"%>
<%@page import="java.io.*" %>
<%@page import="com.frameworkset.common.poolman.DBUtil" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.epp.util.EgpManager"%>

<%
	AccessControl control = AccessControl.getInstance();
	String mgrName = (String)request.getParameter("mgrName");
	mgrName=mgrName.replaceAll("~","#");
	mgrName=mgrName.split("#")[0];
	
	mgrName=mgrName+"#";
	//关闭时设置文件的打开状态
	DBUtil dbUtil = new DBUtil();
	String sql = "update tb_process set checkoutstate='0',checkouttime='',checker='' where substr(p_name,0,"+mgrName.length()+")='"+mgrName+"'";
	//System.out.println("关闭的sql："+sql);
	String zipFileName = request.getParameter("zipFileName");
	//System.out.println(zipFileName);
	try
	{
		dbUtil.executeUpdate(EgpManager.getEgpDBName(), sql);
		
		if(zipFileName!=null&&zipFileName.length()>0)
		{
			String zipFilePath = request.getRealPath("")+"\\jawe\\";
			File f = new File(zipFilePath+zipFileName);
			if(f.exists())
				f.delete();
		}
	}
	catch(Exception ex)
	{
		System.out.println(ex.getMessage());
		ex.printStackTrace();
	}
%>