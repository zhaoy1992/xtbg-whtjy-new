<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<html>
	<head>
		<title>��������</title>

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js" type="text/javascript"></script>

		<!-- �ύ��ҳ���� -->
		<script language="javascript" type="text/javascript" src="../pageGrey.js">
		</script>
		<script type="text/javascript">
			function upload(){
				if(document.impmenudeployform.fileType.value==""){
					alert("��ѡ��ģ����°���");
				}else{					
					//�ύ��ҳ����
					popSignFlow(1);					
					document.impmenudeployform.submit();					
				}
			}		
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">		
			<div id="contentborder" align="center">
				<br />
				<br />				
				<form name="impmenudeployform" action="impmenuload_do.jsp" method="post" enctype="multipart/form-data">
				<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">�ϴ�ģ����°�</FONT>
						</LEGEND>
				<br />
				<table width="85%">
					<tr>
						<td align="center" height="35">
							<input type="file" name="fileType" id="fileType" size="40" maxlength="100" unselectable="on" />
						</td>
					</tr>								
				</table>
				</fieldset>					
					<div align="center">
					<table width="35%" border="0" align="right" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<div align="left">	
									<input name="button" type="button" class="input" value="��һ��" onClick="document.location='impmenuinfo.jsp';">		
									<input name="rsset" type="reset" class="input" value="����">														
									<input name="button" type="button" class="input" value="��һ��" onclick="upload();">							
									
								</div>
							</td>
						</tr>
					</table>
				     </div>
				</form>
			</div>		
	</body>
</html>
	