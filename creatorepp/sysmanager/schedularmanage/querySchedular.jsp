<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
            accesscontroler.checkAccess(request, response);
            String userId = accesscontroler.getUserID();

    String topic = request.getParameter("topic");
    topic = topic == null ? "" : topic;
    String place = request.getParameter("place");
    place = place == null ? "" : place;
	String beginTime = request.getParameter("beginTime");
	beginTime = beginTime == null ? "" : beginTime;
	String endTime = request.getParameter("endTime");
	endTime = endTime == null ? "" : endTime;
	String selectType = request.getParameter("selectType");
	selectType = selectType == null ? "normal" : selectType;
            %>
<html>
	<head>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../scripts/validateForm.js"></SCRIPT>
		<script language="JavaScript" src="<%=request.getContextPath() %>/sysmanager/schedularmanage/My97DatePicker/WdatePicker.js" ></script>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>查询日程</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
.style2 {font-size: medium}
-->
        </style>
	</head>

	<script language="JavaScript">
function validatecheck(checkName)
	{
			 var o = document.all.item(checkName);
		for (var i=0; o && o.length && i<o.length; i++){
	   	  	  if(o[i].checked)
	   	  	  	return true;
	   	   }
	   	   if(o && !o.length )
			{
				if(o.checked)
					return true;
			}
			return false;
	}
	function validateOnlyCheck(checkName)
	{
		 var o = document.all.item(checkName);
		 for (var i=0,j=0; o && o.length && i<o.length; i++){
	   	  	if(o[i].checked)
	   	  	{
	   	  		j++;
	   	   	}
	   	   	if(j == 2)
	   	   	{
	   	   		return false;
	   	   	}
	   	   }
		 return true;
	}
	
function goBack(){		
	document.location.href="<%=rootpath%>/sysmanager/schedularmanage/daySchedularList.jsp";
	}
function submitSD(){
	document.SchedularForm.submit();
		}	
function modify(checkName){		
		if(!validatecheck(checkName))
		{
			alert("请选择要修改的日程");
			return;
		}
		if(!validateOnlyCheck(checkName))
		{
			alert("一次只能选择一个通知进行修改");
			return;
		}
		
		document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=getModifySchedular&path=query";
		document.forms[0].submit();
	}
function view(checkName){		
		if(!validatecheck(checkName))
		{
			alert("请选择要查看的日程");
			return;
		}
		if(!validateOnlyCheck(checkName))
		{
			alert("一次只能选择一个日程进行查看");
			return;
		}
		
	document.forms[0].action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=getSchedularAndRemind&path=query";
	document.forms[0].submit();
}
function checkAll(totalCheck,checkName){	//复选框全部选中
	   var selectAll = document.all.item(totalCheck);
	   
	   var o = document.all.item(checkName);
	   
	   if(selectAll.checked==true){
		   for (var i=0; o && o.length && i<o.length; i++){
	      	  if(!o[i].disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
		   if(o && !o.length && !o.checked)
			{
				o.checked=true;
			}
		   
	   }else{
		   for (var i=0; o && o.length && i<o.length; i++){
	   	  	  o[i].checked=false;
	   	   }
	   	   if(o && !o.length && !o.checked)
			{
				o.checked=false;
			}
	   	   
	   }
	}
	//单个选中复选框
function checkOne(totalCheck,checkName){
	   var selectAll = document.all.item(totalCheck);
	   var o = document.all.item(checkName);
		var cbs = true;
		
		for (var i=0;o && o.length && i < o.length;i++){
			if(!o[i].disabled){
				if (o[i].checked==false){
					cbs=false;
				}
			}
		}
		if(o && !o.length && !o.checked)
		{
			cbs = false;
		}
		if(cbs){
			selectAll.checked=true;
		}
		else{
			selectAll.checked=false;
		}
	}	
	
	function dealRecord(checkName,dealType) {
	    if(!validatecheck(checkName))
		{
			alert("请选择要删除的的日程");
			return false;
		}
	    
	    	if (dealType==1){
	    		outMsg = "你确定要删除吗？(删除后是不可以再恢复的)。";
	        	if (confirm(outMsg)){
		        	SchedularForm.action="<%=rootpath%>/sysmanager/schedularmanage/action/schManager.jsp?method=deleteSchedular&path=query";
					SchedularForm.submit();
			 		return true;
				}
			} 
	    return false;
	}	
	
	function clear2(){
		document.getElementById("topic").value = "";
		document.getElementById("place").value = "";
		document.getElementById("beginTime").value = "";
		document.getElementById("endTime").value = "";
	}
	
	function changType(obj){
		var selectType = obj.value;
		var myDate = new Date();
		var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
		var month = myDate.getMonth();      //获取当前月份(0-11,0代表1月)
		var day = myDate.getDate();         //获取当前日(1-31)
		var week = myDate.getDay();
		var firstDayOfWeek = day-week;
		if(firstDayOfWeek<=0){
			var lastday = new Date(year,month,0).getDate();	//前月最大天数
			firstDayOfWeek = lastday + firstDayOfWeek;
			if((month-1) < 0){
				year = year - 1;
				month = 11;
			}else{
				month = month - 1;
			}
		}else{
			firstDayOfWeek = day-week;
		}
		var lastDayOfWeek = firstDayOfWeek + 6;
		var monthEnd = month;
		if(lastDayOfWeek>new Date(year,month+1,0).getDate()){
			lastDayOfWeek = lastDayOfWeek - new Date(year,month+1,0).getDate();
			if((month+1) > 11){
				year = year + 1;
				monthEnd = 0;
			}else{
				monthEnd = monthEnd + 1;
			}
		}else{
			lastDayOfWeek = firstDayOfWeek + 6;
		}
		var firstDayOfMonth = 1;
		var lastDayOfMonth = new Date(year,month+1,0).getDate();
		month = month + 1;
		monthEnd = monthEnd + 1;
		if(selectType == "normal"){
			document.getElementById("beginTime").value = "";
			document.getElementById("endTime").value = "";
		}else{
			if(selectType == "day"){
				document.getElementById("beginTime").value = year+"-"+dateToString(month)+"-"+dateToString(day)+" 00:00";
				document.getElementById("endTime").value = year+"-"+dateToString(month)+"-"+dateToString(day)+" 23:59";
			}else if(selectType == "week"){
				document.getElementById("beginTime").value = year+"-"+dateToString(month)+"-"+dateToString(firstDayOfWeek)+" 00:00";
				document.getElementById("endTime").value = year+"-"+dateToString(monthEnd)+"-"+dateToString(lastDayOfWeek)+" 23:59";
			}else if(selectType == "month"){
				document.getElementById("beginTime").value = year+"-"+dateToString(month)+"-"+dateToString(firstDayOfMonth)+" 00:00";
				document.getElementById("endTime").value = year+"-"+dateToString(month)+"-"+dateToString(lastDayOfMonth)+" 23:59";
			}
		}
		submitSD();
	}
	function dateToString(day){
		if(day < 10){
			return "0"+day;
		}else{
			return day;
		}
	}
	function prevDate(){
		var selectType = document.getElementById("selectType").value;
		if(selectType == "normal"){
			return;
		}
		var beginTime = document.getElementById("beginTime").value
		beginTime = beginTime.replace(/-/g,"/");
		var endTime = document.getElementById("endTime").value
		endTime = endTime.replace(/-/g,"/");
		var myDate = new Date(Date.parse(beginTime+":00"));
		var myDate1 = new Date(Date.parse(endTime+":00"));
		
		var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
		var month = myDate.getMonth();      //获取当前月份(0-11,0代表1月)
		var day = myDate.getDate();         //获取当前日(1-31)
		var lastday = new Date(year,month+1,0).getDate();	//当月最大天数
		
		var year1 = myDate1.getFullYear();    //获取完整的年份(4位,1970-????)
		var month1 = myDate1.getMonth();      //获取当前月份(0-11,0代表1月)
		var day1 = myDate1.getDate();         //获取当前日(1-31)
		var lastday1 = new Date(year1,month1+1,0).getDate();	//当月最大天数
		
		var firstDayOfMonth = 1;
			if(selectType == "day"){
				if((day-1) == 0){
					if((month-1) < 0){
						year = year - 1;
						month = 11;
					}else{
						month = month - 1;
					}
					day = new Date(year,month+1,0).getDate();
				}else{
					day = day - 1;
				}
				month = month + 1;
				document.getElementById("beginTime").value = year+"-"+dateToString(month)+"-"+dateToString(day)+" 00:00";
				document.getElementById("endTime").value = year+"-"+dateToString(month)+"-"+dateToString(day)+" 23:59";
			}else if(selectType == "week"){
				if((day-7) <= 0){
					if((month-1) < 0){
						year = year - 1;
						month = 11;
					}else{
						month = month - 1;
					}
					day = new Date(year,month+1,0).getDate()-(7-day);
				}else{
					day = day - 7;
				}
				if((day1-7) <= 0){
					if((month1-1) < 0){
						year1 = year1 - 1;
						month1 = 11;
					}else{
						month1 = month1 - 1;
					}
					day1 = new Date(year1,month1+1,0).getDate()-(7-day1);
				}else{
					day1 = day1 - 7;
				}
				month = month + 1;
				month1 = month1 + 1;
				document.getElementById("beginTime").value = year+"-"+dateToString(month)+"-"+dateToString(day)+" 00:00";
				document.getElementById("endTime").value = year1+"-"+dateToString(month1)+"-"+dateToString(day1)+" 23:59";
			}else if(selectType == "month"){
				if((month-1) < 0){
					year = year - 1;
					month = 11;
				}else{
					month = month - 1;
				}
				var myDate1 = new Date(year,month+1,0);
				var lastday = myDate1.getDate();
				month = month + 1;
				document.getElementById("beginTime").value = year+"-"+dateToString(month)+"-"+dateToString(day)+" 00:00";
				document.getElementById("endTime").value = year+"-"+dateToString(month)+"-"+dateToString(lastday)+" 23:59";
			}
			submitSD();
	}
	function nextDate(){
		var selectType = document.getElementById("selectType").value;
		if(selectType == "normal"){
			return;
		}
		var beginTime = document.getElementById("beginTime").value
		beginTime = beginTime.replace(/-/g,"/");
		var endTime = document.getElementById("endTime").value
		endTime = endTime.replace(/-/g,"/");
		
		var myDate = new Date(Date.parse(beginTime+":00"));
		var myDate1 = new Date(Date.parse(endTime+":00"));
		
		var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
		var month = myDate.getMonth();      //获取当前月份(0-11,0代表1月)
		var day = myDate.getDate();         //获取当前日(1-31)
		var lastday = new Date(year,month+1,0).getDate();	//当月最大天数
		
		var year1 = myDate1.getFullYear();    //获取完整的年份(4位,1970-????)
		var month1 = myDate1.getMonth();      //获取当前月份(0-11,0代表1月)
		var day1 = myDate1.getDate();         //获取当前日(1-31)
		var lastday1 = new Date(year1,month1+1,0).getDate();	//当月最大天数
		
		var firstDayOfMonth = 1;
			if(selectType == "day"){
				if((day+1) > lastday){
					if((month+1) > 11){
						year = year + 1;
						month = 0;
					}else{
						month = month + 1;
					}
					day = 1;
				}else{
					day = day + 1;
				}
				month = month + 1;
				document.getElementById("beginTime").value = year+"-"+dateToString(month)+"-"+dateToString(day)+" 00:00";
				document.getElementById("endTime").value = year+"-"+dateToString(month)+"-"+dateToString(day)+" 23:59";
			}else if(selectType == "week"){
				if((day+7) > lastday){
					if((month+1) > 11){
						year = year + 1;
						month = 0;
					}else{
						month = month + 1;
					}
					day = (day+7) - lastday;
				}else{
					day = day+7;
				}
				if((day1+7) > lastday1){
					if((month1+1) > 11){
						year1 = year1 + 1;
						month1 = 0;
					}else{
						month1 = month1 + 1;
					}
					day1 = (day1+7) - lastday1;
				}else{
					day1 = day1+7;
				}
				month = month + 1;
				month1 = month1 + 1;
				document.getElementById("beginTime").value = year+"-"+dateToString(month)+"-"+dateToString(day)+" 00:00";
				document.getElementById("endTime").value = year1+"-"+dateToString(month1)+"-"+dateToString(day1)+" 23:59";
			}else if(selectType == "month"){
				if((month+1) > 11){
					year = year + 1;
					month = 0;
				}else{
					month = month + 1;
				}
				month = month + 1;
				var myDate1 = new Date(year,month+1,0);
				var lastday = myDate1.getDate();
				document.getElementById("beginTime").value = year+"-"+dateToString(month)+"-"+dateToString(day)+" 00:00";
				document.getElementById("endTime").value = year+"-"+dateToString(month)+"-"+dateToString(lastday)+" 23:59";
			}
			submitSD();
	}
</script>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder">
			<form name="SchedularForm" action="querySchedular.jsp" method="post">
				<table width="100%" height="106" border="0" cellpadding="0" cellspacing="0" class="thin">
					<tr>
						<td height="23" class="detailtitle" width="15%">
							<strong> 主题</strong>
						</td>
						<td height="23" width="29%">
							<input name="topic" type="text" style="width:100%" value="<%=topic %>">
						</td>
						<td height="23" class="detailtitle" width="15%">
							<strong> 地点</strong>
						</td>
						<td height="23" width="29%">
							<input name="place" type="text" style="width:100%" value="<%=place %>">
						</td>

					</tr>
					<tr>
						<td height="23" class="detailtitle" width="15%">
							<strong> 查询单位</strong>
						</td>
						<td height="23" >
							<select id="selectType" name="selectType" onchange="changType(this)">
								<option value="normal" <%if("normal".equals(selectType)){ %>selected<%} %>>无</option>
								<option value="day" <%if("day".equals(selectType)){ %>selected<%} %>>天</option>
								<option value="week" <%if("week".equals(selectType)){ %>selected<%} %>>周</option>
								<option value="month" <%if("month".equals(selectType)){ %>selected<%} %>>月</option>
							</select>
							&nbsp;&nbsp;
							<input type="button" class="input" value="向前" onClick="prevDate()">&nbsp;&nbsp;
							<input type="button" class="input" value="向后" onClick="nextDate()">
						</td>
						<td height="23" class="detailtitle" width="15%">
							<strong> 开始时间从</strong>
						</td>
						<td height="23" width="30%">
							<input name="beginTime" readonly="true"  type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" value="<%=beginTime %>">
							<!--<INPUT type="button" value="时间" class="input" onclick="selectTime('SchedularForm.beginTime',0)">
						-->
							<strong> 至</strong>
							<input name="endTime" readonly="true" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" value="<%=endTime %>">
							<!--<INPUT type="button" value="时间"  class="input" onclick="selectTime('SchedularForm.endTime',0)">
						--></td>

					</tr>
					<tr>
						<td height="23" colspan=4 align="right">
							<input type="button" class="input" value="查询" onClick="submitSD()">
							<input type="button" class="input" value="重置" onClick="clear2()">
						</td>
					</tr>
				</table>
				<TABLE width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE" class="thin">
					<!--分页显示开始,分页标签初始化-->
					<pg:listdata dataInfo="QuerySchedularList" keyName="QuerySchedularList" />

					<pg:pager maxPageItems="10" scope="request" data="QuerySchedularList" isList="false">
						<pg:param name="topic" />
						<pg:param name="place" />
						<pg:param name="beginTime" />
						<pg:param name="endTime" />
						<tr>
						<td class="headercolor" width="10">
							<input type="checkBox" name="checkBox" onClick="checkAll('checkBox','ID')">
						</td>
						<td class="headercolor">
							主题
						</td>
						<td class="headercolor">
							地点
						</td>
						<td class="headercolor">
							日程开始时间
						</td>
						<td class="headercolor">
							日程结束时间
						</td>
						</tr>
						
						<!--检测当前页面是否有记录-->
							<pg:notify>
								<tr height='25' class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										暂时没有记录
									</td>
								</tr>
							</pg:notify>
						<pg:list>	
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">
								<td class="tablecells" width="5%" nowrap="nowrap">
									<input type="checkBox" name="ID" onClick="checkOne('checkBox','ID')" value="<pg:cell colName="schedularID" defaultValue=""/>">
								</td>
								<td width="20%" nowrap="nowrap" width="20%" class="tablecells">
									<pg:equal colName="topic" value="">无主题</pg:equal>
									<pg:cell colName="topic" defaultValue="无主题" />
								</td>
								<td width="20%" class="tablecells" width="20%" nowrap="nowrap">
									<pg:equal colName="place" value="">无地点</pg:equal>
									<pg:cell colName="place" defaultValue="无地点" />
								</td>
								<td width="20%" class="tablecells" width="20%" nowrap="nowrap">
									<pg:equal colName="beginTime" value="">未安排</pg:equal>
									<pg:cell colName="beginTime" dateformat="yyyy-MM-dd HH:mm" defaultValue="未安排" />
								</td>
								<td width="20%" class="tablecells" width="20%" nowrap="nowrap">
									<pg:equal colName="endTime" value="">未安排</pg:equal>
									<pg:cell colName="endTime" dateformat="yyyy-MM-dd HH:mm" defaultValue="未安排" />
								</td>
							</tr>
						</pg:list>
						<tr height="18px" class="labeltable_middle_tr_01">
							<td colspan=5 align='center' nowrap="nowrap">
								共
								<pg:rowcount />
								条记录
								<pg:index />
								<INPUT type="button" class="input" name="viewSD" value="查看日程" onclick="view('ID')">
								<input type="submit" class="input" value="删除" 
								onclick="javascript:dealRecord('ID',1); return false;">
							</td>
						</tr>
						<!--<input type="submit" value="删除" 
								onclick="javascript:dealRecord('ID',1); return false;">
								<INPUT type="button" name="modifySD" value="修改日程" onclick="modify('ID')"> 
								</td>							
								</tr>-->
						<!--<input name="queryString" value="<pg:querystring/>" type="hidden">

					--></pg:pager>
				</TABLE>
			</form>
		</div>
	</body>
</html>
