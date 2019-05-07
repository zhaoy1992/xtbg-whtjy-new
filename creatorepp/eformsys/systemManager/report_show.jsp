<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.epp.reportmanage.ReportUtil" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	//response.setHeader("Pragma","No-cache");
	//response.setHeader("Cache-Control","no-cache");
	//response.setDateHeader("Expires", 0); 
	String ec_id = request.getParameter("ec_id");
	
	System.out.println(ec_id);
	//AccessControl control = AccessControl.getInstance();
	//control.checkAccess(request,response);
	
	String reportId = (String)request.getParameter("reportId");
	String reportName = (String)request.getParameter("reportName");
	
	if(reportId == null)
    {
		reportId = "";
	}
	if(reportName == null)
    {
		reportName = "";
	}
%>
<html>
<head>  

  <title>��������</title>
  
  	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">
  
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/windows.css">
   <link rel="stylesheet" type="text/css" href="<%=basePath %>css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="<%=basePath %>css/tab.winclassic.css">
  <link rel="stylesheet" type="text/css" href="<%=basePath %>sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="<%=basePath %>sysmanager/css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="<%=basePath %>sysmanager/css/tab.winclassic.css">
  <script type="text/javascript">
 		function uf_ok(){
		        var reportradio = document.getElementsByName("checkradio");
				var flag=false;
				var rvalue='';
				for(var i=0;i<reportradio.length;i++){
				if(reportradio[i].checked==true){
					rvalue=reportradio[i].value;
					flag=true;
					break;
				}
				}
				if(!flag){
					alert("��û��ѡ����Ŀ��");
					return;
				}
				
				var splitstr=rvalue.split('@');
				
		     	var r_id=splitstr[0];
				var r_name=splitstr[1];
				window.top.close(); 
				window.returnValue=r_id + ";"+r_name;
		}
 
 </script>
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">
					<tr>
						<td height='30' class="detailtitle" align=center colspan=8>
							<b>�����б�(${param.class_name })</b>
						</td>
					</tr>
					<pg:listdata dataInfo="PublishedReportList" keyName="PublishedReportList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="10" scope="request" data="PublishedReportList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--���÷�ҳ��ͷ-->
							<td class="headercolor" width="6%">
								<P align="left">
								&nbsp;
								</P>
							</td>
						
							<td height='20' class="headercolor">
								��������
						
						
						
									</td>
						</tr>

						<pg:param name="ec_id" />
						<pg:param name="class_name" />
						
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									��ʱû�б���
								</td>
							</tr>
						</pg:notify>		
									
						
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
							<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'"
								>
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="radio" name="checkradio"
											value="<pg:cell colName='repId' defaultValue=''/>@<pg:cell colName='repName' defaultValue='' />">
									</P>
								</td>
							
								<td height='20' align="left" class="tablecells" onclick="">
									<pg:cell colName="repName" defaultValue="" />
								</td>
								
							
								</tr>
						</pg:list>
						
						
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='left'>
								��
								<pg:rowcount />
								����¼
								<pg:index />
							</td>
						</tr>
					</pg:pager>

				</table>

				<br />
					<br />
					<div align="center">
						<table width="100%" border="0" align="center" cellpadding="0"
							cellspacing="0">
							<tr>
								<td>
									<div align="center">
										<input name="Submit" type="button" class="input" value="ȷ��"
											onClick="uf_ok()">
									</div>
								</td>
								<td>
									<div align="center">
										<input name="cancel" type="button" class="input" value="ȡ��"
											onClick="window.close()">
									</div>
								</td>
							</tr>
						</table>
					</div>
			
		</div>
	</body>
</html>
