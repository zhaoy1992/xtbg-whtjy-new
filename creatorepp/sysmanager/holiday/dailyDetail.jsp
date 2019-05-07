<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.holiday.*,com.chinacreator.security.AccessControl,com.frameworkset.util.StringUtil"%>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String work_id= StringUtil.replaceNull(request.getParameter("work_id"));
DailyDao dailyDao=null;
Daily daily=null;
String msg=null;
boolean isInit=false;
String modify= StringUtil.replaceNull(request.getParameter("modify"));
if(modify.equalsIgnoreCase("modify")){
	dailyDao=new DailyDao();
	daily=new Daily();
	daily.setWork_id(StringUtil.replaceNull(request.getParameter("work_id")));
	daily.setBegin_date(StringUtil.replaceNull(request.getParameter("begin_date")));
	daily.setEnd_date(StringUtil.replaceNull(request.getParameter("end_date")));
	daily.setAm_begin_time(StringUtil.replaceNull(request.getParameter("am_begin_time")));
	daily.setAm_end_time(StringUtil.replaceNull(request.getParameter("am_end_time")));
	daily.setPm_begin_time(StringUtil.replaceNull(request.getParameter("pm_begin_time")));
	daily.setPm_end_time(StringUtil.replaceNull(request.getParameter("pm_end_time")));
	daily.setRemark(StringUtil.replaceNull(request.getParameter("remark")));
    msg=dailyDao.findAcross(daily);
    if(msg == null){
    	if(daily.getWork_id().length()>0){
		  isInit= dailyDao.updateDaily(daily);    
		}else{
		  isInit= dailyDao.addDaily(daily);
		}
    }

}else{

	if(work_id.length()>0){
	    dailyDao=new DailyDao();
		daily=dailyDao.findDailyByWorkId(work_id);
	}
	
}
%>


<HTML>
 <HEAD><base target="_self"> 
 
  <TITLE> 作息时间设置 </TITLE>

		
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">

<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="javascript" src="../scripts/selectTime.js"></script>
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<script src="../inc/js/func.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
<script language="JavaScript" src="../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
<script type="text/javascript" src="../../public/datetime/calender.js" language="javascript"></script>
<script type="text/javascript" src="../../public/datetime/calender_date.js" language="javascript"></script>
 <script language="JavaScript">
<%
    if(msg!=null){
        out.print("alert('此记录将于其它的记录："+msg+"产生交叉，属于非法数据，不能插入！');");
        
        out.print("window.returnValue=false;this.close();");
    }
    if(isInit){
        out.print("alert('保存成功！');");
        
        out.print("window.returnValue=true;this.close();");
    }   
    if(null==daily) {
       daily =new Daily();
    }else{
       out.println("window.onload=function(){document.getElementById('am_begin_time').value='"+daily.getAm_begin_time()+"';");
       out.println("document.getElementById('am_end_time').value='"+daily.getAm_end_time()+"';");
       out.println("document.getElementById('pm_begin_time').value='"+daily.getPm_begin_time()+"';");
       out.println("document.getElementById('pm_end_time').value='"+daily.getPm_end_time()+"'};");
    }
%>    		
</script>
<script language="JavaScript">
function $(id){
   return document.getElementById(id);
}
function checkField(){
	 if($("begin_date").value=="" || $("end_date").value==""){
	    alert("开始日期 或 结束日期 不能为空");
		return true;
	 }
     if($("begin_date").value>$("end_date").value){
          alert("开始时间段不能晚于结束时间段");
          return true;
     }
     var am1=$("am_begin_time").value;
     var am2=$("am_end_time").value;
     var pm1=$("pm_begin_time").value;
     var pm2=$("pm_end_time").value;

     if(am1!="00:00" && am1==am2 || pm1!="00:00" && pm1==pm2){
        alert("上下班时间不能相同！");
        return true;
     }
     if(am1!="00:00" && parseInt(am1.split(":")[0])>parseInt(am2.split(":")[0]) || pm1!="00:00" && parseInt(pm1.split(":")[0])>parseInt(pm2.split(":")[0])){
        alert("上班时间应该要在下班时间的前面");
        return true;
     }
     if($("remark").value.length>499){
        alert("描述字符长度要少于500！");
        return true;
     }
}
function displayElement(){
  if($("am_begin_time").value=="00:00" ||$("am_end_time").value=="00:00"){
	 $("am_begin_time").value="00:00"
     $("am_end_time").value="00:00";
  }
 if($("pm_begin_time").value=="00:00" || $("pm_end_time").value=="00:00"){
     $("pm_begin_time").value="00:00";
     $("pm_end_time").value="00:00";
  }
  
}
function saveWorkDate(){
      if(checkField()){
      return;
      }else{
        displayElement();
        if( $("am_begin_time").value=="00:00" && $("pm_begin_time").value=="00:00"){
            alert("如果当天不上班，请把当天设置为节假日！");
            return;
        }
        document.forms[0].submit();
     }
     
}


</script>

 </HEAD>
 <%@ include file="/epp/css/cssControl.jsp"%>
 <BODY>

  <form name="dailyForm" action="dailyDetail.jsp" method="get">
     <input type="hidden" name="work_id" value="<%=daily.getWork_id() %>">
     <input type="hidden" name="modify" value="modify">
     <table width="550" border=0>
         <tr>
			<td align=center><b>作息时间明细</b></td>
		 </tr>
         <tr>
			<td>
			<TABLE width=530 class="thin">
				<TR>
					<TD width=30%>日期范围</TD>
					<TD width=70%><input readonly="readonly" type="text" id="begin_date" name="begin_date" style="width:150px"   onclick="showdate(document.all('begin_date'))" value="<%=daily.getBegin_date() %>" validator="stringNull" maxlength="40"> 
					至 &nbsp;<input  readonly="readonly" type="text" id="end_date" name="end_date" style="width:150px" onclick="showdate(document.all('end_date'))" value="<%=daily.getEnd_date() %>" validator="stringNull" maxlength="40">
		
					 </TD>
				</TR>
				<TR>
					<TD>上午 工作时间段</TD>
					<TD>
				
					    <SELECT  style="width:150px" id="am_begin_time" name="am_begin_time"  ><OPTION value=08:00 selected>8:00</OPTION><OPTION value=08:30>8:30</OPTION><OPTION value=09:00>9:00</OPTION><OPTION value=09:30>9:30</OPTION><OPTION value=10:00>10:00</OPTION><OPTION value=10:30>10:30</OPTION><OPTION value=11:00>11:00</OPTION><OPTION value=11:30>11:30</OPTION><OPTION value=12:00>12:00</OPTION><OPTION value=00:00>不上班</OPTION></SELECT>&nbsp;至&nbsp;
					    <SELECT style="width:150px" id="am_end_time" name="am_end_time" ><OPTION value=08:30 >8:30</OPTION><OPTION value=09:00>9:00</OPTION><OPTION value=09:30>9:30</OPTION><OPTION value=10:00>10:00</OPTION><OPTION value=10:30>10:30</OPTION><OPTION value=11:00>11:00</OPTION><OPTION value=11:30>11:30</OPTION><OPTION value=12:00 selected>12:00</OPTION><OPTION value=12:30>12:30</OPTION><OPTION value=00:00>不上班</OPTION></SELECT>
					</TD>
				</TR>
				<TR>
					<TD>下午 工作时间段</TD>
					<TD>
					     <SELECT style="width:150px" id="pm_begin_time" name="pm_begin_time" ><OPTION value=13:00 >13:00</OPTION><OPTION value=13:30>13:30</OPTION><OPTION value=14:00 selected>14:00</OPTION><OPTION value=14:30>14:30</OPTION><OPTION value=15:00>15:00</OPTION><OPTION value=15:30>15:30</OPTION><OPTION value=16:00>16:00</OPTION><OPTION value=16:30>16:30</OPTION><OPTION value=17:00>17:00</OPTION><OPTION value=17:30>17:30</OPTION><OPTION value=18:00>18:00</OPTION><OPTION value=00:00>不上班</OPTION></SELECT>&nbsp;至&nbsp;
					     <SELECT style="width:150px" id="pm_end_time" name="pm_end_time" ><OPTION value=13:30 >13:30</OPTION><OPTION value=14:00>14:00</OPTION><OPTION value=14:30>14:30</OPTION><OPTION value=15:00>15:00</OPTION><OPTION value=15:30>15:30</OPTION><OPTION value=16:00>16:00</OPTION><OPTION value=16:30>16:30</OPTION><OPTION value=17:00>17:00</OPTION><OPTION value=17:30 selected>17:30</OPTION><OPTION value=18:00>18:00</OPTION><OPTION value=18:30>18:30</OPTION><OPTION value=19:00>19:00</OPTION><OPTION value=00:00>不上班</OPTION></SELECT>
					</TD>
				</TR>
				<TR>
					<TD colspan="2">备注</TD>

				</TR>
				<TR>
					<TD colspan="2"><textarea id="remark" name="remark" style="width:530" rows=5><%=daily.getRemark() %></textarea></TD>
				</TR>
				<TR class="labeltable_middle_tr_01">
					<TD colspan="2" align=center>
					<input type="button" value="确定" class="input" onclick="saveWorkDate()">&nbsp;&nbsp;<input type="reset" value="重置" class="input">
					</TD>
				</TR>
			</TABLE>
			
			</td>
		 </tr>
	 </table>

  </form>
 </BODY>
</HTML>

