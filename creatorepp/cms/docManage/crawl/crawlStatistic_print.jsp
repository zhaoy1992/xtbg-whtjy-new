<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.customform.*"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.*"%>
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>

<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	String maxPageItems = request.getParameter("maxPageItems");
    if(maxPageItems==null || maxPageItems==""){
    	maxPageItems = "10";
    }
    int maxPageItems_int = Integer.parseInt(maxPageItems);
	String startDate=request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	if(startDate==null){
		startDate="";
	}
	if(endDate==null){
		endDate="";
	}
	//System.out.println(startDate+endDate);
	int i=1;
%>
<html>
<head>
<title>
	CMS:::ͳ�ƹ���
</title>
<link  href="/cms/inc/css/cms.css" rel="stylesheet" type="text/css"></link>
<script language="javascript" src="/cms/inc/js/func.js"></script>
<script language="javascript" src=src="/sysmanager/include/pager.js" type="text/javascript"></script>
<script type="text/javascript">
/****************************************************************/
function doPrintPreview()
	{
		//��ӡԤ��
		//dividePage();
		//WB.ExecWB(7,1);
		//cancelDividePage();
		//window.preview();
	}
	
function doPrint()
	{
		//��ӡ��ǰҳ
		//document.all("noPrintTd").style.visibility = "hidden";
		window.print();
		//document.all("noPrintTd").style.visibility = "visible";
	}

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
COLOR: #000000;
}
</style>
<STYLE MEDIA="print">
	#navmenu {display: none}
	#article {width: 6.5in}
	#article {height: 9.2in}
	#x1 {display: none}
	#x2 {display: none}
	#x3 {display: none}
	#divideFlagTitle {page-break-before:always}
</STYLE>
</head>
<body topmargin="2" rightmargin="0" leftmargin="1" righttmargin="1">
<form name="form1" action="" method="post" >

<table width="95%" border="0" align="center" cellpadding="3" cellspacing="0" bordercolor="#B7CBE4" class="Datalisttable" id="docListTable">
    <pg:listdata dataInfo="com.chinacreator.cms.documentmanager.crawl.EDocStatisticList" keyName="EDocStatisticList" />
				
				<pg:pager maxPageItems="<%=maxPageItems_int%>" 
								scope="request" data="EDocStatisticList" isList="false" sortKey="status" desc="true">
								
					<pg:param name="startDate" value="<%=startDate%>" />
					<pg:param name="endDate" value="<%=endDate%>" />
					<pg:param name="channelId"/>
					<pg:param name="maxPageItems" value="<%=maxPageItems%>"/>
	<tr id="trTitle" >
		<td valign="absMiddle" align="center" height="10" colspan="9"><h3>�״�ͳ����Ϣ��ӡ</h3></td>
	</tr>
	<tr id="trTime" >
		<td align="left" height="19" colspan="9">&nbsp;&nbsp;��ʼʱ��:<%=startDate%>
		&nbsp;&nbsp;&nbsp;����ʱ��:<%=endDate%>
		&nbsp;&nbsp;&nbsp;
<!--		&nbsp;&nbsp;&nbsp;<a onclick="javascript:doPrintPreview()" id="x2" style="cursor:hand;">[��ӡԤ��]</a>-->
		&nbsp;&nbsp;&nbsp;<a onclick="javascript:doPrint()" id="x3" style="cursor:hand;">[��ӡ]</a>
		&nbsp;&nbsp;&nbsp;<a onclick="javascript:window.close();" id="x3" style="cursor:hand;">[�ر�]</a>
		</td>
	</tr>
	<tr >
		<td width="5%"></td>
		<td width="25%">
							�ĵ���Դ
						</td>
						<td width="25%">
							δʹ���ĵ���
						</td>
						<td width="25%">
							ѡ���ĵ���
						</td>
						<td width="25%">
							�ɼ��ĵ�����
						</td>
		
	</tr>
	<!--��⵱ǰҳ���Ƿ��м�¼-->
	<pg:notify>
	<tr height="18px" class="labeltable_middle_tr_01">
		<td colspan=100 align='center'>��ʱû�м�¼</td>
	</tr>
	</pg:notify>			      
			      			    
	<!--list��ǩѭ�����ÿ����¼-->			      
	<pg:list>
	<tr>
	    <td><%=i++%></td>
		<td>
								<pg:cell colName="extendSource" defaultValue="" />
							</td>
							<td>
								<pg:cell colName="collectionCount" defaultValue="" />
							</td>
							<td>
								<pg:cell colName="sendCount" defaultValue="" />
							</td>
							
							<td>
								<pg:cell colName="crawlCount" defaultValue="" />
							</td>	
	</tr>
	</pg:list>	
</table>
</pg:pager>
</form>
<iframe height="0" width="0" name="operIframe"></iframe>
</body>
</html>
