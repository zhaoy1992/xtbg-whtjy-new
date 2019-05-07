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

  <title>属性容器</title>
  
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
					alert("你没有选择项目！");
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
							<b>报表列表(${param.class_name })</b>
						</td>
					</tr>
					<pg:listdata dataInfo="PublishedReportList" keyName="PublishedReportList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="PublishedReportList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
								&nbsp;
								</P>
							</td>
						
							<td height='20' class="headercolor">
								报表名称
						
						
						
									</td>
						</tr>

						<pg:param name="ec_id" />
						<pg:param name="class_name" />
						
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有报表
								</td>
							</tr>
						</pg:notify>		
									
						
						<!--list标签循环输出每条记录-->
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
								共
								<pg:rowcount />
								条记录
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
										<input name="Submit" type="button" class="input" value="确定"
											onClick="uf_ok()">
									</div>
								</td>
								<td>
									<div align="center">
										<input name="cancel" type="button" class="input" value="取消"
											onClick="window.close()">
									</div>
								</td>
							</tr>
						</table>
					</div>
			
		</div>
	</body>
</html>
