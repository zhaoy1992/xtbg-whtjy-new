<%
/**
  *	���������ĵ�
  */
%>
<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.security.*"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	//String docpath = request.getParameter("docpath");
	String siteid = request.getParameter("siteid");
	String channelId = request.getParameter("channelId");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<title>:::::���������ĵ�::::::::::::::::::::::.</title>
<style type="text/css">
	.STYLE1 {color: #0000FF}
	.STYLE2 {color: #000099}
	.operStyle{
	width:17;
	height:16;
	}
.style7 {font-size: 5px}
</style>
<script src="../inc/js/func.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function subform(){
		if(document.getElementById("d_checkfromfile").checked )
		{
			if(uploadform.UploadFileName.value == "")
			{
				alert("��ѡ��Ҫ�ϴ���ģ��zip�ļ���");
				return false;
			}
			else
			{
				uploadform.fname.value = uploadform.UploadFileName.value;
			}
		}
		if(document.getElementById("d_checkfromurl").checked && uploadform.urlfname.value=="")
		{
			alert("��ѡ��Ҫ�ϴ���ģ��zip�ļ���");
			return false;
		}
		
		var impfile = document.all("UploadFileName").value;
        var oExtPattern   =   /.+\\.([Z][z][I][i][P][p])$/i;   
        
        if(impfile.search(/\.([Z]|[z])([I]|[i])([P]|[p])$/img)<=0)
        {
          	alert("��ѡ��Ҫ�ϴ���ģ��zip�ļ���");
            return false;    
        }   

		uploadform.action = "doc_import.jsp?siteid=<%=siteid%>&channelId=<%=channelId%>";
		uploadform.submit();
		document.all.divProcessing.style.display = "";
	}
	function UploadLoaded(count)
	{
		alert("�ɹ�����" + count);
		var str = window.dialogArguments.location.href;
		var strArray = str.slice(0,str.indexOf("?"));
		window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
		window.close();
	}
	function RadioClick(what)
	{
		if (what=="url"){
			local.disabled = true;
			url.disabled = false;
			document.getElementById("d_checkfromfile").checked = false;
			document.getElementById("d_checkfromurl").checked = true;
		}else{
			local.disabled = false;
			url.disabled = true;
			document.getElementById("d_checkfromfile").checked = true;
			document.getElementById("d_checkfromurl").checked = false;
		}
	}
	
	function setImage(uri){
		document.all("urlfname").value  = uri;
	}
	function xuanze()
	{
		openWin("../channelManage/filelist_browse.jsp",586,486);
	}

</SCRIPT>
</head>
<body bgcolor="#F7F8FC" onload="RadioClick('file')">
	<form target="uploaddoc" method="post" name="uploadform" enctype="multipart/form-data">
		<input type="hidden" name="fname" value="">
		<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize>
			<tr>
				<td>
					<table border=0 cellpadding=0 cellspacing=0 align=center>
						<tr>
							<td>
							<fieldset>
							<legend>�ļ���Դ</legend>
							<table border=0 cellpadding=5 cellspacing=0 width="100%">
							<tr><td>
						
								<table border=0 cellpadding=0 cellspacing=0 width="300px"><tr><td></td></tr></table>
								<table border=0 cellpadding=0 cellspacing=2 width="100%">
									<tr >
										<td  noWrap width="20%" onclick="RadioClick('file')">
										<input type="radio" id="d_checkfromfile" value="1">
										<label >�ϴ�</label>:</td>
										<td noWrap id="local" width="80%">
										<input type="file" name="UploadFileName" contentEditable="false" id="UploadFileName" size="20">
										</td>
									</tr>
									<tr >
										<td noWrap width="20%" onclick="RadioClick('url')">
										<input type="radio" id="d_checkfromurl" value="1">
										<label>����</label>:</td>
										<td noWrap id="url" width="80%">
											<input type="text" name="urlfname" value="" readonly size="20">
											<input type="button" value="���..." onclick="xuanze()" style="width:63px;height:18px;margin-left:2px;padding-top:0px;">
										</td>
									</tr>
								</table>
						
							</td></tr>
							</table>
							</fieldset>
							</td>
						</tr>
					<tr><td height=5>&nbsp;</td></tr>
					<tr>
						<td noWrap align=right>
						<input type="button" value="ȷ��" class="cms_button" id="Ok" onclick="subform()">
						&nbsp;&nbsp;
						<input type="button" value="ȡ��" class="cms_button" onclick="window.close();">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
		
		
	</form>
	<div id="divProcessing" style="width:180px;height:30px;position:absolute;left:50px;top:30px;display:none">
		<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
			<tr>
				<td bgcolor=#3A6EA5>
					<marquee align="middle" behavior="alternate" scrollamount="5">
						<font color=#FFFFFF>...�ĵ�װ����...��ȴ�...</font>
					</marquee>
				</td>
			</tr>
		</table>
	</div>
	<iframe name="uploaddoc" height="0" width="0"></iframe>
</body>
</html>