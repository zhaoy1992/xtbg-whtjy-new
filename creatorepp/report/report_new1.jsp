<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.epp.reportmanage.vo.*" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.epp.reportmanage.JasperReport.subreport.SubInfo"%>
<%@page import="com.chinacreator.epp.reportmanage.ReportUtil"%>
<html>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

	AccessControl control = AccessControl.getInstance();
 	control.checkAccess(request,response);
 	ReportUtil ru= new ReportUtil();
 	
	List<SubInfo> subinfos= (List)session.getAttribute("subinfos"); 
	Report report= (Report)session.getAttribute("report");
	
%>
<head>
	<title>请输入报表名</title>

	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/windows.css"/>
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/treeview.css"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/report/prototype-1.4.0.js"></script>
	<script type="text/javascript">
		function back() {
			var win1= window.open("report_new.jsp");
			this.close();
		}
		
		function uploadToServer() {
			document.all.divProcessing.style.display="block";
			var isFillAll= "true";
			var isTypeError= "true";
			 for(var j= 0;j<"<%=subinfos.size()%>";j++) {
			 	if(document.getElementById(j).value== "")
				    {
				        isFillAll= "false";
				    }
				 if(document.getElementById(j).value.lastIndexOf(".jrxml")==-1) {
				 		isTypeError=="false";
				 }
			 }
			 if(isFillAll=="false") {
			 				alert("请上传全部子资源文件！！");
							document.all.divProcessing.style.display="none";
							return false;
			 }
			
		     if(isTypeError=="false") {
							alert("文件类型错误！(只能是jrxml格式)");
							document.all.divProcessing.style.display="none";
							return false;
			}
			var subName = document.getElementById("subName").value;
			alert(subName);
			//document.all.myform.action="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/reportTools?op=uploadSubReport&repSType=9";
			document.all.myform.action="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/reportTools?op=uploadSubReport&repSType=9&subName="+subName;
			document.all.myform.encoding="multipart/form-data";
			document.all.myform.method="post";
		    document.all.myform.submit();
		}
		
	</script>
</head>

<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="no">
	<form method="post" name="myform">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">父报表名称*：</td>
						<td height="25">
							<%=report.getRepName()%>
						</td>
					</tr>
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">父报表路径*：</td>
						<td height="25">
							<%=report.getFilePath()%>
						</td>
					</tr>
		<%
			for(int i= 0;i<subinfos.size();i++) { 
			SubInfo s= subinfos.get(i);
			String oriPath= s.getOriginalPath();
		
		%>
			<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">子资源<%=i+1%>*：</td>
						<td height="25">
						<%=oriPath.replaceAll(".jasper",".jrxml").replaceAll("\"","")%>	
						</td>
			</tr>
			<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">子资源名称：</td>
						<td height="25">
							<input type="text" name=<%=s.getNewPath()%> id="subName" maxlength="100"/>
						</td>
			</tr>
			<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">请选择子资源：</td>
						<td height="25">
							<input type="file" name="subrep"+<%=i%> id="<%=i%>" maxlength="100" contentEditable="false"/>
						</td>
			</tr>
		<%
			}
		%>
				</table>

            	<hr width="100%"/>

				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">
								<input name="pre_action" type="button" class="input" value="上一步" onClick="back()"/>
								<input name="button_" type="button" class="input" value="上传服务器" onClick="uploadToServer()"/>
						    </div>
						</td>
					</tr>
				  </table>
				  
	</form>		  
		<div id="divProcessing" style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...上传中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>		  
				  
	</body>
</html>