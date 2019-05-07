<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="com.chinacreator.epp.reportmanage.service.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.factory.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.vo.*" %>
<%@ page import="java.io.*" %>
<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 		String resource_id= request.getParameter("resource_id");
 		ReportManage rm= ReportBeanFactory.getReportManager();
 			String filePath = this.getServletContext().getRealPath(ReportUtil.REPORT_FILE_PATH)+"\\";
 			File f= null;
 			String showPictureUrl="";
 			List list= rm.findById(resource_id).getDatas();
 			if(list != null) {
 				Td_report_subresource td= (Td_report_subresource)list.get(0);
 				byte[] blob= td.getResource_bolb();
 				String suffix= td.getResource_suffix();
 				 f= new File(filePath+resource_id+"."+suffix);
 				RunReportUtil rUtil= new RunReportUtil();
 					//构造图片文件
 					rUtil.saveByteArrayToFile(blob,f.getAbsolutePath());
 					 showPictureUrl= "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/report/reportFiles/";
 					showPictureUrl= showPictureUrl+resource_id+"."+suffix;
 			}
	
%>
 <%@ include file="/epp/css/cssControl.jsp"%>
<head>
	<script type="text/javascript">
		function myclose() {
			window.close();
		}
	</script>
</head>
 
  <body>
 	<center>
 	<br><br>
 	<img src="<%=showPictureUrl%>"  height="200" width="200"/><br>
 	<br>
 	<input name="button_" type="button" class="input" value="关闭" onClick="myclose();"/>
 	</center>
  </body>
</html>
