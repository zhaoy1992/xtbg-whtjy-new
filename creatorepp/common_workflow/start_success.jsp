<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%
	String mgrName = (String) request.getAttribute("mgrName");
	if(mgrName == null || mgrName.trim().equals("true")){
		mgrName = request.getParameter("mgrName"); 
	}
	String mgrNameEncode = StringUtil.encode(mgrName);
	String isError = (String) request.getAttribute("isError");
	String msg = "�����ɹ���ллʹ�ã�";
	if (isError == null || isError.trim().equals("true")) {
		isError = request.getParameter("isError"); 
	}
	if (isError == null || isError.trim().equals("true")) {
		msg = "����ʧ�ܣ������ԣ�";
	}
%>
<html>

	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
	
	<base target="_self">
	<%@ include file="/epp/css/cssControl.jsp"%><body scroll=no>
		<form action="">
			<table width="100%" border="1"  cellpadding="2" cellspacing="0"
				class="thin" align="center">
				<tr>
					<td align="center">
						<%=msg%>
					</td>
				</tr>
				<tr>
					<td align="center">
						<input name="Submit" type="button" class="input" value="����"
							onClick="return backStart()">
					</td>
				</tr>
			</table>
		</form>
	</body>
	<script language="JavaScript">
	function backStart(){
		document.location = "start_form.jsp?mgrName=<%=mgrNameEncode%>";
	}		
</script>
</html>