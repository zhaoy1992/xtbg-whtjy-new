<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib prefix="c" uri="/WEB-INF/reportconfig/c.tld"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>报表上传成功</title>
    <%
    	String isuploadSuccess= request.getParameter("uploadSuccess");
     %>
    <script type="text/javascript">
    	  //报表上传结果提示
			function reportUploadSuccess() {
				if("<%=isuploadSuccess%>"=="true") {
					alert("上传报表文件成功！");
					window.close();
					
				}else {
					return;
				}
			}
    </script>
  </head>
  <body onload="reportUploadSuccess()">
			<div id="divProcessing" style="width:200px;height:30px;position:absolute;left:200px;top:260px">
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
</html>
