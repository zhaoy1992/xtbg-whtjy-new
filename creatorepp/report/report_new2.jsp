<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.epp.reportmanage.vo.*" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.epp.reportmanage.service.ReportManage" %>
<%@page import="com.chinacreator.epp.reportmanage.factory.ReportBeanFactory"%>
<html>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

	AccessControl control = AccessControl.getInstance();
 	control.checkAccess(request,response);
 	//获得输入信息
 	String ec_id = request.getParameter("ec_id");
 	String repName = request.getParameter("repName");
 	String repVer = request.getParameter("repVer");
 	String repDesc = request.getParameter("repDesc");
 	String repSType = request.getParameter("repSType");
	
	
 	Tb_report rep = null;
 	boolean isEdit = (request.getParameter("isEdit")!=null&&request.getParameter("isEdit").equals("true"))?true:false;
 	String repId = null;
 	if(isEdit)
 	{
 		repId = request.getParameter("repId");
 		ReportManage rm =ReportBeanFactory.getReportManager();
 		rep = rm.getReport(repId);
 	}
%>
<head>
	<title>请选择报表文件</title>

	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">

	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/treeview.css">
	<script src="<%=request.getContextPath() %>/eformsys/fceform/js/fcpub.js"></script>
	<script>
		var _val ='1';
		var ec_id = '<%=ec_id%>';
		var _name = '<%=repName%>';
		var _ver = '<%=repVer%>';
		var _desc = '<%=repDesc%>';
		<%
			//如果是参数报表或者参数报表组
			if(repSType.equals("1")||repSType.equals("3")){
		%>
			var submit_url = "reportupload_do2.jsp?";
		<%}else{%>
			var submit_url = "reportupload_do.jsp?";
		<%}%>

		<%
			//报表组不能从服务器上选择文件
			if(repSType.equals("2")||repSType.equals("3")){
		%>
			hideServerFileSel();
		<%}else{%>
			showServerFileSel();
		<%}%>

		function hideServerFileSel()
		{
			//隐藏从服务器上传文件的选项
			alert("hide");
			document.all.td_f_server.style.display="none";
		}

		function showServerFileSel()
		{
			//显示从服务器上传文件的选项
			alert("show");
			document.all.td_f_server.style.display="block";
		}

		function befo_submit()
		{
			newReport(ec_id,_name,_ver,_desc);
		}

		function newReport(ec_id,_name,_ver,_desc)
		{
			document.all.divProcessing.style.display="block";
			<%
				if(isEdit){
					String isCreateNew = (request.getParameter("isCreateNew")!=null)?"true":"false";
			%>
				//修改的时候是否创建新版本
				//var isCreateNew = (document.all.createNew.checked)?"true":"false";

				if(_val=='2')
				{
					var server_file = document.all.server_file.value;
					submit_url = submit_url+"ec_id=<%=ec_id%>&repName="+_name+"&repVer="+_ver+"&repDesc="+_desc+"&filesource=serverfile&isEdit=true&repId=<%=repId%>&isCreateNew=<%=isCreateNew%>&server_file="+server_file;
					if(<%=repSType%>==1||<%=repSType%>==3)
					{
						//参数报表
						var server_file2 = document.all.server_file2.value;
						submit_url += "&server_file2="+server_file2;
					}
					window.location.href = submit_url;
				}
				else
				{
					document.all.reportForm.action = submit_url+"ec_id=<%=ec_id%>&repName="+_name+"&repVer="+_ver+"&repDesc="+_desc+"&filesource=localfile&isEdit=true&repId=<%=repId%>&isCreateNew=<%=isCreateNew%>&repSType=<%=repSType%>";

					if((document.all.f.value.lastIndexOf(".raq")==-1)&&(document.all.f.value.lastIndexOf(".rpg")==-1))
					{
						alert("文件类型错误！！");
						document.all.divProcessing.style.display="none";
						return false;
					}
					if(<%=repSType%>==1||<%=repSType%>==3)
					{
						if(document.all.f.value.lastIndexOf(".raq")==-1&&document.all.f.value.lastIndexOf(".rpg")==-1)
						{
							alert("文件类型错误！！");
							document.all.divProcessing.style.display="none";
							return false;
						}
					}
					document.all.reportForm.submit();
				}
			<%}else{%>
				if(_val=='2')
				{
					var server_file = document.all.server_file.value;
					submit_url = submit_url+"ec_id=<%=ec_id%>&repName="+_name+"&repVer="+_ver+"&repDesc="+_desc+"&filesource=serverfile&repSType=<%=repSType%>&server_file="+server_file;
					if(<%=repSType%>==1||<%=repSType%>==3)
					{
						//参数报表
						var server_file2 = document.all.server_file2.value;
						submit_url += "&server_file2="+server_file2;
					}
					//document.all.reportForm.action = submit_url;
					window.location.href = submit_url;
				}
				else
				{
					document.all.reportForm.action = submit_url+"ec_id=<%=ec_id%>&repName="+_name+"&repVer="+_ver+"&repDesc="+_desc+"&filesource=localfile&repSType=<%=repSType%>";
					if(document.all.f.value.lastIndexOf(".raq")==-1&&document.all.f.value.lastIndexOf(".rpg")==-1)
					{
						alert("文件类型错误！！");
						document.all.divProcessing.style.display="none";
						return false;
					}
					if(<%=repSType%>==1||<%=repSType%>==3)
					{
						if(document.all.f.value.lastIndexOf(".raq")==-1&&document.all.f.value.lastIndexOf(".rpg")==-1)
						{
							alert("文件类型错误！！");
							document.all.divProcessing.style.display="none";
							return false;
						}
					}
					document.all.reportForm.submit();
				}
			<%}%>
		}

		function setFileSource(val)
		{
			if(val=='1')
			{
				_val='1';
				document.all.serverfile.style.display="none";
				document.all.localfile.style.display="block";
				document.all.reportForm.encoding="multipart/form-data";
				document.all.reportForm.method="post";
				//document.all.reportForm.target="uploadframe";
			}
			else
			{
				_val='2';
				document.all.serverfile.style.display="block";
				document.all.localfile.style.display="none";
				document.all.reportForm.encoding="application/x-www-form-urlencoded";
				document.all.reportForm.method="get";
				//document.all.reportForm.target="uploadframe";
			}
		}

		function openWin1()
		{
		     var retx = window.showModalDialog("file_list_main.jsp");
		     if(retx == undefined){
		     retx = "";
		     }
		     document.all.server_file.value=retx;
		}
		function openWin2()
		{
		     var retx = window.showModalDialog("file_list_main.jsp");
		     if(retx == undefined){
		     retx = "";
		     }
		     document.all.server_file2.value=retx;
		}
	</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" onload="" scroll="no">
		<div>
			<form method="post" name="reportForm" action="" enctype="multipart/form-data">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">
							<input type="radio" name="filesource" value="1" onclick="setFileSource(this.value)" CHECKED/>本地文件
						</td>
						<td height="25" id="td_f_server">
							<input type="radio" name="filesource" value="2" onclick="setFileSource(this.value)"/>服务器文件
						</td>
					</tr>

					<%--<input type="hidden" name="repName" value="<%=repName %>"/>
					<input type="hidden" name="repVer" value="<%=repVer %>"/>
					<input type="hidden" name="repDesc" value="<%=repDesc %>"/>
					<input type="hidden" name="repSType" value="<%=repSType %>"/>

					--%><tr class="tr" id="localfile" style="display:block">
						<td width="35%" height="25" class="detailtitle" align="center">本地报表文件*：</td>
						<td height="25">
							<input type="file" name="f" maxlength="100" UNSELECTABLE="on"/>
							<%
								//如果是参数报表
								if(repSType.equals("1")||repSType.equals("3")){
							%>
							<input type="file" name="f2" maxlength="100" UNSELECTABLE="on"/>
							<%} %>
						</td>
					</tr>
					<tr class="tr" id="serverfile" style="display:none">
						<td width="35%" height="25" class="detailtitle" align="center">已上传的报表文件*：</td>
						<td height="25">
							<input type="text" name="server_file" maxlength="100" UNSELECTABLE="on"/>
							<input type="button" name="server_file_brow" value="浏览..." onclick="openWin1()"/>
							<%
								//如果是参数报表
								if(repSType.equals("1")||repSType.equals("3")){
							%>
							<br/>
							<input type="text" name="server_file2" maxlength="100" UNSELECTABLE="on"/>
							<input type="button" name="server_file_brow" value="浏览..." onclick="openWin2()"/>
							<%} %>
						</td>
					</tr>
				</table>

            	<hr width="100%">

				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">
								<input type="button" class="input" value="上一步" onclick="new1()">
								<input name="button_" type="button" class="input" value="确定" onClick="befo_submit();">
						    </div>
						</td>
					</tr>
				  </table>

			</form>
		</div>
		<div id="divProcessing" style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe name="uploadframe" width="0" height="0" style="display: none;"></iframe>
</html>