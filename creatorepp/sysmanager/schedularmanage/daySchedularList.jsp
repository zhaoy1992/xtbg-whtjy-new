<%@page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<jsp:directive.page import="java.text.SimpleDateFormat"/>
<%@include file="../include/global1.jsp"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.mq.MQ"%>
<%@page import="com.chinacreator.mq.MQMessage"%>
<%@page import="EDU.oswego.cs.dl.util.concurrent.ConcurrentHashMap"%>
<%@page import="java.util.Map"%>
<%@taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.SchedularManagerImpl"%>
<%
			String rootPath = request.getContextPath();
            String curDate = request.getParameter("curDate");
			if (curDate == null)
				curDate = (String) request.getAttribute("curDate");
			String curDate1 = request.getParameter("curDate1");
			String weekday = request.getParameter("weekday");
			if (curDate1 == null) 
			{
				curDate1 = (String) request.getAttribute("curDate1");
				weekday = (String) request.getAttribute("weekday");
			}
			AccessControl accesscontroler = AccessControl.getInstance();
	        accesscontroler.checkAccess(request, response);
			String userId = accesscontroler.getUserID();
			int j = Integer.parseInt(userId);
			SchedularManagerImpl schedularImpl = new SchedularManagerImpl();
			if (curDate == null)
				curDate = com.frameworkset.util.StringUtil.getFormatDate(
						new java.util.Date(), "yyyy-MM-dd");
			List schedulars = schedularImpl.getDaySchedular(curDate, j);
			request.setAttribute("schedulars", schedulars);
			String show = request.getParameter("show");
			
			%>

<html>
	<head>
		<title>日程列表</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript">     
	  var curDate = "<%=curDate%>";
	  var curDate1 = "<%=curDate1%>";
	  var weekday = "<%=weekday%>";
	  var rootPath = "<%=rootPath%>";
      function showdetail(schedularID)
       {
	    	document.location = rootPath + "/sysmanager/schedularmanage/schedularInfo1.jsp?date="+ curDate + "&date1=" + curDate1 +  "&weekday=" + weekday +  "&schedularID=" + schedularID+"&show=<%=show %>","newWin","scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=800,height=600,top=100,left=150";
       }
      function addschedular(beginTime,endTime)
       {   
       		document.location = "<%=rootpath%>/sysmanager/schedularmanage/addSchedular.jsp?date="+ curDate + "&date1=" + curDate1 +  "&weekday=" + weekday +  "&beginTime="+ beginTime + "&endTime=" + endTime;		
       }

		function getToday()
		{
			var today = getNavigatorContent().getToday();
			alert(today.year + "年" + today.month + "月" + today.day + "日"+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + today.todayWeek);
			document.write(today.year + "年" + today.month + "月" + today.day + "日"+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + today.todayWeek);
			
		}
</script>
		<style type="text/css">
<!--
.style1 {background-color: #EEEEEE }
.style2 {font-size: 18px}
.style3 {background-color: #FFFFD5 }
.style4 {background-color: #FFF4BC }
-->
</style>
		<script>
var STYLE1="style1";
</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body   oncontextmenu="return false;">
		<form name="form1" method="post" action="">
		</form>

		<table width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE">
			<tr>
				<td height="30" align="center" colspan="8" bgcolor="#EEEEEE">
					<b><%if (curDate1 == null) {

			%> <SCRIPT LANGUAGE="JavaScript">             
   
               var day="";
               var month="";
               var ampm="";
               var ampmhour="";
               var myweekday="";
               var year="";
               mydate = new  Date();
               myweekday = mydate.getDay();
               mymonth = mydate.getMonth()+1;
               myday = mydate.getDate();
               myyear = mydate.getYear();
               year = (myyear > 200) ? myyear : 1900 + myyear;
               if(myweekday == 0)
               weekday="日";
               else if(myweekday == 1)
               weekday="一";
               else if(myweekday == 2)
               weekday="二";
               else if(myweekday == 3)
               weekday="三";
               else if(myweekday == 4)
               weekday="四";
               else if(myweekday == 5)
               weekday="五";
               else if(myweekday == 6)
               weekday="六";
			   var output = year+"年"+mymonth+"月"+myday+"日  星期"+weekday;

			   curDate1 = year + "年" + mymonth + "月" + myday + "日";
			   weekday = "星期"+weekday;
		       document.write(output);
             
               </script>
                <%} 
                else 
                {
				out.print(curDate1 + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + weekday);
			    }
			    %></b>
				</td>
			</tr>
		</table>
		<table width="100%" height=600 border="1" cellspacing="0" cellpadding="0">
			<%
			
	        for(int i = 0; i < 24;i ++)
	        {
		        String dateStr1 = "";
				String dateStr2 = "";
				String timeStr1 = "";
				String timeStr2 = "";
				String hours = "";
	            if(i < 10)
	            {
	                dateStr1 = curDate +" 0"+ i +":00:00";
	                dateStr2 = curDate +" 0"+ i +":59:59";
	                hours = "0" + i + ":00";
	                timeStr1 = "0" + i + ":00:00";
	                timeStr2 = "0" + i + ":59:59";
	            }
	            else
	            {
	                dateStr1 = curDate +" "+ i +":00:00";
	                dateStr2 = curDate +" "+ i +":59:59";
	                hours =  i + ":00";
	                timeStr1 = "" + i + ":00:00";
	                timeStr2 = "" + i + ":59:59";
	             }
			%>
			<tr>
				<!--00:00-->
				<td width="10%" rowspan="1" align="center" bordercolor="#000000" bgcolor="#EEEEEE">
					<span class="style2"><%=hours%></span>
					<%
						if(i == 8)
						{
					%>
							<A id="anchor_id" HREF="#icon_3" name="icon_3"></A>
							<script language='javascript'><!--
							anchor_id.click();//--></script>
					<%		
						}
					%>
				</td>
				<% 
				//add by minghua.guo 2010-8-27
				Date compareTime = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date targetTime1 = sdf.parse(dateStr1);
				Date targetTime2 = sdf.parse(dateStr2);
				//当前时间小于目标开始时间
				if(compareTime.compareTo(targetTime2) < 1){
				%>
					<td class="style4" nowrap="nowrap" width="90%" vAlign="middle" bordercolor="#F6DBA2" onmouseover='{classTemp=this.className;this.className=STYLE1}' onmouseout='this.className=classTemp' <%if(!"true".equals(show)){ %>ondblclick=addschedular('<%=timeStr1%>','<%=timeStr2%>')<%} %> >
				<%}else{ %>
					<td class="style4" nowrap="nowrap" width="90%" vAlign="middle" bordercolor="#F6DBA2" style="background-color:#C0C0C0" onmouseover='{classTemp=this.className;this.className=STYLE1}' onmouseout='this.className=classTemp' >
				<%} %>
					&nbsp; &nbsp;
					<pg:list requestKey="schedulars"  needClear="false">
						<pg:equalandupper colName="beginTime" value="<%=dateStr1%>" dateformat="yyyy-MM-dd HH:mm:ss">
								<pg:equalandlower colName="beginTime" value="<%=dateStr2%>" dateformat="yyyy-MM-dd HH:mm:ss">
<!-- 								<IMG SRC="image/daily_work.gif" onclick=showdetail('<pg:cell colName="schedularID"/>') alt="地点<pg:cell colName="place"/>内容:<pg:cell colName="content" /> 开始时间:<pg:cell colName="beginTime" dateformat="yyyy-MM-dd HH:mm:ss"/> 结束时间 :<pg:cell colName="endTime" dateformat="yyyy-MM-dd HH:mm:ss"/>">-->
								<a style="cursor:hand;" onclick=showdetail('<pg:cell colName="schedularID"/>') onmouseover="this.style.color='red'" onmouseout="this.style.color=''" title="<pg:cell colName='topic'/>"> 主题：<pg:cell colName="topic" maxlength="10" replace="..."/> &nbsp;</a>
							</pg:equalandlower>
						</pg:equalandupper>
					</pg:list>
				</td>
			</tr>
		<%}%>
		</table>
	</body>
</html>

