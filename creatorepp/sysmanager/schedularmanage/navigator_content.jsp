<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.SchedularManagerImpl"%>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	SchedularManagerImpl smi = new SchedularManagerImpl();
	int j = Integer.parseInt(userId);
	String dddd = smi.getArrDays(j);
	
%>
<script language="javaScript">
	
	var diarydays="<%=dddd%>";
</script>

<style>
.calendarTd { font-family: "Arial", "Helvetica", "sans-serif", "����"; font-size: 9pt; color: #000000; background-color: #eeeeee; height: 18px; width: 11%; text-align: center;}
.calendarMInput { font-family: "Arial", "Helvetica", "sans-serif", "����"; font-size: 9pt; text-decoration: none; background-color: #FFFFFF; height: 15px; border: 1px solid #666666; width: 19px; color: #0099FF;text-align:center;}
.calendarYInput { font-family: "Arial", "Helvetica", "sans-serif", "����"; font-size: 9pt; color: #0099FF; text-decoration: none; background-color: #FFFFFF; height: 15px; width: 34px; border: 1px solid #666666;}
.calendarMonthTitle { font-family: "Arial", "Helvetica", "sans-serif", "����"; font-size: 9pt; font-weight: normal; height: 24px; text-align: center; color: #333333; text-decoration: none; background-color: #eeeeee; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-bottom-style: none; border-top-color: #999999; border-right-color: #999999; border-bottom-color: #999999; border-left-color: #999999;}
.calendarNow { font-family: "Arial", "Helvetica", "sans-serif", "����"; font-size: 9pt; font-weight: bold; color: #000000; background-color: #C0C9D3; height: 18px; text-align: center;}
.calendarDown{ font-family: "Arial", "Helvetica", "sans-serif", "����"; font-size: 9pt; font-weight: bold; color: #FF0000; background-color: #EEEEEE; height: 18px; text-align: center;}
.calendarDaySat { font-family: "Arial", "Helvetica", "sans-serif", "����"; font-size: 9pt; color: #333333; text-decoration: none; background-color: #eeeeee; text-align: center; height: 18px; width: 12%;}
.calendarDaySun { font-family: "Arial", "Helvetica", "sans-serif", "����"; font-size: 9pt; color: #333333; text-decoration: none; background-color: #eeeeee; text-align: center; height: 18px; width: 12%;}
.calendarLink { font-family: "Arial", "Helvetica", "sans-serif", "����"; font-size: 11pt; font-weight: bold; color: #333333; text-decoration: none; background-color: #EEEEEE; text-align: center; height: 18px;}
.categoryTxt { font-family: "Arial", "Helvetica", "sans-serif", "����"; font-size: 9pt; line-height: 23px; color: #333333; text-decoration: none;}
.categoryTable { border-right-width: 1px; border-bottom-width: 1px; border-right-style: solid; border-bottom-style: solid; border-left-style: none; border-right-color: #000000; border-bottom-color: #000000; border-top-width: 1px; border-top-style: solid; border-top-color: #71b99c;}
</style>
<SCRIPT LANGUAGE="JavaScript">
var months = new Array("һ", "��", "��","��", "��", "��", "��", "��", "��","ʮ", "ʮһ", "ʮ��");
var daysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31,30, 31, 30, 31);
var days = new Array("��","һ", "��", "��","��", "��", "��");
var classTemp;
var calendarHover="calendarHover";
var calendarDOWN="calendarDown";
var today=new getToday();
var year=today.year;
var month=today.month;
var todayWeek = today.todayWeek;
var newCal;
//�õ�ĳ������
function getDays(month, year) 
{ if (month==1)
     return ((0 == year % 4) && (0 != (year % 100))) ||(0 == year % 400) ? 29 : 28;
  else
     return daysInMonth[month];
}
//�õ�����ʱ����Ϣ
function getToday() 
{  this.now = new Date();
   this.year = this.now.getFullYear();
   this.month = this.now.getMonth();
   this.day = this.now.getDate();
} 
//��������
function Calendar() 
{  newCal = new Date(year,month,1); //��ǰ�µĵ�һ��
   today = new getToday();   
   var day = -1;   //�����ж��������Ƿ�Ϊ����
   var startDay = newCal.getDay(); //���¿�ʼʱ��
   var endDay=getDays(newCal.getMonth(), newCal.getFullYear());//���½���ʱ��
   var daily = 0;   //�������������е�����ֵ
   if ((today.year == newCal.getFullYear()) &&(today.month == newCal.getMonth()))
      day = today.day;
   var caltable = document.all.caltable.tBodies.calendar;  //�õ��������ļ���
   var intDaysInMonth =getDays(newCal.getMonth(), newCal.getFullYear()); //�õ���������
   //��������
   for (var intWeek = 0; intWeek < caltable.rows.length;intWeek++)
     for (var intDay = 0;intDay < caltable.rows[intWeek].cells.length;intDay++)
     {
      var cell = caltable.rows[intWeek].cells[intDay];   //�õ���Ԫ��
//�����ַ��������жϵ����Ƿ�����־
     var montemp=(newCal.getMonth()+1)<10?("0"+(newCal.getMonth()+1)):(newCal.getMonth()+1);         
     if ((intDay == startDay) && (0 == daily)){ daily = 1;}
     var daytemp=daily<10?("0"+daily):(daily);
     var d="<"+newCal.getFullYear()+"-"+montemp+"-"+daytemp+">";
 //ѡ����ʽ
      if(day==daily)
      cell.className="calendarNow";
      else if(diarydays.indexOf(d)!=-1)
      cell.className="calendarLink";
      else if(intDay==6)
      cell.className = "calendarDaySat";
      else if (intDay==0)
      cell.className ="calendarDaySun";
      else
      cell.className="calendarTd";
   //����ֵ
      if ((daily > 0) && (daily <= intDaysInMonth))  
      {  cell.innerText = daily;
         daily++;
      }
      else
        cell.innerText = "";
    } 
  document.all.year.value=year;
  document.all.month.value=month+1;
  
}

function subMonth()
{
  if ((month-1)<0)
  {
     month=11;
  year=year-1;
  }
  else
  { 
    month=month-1;
  }
  Calendar();
}
function addMonth()
{
  if((month+1)>11)
  {
    month=0;
    year=year+1;
  }
  else
  { 
    month=month+1;
  }
  Calendar();
}
//�õ���Ӧ�¼�
function getDiary() 
{
  var mon=(newCal.getMonth()+1)<10?("0"+(newCal.getMonth()+1)):(newCal.getMonth()+1);
  var day=event.srcElement.innerText<10?("0"+event.srcElement.innerText):(event.srcElement.innerText);
  var d="<"+newCal.getFullYear()+"-"+mon+"-"+day+">";
  var d1=newCal.getFullYear()+"-"+mon+"-"+day;
  var d2=newCal.getFullYear()+"��"+mon+"��"+day+"��";
  var c = new Date(newCal.getFullYear(),mon-1,day);
  var dayOfWeek = c.getDay();
  var weekday ="";
  if(dayOfWeek == 0)
		weekday="������";
  else if(dayOfWeek == 1)
		weekday="����һ";
  else if(dayOfWeek == 2)
		weekday="���ڶ�";
		else if(dayOfWeek == 3)
		weekday="������";
		else if(dayOfWeek == 4)
		weekday="������";
		else if(dayOfWeek == 5)
		weekday="������";
		else if(dayOfWeek == 6)
		weekday="������";
  if ("TD" == event.srcElement.tagName)
 //if (("" != event.srcElement.innerText)&&(diarydays.indexOf(d)!=-1))
  if (("" != event.srcElement.innerText))
  {     
         
  		getPropertiesContent().location="daySchedularList.jsp?curDate=" + d1 + "&curDate1=" + d2 + "&weekday=" + weekday;
  }
 }

function setDate() 
{
  if (document.all.month.value<1||document.all.month.value>12)
  {
    alert("�µ���Ч��Χ��1-12֮��!");
 return;
  }
  year=Math.ceil(document.all.year.value);
  month=Math.ceil(document.all.month.value-1);
  Calendar();
}

</SCRIPT>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
	<DIV id="contentborder">
		<TABLE border="0" cellpadding="0" cellspacing="1" class="calendarBigBorder" id="caltable" width="200">
			<THEAD>
				<TR align="center" valign="middle">
					<TD colspan="7" class="calendarMonthTitle">
						[<A onclick="subMonth()">����</A>]&nbsp;&nbsp;
						<INPUT name="year" type="text" class="calendarYInput" size="3" maxlength="4" onkeydown="if (event.keyCode==13){setDate()}" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onpaste="this.value=this.value.replace(/[^0-9]/g,'')">
						��
						<INPUT name="month" type="text" class="calendarMInput" size="1" maxlength="2" onkeydown="if (event.keyCode==13){setDate()}" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onpaste="this.value=this.value.replace(/[^0-9]/g,'')">
						��&nbsp;&nbsp;[<A onclick="addMonth()">����</A>]
					</TD>
				</TR>
				<TR align="center" valign="middle">
					<SCRIPT language="JavaScript">  
 document.write("<TD class=calendarDaySun id=diary>" + days[0] + "</TD>"); 
 for (var intLoop = 1; intLoop < days.length-1; intLoop++) 
 document.write("<TD class=calendarTd id=diary>" + days[intLoop] + "</TD>"); 
 document.write("<TD class=calendarDaySat id=diary>" + days[intLoop] + "</TD>"); 
 </SCRIPT>
				</TR>
			</THEAD>
			<TBODY border="1" cellspacing="0" cellpadding="0" id="calendar" align="CENTER" onclick="getDiary()" onmouseup="document.selection.empty()" oncontextmenu="return false" onselectstart="return false" ondragstart="return false" onbeforecopy="return false"
				oncopy="document.selection.empty()" onselect="document.selection.empty()">
				<SCRIPT language="JavaScript">
  for (var intWeeks = 0; intWeeks < 6; intWeeks++) {
  document.write("<TR style='cursor:hand'>");
  for (var intDays = 0; intDays < days.length;intDays++)
  document.write("<TD class=calendarTd onMouseover='{classTemp=this.className;this.className=calendarHover}' onMouseOut='this.className=classTemp' onmousedown='{Calendar();this.className=calendarDOWN;classTemp=this.className}' >  </TD> ");
  document.write("</TR>");
  } 
</SCRIPT>
			</TBODY>
		</TABLE>
		<SCRIPT language="JavaScript">
Calendar();
</SCRIPT>
		
	</DIV>
</body>
