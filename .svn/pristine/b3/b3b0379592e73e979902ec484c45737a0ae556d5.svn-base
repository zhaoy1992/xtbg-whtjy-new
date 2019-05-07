<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%
String path = request.getParameter("path");
SchedularForm schedularForm = (SchedularForm)request.getAttribute("schedular");
%>
<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../scripts/validateForm.js"></SCRIPT>
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
	font-weight: bold;
}
-->
        </style>
	</head>

	<script language="JavaScript">
	var path = "<%=path%>";
	function goBack(){	
		if(path == "history")
			document.location.href="<%=rootpath%>/sysmanager/schedularmanage/historySchedular.jsp";
		else if(path == "query")
			document.location.href="<%=rootpath%>/sysmanager/schedularmanage/querySchedular.jsp";
		else if(path == "latest")
			document.location.href="<%=rootpath%>/sysmanager/schedularmanage/latestSchedular.jsp";
		else if(path == "success")
			document.location.href="<%=rootpath%>/sysmanager/schedularmanage/successfulSchedular.jsp";
		else if(path == "overtime")
			document.location.href="<%=rootpath%>/sysmanager/schedularmanage/overTimeSchedular.jsp";
		else if(path == "bookingSchedularList")
			document.location.href="<%=rootpath%>/sysmanager/schedularmanage/bookingSchedularList.jsp";	
		else if(path == "departmentSchedularList")
			document.location.href="<%=rootpath%>/sysmanager/schedularmanage/departmentSchedularList.jsp";	
		else document.location.href="<%=rootpath%>/sysmanager/schedularmanage/daySchedularList.jsp";
	}
	
</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="info">
		<form name="schedularForm" method="post" action="">
			<pg:beaninfo requestKey="schedular">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="thin">
					<tr>
						<td align="center" class="detailtitle" colspan=4>
							<span class="style2">查看日程</span>
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle" width="15%">
							<strong> 主题</strong>
						</td>
						<td height="25" colspan=3>
							<input type="text" name="topic" readonly="true"  style="width:100%" value="<pg:cell colName="topic"  defaultValue=""/>">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle" width="15%">
							<strong> 开始时间</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="beginTime" readonly="true" value="<pg:cell colName="beginTime"  dateformat="yyyy-MM-dd HH:mm" defaultValue=""/>">
						</td>
						<td height="25" class="detailtitle" width="15%">
							<strong> 结束时间</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="endTime" readonly="true" value="<pg:cell colName="endTime"  dateformat="yyyy-MM-dd HH:mm" defaultValue=""/>">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle" width="15%">
							<strong> 重要性</strong>
						</td>
						<td height="25" width="25%">
							<pg:equal colName="essentiality" value="0">
								<input type="text" name="type" readonly="true" value="重要">
							</pg:equal>
							<pg:equal colName="essentiality" value="1">
								<input type="text" name="type" readonly="true" value="一般">
							</pg:equal>
							<pg:equal colName="essentiality" value="2">
								<input type="text" name="type" readonly="true" value="不重要">
							</pg:equal>
						</td>
						<td height="25" class="detailtitle" width="15%">
							<strong> 是否公事</strong>
						</td>
						<td height="25" width="25%">
							<pg:equal colName="isPublicAffair" value="0">
								<input type="text" name="type" readonly="true" value="公事">
							</pg:equal>
							<pg:equal colName="isPublicAffair" value="1">
								<input type="text" name="type" readonly="true" value="私事">
							</pg:equal>
						</td>
					</tr>
					<tr>
						<td height="23" class="detailtitle" width="20%">
							<strong> 地点</strong>
						</td>
						<td height="23" >
							<input name="place" type="text" validator="stringLegalNull" style="width:100%" cnname="地点" value="<pg:cell colName="place"  defaultValue=""/>">
						</td>
						<td height="23" class="detailtitle">
							<strong> 是否提醒</strong>
						</td>
						<td height="23">

							<select name="isRemind" class="select" disabled onchange="
								if(this.value==0){
									document.getElementById('rmtr1').style.display='';
									document.getElementById('rmtr2').style.display='';
								}else{
									document.getElementById('rmtr1').style.display='none';
									document.getElementById('rmtr2').style.display='none';
								}
							">
								<option value="0" <pg:equal colName="isRemind" value="0">selected</pg:equal>>
									是
								</option>
								<option value="1"<pg:equal colName="isRemind" value="1">selected</pg:equal>>
									否
								</option>
							</select>
						</td>
					</tr>
					
					<%--<tr>
						<td height="25" class="detailtitle" width="25%">
							<strong> 日程类型</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="type" readonly="true" value="<pg:cell colName="type"  defaultValue=""/>">
							<pg:equal colName="type" value="他人安排">
								<td height="25" class="detailtitle" width="30%">
									<strong> 安排人</strong>
								</td>
								<td height="25" width="25%">
									<input type="text" name="plannerName" readonly="true" value="<pg:cell colName="plannerName"  defaultValue=""/>(<pg:cell colName="plannerRealName" defaultValue="" />)">
								</td>
							</pg:equal>
							<pg:equal colName="type" value="他人预约">
								<td height="25" class="detailtitle" width="30%">
									<strong> 预约人</strong>
								</td>
								<td height="25" width="25%">
									<input type="text" name="plannerName" readonly="true" value="<pg:cell colName="plannerName"  defaultValue=""/>(<pg:cell colName="plannerRealName" defaultValue="" />)">
								</td>
							</pg:equal>
							<pg:equal colName="type" value="自己安排">
								<td height="25" class="detailtitle" width="30%">
									<strong>  </strong>
								</td>
								<td height="25" width="25%">
									<strong>  </strong>
								</td>
							</pg:equal>
						</td>
					</tr>
					--%><tr id="rmtr1">
						<td height="23" class="detailtitle" width="15%">
							<strong> 开始提醒时间</strong>
						</td>
						<td width="20%">
							<input name="remindBeginTime" readonly="true" type="text" value="<pg:cell colName="remindBeginTime"  defaultValue=""/>">
						</td>
						<td height="23" class="detailtitle" width="15%">
							<strong> 结束提醒时间</strong>
						</td>
						<td width="20%">
							<input name="remindEndTime" readonly="true" type="text" value="<pg:cell colName="remindEndTime"  defaultValue=""/>">
						</td>
					</tr>
					<tr id="rmtr2">
						<td height="23" class="detailtitle" width="15%">
							<strong> 提醒间隔</strong>
						</td>
						<td nowrap="nowrap">
							<input name="interval" readonly="true" type="text" value="<pg:cell colName="interval"  defaultValue=""/>">
							<pg:equal colName="intervalType" value="0">
							分
							</pg:equal>
							<pg:equal colName="intervalType" value="1">
							小时
							</pg:equal>
							<pg:equal colName="intervalType" value="2">
							天
							</pg:equal>
						</td>
						<td height="23" class="detailtitle" width="15%">
							<strong> 提醒方式</strong>
						</td>
						<td width="30%">
							<input type="checkBox" <pg:equal colName="isSys" value="1">checked</pg:equal> name="isSys">
							<strong> 系统</strong>
							<input type="checkBox" <pg:equal colName="isEmail" value="1">checked</pg:equal> name="isEmail">
							<strong> 邮件</strong>
							<input type="checkBox" <pg:equal colName="isMessage" value="1">checked</pg:equal> name="isMessage">
							<strong> 短信</strong>
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="15%">
							<strong> 日程描述</strong>
						</td>
						<td colspan=3>
							<TEXTAREA style="width:100%" readonly="true" rows="6" name="content"><pg:cell colName="content" defaultValue="" /></TEXTAREA>
						</td>
						<%--<pg:notequal colName="partner" value="">
							<pg:notequal colName="partner" value="null">
								<td height="23" width="20%" class="detailtitle">
									<strong> 日程合作人</strong>
								</td>
								<td height="23" width="30%">
									<textarea name="partner" cols="25" rows="6"><pg:cell colName="partner" defaultValue="" /></textarea>
								</td>
							</pg:notequal>
						</pg:notequal>
					--%></tr>
				</table>
			</pg:beaninfo>
			
<script type="text/javascript">
if(document.getElementById("isRemind").value=="0"){
	document.getElementById('rmtr1').style.display='';
	document.getElementById('rmtr2').style.display='';
}else{
	document.getElementById('rmtr1').style.display='none';
	document.getElementById('rmtr2').style.display='none';
}
</script>
		</form>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<INPUT type="button" class="input" value="返回" onclick="goBack()">
				</td>
			</tr>
		</table>
	</body>
</html>
