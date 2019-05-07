<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>


<%			AccessControl control = AccessControl.getInstance();
			control.checkManagerAccess(request, response);
			
			
			String siteDir = request.getParameter("siteDir");
	
			String uri = request.getParameter("uri");
			
			String file_list = "file_list.jsp?siteDir="+ siteDir +"&uri=" + uri  ;
%>

<html>
	<head>
		<title>文件附后管理</title>
	</head>
	<script language="javascript">
	
		var win = window.open("<%=request.getContextPath()%>/cms/doing.html","doinghtml","height="+(screen.availHeight-200)+",width="+(screen.availWidth-300)+",top=100,left=150,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
		
		function closeWin()
		{
			if(win)
			{
				win.close();
			}
		}
	</script>
	<frameset name="fileGarbageFrame" cols="2*" border=0 framespacing="0">
		<frame frameborder=0 scrolling="auto" name="file_list" src="<%=file_list%>" marginWidth=0 marginHeight=0 >
		</frame>
	</frameset>
</html>
