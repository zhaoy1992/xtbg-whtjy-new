<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.epp.reportmanage.ReportConfig"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.epp.reportmanage.ReportUtil" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String ec_id = (String)request.getParameter("ec_id");
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);

	boolean isflash = "flash".equalsIgnoreCase(ReportConfig.getProperties("DEFAULT_VIEW"));
	
	String reportId = (String)request.getParameter("reportId");
	
	String reportName = (String)request.getParameter("reportName");
	if(ec_id == null)
    {
		ec_id = "";
	}
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

	<script src="report.js"></script>

  <title>属性容器</title>

  	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">

   <link rel="stylesheet" type="text/css" href="../css/windows.css">
   <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
  <script type="text/javascript">
  

  	function val_input(input)
  	{
  		//验证输入的是否为合法字符
	     var patten=/^[a-zA-Z0-9]+$/;
	  	 if(patten.test(input))
	  	 {
	  		 return true;
	  	 }else
	  	 {
	   	     return false;
	     }
  	}

  	//下载jrxml报表设计文件
  	function downLoadJrxml(rep_id)
  	{
  		window.location.href="downLoadJrxml.jsp?raq="+rep_id;
  	}

  	//打开jrxml报表设计文件
  	function openJrxml(rep_id,rep_type)
  	{
  		window.open("<%=request.getContextPath()%>/report/ireporthandle.jsp?rep_id="+rep_id+"&rep_type="+rep_type);
  	}

  	//新增报表
	function newReport(rep_id)
	{
		var retx=window.showModalDialog("<%=request.getContextPath()%>/report/iframe_main.jsp?ec_id=<%=ec_id%>","properties");
		if(retx) window.location.reload();
	}
	//修改报表信息
	function editReport(rep_id)
	{
		var retx=window.showModalDialog("<%=request.getContextPath()%>/report/report_modify.jsp?repId="+rep_id);
		if(retx=="true") {
			window.location.reload();
		}
	}
	//查看历史版本
	function showReportHistory(repId)
	{
		var retx=window.showModalDialog("report_history.jsp?repId="+repId);
		//if(retx) window.location.reload();
	}

	function deleteReport()
	{
		//删除报表
		if(setSelectId())
		{
			if(window.confirm("确定删除？"))
			{
				var obj1=document.all.selectId;
				var idarray = obj1.value.split(',');
				var flag = -1;
				for(var k=0;k<idarray.length;k++){
					if(''==idarray[k]){
					continue;
					}
					if(document.getElementById(idarray[k]).value==1){
						flag =1;
					}
				}
				if(flag==1){
				alert('已经发布的项目不能删除，你可以先取消发布！');
				return;
				}
				var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=deletereport&ids="+obj1.value+"&userName=<%=control.getUserName()%>&userId=<%=control.getUserID()%>&userAccount=<%=control.getUserAccount()%>");
				alert(retX);
				window.location.reload();
			}
		}
		else
		{
			alert("请选择报表！");
		}
	}

	function setSelectId()
	{
		var els=document.getElementsByName("checkBoxOne");
		var obj1=document.all.selectId;
		obj1.value="";
		var ret = false;
		for(var i=0;i<els.length;i++)
		{
			if(els[i].checked)
			{
				obj1.value+=els[i].value+",";
				ret = true;
			}
		}
		return ret;
	}


	// 复选框全部选中
	function checkAll(totalCheck,checkName){
 	 		var selectAll = document.getElementsByName(totalCheck);
  			var o = document.getElementsByName(checkName);
  			if(selectAll[0].checked==true){
   			for (var i=0; i<o.length; i++){
     	  			if(!o[i].disabled){
     	  				o[i].checked=true;
     	  			}
   			}
  			}else{
   			for (var i=0; i<o.length; i++){
  	  	 	 		o[i].checked=false;
  	   			}
  			}
	}
	function delcheck(statu,rid){
		if(statu==1){
		alert(rid);
		alert(1111);
		return;
		}
	}

	// 单个选中复选框
	function checkOne(totalCheck,checkName){

  		var selectAll = document.getElementsByName(totalCheck);
  		var o = document.getElementsByName(checkName);
		var cbs = true;
		for (var i=0;i<o.length;i++){
			if(!o[i].disabled){
				if (o[i].checked==false){
					cbs=false;
				}
			}
		}
		if(cbs){
			selectAll[0].checked=true;
		}else{
			selectAll[0].checked=false;
		}
	}
	//打开设计器
	function openDesigner()
	{

		window.open("<%=request.getContextPath()%>/report/reportDesign_do.jsp");
	}
	//打开润前报表
	function designReport(repId)
	{
			window.open("<%=request.getContextPath()%>/report/reportopen_do.jsp?repId="+repId);
	}
	//打开jasper报表
  	function openJrxml(rep_id,rep_type)
  	{
  			window.open("<%=request.getContextPath()%>/report/ireporthandle.jsp?rep_id="+rep_id+"&rep_type="+rep_type);
  	}
	//运行报表
	function runReport(repId,repSType,repName)
	{
		window.open("<%=request.getContextPath()%>/report/showreport.jsp?raq="+repId+"&type_lm="+repSType+"&reportname_lm="+repName);
	}
	//发布报表
	function publish(repId,userName)
	{
		var retX=SendHttp("<%=request.getContextPath()%>/report/reportglobalservlet?@action=publisher&operator=p&repId="+repId+"&userName="+userName);
		alert(retX);
		window.location.reload();
	}
	//取消发布
	function cancelPublish(repId)
	{
		var retX=SendHttp("<%=request.getContextPath()%>/report/reportglobalservlet?@action=publisher&operator=c&repId="+repId);
		alert(retX);
		window.location.reload();
	}

	//清空
	function myclear()
	{
		document.getElementById('_reportid').value="";
		document.getElementById('_reportname').value="";
	}

	function queryForm()
	{
		var reportId = document.all("reportId").value;
		var reportName = document.all("reportName").value;
		var class_name = document.getElementById('hidvalue').value;
		var sUrl="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/properties_content.jsp?reportId="+reportId+"&reportName="+reportName+"&bool=true&ec_id=<%=ec_id%>&class_name="+class_name;
		
		ProcessForm.action=sUrl;
		ProcessForm.submit();
	}

	function openJrxmlDesigner(){
		window.open("<%=request.getContextPath()%>/report/ireportRemoteDesigner/jnlp.jsp");
	}
  </script>

</head>

<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="ProcessForm" action="properties_content.jsp" method="post">
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							报表编号：
						</td>
						<td class="detailcontent" width="90%">
							<input id = "_reportid" type="text" name="reportId" style="width:70%" value="<%= reportId%>">
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="10%" align=right>
							报表名称：
						</td>
						<td class="detailcontent" width="90%">
							<input id="_reportname" type="text" name="reportName" style="width:70%" value="<%= reportName%>">
						</td>
					</tr>
					<tr>
						<td width="16%">
						</td>
						<td class="detailcontent" width="30%" align="right">
							<input name="Submit4" type="submit" class="input" value="查询">
							<input name="Submit22" type="button" class="input" value="清空" onClick="myclear()">
						</td>
					</tr>
				</table>
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=10>
							<input id="hidvalue" type="hidden" value="<%=request.getParameter("class_name")==null?"":request.getParameter("class_name") %>">
							<b>报表列表(<%=request.getParameter("class_name") %>)</b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.epp.reportmanage.menu.ReportList" keyName="reportList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="reportList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P>
							</td>
							<td height='20' class="headercolor">
								报表编号
							</td>
							<td height='20' class="headercolor">
								报表名称
							</td>
							<td height='20' class="headercolor">
								报表类型
							</td>
							<td height='20' class="headercolor">
								报表描述
							</td>
							<td height='20' class="headercolor">
								版本
							</td>
							<td height='20' class="headercolor">
								发布状态
							</td>
							<td height='20' class="headercolor">
								发布人
							</td>
							<td height='20' class="headercolor">
								发布时间
							</td>
							<td height='20' class="headercolor">
								修改
							<input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false"/>
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
									<P align="left" >
										<INPUT type="checkbox" name="checkBoxOne"
											onclick="checkOne('checkBoxAll','checkBoxOne')"
											value='<pg:cell colName="rep_id" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<pg:cell colName="rep_id" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<pg:cell colName="rep_name" defaultValue="" maxlength="15"/>
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_GROU0P %>">
											润乾
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_GROU0P_ARG %>">
											润乾
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ %>">
											润乾
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ_ARG %>">
											润乾
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT %>">
											jasper
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION %>">
											jasper(javabean)
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_FILL %>">
											jasper(填报)
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT %>">
											jasper(子报表)
										</pg:equal>
								</td>

								<td height='20' align="left" class="tablecells">
									<pg:cell colName="rep_desc" defaultValue="" maxlength="15"/>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="rep_ver" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells">
								<input type="hidden" id="<pg:cell colName="rep_id" defaultValue=""/>" value="<pg:cell colName="publishstate" defaultValue=""/>" />
									<pg:equal colName="publishstate" value="0">
										未发布
									</pg:equal>
									<pg:equal colName="publishstate" value="1">
										已发布
									</pg:equal>
								</td>

								<td height='20' align="left" class="tablecells">
									<pg:cell colName="publisher" defaultValue="" />
								</td>

								<td height='20' align="left" class="tablecells">
									<pg:cell colName="publishtime" defaultValue="" dateformat="yyyy-MM-dd HH:mm:ss"/>
								</td>

								<td height='20' align="left" class="tablecells">
									<pg:equal colName="publishstate" value="0">
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_GROU0P %>">
											<input type="button" value="修改文件" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_GROU0P_ARG %>">
											<input type="button" value="修改文件" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ %>">
											<input type="button" value="修改文件" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_RAQ_ARG %>">
											<input type="button" value="修改文件" onclick="designReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT %>">
											<input type="button" value="修改文件" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION %>">
											<input type="button" value="修改文件" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_FILL %>">
											<input type="button" value="修改文件" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										<pg:equal colName="rep_stype" value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT %>">
											<input type="button" value="修改文件" onclick="openJrxml('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>')"/>
										</pg:equal>
										<input type="button" value="发布" onclick="publish('<pg:cell colName="rep_id" defaultValue="" />','<%=control.getUserName()%>')"/>
									</pg:equal>
									<pg:equal colName="publishstate" value="1">
										<input type="button" value="运行" onclick="runReport('<pg:cell colName="rep_id" defaultValue=""/>','<pg:cell colName="rep_stype" defaultValue=""/>','<pg:cell colName="rep_name" defaultValue="" />')"/>
										<input type="button" value="取消" onclick="cancelPublish('<pg:cell colName="rep_id" defaultValue="" />')"/>
									</pg:equal>
									<input type="button" value="修改信息" onclick="editReport('<pg:cell colName="rep_id" defaultValue=""/>')"/>
								</td>
								</tr>
						</pg:list>


						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align="right">
								共
								<pg:rowcount />
								条记录
								<pg:index />

								<input name="Submit" type="button" class="input" value="新增"
									onClick="newReport('<%=request.getParameter("ec_id") %>')"/>
								<input type="button" value="删除" class="input"
									onclick="deleteReport()"/>
									<%
									if(ReportConfig.getPropertiesBoolean("USE_RUNQIAN")){
									%>
									<br>
								<input name="Submit" type="button" class="input" value="打开润乾设计器"
									onClick="openDesigner()"/>
									<%}%>
										<%
									if(ReportConfig.getPropertiesBoolean("USE_JASPERREPORT")){
									%>
								    <input name="Submit" type="button" class="input" value="打开Ireport设计器"
									onClick="openJrxmlDesigner()"/>
									<%}%>
							</td>
						</tr>
					</pg:pager>

				</table>

				<div align="center">
				</div>
			</form>
		</div>
	</body>
	<iframe name="properties" style="display:none"></iframe>
</html>
