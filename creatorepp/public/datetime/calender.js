var today=new Date();  //����һDate���Ͷ����ȡ��ǰʱ��
   var desTxtId;
   var cal;               //�����ؼ�
   var tbl;
   var tblchild;
   var obj;
   var browserName=navigator.appName;
   var isIE=browserName.indexOf("Microsoft")!=-1?true:false;
   
   function montharr(m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11)
   {
      this[0]=m0;this[1]=m1;this[2]=m2;this[3]=m3;this[4]=m4;this[5]=m5;this[6]=m6;
	  this[7]=m7;this[8]=m8;this[9]=m9;this[10]=m10;this[11]=m11; }

   function fillcalendar()
   {
	  var monthDays=new montharr(31,28,31,30,31,30,31,31,30,31,30,31);
	  var monthNames=new Array("1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��");
	  year=today.getFullYear();
	  if(((year%4==0)&&(year%100==0))||(year%400==0))monthDays[1]=29;
	  nDays=monthDays[today.getMonth()];
	  firstDay=today;
	  firstDay.setDate(1);
	  startDay=firstDay.getDay();
	  column=0;
	  tblchild=tbl.firstChild;
	  tblchild.childNodes[1].childNodes[2].innerHTML=year+"��"+monthNames[today.getMonth()]
	  for(var i=0;i<startDay;i++){tblchild.childNodes[3].childNodes[i].innerHTML="&nbsp;";column++;}
	  j=3;
	  var txt="";

      var myToday=new Date();
      var myYear = myToday.getFullYear();
      var myMonth = myToday.getMonth();
      var myDate = myToday.getDate();
      var selYear = today.getFullYear();
      var selMonth = today.getMonth();

	  for(var i=1;i<=nDays;i++)
	  {
            tblchild.childNodes[j].childNodes[column].innerHTML=i;
            if(myYear==selYear && myMonth==selMonth && i==myDate){
              tblchild.childNodes[j].childNodes[column].style.color="black";
            }
            else if(column==0 || column==6){
              tblchild.childNodes[j].childNodes[column].style.color="red";
            }
            else{
              tblchild.childNodes[j].childNodes[column].style.color="blue";
            }
            column++;
            if(column==7){j=j+1;column=0;}
	  }
	  if(column<7&&column!=0)
	     for(var i=column;i<7;i++)tblchild.childNodes[j].childNodes[i].innerHTML="&nbsp;";
   }

   function monthadd()
   {
       clearCalendar();
	   today.setMonth((today.getMonth()+1)%12);
	   if(today.getMonth()==0)today.setFullYear(today.getFullYear()+1);
	   fillcalendar();
   }

   function monthsub()
   {
       clearCalendar();
	   today.setMonth((today.getMonth()+11)%12);
	   if(today.getMonth()==11)today.setFullYear(today.getFullYear()-1);
	   fillcalendar();
   }

   function changeyear(yearValue)
   {
		if(1900>yearValue||yearValue>2999){alert("��ݷ�Χ����");return;}
		today.setFullYear(yearValue);
		clearCalendar();
		fillcalendar();
   }

   function changemonth(monthValue)
   {
		today.setMonth(monthValue-1);
		clearCalendar();
		fillcalendar();
   }

// ----- created by lintao 2004-12-3 -----
   function returndate(vday,vtime)
   {
	   if(vday=="&nbsp;"){hidecal();return;}
	   if(vday!="")
	   { month=today.getMonth()+1;
	     year=today.getFullYear();
		 if (month<10) month = '0'+ month;
		 if (vday<10) vday = '0'+vday;

	     desTxtId.value=year+"-"+month+"-"+vday+" "+vtime;
	     }
	   else desTxtId.value=""
	   hidecal();
   }
// ----- original edition -----
/*
   function returndate(vday)
   {
	   if(vday=="&nbsp;"){hidecal();return;}
	   if(vday!="")
	   { month=today.getMonth()+1;
	     year=today.getFullYear();


	     desTxtId.value=year+"-"+month+"-"+vday;

	     }
	   else desTxtId.value=""
	   hidecal();
   }
*/

   function clearCalendar()
   {
	  for(var i=3;i<tblchild.childNodes.length;i++)
	     for(var j=0;j<tblchild.childNodes[3].childNodes.length;j++)
		     tblchild.childNodes[i].childNodes[j].innerHTML="";
   }

  function buildtbl()
  {
      var myToday=new Date();
      var myYear = myToday.getFullYear();
      var myMonth = myToday.getMonth() + 1;

      document.write("<div id='Calendar' style=\"display:none;position:absolute;width:220;background:#DEE5FF;z-index:100\">");
      document.write("<table id='calTbl' width='220' align='center' border='1' bordercolorlight='#000000' bordercolordark='#FFFFFF' >");
      document.write("<tr>");
	  document.write("<td Author='rodger' align='center' colspan='5' valign='middle'>");
	  document.write("<select Author='rodger' size='1' onchange='changeyear(this.value)'>");
	  for(var i=1940;i<=2050;i++){
            if(i == myYear)
            document.write("<option Author='rodger' value='"+i+"' selected>"+i+"</option>");
            else
            document.write("<option Author='rodger' value='"+i+"'>"+i+"</option>");
	  }
	  document.write("</select>��")
      document.write("<select Author='rodger' size='1' onchange='changemonth(this.value)'>");
	  for(var i=1;i<=12;i++){
            if(i == myMonth)
            document.write("<option Author='rodger' value='"+i+"' selected>"+i+"</option>");
            else
            document.write("<option Author='rodger' value='"+i+"'>"+i+"</option>");
	  }
	  document.write("</select>��</td>")
	  document.write("<td Author='rodger' align='center'><a href='javascript:void(null)' onclick='returndate(\"\")'><font face='Webdings' color='black'>=</font></a></td>");
	  document.write("<td Author='rodger' align='center'><a href='javascript:void(null)' onclick='hidecal()'><font face='Webdings' color='black'>r</font></a></td>");
	  document.write("</tr><tr>");
      document.write("<td Author='rodger' align='center'><a Author='rodger' href='javascript:void(null)' onclick='changeyear(today.getFullYear()-1)'><font Author='rodger' face='Webdings'>7</font></a></th>");
      document.write("<td Author='rodger' align='center'><a Author='rodger' href='javascript:void(null)'onclick='monthsub()'><font Author='rodger' face='Webdings'>3</font></a></th>");
	  document.write("<td Author='rodger' colspan='3' align='center' style='font-size:9pt;font-weight:bold;color:blue'>&nbsp;</th>");
      document.write("<td Author='rodger' align='center'><a href='javascript:void(null)' onclick='monthadd()'><font Author='rodger' face='Webdings'>4</font></a></th>");
	  document.write("<td Author='rodger' align='center'><a href='javascript:void(null)' onclick='changeyear(today.getFullYear()+1)'><font Author='rodger' face='Webdings'>8</font></a></th>");
	  document.write("</tr><tr>");
      document.write("<td Author='rodger' align='center' style='font-size:9pt;color:red; bgcolor='#C6DFC6'>��</th>");
      document.write("<td Author='rodger' align='center' style='font-size:9pt;color:black; bgcolor='#C6DFC6'>һ</th>");
      document.write("<td Author='rodger' align='center' style='font-size:9pt;color:black; bgcolor='#C6DFC6'>��</th>");
      document.write("<td Author='rodger' align='center' style='font-size:9pt;color:black; bgcolor='#B1D9B1'>��</th>");
      document.write("<td Author='rodger' align='center' style='font-size:9pt;color:black; bgcolor='#B1D9B1'>��</th>");
	  document.write("<td Author='rodger' align='center' style='font-size:9pt;color:black; bgcolor='#B1D9B1'>��</th>");
	  document.write("<td Author='rodger' align='center' style='font-size:9pt;color:red; bgcolor='#66aa77'>��</th>");
	  document.write("</tr>");

for(var i=0;i<6;i++)
	  {
	      document.write("<tr>");
		  for(var j=0;j<7;j++)
		  {
              if(j==0)varStyle="font-size:9pt;font-weight:bold;color:red";
              else if(j==6)varStyle="font-size:9pt;font-weight:bold;color:red";
              else varStyle="font-size:9pt;font-weight:bold;color:blue;";
			  if(isIE)varCursor="hand";
			  else varCursor="default"
			  // ---------- modified by lintao 2004-12-3: change 'returndate(this.innerHTML)' to 'isOK(this.innerHTML)' ----------
              document.write("<td Author='rodger' align='center' width='14%' style='"+varStyle+"' onmousedown=isOK(this.innerHTML);this.style.backgroundColor='' onmouseover=this.style.cursor='"+varCursor+"';this.style.backgroundColor='#FFFFFF' onmouseout=this.style.backgroundColor=''></td>");
              //document.write("<td Author='rodger' align='center' width='14%' style='"+varStyle+"' onmousedown=returndate(this.innerHTML);this.style.backgroundColor='' onmouseover=this.style.cursor='"+varCursor+"';this.style.backgroundColor='#FFFFFF' onmouseout=this.style.backgroundColor=''></td>");
			  // ---------- end of modify ----------
          }
		  document.write("</tr>");
	  }
      document.write("</table>");

//------------------ inserted by lintao 2004-12-3 -------------------
var intHour	= today.getHours();
var intMinute	= today.getMinutes();
var intSecond	= today.getSeconds();
document.write("<style type=\"text/css\"><!--\n");
document.write(".myinput {text-align: center;width: 20px;border: 0px;height: 16px;vertical-align: baseline;}");
document.write(".boxIn {border-top: 2px solid #423E3B;border-right: 1px solid #FFFCF5;border-bottom: 1px solid #FFFCF5;border-left: 2px solid #423E3B;background:;}");
document.write(".myButton {height: 10px;width: 25px;font-size: 4px;}");
document.write("\n--></style>");
document.write("<script language=\"JavaScript\">");
document.write("var strTemp=\"\",intTemp=0;");
document.write("var objTime,intMax;");
document.write("function onTimeKeyUp(obj,num,maxnum,next){");
document.write("var strTemp=obj.value;");
document.write("if(isNaN(strTemp))obj.value=strTemp.substring(0,strTemp.length-1);");
document.write("else{var intTemp=parseInt(strTemp);");
document.write("if(intTemp>maxnum)obj.value=strTemp.substring(0,strTemp.length-1);");
document.write("else if(intTemp>num){next.focus();}");
document.write("}}");

document.write("function timeAdd(obj0){if(objTime==null) {objTime=hour;intMax=23;};var i=parseInt(objTime.value);if(i<intMax)objTime.value=i+1;objTime.select();obj0.focus();}");

document.write("function timeRid(obj0){if(objTime==null) {objTime=hour;intMax=23;};var i=parseInt(objTime.value);if(i>0)objTime.value=i-1;objTime.select();obj0.focus();}");

document.write("function isOK(vday){");
document.write("var hourStr;");
document.write("if (parseInt(hour.value)<10) hourStr = '0'+hour.value;");
document.write("else hourStr = hour.value;");
document.write("var minuteStr;");
document.write("if (parseInt(minute.value)<10) minuteStr = '0'+minute.value;");
document.write("else minuteStr = minute.value;");
document.write("var secondStr;");
document.write("if (parseInt(second.value)<10) secondStr = '0'+second.value;");
document.write("else secondStr = second.value;");
document.write("var vtime;");
document.write("vtime=hourStr+':'+minuteStr+':'+secondStr;");
document.write("returndate(vday,vtime);");
document.write("}");
document.write("</script>");

document.write("<table>");
document.write("<tr>");
document.write("<td Author='rodger' width=\"125\" align='center' class='boxIn'>");
document.write("ʱ��:");
document.write("<input name=\"hour\" type=\"text\" class='myInput' id=\"hour\" onBlur=\"if(this.value=='')this.value='0';\" onFocus=\"this.select();objTime=this;intMax=23\" value=\""+intHour+"\" maxlength=\"2\" onkeyup=\"onTimeKeyUp(this,2,23,minute)\">:");
document.write("<input name=\"minute\" type=\"text\" class='myInput' id=\"minute\" onBlur=\"if(this.value=='')this.value='0';\" onFocus=\"this.select();objTime=this;intMax=59\" value=\""+intMinute+"\" maxlength=\"2\" onkeyup=\"onTimeKeyUp(this,5,59,second)\">:");
document.write("<input name=\"second\" type=\"text\" class='myInput' id=\"second\" onBlur=\"if(this.value=='')this.value='0';\" onFocus=\"this.select();objTime=this;intMax=59\" value=\""+intSecond+"\" maxlength=\"2\" onkeyup=\"onTimeKeyUp(this,59,59,null)\">");
document.write("<td width=\"25\"><input name=\"timeup\" type=\"button\" class=\"myButton\" value=\"��\" onClick=\"timeAdd(this)\">");
document.write("<input name=\"timedown\" type=\"button\" class=\"myButton\" value=\"��\" onClick=\"timeRid(this)\"></td>");
document.write("</th>");
document.write("</tr>");
document.write("</table>");
//-------------------------- end of insert --------------------------
//document.write("<iframe src='javascript:false' style='position:absolute; visibility:inherit; top:0px; left:0px; width:'+mmenuitemwidth+'px; height:200px; z-index:-1; filter=\'progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)\';'></iframe>'");
	  document.write("</div> ");
	  cal=document.getElementById("Calendar");
	  tbl=document.getElementById("calTbl");
	  fillcalendar();
	  hidecal();
  }

  function hidecal(){ cal.style.display="none"; }

  function showcaltime(obj1)
  {
	      var obj=obj1.parentElement.childNodes(2);
     	  var id=obj.name;
     	  var x=offsetLeft(obj);alert(x);
		  var y=offsetTop(obj)*1-50;alert(y);
	        var p=location.href;
	        var i=0;
		  while(p.indexOf("/")>=0){
			  p=p.replace("/","");
			  i=i+1;
		  }
		  i=i-4;
		  p="";
    for (var j=0;j<i ;j++ )
    {
		p=p+"../"
    }
   window.showModalDialog( p+"public/datetime/showdate.jsp?retObj="+id,window,'dialogheight:260px;dialogwidth:180px;dialogLeft:'+x+';dialogTop:'+y+'status:no;help:no')
  }
  
  function showdatetime(obj)
  {
	var id=obj.name;
	var x = window.event.screenX - 150;
	var y = window.event.screenY + 20;
	var p=location.href;
	var temp_p,temp_i;
	var i=0;
	if(p.indexOf("?") >= 0)
	{
		p = p.substring(0,p.indexOf("?"));
	}
	while(p.indexOf("/")>=0){
	  p=p.replace("/","");
	  i=i+1;
	}
	temp_p = p;
	temp_i = i;
	i=i-4;
	p="";
    for (var j=0;j<i ;j++ )
    {
		p=p+"../"
    }
	
	if(!send_request_date(p+"public/datetime/showdatetime.jsp?retObj="+id))
	{
		i = temp_i;
		i=i-3;
		p="";
		for (var j=0;j<i ;j++ )
		{
			p=p+"../"
		}
	}
   window.showModalDialog( p+"public/datetime/showdate.jsp?retObj="+id,window,'dialogheight:256px;dialogwidth:180px;dialogLeft:'+x+';dialogTop:'+y+';status:no;help:no')
  }

  function send_request_date(url){
		http_request = false;
		//��ʼ��ʼ��XMLHttpRequest����
		if(window.XMLHttpRequest){//Mozilla
			http_request = new XMLHttpRequest();
			if(http_request.overrideMimeType){//����MIME���
				http_request.overrideMimeType("text/xml");						
			}
		}
		else if(window.ActiveXObject){//IE
			try{
				http_request = new ActiveXObject("Msxml2.XMLHTTP");
			}catch(e){
				try{
					http_request = new ActiveXObject("Microsoft.XMLHTTP");							
				}catch(e){
				}
			}
		}
		if(!http_request){
			alert("���ܴ���XMLHttpRequest����");
			return false;
		}
		//http_request.onreadystatechange = processRequest;
		http_request.open("GET",url,false);
		http_request.send();
		if(http_request.readyState == 4){
		
			if(http_request.status == 200){
				return true;
			}
			else{
				return false;
			}
		}
	}

  function offsetLeft(obj)
  {
    x = obj.offsetLeft;
    for (objParent=obj.offsetParent;objParent;objParent=objParent.offsetParent)x+=objParent.offsetLeft;
    return x;
  }
  function offsetTop(obj)
  {
     y = obj.offsetTop;
     for(objParent=obj.offsetParent;objParent;objParent=objParent.offsetParent)y+=objParent.offsetTop;
     return y;
  }

  buildtbl();
