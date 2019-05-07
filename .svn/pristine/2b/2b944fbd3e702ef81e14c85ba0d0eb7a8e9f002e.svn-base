<%@ page contentType="text/html;charset=GBK" %>
<%@page errorPage="error.jsp" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<jsp:directive.page import="com.chinacreator.epp.reportmanage.service.ReportManage"/>
<%@page import="com.chinacreator.epp.reportmanage.ReportConfig"%>
<%@page import="com.chinacreator.epp.reportmanage.factory.ReportBeanFactory"%>
<%@page import="com.chinacreator.epp.reportmanage.MakeBase64"%>
<%@ taglib uri="/WEB-INF/reportconfig/runqianReport4.tld" prefix="report" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.epp.reportmanage.vo.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.ReportConnectionFactory" %>

<%@ page import="java.sql.*" %>
<%@ page import="com.runqian.report4.usermodel.*"%>
<%@ page import="com.chinacreator.epp.reportmanage.ReportUtil" %>

<html>
<head>
	<script type="text/javascript">
	function printReport()
	{
		var nw = window.open('','','width=800,height=600');
		var scripts = window.document.getElementsByTagName("SCRIPT");
 		nw.document.open("text/html","GBK");

		nw.document.write("<object classid='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2' id='wb'height='0' width='0'></object>");
		nw.document.write(document.getElementById("report1_style").outerHTML);
		nw.document.write(document.getElementById("report1").outerHTML);

		for(var i=0;i<scripts.length;i++)
 		{
 			var tmp = scripts[i].innerHTML;
 			if(tmp.indexOf("function")!=-1)
 			{
 				nw.document.write("<scrip"+"t>"+scripts[i].innerHTML+"</sc"+"ript>");
 			}
 		}
		nw.document.write("<scrip"+"t>document.all.wb.ExecWB(7,1)</sc"+"ript>");
	}
</script>
</head>
<body>
<%
	String appmap = request.getContextPath();
	String printImage = "<img src='" + appmap + "/images/print.gif' border=no >";
	String excelImage = "<img src='" + appmap + "/images/excel.gif' border=no >";
	String pdfImage = "<img src='" + appmap + "/images/pdf.gif' border=no >";
    String wordImage = "<img src='" + appmap + "/images/doc.gif' border=no >";
%>

<%@ include file="/epp/css/cssControl.jsp"%><body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
	//AccessControl control = AccessControl.getInstance();
	//control.checkAccess(request,response);
	boolean isFileSearch = "file".equalsIgnoreCase(ReportConfig.getProperties("SEARCH_STRATEGY"));
	ReportUtil util = new ReportUtil();
	String rid = request.getParameter("raq");
	ReportManage rm = ReportBeanFactory.getReportManager();
	Tb_report reportObj = rm.getReport(rid);

	
	
	//报表文件要保存到的位置
	String filePath = request.getRealPath("")+"\\report\\reportFiles\\";
	String fileName = filePath+rid+".raq";

	if(!isFileSearch){
	util.creatFile(fileName,rm.getReportFileBytes(rid),false);
	}else{
	    File ff = new File(fileName);
		if(!ff.exists()){
		 out.print("未找到文件"+fileName);
	     return;
		}

	}
	//是否需要转码，true为需要
	String needDecode = request.getParameter("needDecode");
	//获得从JSP页面传过来的参数
	StringBuffer params=new StringBuffer();
	Enumeration paramNames = request.getParameterNames();
	if(paramNames!=null){
		while(paramNames.hasMoreElements()){
			String paramName = (String) paramNames.nextElement();
			String paramValue=request.getParameter(paramName);
			if(paramValue!=null){
				//如果需要转码
				if(needDecode!=null&&needDecode.equals("true"))
				{
					//************请求端采用JS加密************
					//详细使用请查看s2u.js中的说明该JS负责将现有字符串转换为unicode码，下面将接受到的Unicode码转回来
					paramValue=ReportUtil.UnicodeToChinese(paramValue);
				}

				//把参数拼成name=value;name2=value2;.....的形式
				params.append(paramName).append("=").append(paramValue).append(";");
			}
		}
	}
	System.out.println(params.toString());

	//保证报表名称的完整性
	int iTmp = 0;
	if( (iTmp = rid.lastIndexOf(".raq")) <= 0 ){
		rid = rid + ".raq";
		iTmp = 0;
	}

	//第一步，读取报表模板
	//ReportDefine rd = (ReportDefine) ReportUtils.read( new FileInputStream(f) );

	ReportConnectionFactory cipConnectionFactory = new ReportConnectionFactory();
	Context context = new Context();
	DataSourceConfig dsoc = new DataSourceConfig(2, true, "GBK", "GBK",false);
	Connection conn=cipConnectionFactory.getConnection();
	context.setDataSourceConfig("reportsource", dsoc);
	context.setDefDataSourceName("reportsource");
	//context.setConnectionFactory("reportsource", cipConnectionFactory);
	context.setConnection("reportsource",conn);
	request.setAttribute("mctx",context);
%>

<%
	if( reportObj.getRep_stype()==2||reportObj.getRep_stype()==3 )
	{
	}
	else{
%>
<jsp:include page="toolbar.jsp" flush="false" />
<%} %>


<table id=rpt align=center><tr><td align="left">
<%	//如果参数模板存在，则显示参数模板
	if( reportObj.getRep_stype()==1||reportObj.getRep_stype()==3 ) {
	System.out.println("是参数模板");
	//参数模板的raq
	String fileName2 = filePath+reportObj.getRep_id2()+".raq";
	File f2 = new File(fileName2);
	//验证文件是否存在,如果不存在，从数据库中取出，生成.raq文件
	if((!isFileSearch) && !f2.exists())
	{
		byte[] bytes2 = rm.getReportFileBytes(reportObj.getRep_id2());
		f2.createNewFile();
		FileOutputStream fos2 = new FileOutputStream(f2);
		fos2.write(bytes2);
		fos2.flush();
		fos2.close();
	}else{
	   out.print("未找到文件"+fileName2);
	   return;
	}
	String paramFile = reportObj.getRep_id2()+".raq";
	%>
	<table id=param_tbl>
		<tr>
			<td>
				<report:param name="form1" paramFileName="<%=paramFile%>"
					needSubmit="no"
					params="<%=params.toString()%>"
				/>
			</td>
			<td><a href="javascript:_submit( form1 )"><img src="../images/query.jpg" border=no style="vertical-align:middle"></a></td>
		</tr>
	</table>
	<% }
%>
<%
	//srcType="defineBean" beanName="iReport"
	//Hashtable ht = (Hashtable)Readreportstyle.getstyle();
%>
	<table align=center width="100%">
		<tr><td align="center" width="100%">
		<%
			if(reportObj.getRep_stype()==0||reportObj.getRep_stype()==1){
		%>
			<report:html name="report1" reportFileName="<%=rid %>"
			contextName="mctx"
			funcBarLocation="top"
			needPageMark="yes"
			separator=" "
			funcBarFontColor="red"
			funcBarFontFace="宋体"
			funcBarFontSize="20px"
			functionBarColor="#FFFFCC"
			needScroll="no"
			generateParamForm="no"
			excelPageStyle="1"
			params="<%=params.toString()%>"
			inputListener="com.chinacreator.epp.reportmanage.ReportInputListener"
			/>
		<%
		
			}else{
		%>
			<report:group groupFileName="<%=rid %>"
			params="<%=params.toString()%>"
			funcBarLocation="top"
			inputListener="com.chinacreator.epp.reportmanage.ReportInputListener"
			needSaveAsExcel="yes"
			excelLabel="<%=excelImage %>"
			needSaveAsWord="yes"
			wordLabel="<%=wordImage %>"
			needSaveAsPdf="yes"
			pdfLabel="<%=pdfImage %>"
			needPrint="yes"
			printLabel="<%=printImage %>"
			></report:group>
		<%} %>
		</td></tr>
	</table>
	<%
	if(conn!=null){
	conn.close();
	System.out.println(conn+"连接是否关闭："+conn.isClosed());
	}

	 %>
</body>
</html>
