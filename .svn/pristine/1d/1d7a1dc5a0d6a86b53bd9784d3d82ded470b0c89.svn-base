<%@ page contentType="text/html; charset=GBK" language="java" import="java.io.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response);
	
	String uri = request.getParameter("uri");

	String abUri = (String)session.getAttribute("pathContext")+"/"+uri;

	//将 \\ 转换成 /		
	abUri = abUri.replaceAll("\\\\","/") ;
	boolean existFlag = false;
	if(new File(abUri).exists())
		existFlag = true;
	try{
		 if(existFlag){
				String pathContext = rootpath + "/cms/editor/eWebEditor48/template/" + uri;
				%>
					<script language = "javascript">
						window.open("<%=pathContext%>");
					</script>
				<%
			}
		if(!existFlag){
			%>
			<script language = "javascript">
				alert("文件不存在！！");
			</script>
			<%
		}		
	}catch(Exception de){
		de.printStackTrace();
		%>
		<script language="javascript">
			alert("操作失败!!");
		</script>
		<%
	}
%>