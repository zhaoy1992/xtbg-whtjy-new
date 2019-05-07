<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,java.io.File"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
			content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body>

		<script type="text/javascript">
		  var aaa;
			function open11(pa){
		
			var dd= window.showModalDialog("http://127.0.0.1:8080/testApplet/index.html" ) ;
					alert(dd);
					return "来自网页"+dd;
			}
			function openXPDL(path,file_name){
			
				var ap=document.applets.jawe;
					//alert(ap.readyState);
				ap.setPath(path);
				ap.setFileName("ttt");
				ap.setOpenUrl("http://172.16.168.195:8081/jawe/ttt.xpdl");
				ap.setSaveUrl("http://172.16.168.195:8081/dzzwpt/jawe/xpdl_save.jsp");
			}
				
			</script>
		<form action="d">
			<label>
				打开新窗口的链接
			</label>
			<input onclick="open11()" type="button" name="dd" value="打开">
		</form>
		<jsp:plugin archive="graph.jar" height="60px" width="80px"
			code="com.chinacreator.jawe.JaweApplet" codebase="." type="applet"
			name="jawe">
			<jsp:params>

				<jsp:param name="APP_ID" value="1" />
					
			</jsp:params>
		</jsp:plugin>
		<ul>
			<%
			request.getSession(true).setAttribute("haha","nihao");
			
			
				File f = new File("C:\\JaWE1.4.2\\examples\\Valid\\Business");
				if (f.isDirectory()) {
					File[] fs = f.listFiles();

					for (File f2 : fs) {
						//System.out.println(f2.getPath());
						//System.out.println(f2.canWrite());
			%>
			<li>
				<a href="#" path="<%=f2.getPath()%>" onclick="openXPDL('<%=f2.getPath()%>','<%=f2.getName()%>')"><%=f2.getPath()%>?<%=f2.getName()%></a>
			</li>
			<%
				}
				}
			%>

			<script>
				/*
				alert(location.protocol+location.host+location.pathname)
				alert(location.host);
				alert(location.pathname);
				*/
			</script>

			<%=request.getContextPath()%>
		</ul>
	</body>
</html>