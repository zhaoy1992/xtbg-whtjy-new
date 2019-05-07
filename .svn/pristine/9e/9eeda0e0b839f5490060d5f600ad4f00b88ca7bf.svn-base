<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.chinacreator.workflow.shark.*"%>
<%@page import="com.frameworkset.common.poolman.DBUtil" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.jawe.JaWEConstants"%>
<%@page import="com.chinacreator.epp.util.EgpManager"%>
<%
	String userName = request.getParameter("userName");
	//System.out.println("bbbbbbbbbbbbbb");
	String mgrName = (String)request.getParameter("mgrName");
	mgrName=mgrName.replaceAll("~","#");
	SharkEngine se=SharkEngine.getInstance();
	String xpdlContent = se.getXPDLByMgrName(mgrName);
    
	//System.out.println(request.getQueryString());
	
    String cont = xpdlContent;

	out.clear();
	out.clearBuffer();
	out.print(cont);
	
	//修改数据表中的记录，登记当前时间和打开XPDL文件的人
	DBUtil dbUtil = new DBUtil();
	String sql = "update tb_process set checkoutstate='1',checkouttime=sysdate,checker='"+ userName +"' where p_name='"+mgrName+"'";
	
	//System.out.println(sql);
	
	//日志管理接口
	LogManager logMgr = SecurityDatabase.getLogManager();
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo = request.getParameter("userName")+":"+request.getParameter("userAccount")+"["+request.getParameter("userId")+"]";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();
	//用户信息
	String operUser = userInfo;
	//日志类型
	String operModule = JaWEConstants.LOG_MODULE_NAME;
	//操作的ip地址
	String operSource = remoteAddr;
	
	//写入日志
	logMgr.log(request.getParameter("userAccount"), userInfo+"打开流程文件"+mgrName, operModule, operSource);

	
	try
	{
		dbUtil.executeUpdate(EgpManager.getEgpDBName(), sql);
	}
	catch(Exception ex)
	{
		System.out.println(ex.getMessage());
		ex.printStackTrace();
	}
%>