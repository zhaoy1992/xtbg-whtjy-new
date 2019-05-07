<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>子资源上传</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	<script type="text/javascript">
	//子资源上传
	function uploadSubResource() {
			document.all.divProcessing.style.display="block";
			var resource_name=document.getElementById('rname').value;
	  		var resource_type=document.getElementById('rtype').value;
	  		var resource_path=document.getElementById('filepath').value;
	  		if(resource_name == null || resource_name=="") {
	  			alert("请输入资源名称");
	  			document.all.divProcessing.style.display="none";
	  			return;
	  		}
	  		if(resource_type== "1") {
	  			if(resource_path.lastIndexOf(".jrxml")==-1) {
	  				alert("文件类型错误(只能上传jrxml类型)");
	  				document.all.divProcessing.style.display="none";
	  				return;
	  			}
	  		}else{
	  			var arr= ["gif","jpg","jpeg","bmp"];
	  			var isRight = false;
	  			for(var i= 0;i<arr.length;i++) {
	  				var suffix= arr[i];
	  				if (resource_path.lastIndexOf(suffix) !=-1){
	  					isRight= true;
	  					break;
	  				}
	  			}
	  			if(!isRight) {
	  					alert("图片类型错误(目前只能上传jpg,bmp,gif,jpeg格式)");
	  					document.all.divProcessing.style.display="none";
	  					return;
	  			}
	  		}
	  		document.all.subResourceForm.encoding="multipart/form-data";
			document.all.subResourceForm.method="post";
			document.all.subResourceForm.action="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=add_subresource&resource_name="
			+resource_name+"&resource_type="+resource_type+"&filepath="+resource_path;
			document.all.subResourceForm.target="uploadframe";
		    document.all.subResourceForm.submit();
	}	
	
	function cancelUpload() {
		window.close();
	}
	
</script>
  </head>
  <%@ include file="/epp/css/cssControl.jsp"%>
  <body>
  	<form id="subResourceForm" name="subResourceForm">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">资源名称*：</td>
						<td height="25">
							<input type="text" name="rname" desc="资源名称" maxlength="100"/>
						</td>
					</tr>

					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">资源类型*：</td>
						<td height="25">
							<select name="rtype">
								<option value="1">报表</option>
								<option value="2">图片</option>
							</select>
						</td>
					</tr>

					
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">资源路径*：</td>
						<td height="25">
							<input type="file" name="filepath" desc="资源路径" maxlength="100" contentEditable="false"/>
						</td>
					</tr>
				</table>

            	<hr width="100%"/>

				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">
								<input name="button_" type="button" class="input" value="上传服务器" onClick="uploadSubResource();"/>
								<input name="button_" type="button" class="input" value="取消" onClick="cancelUpload();"/>
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
							<font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
		<iframe id="uploadframe" name="uploadframe" width="0" height="0" style="display: none;"></iframe>
  </body>
</html>
