<%@ page language="java" contentType="text/html; charset=GBK"%>

<%
	String app_id = request.getParameter("app_id");
%>
<html>
<head>
	<title>�ļ��ϴ�</title>

	<link href="../../css/windows.css" rel="stylesheet" type="text/css">
	<link href="../../css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/windows.css" rel="stylesheet"
		type="text/css">
	<link href="sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="sysmanager/css/contentpage.css" rel="stylesheet"
		type="text/css">

	<!-- dwr begin-->
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/util.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
	<!-- dwr end -->
	
	<!-- �ύ��ҳ���� -->
	<script language="javascript" type="text/javascript"
		src="../pageGrey.js" ></script>	
	<script type="text/javascript">
		function upload(){
				//�ύ��ҳ����
			    popSignFlow(1);
			    
			    var uploadType = getradiovalue();
				
		        uploadForm.action = "<%=request.getContextPath()%>/sysmanager/applymanager/applywork/applylogoupload_do.jsp?app_id=<%=app_id%>&&uploadType="+uploadType;
			   	uploadForm.target = "uploadframe";
			    
		}
		
		
		//�õ�ѡ��ֵ
			function getradiovalue(){
				var r = document.uploadForm.uploadType
					for(var i = 0; i < r.length; i++){
   						if(r[i].checked){
    						return r[i].value;
   							}
						}
			}
	</script>
</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="yes">
		<div align="center">
			<br />
			<form name="uploadForm" method="post" enctype="multipart/form-data" onSubmit="upload();">	
				
					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">�Զ���ͼƬ�ϴ�</FONT>
						</LEGEND>
						<br/>
						<table width="85%" height="35" border="0" align="center"
							cellpadding="0" cellspacing="1" class="thin">
							<tr>
								<td width="20%" height="35" class="detailtitle">
									�ϴ�����:
								</td>
								<td nowrap="NOWRAP" class="detailcontent">									
									<input type="radio" name="uploadType" value="applyLogo" checked="checked"/>Ӧ��Logo
									<input type="radio" name="uploadType" value="applybackground"/>��ͷ����									
								</td>
							</tr>
							<tr>
								<td height="35" class="detailtitle">
									·��ѡ��:
								</td>
								<td class="detailcontent">									
									<input type="file" name="fileType" id="fileType" size="40"
										maxlength="100" unselectable="on" />							
								</td>
							</tr>
						</table>
						<br />						
					</fieldset>
					<br />
					<br />
					<div align="center">
						<table width="35%" border="0" align="right" cellpadding="0"
							cellspacing="0">
							<tr>
								<td>
									<div align="left">										
										<input name="Submit" type="submit" class="input" value="�ϴ�">
										<input name="rsset" type="reset" class="input" value="����">
										<input name="button" type="button" class="input" value="����"
											onClick="window.close();">
									</div>
								</td>
							</tr>
						</table>
					</div>				
			</form>
		</div>
		<br/>
		<br/>
		<br/>		
		<div align="center">
			<table width="50%" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td valign="top" nowrap style="color: #CC0000;font-size: 12px;">
					*ע��					
					</td>
					<td rowspan="2" valign="top" style="color: #CC0000;font-size: 12px;">
					LogoͼƬ��ѡ��75X25���أ�����ͼƬ��ѡ��1024X59���أ���С������5M���ļ���ʽΪ��bmp��gif��jpg��jpeg 
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</div>				
	</body>
	<iframe name="uploadframe" width="0" height="0" style="display: none;"></iframe>
</html>
