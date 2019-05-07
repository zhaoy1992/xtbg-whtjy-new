<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.schedularmanage.Schedular"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.SchedularManagerImpl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
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
            if (curDate == null)
                curDate = "";
            if (beginTime == null)
                beginTime = "";
            if (endTime == null)
                endTime = "";

            String schedularID = request.getParameter("schedularID");
            String curDate2 = request.getParameter("curDate");

            SchedularManagerImpl smi = new SchedularManagerImpl();
            Schedular sch = smi.getModifySchedular(Integer
                    .parseInt(schedularID));
            String topic = sch.getTopic();
            String place = sch.getPlace();
            Date beginTime1 = sch.getBeginTime();
            Date endTime1 = sch.getEndTime();
            Date remindBeginTime = sch.getRemindBeginTime();
            Date remindEndTime = sch.getRemindEndTime();
            String essentiality = sch.getEssentiality();
            String isPublicAffair = String.valueOf(sch.getIsPublicAffair());
            String isLeisure = String.valueOf(sch.getIsLeisure());
            String content = sch.getContent();
            String intervalType = String.valueOf(sch.getIntervalType());
            String isSys = String.valueOf(sch.getIsSys());
            String isEmail = String.valueOf(sch.getIsEmail());
            String isMessage = String.valueOf(sch.getIsMessage());
            request.setAttribute("newSchedular", sch);
            
            String show = request.getParameter("show");
            String disabled = "";
            if("true".equals(show)){
            	disabled = "disabled";
            }
%>
<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../scripts/validateForm.js"></SCRIPT>
		<script language="JavaScript" src="<%=request.getContextPath() %>/sysmanager/schedularmanage/My97DatePicker/WdatePicker.js" ></script>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>浏览日程</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<style type="text/css">

<!--.STYLE1 {color: #FF0000}-->
<!--.style2 {-->
<!--	font-family: Tahoma, Verdana, Arial, Helvetica;-->
<!--	font-weight: bold;-->
<!--	font-size: medium;-->
<!--}-->
<!--.style3 {font-size: medium}-->

        </style>
	</head>
	<script language="JavaScript">

//self.moveTo(0,0) 
//self.resizeTo(screen.availWidth,screen.availHeight) 
function remove_remind()
	{
		document.all.item("remindBeginTime").value = "";
		document.all.item("remindEndTime").value = "";
		document.all.item("interval").value = 0;
		document.all.item("isSys").value = 0;
		document.all.item("isSys").checked = false;
		document.all.item("isSys").value = 0;
		document.all.item("isEmail").checked = false;
		document.all.item("isEmail").value = 0;
		document.all.item("isMessage").checked = false;
		document.all.item("isMessage").value = 0;
		document.getElementById("isRemind").value="1";
		if(confirm("确定取消提醒？"))
			motifySD();
	}
function motifySD()
    {   
    	if (document.all.item("remindBeginTime").value != "")
		{
		    if (document.all.item("remindEndTime").value == "")
			{
				alert("请填写提醒结束时间");
	    		return;
			}
	    }
	    
	    if (document.all.item("remindEndTime").value != "")
		{
			if (document.all.item("remindBeginTime").value == "")
			{
				alert("请填写提醒开始时间");
	    		return;
			}
		}
		
	    if(document.all.item("topic").value == "" )
		{
			alert("请填写主题!!!");
			return;
		}
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
			alert("开始时间晚于结束时间");
    		return;
    	}
    	
    	if(document.all.item("remindBeginTime").value > document.all.item("remindEndTime").value)
		{
			alert("提醒开始时间晚于提醒结束时间");
    		return;
    	}
    	
    	if(document.all.item("remindEndTime").value > document.all.item("endTime").value)
		{
			alert("提醒结束时间晚于日程结束时间");
    		return;
    	}
    	if(document.all.item("topic").value.length>100 )
		{
			alert("主题长度不能大于100!!!");
			return;
		}
    	if(document.all.item("place").value.length>100 )
		{
			alert("地点长度不能大于100!!!");
			return;
		}
    	if(document.all.item("content").value.length>500 )
		{
			alert("日程描述长度不能大于500!!!");
			return;
		}
		if(!validateForm(schedularForm)){
			return;
		}
    	check('checkBox','isSys');
    	check('checkBox','isEmail');
    	check('checkBox','isMessage');
	    document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=modifySchedular&path=daySchedularList&curDate=<%=curDate%>&date1=<%=curDate1%>&weekday=<%=weekday%>";
		document.forms[0].submit();
	}	
	
	function impactCheck(){
		if(document.all.item("beginTime").value == " " )
		{
			alert("请选择开始时间!!!");
			return;
		}
		if(document.all.item("endTime").value == " " )
		{
			alert("请选择结束时间!!!");
			return;
		}
		
		if(document.all.item("beginTime").value >= document.all.item("endTime").value)
		{
			alert("开始时间大于结束时间");
    		return;
    	}
    	if(document.all.item("beginTime").value <= "<%=dateStr%>")
		{
			alert("开始时间小于当前时间");
    		return;
    	}
		var beginTime =document.all.item("beginTime").value;
		var endTime =document.all.item("endTime").value;	
  		var linkurl = "<%=rootpath%>/sysmanager/schedularmanage/impactSchedular.jsp" ;  	
  		document.resource_bridge.location = linkurl + "?beginTime=" + beginTime + "&endTime=" + endTime;
	}
	function goback()
	{
	    document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/daySchedularList.jsp?curDate=<%=curDate%>&date1=<%=curDate1%>&weekday=<%=weekday%>";
		document.forms[0].submit();
		return true;
	}
	
	function addRemind(){
		if(document.all.item("remindTime").value == "" )
		{
			alert("请填写提醒时间!!!");
			return;
		}
		var remindBeginTime =document.all.item("remindTime").value;
		var remindEndTime =document.all.item("beginTime").value;
  		var linkurl = "<%=rootpath%>/sysmanager/schedularmanage/remindList.jsp" ;  	
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

</script>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="info" scrolling="no">
		<form name="schedularForm" action="" method="post">
			<table cellpadding="0" cellspacing="0" border="0" width="100%"
				align="center">
				<tr>
					<td>
						<fieldset class="x-fieldset">
							<legend class="legend">
								日程信息
							</legend>
			<pg:beaninfo requestKey="newSchedular">
				<input type="hidden" name="schedularID" value="<%=schedularID%>" />
				<input type="hidden" name="plannerID" value="<pg:cell colName="plannerID"  defaultValue="<%=userId%>"/>" />
				<input type="hidden" name="executorID" value="<pg:cell colName="executorID"  defaultValue="<%=userId%>"/>" />
				<input type="hidden" name="requestID" value="<pg:cell colName="requestID"  defaultValue="0"/>" />
				<input type="hidden" name="type" value="<pg:cell colName="type"  defaultValue="自己安排"/>" />
				<input type="hidden" name="status" value="<pg:cell colName="status"  defaultValue="0"/>" />
				<input type="hidden" name="isHistory" value="<pg:cell colName="isHistory"  defaultValue="0"/>" />
				<input type="hidden" name="data1" value="<pg:cell colName="data1"  defaultValue="<%=curDate1%>"/>" />
				<input type="hidden" name="weekday" value="<pg:cell colName="weekday"  defaultValue="<%=weekday%>"/>" />
								<table cellpadding="0" cellspacing="0" width="99%"
									class="detail" border="0" style="margin-top: 10px">
					
					<tr>
						<td height="23" class="detailtitle" width="15%">
							<strong> 主题</strong>
						</td>
						<td colspan=3>
							<input name="topic" type="text" validator="stringLegalSpace" style="width:100%" cnname="主题" value="<%=topic%>">
						</td>
					</tr>
					<tr>
						<td height="23" class="detailtitle">
							<strong> 开始时间</strong>
						</td>
						<td height="23" width="30%">
							<input name="beginTime" type="text" readonly="true" value="<pg:cell colName="beginTime"  dateformat="yyyy-MM-dd HH:mm" defaultValue="<%=beginTime1%>"/>"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})">
							<!--<INPUT type="button" class="input" value="时间" onclick="selectTime('schedularForm.beginTime',0)">
						--></td>
						<td height="23" class="detailtitle" nowrap="nowrap">
							<strong> 结束时间</strong>
						</td>
						<td height="23" width="30%" nowrap="nowrap">
							<input name="endTime" type="text" readonly="true" value="<pg:cell colName="endTime"  dateformat="yyyy-MM-dd HH:mm" defaultValue="<%=endTime1%>"/>"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})">
							<!--<INPUT type="button" class="input" value="时间" onclick="selectTime('schedularForm.endTime',0)">

						--></td>
					</tr>

					<tr>
						<td height="24" class="detailtitle">
							<strong> 重要性</strong>
						</td>
						<td height="24" width="30%">
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
						<td height="24" class="detailtitle">
							<strong> 是否公事</strong>
						</td>
						<td height="24" width="30%">
							<select name="isPublicAffair" class="select">
								<option value="0" <pg:equal colName="isPublicAffair" value="0">selected</pg:equal>>
									是
								</option>
								<option value="1" <pg:equal colName="isPublicAffair" value="1">selected</pg:equal>>
									否
								</option>
							</select>
						</td>
						<!--<td height="24" class="detailtitle">
							<strong> 是否空闲</strong>
						</td>
						<td height="24" width="30%">
							<select name="isLeisure" class="select">
								<option value="0" <pg:equal colName="isLeisure" value="0">selected</pg:equal>>
									忙
								</option>
								<option value="1" <pg:equal colName="isLeisure" value="1">selected</pg:equal>>
									空闲
								</option>
							</select>
						</td>
						
					--></tr>
					<tr>
						<td height="23" class="detailtitle" width="20%">
							<strong> 地点</strong>
						</td>
						<td height="23" >
							<input name="place" type="text" validator="stringLegalSpace" style="width:100%" cnname="地点" value="<pg:cell colName="place"  defaultValue=""/>">
						</td>
						<td height="23" class="detailtitle">
							<strong> 是否提醒</strong>
						</td>
						<td height="23">

							<select name="isRemind" class="select" onchange="
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
					<!--<tr>
						<td height="24" class="detailtitle">
							<strong> 是否公事</strong>
						</td>
						<td height="24" width="30%">
							<select name="isPublicAffair" class="select">
								<option value="0" <pg:equal colName="isPublicAffair" value="0">selected</pg:equal>>
									公事
								</option>
								<option value="1" <pg:equal colName="isPublicAffair" value="1">selected</pg:equal>>
									私事
								</option>
							</select>
						</td>
						<td height="25" class="detailtitle" width="25%">
							<strong> 部门公开</strong>
						</td>
						<td height="25" width="30%">
							<select name="isOpen" class="select">
								<option value="0" <pg:equal colName="isOpen" value="0">selected</pg:equal>>
									保密
								</option>
								<option value="1" <pg:equal colName="isOpen" value="1">selected</pg:equal>>
									公开
								</option>
							</select>
						</td>
					</tr>
					--><tr id="rmtr1">

						<td height="23" class="detailtitle" width="15%">
							<strong> 开始提醒时间</strong>
						</td>
						<td width="20%">
							<input name="remindBeginTime" type="text" readonly="true" value="<pg:cell colName="remindBeginTime" dateformat="yyyy-MM-dd HH:mm:ss" defaultValue="<%=remindBeginTime%>"/>"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
							<!--<INPUT type="button" class="input" value="时间" onclick="selectTime('schedularForm.remindBeginTime',0)">
						--></td>
						<td height="23" class="detailtitle" width="15%">
							<strong> 结束提醒时间</strong>
						</td>
						<td width="20%">
							<input name="remindEndTime" type="text" readonly="true" value="<pg:cell colName="remindEndTime" dateformat="yyyy-MM-dd HH:mm:ss" defaultValue="<%=remindEndTime%>"/>"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
							<!--<INPUT type="button" class="input" value="时间" onclick="selectTime('schedularForm.remindEndTime',0)">
						--></td>
					</tr>
					<tr id="rmtr2">

						<td height="23" class="detailtitle" width="15%">
							<strong> 提醒间隔</strong>
						</td>
						<td height="23" class="detailtitle" width="30%">
							<input name="interval" type="text" value="<pg:cell colName="interval"  defaultValue=""/>">
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
						<td width="15%" class="detailtitle">
							<strong> 提醒方式</strong>
						</td>
						<td width="30%">
							<input type="checkBox" name="isSys" <pg:equal colName="isSys" value="1">checked</pg:equal> onClick="check('checkBox','isSys')">
							<strong> RTX</strong>
							<input type="checkBox" name="isEmail" <pg:equal colName="isEmail" value="1">checked</pg:equal> onClick="check('checkBox','isEmail')">
							<strong> 邮件</strong>
							<input type="checkBox" name="isMessage" <pg:equal colName="isMessage" value="1">checked</pg:equal> onClick="check('checkBox','isMessage')">
							<strong> 短信</strong>
						</td>

					</tr>
					<tr>
						<td height="55" class="detailtitle">
							<strong> 日程描述</strong>
						</td>
						<td height="55" colspan="3">
							<textarea name="content" style="width:100%" rows="6" defaultValue=""><%=content%></textarea>
						</td>
					</tr>
				</table>
			</pg:beaninfo>
						</fieldset>
					</td>
				</tr>
			</table>
			
<script type="text/javascript">
if(document.getElementById("isRemind").value=="0"){
	document.getElementById('rmtr1').style.display='';
	document.getElementById('rmtr2').style.display='';
}else{
	document.getElementById('rmtr1').style.display='none';
	document.getElementById('rmtr2').style.display='none';
}
</script>
			<table cellpadding="0" cellspacing="0" border="0" width="100%"
				align="center">
				<br/>
				<tr>
					<td align="right">
						<INPUT type="button" class="input" value="检测冲突" <%=disabled %> onclick="impactCheck()">
						<input type="button" class="input"  value="取消提醒" <%=disabled %> onclick="remove_remind()">
						<INPUT type="button" class="input" value="修改" <%=disabled %> onclick="motifySD()">
						<INPUT type="button" class="input" value="返回" <%=disabled %> onclick="goback()">
					</td>
				</tr>
			</table>
		</form>
		<table height="40%" width="100%">
			<tr height="100%" width="100%">
				<td height="100%" width="100%">
					<iframe id="resource_bridge" FRAMEBORDER="0" name="resource_bridge" src="" height="100%" width="100%" />
				</td>
			</tr>

		</table>
	</body>
	<%@include file="sysMsg.jsp"%>
</html>
