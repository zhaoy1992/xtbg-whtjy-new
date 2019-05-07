
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="java.util.Enumeration"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>




<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String tableName = request.getParameter("tableName");
	String keyName = request.getParameter("keyName");
	String keyType = request.getParameter("keyType");
	
	tableName = tableName == null ? "" : tableName;
	keyName = keyName == null ? "" : keyName;
	keyType = keyType == null ? "" : keyType ;
	
%>
<html>
	<head>
		<title>��������</title>
		
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript">	
			//�����ѯ����
			function clearInfos()
			{
				tableInfoForm.tableName.value = "";
				tableInfoForm.keyName.value = "";
				tableInfoForm.keyType.options[0].selected = "selected" ;
			}
			
			//ע��:�÷����� onload()����  ��ѯ����
			function query()
			{
				tableInfoForm.action = "tableinfoList.jsp?db=" + document.all.db.value;
				tableInfoForm.target = "queryList";	
				tableInfoForm.submit();
			}
		</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="query()">
		
		<div id="contentborder" align="center">
			<form name="tableInfoForm" action="" method="post">
			<div>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr>
						<td width="10%" nowrap>����Դ����:</td>
						<td width="15%" nowrap>
							<select name="db">
								<%
									DBUtil db = new DBUtil();
									Enumeration enum_ =   db.getAllPoolnames();
									while(enum_.hasMoreElements())
									{
										String dbName = (String)enum_.nextElement();
								%>
									<option value="<%=dbName%>"> &nbsp;&nbsp;<%=dbName%>&nbsp;&nbsp;
								<%
									}
								%>
							</select>
						</td>
						<td width="10%" nowrap>�������:</td>
						<td width="15%" nowrap>
							<input type="text" name="tableName" size="20" value="<%=tableName%>"/>
						</td>
						<td width="10%" nowrap>��������:</td>
						<td width="10%" nowrap>
							<input type="text" name="keyName" size="15" value="<%=keyName%>"/>
						</td>
						<td width="10%" nowrap>��������:</td>
						<td width="18%" nowrap>
							<select name="keyType">
								<option value="">--��ѡ��ؼ�����--
								<option value="string">�ı���
								<option value="int">������
								<option value="sequence">sequence
							</select>
						</td>
						<td align="center">
							<input type="button" name="queryButton" value="��ѯ" class="input" onclick="query()"/>&nbsp;&nbsp;
							<input type="button" name="resetButton" value="����" class="input" onclick="clearInfos()"/>
						</td>
					</tr>
				</table>
			</div>
			<hr/>
			
			<iframe src="" name="queryList" frameborder="0" width="100%" height="480px">
	</body>
</html>
