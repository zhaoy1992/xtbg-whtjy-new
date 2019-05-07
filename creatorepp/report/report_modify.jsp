<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.epp.reportmanage.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.factory.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.service.*" %>
<%@ page import="com.chinacreator.epp.reportmanage.vo.*" %>
<%@ include file="/epp/css/cssControl.jsp"%>
<%
	String repId= request.getParameter("repId");
	ReportManage rm = ReportBeanFactory.getReportManager();
 	Tb_report report = rm.getReport(repId);
 	String reportName= report.getRep_name();
 	String reportDesc= report.getRep_desc();
 	String reportVer= report.getRep_ver();
 	int reportType= report.getRep_stype();
 %>
<html>
  <head>
<script src="report.js"></script>
  <script type="text/javascript">
  
  	function commitModify() {
  		var reportName= document.getElementById("repName").value;
  		var reportType= document.getElementById("repSType").value;
  		var reportVer= document.getElementById("currentVersion").value;
  		var reportDesc= document.getElementById("repDesc").value;
  		var isnewVersion= document.getElementById("addversion").checked;
  		if(reportVer=="") {
  			reportVer= "1";
  		}
  		if(isnewVersion) {
  			reportVer= "2";
  		}
  		if(reportName == null || reportName=="") {
  			alert("必须输入报表名");return;
  		}
  		if(reportName != "<%=reportName%>") {
  			
  			 //var patten=/^[a-zA-Z0-9]+$/;
		     var patten=/^([a-zA-Z0-9]|[\u4E00-\u9FA5]|[\uFE30-\uFFA0])*$/gi;
		  	 if(!patten.test(reportName))
		  	 {
		  	 	alert("报表名称只能输入字符和数字");
		  		 return;
		  	 }
		  	 
		  	 if(checkReportName(reportName)){
  				return;
  			}
  		}
  		var retX= SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=updatereport&reportId=<%=repId%>&reportName="+reportName+"&reportType="+reportType+"&reportVersion="+reportVer+"&reportDesc="+reportDesc);
  		alert(retX);
  		if(retX=="修改成功") {
  			returnValue="true";
  		}
  		window.close();
  	}
  
  	function checkReportName(repname){
		var ret=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=validatereportname&name="+repname);
		if(ret != "") {
			document.getElementById("myspan").innerHTML= "<font size='2' color='red'>"+ret+"</font>";
			return true;
		}else if(ret == "") {
			document.getElementById("myspan").innerHTML="";
			return false;
		}
	}
  
  </script>
 </head>

 <body>
 	<form method="post" name="modifyForm" action="">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">报表名称*：</td>
						
						<td height="25">
							<input type="text" id="repName" name="repName" desc="报表名称" maxlength="100" value="<%=reportName== null?"":reportName%>"/>
							<span id="myspan" name="myspan"></span>
						</td>
					</tr>

					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">报表类型*：</td>
						<td height="25">
							<select id="repSType" name="repSType" DISABLED>
								<%if(ReportConfig.getPropertiesBoolean("USE_RUNQIAN")){ %>
								<option value="<%=ReportUtil.REPORT_TYPE_RAQ%>" <%=reportType==0?"SELECTED":""%>>普通报表</option>
								<option value="<%=ReportUtil.REPORT_TYPE_RAQ_ARG%>" <%=reportType==1?"SELECTED":""%>>参数报表</option>
								<option value="<%=ReportUtil.REPORT_TYPE_GROU0P%> <%=reportType==4?"SELECTED":""%>">普通报表组</option>
								<option value="<%=ReportUtil.REPORT_TYPE_GROU0P_ARG%>" <%=reportType==5?"SELECTED":""%>>参数报表组</option>
								<%}
								if(ReportConfig.getPropertiesBoolean("USE_JASPERREPORT")){
								 %>
								<option value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT%>" <%=reportType==6?"SELECTED":""%>>jasperreport</option>
								<option value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_COLLECTION%>" <%=reportType==7?"SELECTED":""%>>jasperreport(javabean数据源)</option>
								<option value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_FILL%>" <%=reportType==8?"SELECTED":""%>>jasperreport(填报)</option>
								<option value="<%=ReportUtil.REPORT_TYPE_JASPERREPORT_SUBREPORT%>" <%=reportType==9?"SELECTED":""%>>jasperreport(子报表)</option>
								<%} %>
							</select>
						</td>
					</tr>

					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">报表版本*：</td>
						<td height="25">
							<input id="currentVersion" type="text" name="repVer" desc="版本" maxlength="100" value="<%=reportVer== null?"":reportVer%>" readonly="readonly"/>
							<input type="checkbox" name="addversion" id="addversion"/>添加新版本
						</td>
					</tr>
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">报表描述：</td>
						<td height="25">
							<input type="text" id= "repDesc" name="repDesc" desc="报表描述" maxlength="100" value="<%=reportDesc== null?"":reportDesc%>"/>
						</td>
					</tr>
				</table>

            	<hr width="100%"/>

				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">
								<input name="button_" type="button" class="input" value="提交修改" onClick="commitModify();"/>
						    </div>
						</td>
					</tr>
				  </table>
				  </form>
 </body>
</html>
