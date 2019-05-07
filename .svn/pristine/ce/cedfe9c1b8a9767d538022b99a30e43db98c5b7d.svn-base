<%@page import="com.chinacreator.xtbg.core.holiday.service.impl.DailyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.holiday.service.DailyService"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String work_id= StringUtil.deNull(request.getParameter("work_id"));
String subid= StringUtil.deNull(request.getParameter("subid"));
DailyService service=new DailyServiceImpl();
Map<String,String> daily=new HashMap<String,String>();
if(!StringUtil.isBlank(work_id)){
	daily=service.findDailyByWorkId(work_id);
}

%>


<HTML>
 <HEAD><base target="_self"> 
 
  <TITLE> 作息时间设置 </TITLE>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="utf-8"></script>

<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
		



<script language="JavaScript">
$(function() {
	if("<%=work_id%>"!=""){
		$("#am_begin_time").val("<%=daily.get("am_begin_time")%>");
	    $("#am_end_time").val("<%=daily.get("am_end_time")%>");
	    $("#pm_begin_time").val("<%=daily.get("pm_begin_time")%>");
	    $("#pm_end_time").val("<%=daily.get("pm_end_time")%>");
	}
	jQuery("#begin_date").focus();
	
});

function checkField(){
	
	 
     var am1=$("#am_begin_time").val();
     var am2=$("#am_end_time").val();
     var pm1=$("#pm_begin_time").val();
     var pm2=$("#pm_end_time").val();

     if(am1!="00:00" && am1==am2 || pm1!="00:00" && pm1==pm2){
        alert("上下班时间不能相同！");
        return true;
     }
     if(am1!="00:00" && (parseInt(am1.split(":")[0])>parseInt(am2.split(":")[0])|| parseInt(am1.split(":")[1])>parseInt(am2.split(":")[1])) || pm1!="00:00" && (parseInt(pm1.split(":")[0])>parseInt(pm2.split(":")[0])|| parseInt(pm1.split(":")[1])>parseInt(pm2.split(":")[1]))){
        alert("上班时间应该要在下班时间的前面");
        return true;
     }
     
}
function displayElement(){
  if($("#am_begin_time").val()=="00:00" ||$("#am_end_time").val()=="00:00"){
	 $("#am_begin_time").val("00:00");
     $("#am_end_time").val("00:00");
  }
 if($("#pm_begin_time").val()=="00:00" || $("#pm_end_time").val()=="00:00"){
     $("#pm_begin_time").val("00:00");
     $("#pm_end_time").val("00:00");
  }
  
}
function saveWorkDate(){
	  var isFlag = jQuery('#vcenter').validationEngine('validate');
	  if(isFlag){
	      if(checkField()){
	      	return;
	      }else{
	        displayElement();
	        if( $("#am_begin_time").val()=="00:00" && $("#pm_begin_time").val()=="00:00"){
	            alert("如果当天不上班，请把当天设置为节假日！");
	            return;
	        }
	        var fm = document.getElementById("form1");
			fm.target = "hiddenFrame";
			fm.submit();
	      }
	  }
     
}

function back(){
	closeAlertWindows("<%=subid%>",false,true);
}
</script>

 </HEAD>
 <%@ include file="/epp/css/cssControl.jsp"%>
 <body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="dailydo.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="work_id" id="work_id"  value="<%=work_id %>"  />
<input type="hidden" name="action" id="action" value="addorupdate"  />



<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<input name="fbbt" id="fbbt" value="保存" onclick="saveWorkDate();"  type="button" class="but_y_01" /> 
		<input name="" value="返回" onclick="back()" type="button" class="but_y_01" />
	</div>
</div>
<!-- 操作-->

<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px;">
	
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>作息时间明细</span></div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<th class="content_02_box_div_table_th">日期范围：</th>
						<td class="content_02_box_div_table_td">
						<input readonly="readonly" type="text" id="begin_date" name="begin_date" style="float:left;width: 150px;height: 26px" class="validate[required] date_120 Wdate"
							onclick="WdatePicker({maxDate:'#F{$dp.$D(\'end_date\')}',dateFmt:'yyyy-MM-dd'})" value="<%=StringUtil.deNull(daily.get("begin_date")) %>"/>
					<span style="float:left">&nbsp;至 &nbsp;</span><input  readonly="readonly" type="text" id="end_date" name="end_date" style="width: 150px;height: 26px" class="validate[required] date_120 Wdate"
							onclick="WdatePicker({minDate:'#F{$dp.$D(\'begin_date\')}',dateFmt:'yyyy-MM-dd'})" value="<%=StringUtil.deNull(daily.get("end_date")) %>"/>
						</td>
						
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">上午 工作时间段：</th>
						<td class="content_02_box_div_table_td">
							<SELECT  style="width:150px" id="am_begin_time" name="am_begin_time"  ><OPTION value=08:00 selected>8:00</OPTION><OPTION value=08:30>8:30</OPTION><OPTION value=09:00>9:00</OPTION><OPTION value=09:30>9:30</OPTION><OPTION value=10:00>10:00</OPTION><OPTION value=10:30>10:30</OPTION><OPTION value=11:00>11:00</OPTION><OPTION value=11:30>11:30</OPTION><OPTION value=12:00>12:00</OPTION><OPTION value=00:00>不上班</OPTION></SELECT>&nbsp;至&nbsp;
					    	<SELECT style="width:150px" id="am_end_time" name="am_end_time" ><OPTION value=08:30 >8:30</OPTION><OPTION value=09:00>9:00</OPTION><OPTION value=09:30>9:30</OPTION><OPTION value=10:00>10:00</OPTION><OPTION value=10:30>10:30</OPTION><OPTION value=11:00>11:00</OPTION><OPTION value=11:30>11:30</OPTION><OPTION value=12:00 selected>12:00</OPTION><OPTION value=12:30>12:30</OPTION><OPTION value=00:00>不上班</OPTION></SELECT>
						</td>
					</tr>
					<tr id="sel">
						<th class="content_02_box_div_table_th">下午 工作时间段：</th>
						<td  class="content_02_box_div_table_td" >
							<SELECT style="width:150px" id="pm_begin_time" name="pm_begin_time" ><OPTION value=13:00 >13:00</OPTION><OPTION value=13:30>13:30</OPTION><OPTION value=14:00 selected>14:00</OPTION><OPTION value=14:30>14:30</OPTION><OPTION value=15:00>15:00</OPTION><OPTION value=15:30>15:30</OPTION><OPTION value=16:00>16:00</OPTION><OPTION value=16:30>16:30</OPTION><OPTION value=17:00>17:00</OPTION><OPTION value=17:30>17:30</OPTION><OPTION value=18:00>18:00</OPTION><OPTION value=00:00>不上班</OPTION></SELECT>&nbsp;至&nbsp;
					     	<SELECT style="width:150px" id="pm_end_time" name="pm_end_time" ><OPTION value=13:30 >13:30</OPTION><OPTION value=14:00>14:00</OPTION><OPTION value=14:30>14:30</OPTION><OPTION value=15:00>15:00</OPTION><OPTION value=15:30>15:30</OPTION><OPTION value=16:00>16:00</OPTION><OPTION value=16:30>16:30</OPTION><OPTION value=17:00>17:00</OPTION><OPTION value=17:30 selected>17:30</OPTION><OPTION value=18:00>18:00</OPTION><OPTION value=18:30>18:30</OPTION><OPTION value=19:00>19:00</OPTION><OPTION value=00:00>不上班</OPTION></SELECT>
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th">备注：</th>
						<td  class="content_02_box_div_table_02_td">
						<textarea class="validate[maxSize[500]] textarea_575" style="width:99%" name="remark" id="remark"  ><%=StringUtil.deNull(daily.get("remark")) %></textarea>
							
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>

</form>

<iframe name="hiddenFrame" width="0" height="0"></iframe>

</body>
</HTML>

