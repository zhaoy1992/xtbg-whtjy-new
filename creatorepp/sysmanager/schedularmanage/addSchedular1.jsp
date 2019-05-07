<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@page
	import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	Date date = new Date();
	String dateStr = StringUtil.getFormatDate(date,
			"yyyy-MM-dd HH:mm:ss");
	String curDate = request.getParameter("date");
	String curDate1 = request.getParameter("date1");
	String weekday = request.getParameter("weekday");
	String beginTime = request.getParameter("beginTime");
	String endTime = request.getParameter("endTime");
	String id = request.getParameter("id");
	if (curDate == null)
		curDate = "";
	if (beginTime == null)
		beginTime = "";
	if (endTime == null)
		endTime = "";
	beginTime = curDate + " " + beginTime;
	endTime = curDate + " " + endTime;

	Calendar c = Calendar.getInstance();
	c.add(Calendar.DAY_OF_MONTH, 1);
	String tmpStr = StringUtil.getFormatDate(c.getTime(), "yyyy-MM-dd");
	String dateStr1 = tmpStr + " 09:00";
	String dateStr2 = tmpStr + " 10:00";
	if (beginTime.trim().equals(""))
		beginTime = dateStr1;
	if (endTime.trim().equals(""))
		endTime = dateStr2;
%>
<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../scripts/validateForm.js"></SCRIPT>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/schedularmanage/My97DatePicker/WdatePicker.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>����ճ�</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="../css/tab.winclassic.css">
		<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}

.style2 {
	font-family: Tahoma, Verdana, Arial, Helvetica;
	font-weight: bold;
	font-size: medium;
}

.style3 {
	font-size: medium
}
-->
</style>
	</head>

	<script language="JavaScript">
	function submitSD(){     
		check('checkBox','isSys');
    	check('checkBox','isEmail');
    	check('checkBox','isMessage');
		if (document.all.item("remindBeginTime").value != "")
		{
		    if("<%=dateStr%>">document.all.item("remindBeginTime").value  )
			{
				alert("���ѿ�ʼʱ�����ڵ�ǰʱ��");
	    		return;
	    	}
	    	if (document.all.item("remindEndTime").value == "")
			{
				alert("����д���ѽ���ʱ��");
	    		return;
			}
			if(document.all.item("isSys").value == 0&&document.all.item("isEmail").value == 0&&document.all.item("isMessage").value == 0)
			{
				alert("��ѡ�����ѷ�ʽ");
	    		return;
			}
	    }
	    
	    if (document.all.item("remindEndTime").value != "")
		{
			if (document.all.item("remindBeginTime").value == "")
			{
				alert("����д���ѿ�ʼʱ��");
	    		return;
			}
			
		}
	    
    	if(document.all.item("topic").value == "" )
		{
			alert("����д����!!!");
			return;
		}
		if(document.all.item("beginTime").value == " " )
		{
			alert("��ѡ��ʼʱ��!!!");
			return;
		}
		if(document.all.item("endTime").value == " " )
		{
			alert("��ѡ�����ʱ��!!!");
			return;
		}
		
		if(document.all.item("beginTime").value > document.all.item("endTime").value)
		{
			alert("��ʼʱ�����ڽ���ʱ��");
    		return;
    	}
    	if(document.all.item("beginTime").value < "<%=dateStr%>")
		{
			alert("��ʼʱ�����ڵ�ǰʱ��");
    		return;
    	}
    	if(document.all.item("remindBeginTime").value > document.all.item("remindEndTime").value)
		{
			alert("���ѿ�ʼʱ���������ѽ���ʱ��");
    		return;
    	}
    	if(document.all.item("remindBeginTime").value > document.all.item("beginTime").value)
		{
			alert("���ѿ�ʼʱ�������ճ̿�ʼʱ��");
    		return;
    	}
    	if(document.all.item("remindEndTime").value > document.all.item("endTime").value)
		{
			alert("���ѽ���ʱ�������ճ̽���ʱ��");
    		return;
    	}
    	if(document.all.item("topic").value.length>100 )
		{
			alert("���ⳤ�Ȳ��ܴ���100!!!");
			return;
		}
    	if(document.all.item("place").value.length>100 )
		{
			alert("�ص㳤�Ȳ��ܴ���100!!!");
			return;
		}
    	if(document.all.item("content").value.length>500 )
		{
			alert("�ճ��������Ȳ��ܴ���500!!!");
			return;
		}
		if(!validateForm(SchedularForm)){
			return;
		}
    	var curDate = "<%=curDate%>";
    	if(curDate=="")
    	{
    		document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=addSchedularAndRemind";
			document.forms[0].submit();	
    	}
	    else
	    {
	    	document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=addSchedular1&direct=all&curDate=<%=curDate%>&date1=<%=curDate1%>&weekday=<%=weekday%>";
			document.forms[0].submit();	
		}
			//document.location.href = "<%=rootpath%>/sysmanager/schedularmanage/querySchedular.jsp";
	}	
	
	function impactCheck(){
		if(document.all.item("beginTime").value == " " )
		{
			alert("��ѡ��ʼʱ��!!!");
			return;
		}
		if(document.all.item("endTime").value == " " )
		{
			alert("��ѡ�����ʱ��!!!");
			return;
		}
		
		if(document.all.item("beginTime").value >= document.all.item("endTime").value)
		{
			alert("��ʼʱ����ڽ���ʱ��");
    		return;
    	}
    	if(document.all.item("beginTime").value <= "<%=dateStr%>")
		{
			alert("��ʼʱ��С�ڵ�ǰʱ��");
    		return;
    	}
		var beginTime =document.all.item("beginTime").value;
		var endTime =document.all.item("endTime").value;
  		var linkurl = "impactSchedular.jsp" ;  	
  		document.resource_bridge.location = linkurl + "?beginTime=" + beginTime + "&endTime=" + endTime;
	}
	function addRemind(){
		if(document.all.item("remindTime").value == "" )
		{
			alert("����д����ʱ��!!!");
			return;
		}
		var remindBeginTime =document.all.item("remindTime").value;
		var remindEndTime =document.all.item("beginTime").value;
  		var linkurl = "remindList.jsp" ;  	
  		document.resource_bridge.location = linkurl + "?remindBeginTime=" + remindBeginTime + "&remindEndTime=" + remindEndTime;
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
	function adduser(){
	    	window.open('<%=rootpath%>/sysmanager/schedularmanage/selectexecutor.jsp?displayNameInput=partner&displayValueInput=executors','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
		}
	function goback()
	{
	    document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/daySchedularList.jsp?curDate=<%=curDate%>&date1=<%=curDate1%>&weekday=<%=weekday%>";
		document.forms[0].submit();
		return true;
	}

</script>

	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="info" scrolling="no">

		<form name="SchedularForm" action="" method="post">
			<table cellpadding="0" cellspacing="0" border="0" width="100%"
				align="center">
				<tr>
					<td>
						<fieldset class="x-fieldset">
							<legend class="legend">
								�ճ���Ϣ
							</legend>
							<pg:beaninfo requestKey="newSchedular">
								<input type="hidden" name="schedularID"
									value="<pg:cell colName="schedularID"  defaultValue=""/>" />
								<input type="hidden" name="plannerID"
									value="<pg:cell colName="plannerID"  defaultValue="<%=userId%>"/>" />
								<input type="hidden" name="executorID"
									value="<pg:cell colName="executorID"  defaultValue="<%=userId%>"/>" />
								<input type="hidden" name="requestID"
									value="<pg:cell colName="requestID"  defaultValue="0"/>" />
								<input type="hidden" name="type"
									value="<pg:cell colName="type"  defaultValue="�Լ�����"/>" />
								<input type="hidden" name="status"
									value="<pg:cell colName="status"  defaultValue="0"/>" />
								<input type="hidden" name="isHistory"
									value="<pg:cell colName="isHistory"  defaultValue="0"/>" />
								<input type="hidden" name="data1"
									value="<pg:cell colName="data1"  defaultValue="<%=curDate1%>"/>" />
								<input type="hidden" name="weekday"
									value="<pg:cell colName="weekday"  defaultValue="<%=weekday%>"/>" />
								<table cellpadding="0" cellspacing="0" width="99%"
									class="detail" border="0" style="margin-top: 10px">

									<tr>
										<td height="23" class="detailtitle" width="20%">
											<strong> ����</strong>
										</td>
										<td colspan=3>
											<input name="topic" type="text" validator="stringLegalSpace"
												cnname="����" style="width: 100%"
												value="<pg:cell colName="topic"  defaultValue=""/>">
										</td>
									</tr>
									<tr>
										<td height="23" class="detailtitle">
											<strong> ��ʼʱ��</strong>
										</td>
										<td height="23" width="30%">

											<input name="beginTime" type="text" readonly="true"
												value="<pg:cell colName="beginTime"  defaultValue="<%=beginTime%>"/>"
												onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" />
										</td>
										<td height="23" class="detailtitle">
											<strong> ����ʱ��</strong>
										</td>
										<td height="23" width="30%">
											<input name="endTime" type="text" readonly="true"
												value="<pg:cell colName="endTime"  defaultValue="<%=endTime%>"/>"
												onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})">
										</td>

									</tr>
									<tr>

										<td height="23" class="detailtitle">
											<strong> ��Ҫ��</strong>
										</td>
										<td height="23" width="30%">

											<select name="essentiality" class="select">
												<option value="0">
													<pg:equal colName="essentiality" value="0">selected</pg:equal>
													��Ҫ
												</option>
												<option value="1">
													<pg:equal colName="essentiality" value="1">selected</pg:equal>
													һ��
												</option>
												<option value="2">
													<pg:equal colName="essentiality" value="2">selected</pg:equal>
													����Ҫ
												</option>
											</select>
										</td>
										<td height="23" class="detailtitle">
											<strong> �Ƿ���</strong>
										</td>
										<td height="23" width="30%">
											<select name="isPublicAffair" class="select">
												<option value="0">
													<pg:equal colName="isPublicAffair" value="0">selected</pg:equal>
													��
												</option>
												<option value="1">
													<pg:equal colName="isPublicAffair" value="1">selected</pg:equal>
													��
												</option>
											</select>
										</td>
									<tr>
										<td height="23" class="detailtitle" width="20%">
											<strong> �ص�</strong>
										</td>
										<td height="23">
											<input name="place" type="text" validator="stringLegalNull"
												style="width: 100%" cnname="�ص�"
												value="<pg:cell colName="place"  defaultValue=""/>">
										</td>
										<td height="23" class="detailtitle">
											<strong> �Ƿ�����</strong>
										</td>
										<td height="23">

											<select name="isRemind" class="select"
												onchange="
													if(this.value==0){
														document.getElementById('rmtr1').style.display='';
														document.getElementById('rmtr2').style.display='';
													}else{
														document.getElementById('rmtr1').style.display='none';
														document.getElementById('rmtr2').style.display='none';
													}
												">
												<option value="1"
													<pg:equal colName="isRemind" value="1">selected</pg:equal>>
													��
												</option>
												<option value="0"
													<pg:equal colName="isRemind" value="0">selected</pg:equal>>
													��
												</option>
											</select>
										</td>
									</tr>
									<tr id="rmtr1" style="display:none">
										<td height="23" class="detailtitle" width="20%">
											<strong> ��ʼ����ʱ��</strong>
										</td>
										<td width="20%">
											<input name="remindBeginTime"
												dateformat="yyyy-MM-dd HH:mm:ss" type="text"
												value="<pg:cell colName="remindBeginTime" dateformat="yyyy-MM-dd HH:mm:ss" defaultValue=""/>"
												readonly="true"
												onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
										</td>
										<td height="23" class="detailtitle" width="20%">
											<strong> ��������ʱ��</strong>
										</td>
										<td width="20%">
											<input name="remindEndTime" dateformat="yyyy-MM-dd HH:mm:ss"
												type="text"
												value="<pg:cell colName="remindEndTime"  defaultValue=""/>"
												readonly="true"
												onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
										</td>
									</tr>
									<tr id="rmtr2" style="display:none">
										<td height="23" class="detailtitle" width="10%">
											<strong> ���Ѽ��</strong>
										</td>
										<td>
											<input name="interval" type="text"
												value="<pg:cell colName="interval"  defaultValue="30.0"/>">
											<select name="intervalType" class="select">
												<option value="0"
													<pg:equal colName="intervalType" value="0">selected</pg:equal>>
													��
												</option>
												<option value="1"
													<pg:equal colName="intervalType" value="1">selected</pg:equal>>
													Сʱ
												</option>
												<option value="2"
													<pg:equal colName="intervalType" value="2">selected</pg:equal>>
													��
												</option>
											</select>
										<td height="23" width="13%" class="detailtitle">
											<strong> ���ѷ�ʽ</strong>
										</td>
										<td height="23" width="30%">
											<input type="checkBox" name="isSys"
												onClick="check('checkBox','isSys')">
											<strong> RTX</strong>
											<input type="checkBox" name="isEmail"
												onClick="check('checkBox','isEmail')">
											<strong> �ʼ�</strong>
											<input type="checkBox" name="isMessage"
												onClick="check('checkBox','isMessage')">
											<strong> ����</strong>
									</tr>

									<tr>
										<td height="23" width="20%" class="detailtitle">
											<strong>�ճ�����</strong>
										</td>
										<td height="23" width="30%" colspan=3>
											<textarea name="content" style="width: 100%" rows="6"></textarea>

										</td>
									</tr>
								</table>
							</pg:beaninfo>
						</fieldset>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" border="0" width="100%"
				align="center">
				<br>
				<tr><td align="right">
					<INPUT type="button" class="input" value="����ͻ"
						onclick="impactCheck()">
					<INPUT type="button" class="input" value="�ύ" onclick="submitSD()">
					<INPUT type="button" class="input" value="����" onclick="goback()">
				</td></tr>
			</table>
		</form>
		<table cellpadding="0" cellspacing="0" border="0" width="100%"
			align="center">
			<tr height="100%" width="100%">
				<td height="100%" width="100%">
					<iframe id="resource_bridge" FRAMEBORDER="0" name="resource_bridge"
						src="" height="100%" width="100%" />
				</td>
			</tr>
			<%@include file="sysMsg.jsp"%>
		</table>
	</body>
</html>

