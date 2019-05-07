<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String filename = request.getParameter("filename") != null ? request
			.getParameter("filename")
			: "";
%>
<html>
	<head>
		<title>��������</title>

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js" type="text/javascript"></script>
		<!-- dwr begin-->
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/sysmanager/applymanager/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/menuissueChange.js'></script>
		<!-- dwr end -->

		<!-- �ύ��ҳ���� -->
		<script language="javascript" type="text/javascript" src="../pageGrey.js">
		</script>
		<script type="text/javascript">
		function impmenuShowContent(){
			//�ύ��ҳ����
			popSignFlow(1);				
			menuissueChange.showContentToFilename("<%=filename%>",result);
		}
		
		function result(obj){			
			DWREngine.setPreHook(function() {});				
			DWREngine.setPostHook(function() {});
			//ҳ���һָ�����
			cancelSign();
			
			if(obj[0]=="false"){
				alert(obj[1]);
			}else{				
				
				document.getElementById("type").innerHTML = obj[1];
				document.getElementById("time").innerHTML = obj[2];
				document.getElementById("workclass").innerHTML = obj[3];
				document.getElementById("eform").innerHTML = obj[4];
				document.getElementById("eform_warn").innerHTML = obj[5];				
				document.getElementById("jawe").innerHTML = obj[6];
				document.getElementById("jawe_warn").innerHTML = obj[7];	
				document.getElementById("report").innerHTML = obj[8];
				document.getElementById("report_warn").innerHTML = obj[9];
				document.getElementById("filename").innerHTML = obj[10];
				document.getElementById("filename_warn").innerHTML = obj[11];
				document.getElementById("remark").innerHTML = obj[12];
			}
		}
		
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="auto" onload="impmenuShowContent()">
		<div id="contentborder" align="center">
			<table width="100%">
				<tr>
					<td align="center" colspan=2>
						<br />
						<br />
						<fieldset style="width: 90%;">
							<LEGEND align=center>
								<FONT size="2">���°�����</FONT>
							</LEGEND>
							<br />
							<table align="left" width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
								<tr>
									<td width="20%" height="25">
										��������:
									</td>
									<td id="type" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										����ʱ��:
									</td>
									<td id="time" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										ҵ�����:
									</td>
									<td id="workclass" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										��:
									</td>
									<td id="eform" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										������:
									</td>
									<td id="eform_warn" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										����:
									</td>
									<td id="jawe" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										���̾���:
									</td>
									<td id="jawe_warn" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										����:
									</td>
									<td id="report" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										������:
									</td>
									<td id="report_warn" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										�����ļ�:
									</td>
									<td id="filename" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										�����ļ�����:
									</td>
									<td id="filename_warn" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
								<tr>
									<td width="20%" height="25">
										��ע:
									</td>
									<td id="remark" width="400" style="word-wrap:break-word;">
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
			<div align="center">
				<table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<div align="center">
								<input type="button" value="�رմ���" class="input" onclick="window.close();">
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>

	</body>
</html>
