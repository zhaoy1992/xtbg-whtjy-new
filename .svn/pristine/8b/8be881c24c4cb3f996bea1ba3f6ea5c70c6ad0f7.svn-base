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
<%@ page import="com.chinacreator.security.AccessControl"%>

<%Date date = new Date();
			String dateStr = StringUtil.getFormatDate(date,
					"yyyy-MM-dd HH:mm:ss");
			String path = request.getParameter("path");
%>
<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../scripts/validateForm.js"></SCRIPT>
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
}
-->
        </style>
	</head>

	<script language="JavaScript">
	var path = "<%=path%>";
	function goBack(){		
		document.location.href="<%=rootpath%>/sysmanager/schedularmanage/historySchedular.jsp";
	}
	function impactCheck(){
		
		var beginTime =document.all.item("beginTime").value;
		var endTime =document.all.item("endTime").value;
  		var linkurl = "<%=rootpath%>/sysmanager/schedularmanage/impactSchedular.jsp" ;  	
  		document.resource_bridge.location = linkurl + "?beginTime=" + beginTime + "&endTime=" + endTime;
	}
	function resume(){	
	if(document.all.item("beginTime").value == "" )
		{
			alert("请选择开始时间!!!");
			return;
		}
		if(document.all.item("endTime").value == "" )
		{
			alert("请选择结束时间!!!");
			return;
		}
		
		if(document.all.item("beginTime").value > document.all.item("endTime").value)
		{
			alert("开始时间大于结束时间");
    		return;
    	}
    	if(document.all.item("beginTime").value < "<%=dateStr%>")
		{
			alert("开始时间小于当前时间");
    		return;
    	}	
    	check('checkBox','isSys');
    	check('checkBox','isEmail');
    	check('checkBox','isMessage');
		document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=resumeSchedular";
		document.forms[0].submit();
	}
	function check(totalCheck,checkName){
	
		var o = document.all.item(checkName);
		if(o.checked)
		{
			o.value = 1;
		}
		else
		{
			o.value = 0;
		}
	}
</script>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="info" scrolling="no">

		<form name="schedularForm" method="post" action="">

			<p align="center" class="detailtitle style2">
				<strong><br> 恢复日程 </strong>
			</p>
			<pg:beaninfo requestKey="schedular">
				<input type="hidden" name="schedularID" value="<pg:cell colName="schedularID"  defaultValue=""/>">

				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="2">
					
					<tr>
						<td height="25" class="detailtitle" width="25%">
							<strong> 主题</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="topic" value="<pg:cell colName="topic"  defaultValue=""/>">
						</td>

						<td height="25" class="detailtitle" width="25%">
							<strong> 地点</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="place" value="<pg:cell colName="place"  defaultValue=""/>">
						</td>
						<td>
							&nbsp;

						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle" width="25%">
							<strong> 开始时间</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="beginTime" value="<pg:cell colName="beginTime"  defaultValue=""/>"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
							<!--<INPUT type="button" value="时间" onclick="selectTime('schedularForm.beginTime',0)">
						--></td>
					
						<td height="25" class="detailtitle" width="25%">
							<strong> 结束时间</strong>
						</td>
						<td height="25" width="25%">
							<input type="text" name="endTime" value="<pg:cell colName="endTime"  defaultValue=""/>"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
							<!--<INPUT type="button" value="时间" onclick="selectTime('schedularForm.endTime',0)">
						--></td>
						
					</tr>
					<tr>
						<td height="25" class="detailtitle" width="25%">
							<strong> 重要性</strong>
						</td>
						<td height="25" width="25%">
							<select name="essentiality" class="select">
								<option value="1" <pg:equal colName="essentiality" value="1">selected</pg:equal>>
									一般
								</option>
								<option value="0" <pg:equal colName="essentiality" value="0">selected</pg:equal>>
									重要
								</option>
								<option value="2" <pg:equal colName="essentiality" value="2">selected</pg:equal>>
									不重要
								</option>
							</select>
						</td>
						<td height="25" class="detailtitle" width="25%">
							<strong> 是否公事</strong>
						</td>
						<td height="25" width="25%">
							<select name="isPublicAffair" class="select">
								<option value="0" <pg:equal colName="isPublicAffair" value="0">selected</pg:equal>>
									公事
								</option>
								<option value="1" <pg:equal colName="isPublicAffair" value="1">selected</pg:equal>>
									私事
								</option>
							</select>
						</td>
						
						<td>
							&nbsp;

						</td>
					</tr>
					
					<tr>
						<td height="23" class="detailtitle" width="20%">
							<strong> 开始提醒时间</strong>
						</td>
						<td width="20%">
							<input name="remindBeginTime" readonly="true" type="text" value="<pg:cell colName="remindBeginTime"  defaultValue=""/>">
							<INPUT type="button" value="时间" onclick="selectTime('schedularForm.remindBeginTime',0)">
						</td>
						<td height="23" class="detailtitle" width="20%">
							<strong> 结束提醒时间</strong>
						</td>
						<td width="20%">
							<input name="remindEndTime" readonly="true" type="text" value="<pg:cell colName="remindEndTime"  defaultValue=""/>">
							<INPUT type="button" value="时间" onclick="selectTime('schedularForm.remindEndTime',0)">
						</td>
					</tr>
					<tr>
						<td height="23" class="detailtitle" width="25%">
							<strong> 提醒间隔</strong>
						</td>
						<td nowrap="nowrap">
							<input name="interval" type="text" value="<pg:cell colName="interval"  defaultValue="30"/>">
							<select name="intervalType" class="select">
								<option value="0" <pg:equal colName="intervalType" value="0">selected</pg:equal>>
									分
								</option>
								<option value="1" <pg:equal colName="intervalType" value="1">selected</pg:equal>>
									小时
								</option>
								<option value="2" <pg:equal colName="intervalType" value="2">selected</pg:equal>>
									天
								</option>
							</select>
						</td>
					</tr>

					<tr>
						<td height="23" class="detailtitle" width="25%">
							<strong> 提醒方式</strong>
						</td>
						<td width="30%">
							<input type="checkBox" <pg:equal colName="isSys" value="1">checked</pg:equal> name="isSys" onClick="check('checkBox','isSys')">
							<strong> 系统</strong>
							<input type="checkBox" <pg:equal colName="isEmail" value="1">checked</pg:equal> name="isEmail" onClick="check('checkBox','isEmail')">
							<strong> 邮件</strong>
							<input type="checkBox" <pg:equal colName="isMessage" value="1">checked</pg:equal> name="isMessage" onClick="check('checkBox','isMessage')">
							<strong> 短信</strong>
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle" width="25%">
							<strong> 日程描述</strong>
						</td>
						<td>
							<TEXTAREA cols="30" rows="6" name="content"><pg:cell colName="content" defaultValue="" /></TEXTAREA>
						</td>
						<td>
						</td>
					</tr>
				</table>
			</pg:beaninfo>
		</form>
		<hr width="98%">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<INPUT type="button" value="检测冲突" onclick="impactCheck()">
					<INPUT type="button" value="恢复" onclick="resume()">
					<INPUT type="button" value="取消" onclick="goBack()">

				</td>
			</tr>
		</table>
		<table height="40%" width="100%">
			<tr height="10%" width="100%">
				<td width="100%"></td>
			</tr>
			<tr height="100%" width="100%">
				<td height="100%" width="100%">
					<iframe id="resource_bridge" FRAMEBORDER="0" name="resource_bridge" src="" height="100%" width="100%" />
				</td>
			</tr>

		</table>
		<%@include file="sysMsg.jsp" %>
	</body>
</html>
