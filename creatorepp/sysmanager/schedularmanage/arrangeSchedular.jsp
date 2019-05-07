<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	Date date = new Date();
	String dateStr = StringUtil.getFormatDate(date,"yyyy-MM-dd HH:mm:ss");
	String path = request.getParameter("path");
%>

<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="validateForm.js"></SCRIPT>
<script language="JavaScript" src="<%=request.getContextPath() %>/sysmanager/schedularmanage/My97DatePicker/WdatePicker.js" ></script>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>userInfo4</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
.style2 {
	font-size: medium;
	font-family: Tahoma, Verdana, Arial, Helvetica;
	font-weight: bold;
}
-->
        </style>
	</head>

	<script language="JavaScript">
	var path = "<%=path%>";
	function goBack(){		
		
		if(path == "arrangeSDList")	
			document.location.href="<%=rootpath%>/sysmanager/schedularmanage/arrangeSDList.jsp";
		else 
			document.location.href="<%=rootpath%>/sysmanager/schedularmanage/noPassList.jsp";
	}
	function arrange()
	{
		if(document.all.item("topic").value == "" )
		{
			alert("���ⲻ��Ϊ��!!!");
			return;
		}
		if(document.all.item("beginTime").value == "" )
		{
			alert("��ѡ��ʼʱ��!!!");
			return;
		}
		if(document.all.item("endTime").value == "" )
		{
			alert("��ѡ�����ʱ��!!!");
			return;
		}
		
		if(document.all.item("beginTime").value >= document.all.item("endTime").value)
		{
			alert("��ʼʱ�����ڽ���ʱ��");
    		return;
    	}
    	if(document.all.item("beginTime").value <= "<%=dateStr%>")
		{
			alert("��ʼʱ�����ڵ�ǰʱ��");
    		return;
    	}
    	
		document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=modifySchedular&path=<%=path%>";
		document.forms[0].submit();	
	}
</script>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="info"  scrolling="no">

		<form name="SchedularForm" method="post" action="">

			<p align="center" class="detailtitle style2">
				<br>
				�����ճ�
			</p>
			<pg:beaninfo requestKey="schedular">
				<input type="hidden" name="schedularID" value="<pg:cell colName="schedularID"  defaultValue=""/>" >
				<input type="hidden" name="status" value="2" >
				
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="2" class="thin">
					
					<tr>
						<td height="25" class="detailtitle" width="25%">
							<strong> ����</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="topic" value="<pg:cell colName="topic"  defaultValue=""/>">
						</td>

						<td height="25" class="detailtitle" width="25%">
							<strong> �ص�</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="place" value="<pg:cell colName="place"  defaultValue=""/>">
						</td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle" width="25%">
							<strong> ��ʼʱ��</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="beginTime" readonly="true" value="<pg:cell colName="beginTime"  defaultValue=""/>"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
							<!--<INPUT type="button" class="input" value="ʱ��" onclick="selectTime('SchedularForm.beginTime',0)">
						--></td>

						<td height="25" class="detailtitle" width="25%">
							<strong> ����ʱ��</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="endTime" readonly="true" value="<pg:cell colName="endTime"  defaultValue=""/>"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
							<!--<INPUT type="button" class="input" value="ʱ��" onclick="selectTime('SchedularForm.endTime',0)">
						--></td>
					
					</tr>
					<tr>
						<td height="25" class="detailtitle" width="25%">
							<strong> ��Ҫ��</strong>
						</td>
						<td height="25" width="25%">
							<select name="essentiality" class="select">
								<option value="1" <pg:equal colName="essentiality" value="1">selected</pg:equal>>
									һ��
								</option>
								<option value="0" <pg:equal colName="essentiality" value="0">selected</pg:equal>>
									��Ҫ
								</option>
								<option value="2" <pg:equal colName="essentiality" value="2">selected</pg:equal>>
									����Ҫ
								</option>
							</select>
						</td>
						<td height="25" class="detailtitle" width="25%">
							<!--<strong> �Ƿ����</strong>
						--></td>
						<td height="25" width="25%">
							<!--<select name="isLeisure" class="select">
								<option value="0" <pg:equal colName="isLeisure" value="0">selected</pg:equal>>
									æ
								</option>
								<option value="1" <pg:equal colName="isLeisure" value="1">selected</pg:equal>>
									����
								</option>
							</select>
						--></td>
					
					</tr>
					<tr>
						<td height="25" class="detailtitle" width="25%">
							<strong> �Ƿ���</strong>
						</td>
						<td height="25" width="25%">
							<select name="isPublicAffair" class="select">
								<option value="0" <pg:equal colName="isPublicAffair" value="0">selected</pg:equal>>
									����
								</option>
								<option value="1" <pg:equal colName="isPublicAffair" value="1">selected</pg:equal>>
									˽��
								</option>
							</select>
						</td>
						<td height="24" class="detailtitle">
							<!--<strong> ���Ź���</strong>
						--></td>
						<td height="24" width="30%">
							<!--<select name="isOpen" class="select">
								<option value="0" <pg:equal colName="isOpen" value="0">selected</pg:equal>>
									����
								</option>
								<option value="1" <pg:equal colName="isOpen" value="1">selected</pg:equal>>
									����
								</option>
							</select>
						--></td>
					</tr>
					<tr>
						<td height="25" class="detailtitle" width="25%">
							<strong> �ճ�����</strong>
						</td>
						<td height="25" width="25%">
							<TEXTAREA name= "content" cols="25" rows="6"><pg:cell colName="content" defaultValue="" /></TEXTAREA>
						</td>
						<td>
						</td>
						<td>
						</td>
					</tr>
				</table>
			</pg:beaninfo>

		</form>

		<hr width="98%">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="thin">
			<tr>
				<td>

					<INPUT type="button" class="input" value="����" onclick="arrange()">

				</td>
			</tr>
		</table>
		<%@include file="sysMsg.jsp" %>
	</body>
</html>
