<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.security.*"%>

<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	//本周的起始时间
	String start_weekDate;
	java.text.SimpleDateFormat   df=new   java.text.SimpleDateFormat("yyyy-MM-dd");   
    Calendar   calendar=Calendar.getInstance();   
    Calendar   cpcalendar=(Calendar)calendar.clone(); 
        
    Date currentDate = new Date(); 
    /**当前时间*/ 
    String riqi = df.format(currentDate); 
    //得到本周一的时间
    cpcalendar.set(Calendar.DAY_OF_WEEK,   Calendar.MONDAY); 
    start_weekDate = df.format(new Date(cpcalendar.getTimeInMillis()));
    
    String maxPageItems = request.getParameter("maxPageItems");
    if(maxPageItems==null || maxPageItems==""){
    	maxPageItems = "10";
    }
    int maxPageItems_int = Integer.parseInt(maxPageItems);    
	String startDate=request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	
	if(startDate==null){
		startDate=start_weekDate;
	}
	if(endDate==null){
		endDate=riqi;
	}
	//System.out.println(startDate+endDate);
	
%>
<html>
<head>
<title>
	CMS:::统计功能
</title>
<link  href="../inc/css/cms.css" rel="stylesheet" type="text/css"></link>
<script language="javascript" src="../inc/js/func.js"></script>
<script language="javascript" src=src="../../sysmanager/include/pager.js" type="text/javascript"></script>
<script type="text/javascript">
/****************************************************************/


</script>
<style type="text/css">
body {
	background-color: #ffffff;
scrollbar-face-color: #C9D1E4; 
scrollbar-shadow-color: #6B74B7; 
scrollbar-highlight-color: white; 
scrollbar-3dlight-color: #E100E1; 
scrollbar-darkshadow-color:#E100E1; 
scrollbar-arrow-color:#003492; 
scrollbar-base-color: #E100E1; 
scrollbar-track-color: #E9EDF3; 
}
</style>
</head>
<body topmargin="2" rightmargin="0" leftmargin="1" righttmargin="1">
<form name="form1" action="" method="post" >
<table width="95%" border="0" align="center" cellpadding="3" cellspacing="0" bordercolor="#B7CBE4" class="Datalisttable" id="docListTable">
    <pg:listdata dataInfo="com.chinacreator.cms.statisticManage.tag.DepartStatisticList" keyName="DepartStatisticList"/>
		                    <!--分页显示开始,分页标签初始化-->
		                    <pg:pager maxPageItems="<%=maxPageItems_int%>" scope="request" data="DepartStatisticList" isList="false">
		                    <pg:param name="startDate" value="<%=startDate%>"/>
		                    <pg:param name="endDate" value="<%=endDate%>"/>
		                    <pg:param name="maxPageItems" value="<%=maxPageItems%>"/>
		                    <pg:param name="orgid"/>
		                    <pg:param name="channel_id"/>
	<tr class="cms_report_tr">

		<td width="45%">
			部门名称</td>	
		<td width="15%">
			录入篇数	</td>	
		<td width="10%">
			审稿篇数</td>	
		<td width="15%">
			发稿篇数	</td>		
		<td width="15%">
			录稿总字数</td>		
	</tr>
	<!--检测当前页面是否有记录-->
	<pg:notify>
	<tr height="18px" class="labeltable_middle_tr_01">
		<td colspan=100 align='center'>暂时没有记录</td>
	</tr>
	</pg:notify>			      
			      			    
	<!--list标签循环输出每条记录-->			      
	<pg:list>
	<tr>
			<%if(dataSet.getString("org_name")!=null&&(dataSet.getString("org_name").equals("党群部门")||dataSet.getString("org_name").equals("区政府组成部门")||dataSet.getString("org_name").equals("区政府管理机构")||dataSet.getString("org_name").equals("区直属事业单位"))){%>
			<td style="color:red">
			<pg:cell colName="org_name" defaultValue=""/>
			</td>
			<%}else{%>
			<td>
			<pg:cell colName="org_name" defaultValue=""/>
			</td>
			<%}%>
		<td >		
			<pg:cell colName="writeDocs" defaultValue=""/>
		</td>
		<td >			
			<pg:cell colName="auditDocs" defaultValue=""/>
		</td>
		<td >
			<pg:cell colName="publishDocs" defaultValue=""/>
		</td>		
		<td >
			<pg:cell colName="totalWords" defaultValue=""/></td>		
	</tr>
	</pg:list>	
	</pg:pager>
</table>
<table align=center width="100%">
	<tr height="18px" class="labeltable_middle_tr_01">
		<td colspan=4 align='center'>每页<font color="blue"><%=maxPageItems_int%></font>条记录 共<pg:rowcount/>条记录&nbsp;&nbsp;<pg:index/></td>			      	          
	</tr>
</table>
</form>
<iframe height="0" width="0" name="operIframe"></iframe>
</body>
</html>