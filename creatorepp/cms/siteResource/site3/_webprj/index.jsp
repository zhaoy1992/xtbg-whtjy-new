<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="cms"%>


<!--输出模版头文件-->

<!--输出模版前缀-->

<!--输出模版正文-->
<HTML><HEAD><TITLE>湖南省郴州市苏仙区门户网站</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="images/main.css" type=text/css rel=stylesheet>
<style type="text/css">
<!--
.STYLE1 {font-weight: bold}
.STYLE2 {color: #969E60}
-->
</style>
<form action="/cms/searchManage/search_process.jsp?siteId=1&searchType=2&tagFlag=1&chnlId=&indexName=null" method="post" enctype="application/x-www-form-urlencoded" target="_blank" style="display:inline">
<style type="text/css">
<!--
.STYLE1 {
	color: #FF6600;
	font-weight: bold;
}
.STYLE2 {
	color: #78A55F;
	font-weight: bold;
}
-->
</style>
<body topmargin="0" bottommargin="0" style="overflow-x:hidden" leftmargin="0" rightmargin="0"> 
<TABLE width=1007 height="184" border=0 align=center cellPadding=0 cellSpacing=0>
  <TR>
    <TD ><iframe  align="middle" src="top.htm" width="100%" height="184" scrolling="No" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" ></iframe></TD>
    </TR></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=1007 align=center border=0>
  
  <TR>
    <TD width=1 bgColor=#a6a6a6></TD>
    <TD width=3 bgColor=#f6f9ec></TD>
    <TD width=999 bgColor=#f6f9ec>
      <TABLE height=35 cellSpacing=0 cellPadding=0 width=999 align=center 
      border=0>
        <TR>
          <TD background=images/sgw.gif>
            <TABLE height=35 cellSpacing=0 cellPadding=0 width="99%" 
            align=center border=0>
              <TR>
                <TD width="25%"><IMG height=15 
                  src="images/rq.gif" width=15 align=absMiddle> 
                  今天是：
                  <SCRIPT language=javascript>
      currentDate = new Date()
 with (currentDate)
 {
  day=getDay()
  month=getMonth()+1
  this.document.write(getFullYear()+'年'+month+'月'+getDate()+'日')
 }
 
currentDate = new Date()
 with (currentDate)
 {
 youbi = new Array();
youbi[0] = " 星期日";
youbi[1] = " 星期一";
youbi[2] = " 星期二";
youbi[3] = " 星期三";
youbi[4] = " 星期四";
youbi[5] = " 星期五";
youbi[6] = " 星期六";
  day=getDay()
  month=getMonth()+1
  this.document.write(youbi[(new Date()) . getDay()])
 }
document.write('&nbsp;<font color=#ffffff>');
document.write("<font id='clock'></font>");
var now,hours,minutes,seconds,timeValue;
function showtime(){
now = new Date();
hours = now.getHours();
minutes = now.getMinutes();
seconds = now.getSeconds();
timeValue = (hours >= 12) ? "下午  " : "上午  ";
timeValue += ((hours > 12) ? hours - 12 : hours) + ":";
timeValue += ((minutes < 10) ? "0" : "") + minutes + ":";
timeValue += ((seconds < 10) ? "0" : "") + seconds + "";
clock.innerHTML = timeValue;
setTimeout("showtime()",600);
}
//showtime();
document.write('</font>');
</SCRIPT>
                </TD>
                <TD width="43%"><MARQUEE onmouseover=this.stop(); onmouseout=this.start(); 
                  scrollAmount=2 scrollDelay=10 width=330>
                  <iframe src="http://www.tianqi123.com/small_page/chengshi_1070.html?c0=black&c1=000000&t1=000000&bg=transparent&w=320&h=20&text=yes" width=330 height=21 marginwidth=0 marginheight=0 hspace=0 vspace=0 frameborder=0 scrolling=no align=center id=url allowtransparency="true"></iframe>
                </MARQUEE></TD>
                <TD width="32%"><table width="280" border="0" align="right">
                  <tr>
                    <td width="41"><div align="right"><IMG height=20 
                  src="images/search1.gif" width=20 
                  align=absMiddle></div></td>
                    <td width="157">
                      <div align="right">
                        <input name="queryString" style="padding-top:2px;border: 1px solid #DEDDDD"  type="text"  onfocus="this.select();" value="在这里输入关键字..." size="22" maxlength="15" />
                        </div></td><td width="68"><input type=image 
                  src="images/search_button.gif" align=absMiddle 
                  value=Submit name=Submit></td>
                    </tr>
                </table>
                </TD>
            </TR></TABLE></TD></TR></TABLE></TD>
    <TD width=3 bgColor=#f6f9ec></TD>
    <TD width=1 bgColor=#a6a6a6></TD></TR></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=1007 align=center border=0>
  
  <TR>
    <TD width=1 bgColor=#a6a6a6></TD>
    <TD width=3 bgColor=#f6f9ec></TD>
    <TD vAlign=top width=999 bgColor=#f6f9ec>
      <TABLE cellSpacing=0 cellPadding=0 width=999 align=center border=0>
        
        <TR>
          <TD vAlign=top width=789 bgColor=#f6f9ec>
            <TABLE cellSpacing=0 cellPadding=0 width=789 border=0>
              
              <TR>
                <TD vAlign=top width=232 height=223>
                  <TABLE height=223 cellSpacing=0 cellPadding=0 width=211 
                  align=center border=0>
                    
                    <TR>
                      <TD width="211" height=33 background="images/gggs.gif"><div align="center" class="STYLE2">社区新闻</div></TD>
                    </TR>
                    <TR>
                      <TD vAlign=top 
                        background=images/lgw.gif><TABLE 
                        cellSpacing=0 cellPadding=0 width="92%" align=center 
                        border=0>
                          
                          <TR>
                            <TD height=6></TD></TR>
                          <TR>
                            <TD vAlign=top>
                              <MARQUEE onmouseover=this.stop(); 
                              onmouseout=this.start(); scrollAmount=1 
                              direction=up height=155>
                              <TABLE height=22 cellSpacing=0 cellPadding=0 
                              width="98%" align=center border=0>
                               <cms:outline channel="社区新闻"  count="6"> 
                                <TR>
                                <TD vAlign=top width="5%" height=22><IMG 
                                src="images/dot05.gif"> </TD>
                                <TD class=link05 vAlign=top width="95%"><cms:link target="_blank" colName="title"  classname="link03" maxlength="25"  replace="..." /> [<cms:cell colName="docwtime" dateformat="MM-dd"/>] 
                          </TD></TR>
						    </cms:outline>
							</TABLE></MARQUEE></TD></TR></TABLE></TD></TR>
                    <TR>
                      <TD height=11><IMG height=11 
                        src="images/gggs_1.gif" 
                    width=211></TD></TR></TABLE></TD>
                <TD>
                  <TABLE height="100%" cellSpacing=0 cellPadding=0 width="98%" 
                  align=center border=0>
                    
                    <TR>
                      <TD width=405 height=22 background="images/tpxw.gif" style="background-repeat:no-repeat">&nbsp; &nbsp;&nbsp;<span class="STYLE1"> 社区图片</span></TD>
                    </TR>
                    <TR>
                      <TD><!--图片新闻-->
                        <TABLE height=167 cellSpacing=0 cellPadding=0 width=550 
                        border=0>
                          <TR>
                            <TD align=middle width=260 rowSpan=2 style="padding-top:5px;">
                            <cms:imageNews channel="社区图片新闻" maxlength="17" replace="..."  count="4" imgWidth="240" imgHeight="182" isMarquee="false"  />
                            </TD>
                            <TD width=5 rowSpan=2></TD>
                            <TD vAlign=top width=290>
                              <TABLE cellSpacing=0 cellPadding=0 width="100%" 
                              align=center border=0>
                                
                                <TR>
                                <TD height=6></TD></TR>
                               <cms:outline channel="我的社区"  count="8">
							    <TR>
                                <TD height=22><IMG height=7 
                                src="images/dot05.gif" width=6 
                                align=absMiddle> <cms:link target="_blank" colName="title" maxlength="20" classname="link03" replace="..." /></TD></TR>
							  </cms:outline>         
                                <TR>
                                <TD background="" height=1></TD></TR>
                                <TR>
                                <TD background="" 
                              height=1></TD></TR></TABLE></TD></TR>
                          <TR>
                            <TD class=t_br8 align=right height=20><cms:more classname="link03_2"  channel="我的社区" moretext=">>更多"/></TD>
                          </TR></TABLE><!----></TD></TR></TABLE></TD></TR></TABLE>
            <TABLE cellSpacing=0 cellPadding=0 width="75%" border=0>
              
              <TR>
                <TD height=2></TD>
              </TR></TABLE>
            <TABLE cellSpacing=0 cellPadding=0 width=789 border=0>
              
                <TR>
                  <TD width=232 rowspan="4" vAlign=top><TABLE height=383 cellSpacing=0 cellPadding=0 width=211 
                  align=center border=0>
                      
                        <TR>
                          <TD width="211" height=38 background="images/wykx.gif">&nbsp;</TD>
                        </TR>
                        <TR>
                          <TD vAlign=top 
                        background=images/lgw.gif><TABLE 
                        cellSpacing=0 cellPadding=0 width="92%" align=center 
                        border=0>
                              
                                <TR>
                                  <TD colSpan=2 height=10></TD>
                                </TR>
                                <TR>
                                  <TD height=30><IMG height=10 
                              src="images/dot90.gif" width=8> <STRONG>社区文化</STRONG></TD>
                                  <TD align=right height=30><cms:more classname="Link03"  channel="社区文化" moretext="更多.."/>
                                  </TD>
                                </TR>
                                <TR>
                                  <TD bgColor=#b77e00 colSpan=2 height=1></TD>
                                </TR>
                                <TR>
                                  <TD colSpan=2 height=5></TD>
                                </TR>
                                <TR>
                                  <TD width=80><IMG height=66 
                              src="images/wy_1.gif" width=76></TD>
                                  <TD><TABLE cellSpacing=0 cellPadding=0 width="100%" 
                              align=center border=0>
                                        <cms:outline channel="社区文化"  count="5">
										<TR>
                                          <TD width="81%" height=20><cms:link classname="Link03" target="_blank" colName="title" maxlength="8" replace=".."/></TD>
                                        </TR>
                                        <TR>
                                          <TD background=images/line08.gif 
                                height=1></TD>
                                        </TR>
                                        </cms:outline>
                                  </TABLE></TD>
                                </TR>
                              
                            </TABLE>
                            <TABLE cellSpacing=0 cellPadding=0 width="92%" 
                        align=center border=0>
                              
                                <TR>
                                  <TD colSpan=2 height=10></TD>
                                </TR>
                                <TR>
                                  <TD height=30><IMG height=10 
                              src="images/dot90.gif" width=8> <STRONG>商务金融</STRONG></TD>
                                  <TD align=right height=30><cms:more classname="Link03"  channel="商务金融" moretext="更多.."/></TD>
                                </TR>
                                <TR>
                                  <TD bgColor=#b77e00 colSpan=2 height=1></TD>
                                </TR>
                                <TR>
                                  <TD colSpan=2 height=5></TD>
                                </TR>
                                <TR>
                                  <TD><TABLE cellSpacing=0 cellPadding=0 width="100%" 
                              align=center border=0>
                                   <cms:outline channel="商务金融"  count="5">
                                      <TR>
                                        <TD width="81%" height=20><cms:link classname="Link03" target="_blank" colName="title" maxlength="8" replace=".."/></TD>
                                      </TR>
                                      <TR>
                                        <TD background=images/line08.gif 
                                height=1></TD>
                                      </TR>
                                    </cms:outline>
                                  </TABLE></TD>
                                  <TD width=80><IMG 
                              src="images/wy_2.gif"></TD>
                                </TR>
                            </TABLE>
                            <TABLE cellSpacing=0 cellPadding=0 width="92%" 
                        align=center border=0>
                              
                                <TR>
                                  <TD colSpan=2 height=10></TD>
                                </TR>
                                <TR>
                                  <TD height=30><IMG height=10 
                              src="images/dot90.gif" width=8> <STRONG>推荐消费</STRONG></TD>
                                  <TD align=right height=30><cms:more classname="Link03"  channel="推荐消费" moretext="更多.."/></TD>
                                </TR>
                                <TR>
                                  <TD bgColor=#b77e00 colSpan=2 height=1></TD>
                                </TR>
                                <TR>
                                  <TD colSpan=2 height=5></TD>
                                </TR>
                                <TR>
                                  <TD width=80><IMG 
                              src="images/wy_3.gif"></TD>
                                  <TD><TABLE cellSpacing=0 cellPadding=0 width="100%" 
                              align=center border=0>
                                    <cms:outline channel="推荐消费"  count="5">
                                      <TR>
                                        <TD width="81%" height=20><cms:link classname="Link03" target="_blank" colName="title" maxlength="8" replace=".."/></TD>
                                      </TR>
                                      <TR>
                                        <TD background=images/line08.gif 
                                height=1></TD>
                                      </TR>
                                    </cms:outline>
                                  </TABLE></TD>
                                </TR>
                          </TABLE>                          </TD>
                        </TR>
                        <TR>
                          <TD height=12><IMG height=12 
                        src="images/lgw_1.gif" 
                    width=211></TD>
                        </TR>
                      
                  </TABLE></TD>
                  <TD height="1" vAlign=middle></TD>
                </TR>
                <TR>
                <TD height="205" vAlign=top><TABLE cellSpacing=0 cellPadding=0 width=556 border=0>                  
                    <TR>
                      <TD width="556" height=45 background="images/whxx.gif"><TABLE height=30 cellSpacing=0 cellPadding=0 width="100%" 
                  border=0>
                        <TR>
                          <TD width="82%">&nbsp; &nbsp;&nbsp;         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="STYLE2">财务公开</span></TD>
                          <TD width="18%"><div align="right" style="padding-right:18px;">
                            <cms:more classname="link03_2"  channel="财务公开" moretext=">>更多"/>
                          </div></TD>
                        </TR>
                      </TABLE></TD>
                    </TR>
                    <TR>
                      <TD vAlign=top><TABLE cellSpacing=0 cellPadding=0 width="95%" 
                        align=center border=0>
  <cms:outline channel="财务公开"  count="7"> 
                            <TR>
                              <TD width="81%" height=20>·<cms:link target="_blank" colName="title"  classname="link03" maxlength="33" replace="..."/></TD>
                              <TD class=link04 width="19%" style="font-size:12px" >
                                <div align="center">
                                  <cms:cell colName="docwtime" dateformat="yyyy-MM-dd"/>
                                  </div></TD></TR>
                            <TR>
                              <TD background=images/line08.gif 
                            colSpan=2 height=1></TD>
                            </TR>
                      </cms:outline>
                      </TABLE></TD>
                    </TR>
                  
                </TABLE>
                           </TD></TR>
                <TR>
                  <TD height="90" vAlign=middle><cms:outline channel="推荐消费" count="1"><cms:imagelink target="_blank" width="545" height="90"/></cms:outline></TD>
                </TR>
              <TR>
                <TD height="205" vAlign=top><TABLE cellSpacing=0 cellPadding=0 width=556 border=0>
                  
                    <TR>
                      <TD width="556" height=45 background="images/jcxx.gif"><TABLE height=30 cellSpacing=0 cellPadding=0 width="100%" 
                  border=0>
                        <TR>
                          <TD width="82%">&nbsp; &nbsp;&nbsp;         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="STYLE2">法律维权</span></TD>
                          <TD width="18%"><div align="right" style="padding-right:18px;">
                            <cms:more classname="link03_2"  channel="法律维权" moretext=">>更多"/>
                          </div></TD>
                        </TR>
                      </TABLE></TD>
                    </TR>
                    <TR>
                      <TD vAlign=top><TABLE cellSpacing=0 cellPadding=0 width="95%" 
                        align=center border=0>
                        <cms:outline channel="法律维权"  count="7">
                          <TR>
                            <TD width="81%" height=20>·<cms:link target="_blank" colName="title"  classname="link03" maxlength="33" replace="..."/></TD>
                            <TD class=link04 width="19%" style="font-size:12px" >
                                <div align="center">
                                  <cms:cell colName="docwtime" dateformat="yyyy-MM-dd"/>
                              </div></TD></TR>
                          <TR>
                            <TD background=images/line08.gif 
                            colSpan=2 height=1></TD>
                          </TR>
                        </cms:outline>
                      </TABLE></TD>
                    </TR>
                  
                </TABLE>                </TD>
              </TR>
            </TABLE>
            <TABLE cellSpacing=0 cellPadding=0 width="75%" border=0>
              
              <TR>
                <TD height=10></TD>
              </TR></TABLE>
            <TABLE height=90 cellSpacing=0 cellPadding=0 width=789 border=0>
              
              <TR>
                <TD align=middle>
                  <TABLE height=71 cellSpacing=0 cellPadding=0 width="100%" 
                  align=center border=0>
                    
                    <TR>
                      <TD align=middle><div id="div56" style="OVERFLOW: hidden; WIDTH:700px; HEIGHT:100px; display:block">
                    <table border="0" align="center" cellpadding="0" cellspacing="0" cellspace="0">
                      <tbody>
                        <tr>
                          <td id="div561" valign="top"><table width="700" height="100" border='0' align='center' cellpadding='0' cellspacing='1'>
                              <tr>
                                <cms:outline channel="图说社区"   count="15">
                                  <td align="center"><table  width="124" height="80"   cellspacing="1" cellpadding="0">
                                      <tr>
                                        <td><cms:imagelink target="_blank" width="120" height="80"/></td>
                                      </tr>
                                    </table>
                                      <table cellpadding="0" cellspacing="0" align="center">
                                        <tr>
                                          <td><font style="font-size:12px">
                                            <cms:link target="_blank" colName="title" maxlength="8" replace=".." classname="link03" />
                                          </font></td>
                                        </tr>
                                    </table></td>
                                </cms:outline>
                              </tr>
                          </table></td>
                          <td id="div562"></td>
                          <script>                                       
			  var speed5=30                                       
			  div562.innerHTML=div561.innerHTML                                       
			  function Marquee5(){                                       
			  if(div562.offsetWidth-div56.scrollLeft<=0)                                       
			  div56.scrollLeft-=div561.offsetWidth                                       
			  else{                                       
			  div56.scrollLeft++                                       
			  }                                       
			  }                                       
			  var MyMar5=setInterval(Marquee5,speed5)                                       
			  div56.onmouseover=function() {clearInterval(MyMar5)}
			  div56.onmouseout=function() {MyMar5=setInterval(Marquee5,speed5)}            
              </script>
                        </tr>
                      </tbody>
                    </table>
                </div>
                      </TD>
                      <TD 
            width=1>&nbsp;</TD></TR></TABLE></TD></TR></TABLE>
            <TABLE cellSpacing=0 cellPadding=0 width="75%" border=0>
              
              <TR>
                <TD height=12></TD></TR></TABLE>
          </TD>
          <TD vAlign=top bgColor=#f6f9ec>
            <TABLE height=131 cellSpacing=0 cellPadding=0 width=199 border=0>
              
              <TR>
                <TD vAlign=top background=images/zfxx.gif style="background-repeat:no-repeat">
                  <TABLE height=30 cellSpacing=0 cellPadding=0 width="100%" 
                  border=0>
                    
                    <TR>
                      <TD>&nbsp; &nbsp;<span class="STYLE2">家政服务</span></TD>
                      <TD width="29%"><cms:more classname="link03_2"  channel="家政服务" moretext=">>更多"/></TD>
                    </TR></TABLE>
                  <TABLE cellSpacing=1 cellPadding=1 width="98%" 
                              align=center border=0>
                    <TR>
                      <TD height=6></TD>
                    </TR>
                    <cms:outline channel="家政服务"  count="5">
                      <TR>
                        <TD height=22><IMG height=7 
                                src="images/dot05.gif" width=6 
                                align=absMiddle> <cms:link target="_blank" colName="title" maxlength="13" classname="link03" replace="..." /></TD>
                      </TR>
                    </cms:outline>
                    <TR>
                      <TD background="" height=1></TD>
                    </TR>
                  </TABLE>                  </TD>
              </TR>
              <TR>
                <TD height="13" vAlign=top><IMG height=10 
                  src="images/zxdc_1.gif" 
              width=199></TD>
              </TR>
            </TABLE>
            <TABLE height=128 cellSpacing=0 cellPadding=0 width=199 border=0>
              <TR>
                <TD vAlign=top background=images/zfxx.gif style="background-repeat:no-repeat"><TABLE height=30 cellSpacing=0 cellPadding=0 width="100%" 
                  border=0>
                      <TR>
                        <TD width="71%">&nbsp; &nbsp;<span class="STYLE2">房租租赁</span></TD>
                        <TD width="29%"><cms:more classname="link03_2"  channel="房租租赁" moretext=">>更多"/></TD>
                      </TR>
                    </TABLE>
                  <TABLE cellSpacing=1 cellPadding=1 width="98%" 
                              align=center border=0>
                      <TR>
                        <TD height=6></TD>
                      </TR>
                      <cms:outline channel="房租租赁"  count="5">
                        <TR>
                          <TD height=22><IMG height=7 
                                src="images/dot05.gif" width=6 
                                align=absMiddle>
                              <cms:link target="_blank" colName="title" maxlength="13" classname="link03" replace="..." /></TD>
                        </TR>
                      </cms:outline>
                      <TR>
                        <TD background="" height=1></TD>
                      </TR>
                  </TABLE></TD>
              </TR>
              <TR>
                <TD height="10" vAlign=top><IMG height=10 
                  src="images/zxdc_1.gif" 
              width=199></TD>
              </TR>
            </TABLE>
            <TABLE height=175 cellSpacing=0 cellPadding=0 width=199 border=0>
              
              <TR>
                <TD height=42 background="images/zxdc.gif"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                  <tr>
                    <td width="58%">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE2">生活服务</span></td>
                    <td width="42%"><div align="right"><cms:more classname="link03_2"  channel="生活服务" moretext=">>更多"/></div></td>
                  </tr>
                </table></TD>
              </TR>
              <TR>
                <TD vAlign=top background=images/zxdc_di.gif><TABLE cellSpacing=1 cellPadding=1 width="98%" 
                              align=center border=0>
                  <TR>
                    <TD height=6></TD>
                  </TR>
                  <cms:outline channel="生活服务"  count="5">
                    <TR>
                      <TD height=22><IMG height=7 
                                src="images/dot05.gif" width=6 
                                align=absMiddle>
                          <cms:link target="_blank" colName="title" maxlength="13" classname="link03" replace="..." /></TD>
                    </TR>
                  </cms:outline>
                  <TR>
                    <TD background="" height=1></TD>
                  </TR>
                </TABLE></TD>
              </TR>
              <TR>
                <TD height=10><IMG height=10 
                  src="images/zxdc_1.gif" 
              width=199></TD></TR></TABLE>
            <TABLE height=150 cellSpacing=0 cellPadding=0 width=199 border=0>
              
              <TR>
                <TD height=42 background="images/zxdc.gif"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                  <tr>
                    <td width="58%">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE2">医疗保健</span></td>
                    <td width="42%"><div align="right">
                      <cms:more classname="link03_2"  channel="医疗保健" moretext=">>更多"/>
                    </div></td>
                  </tr>
                </table></TD>
              </TR>
              <TR>
                <TD valign="top" background=images/zxdc_di.gif>
                  <TABLE cellSpacing=1 cellPadding=1 width="98%" 
                              align=center border=0>
                    <TR>
                      <TD height=6></TD>
                    </TR>
                    <cms:outline channel="医疗保健"  count="5">
                      <TR>
                        <TD height=22><IMG height=7 
                                src="images/dot05.gif" width=6 
                                align=absMiddle>
                            <cms:link target="_blank" colName="title" maxlength="13" classname="link03" replace="..." /></TD>
                      </TR>
                    </cms:outline>
                    <TR>
                      <TD background="" height=1></TD>
                    </TR>
                  </TABLE>
                  <TABLE class=unnamed1 height=75 cellSpacing=0 cellPadding=0 
                  width="90%" align=center border=0>
                </TABLE></TD></TR>
              <TR>
            <TD height=10><IMG height=10 
                  src="images/zxdc_1.gif" 
              width=199></TD></TR></TABLE>
            <TABLE cellSpacing=0 cellPadding=0 width=199 border=0>
              <FORM name=link method=post>
              
              <TR>
                <TD height=25><table width="200" border="0" cellpadding="1" cellspacing="3">
                  <tr>
                    <td height="41" background="images/lltj.gif">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="STYLE2">友情链接</span></td>
                  </tr>
                  <tr>
                    <td height="24"><select name="select3" style="FONT-SIZE: 12px; WIDTH: 190px" 
                              onchange="window.open(this.options[this.selectedIndex].value)" class="bd">
                        <option value="http://www.blqwb.gov.cn" selected>:::::国内著名网站链接:::::</option>
                        <option value="http://www.sohu.com">搜狐</option>
                        <option value="http://www.sina.com.cn">新浪网</option>
                        <option value="http://www.163.com">网易</option>
                        <option value="http://www.google.com">google</option>
                        <option value="http://www.baidu.com">百度</option>
                        <option value="http://www.yahoo.com">雅狐</option>
                        <option value="http://www.cctv.com">中央电视台</option>
                        <option value="http://www.people.com.cn/">人民日报</option>
                        <option value="http://www.xinhuanet.com/">新华社</option>
                        <option value="http://www.gmw.com.cn/gmw/">光明日报</option>
                        <option value="http://www.jfdaily.com/">解放日报</option>
                    </select></td>
                  </tr>
                  <tr>
                    <td height="24"><select name="select"   onchange="window.open(this.options[this.selectedIndex].value)" class="bd" style="FONT-SIZE: 12px; WIDTH: 190px" >
                        <option selected>:::::本省市、州政府网站:::::</option>
                        <option value='http://www.changsha.gov.cn'> 长沙市 </option>
                        <option value='http://www.zzcity.gov.cn'> 株洲市 </option>
                        <option value='http://www.xiangtan.gov.cn'> 湘潭市 </option>
                        <option value='http://www.hengyang.gov.cn'> 衡阳市 </option>
                        <option value='http://www.shaoyang.gov.cn'> 邵阳市 </option>
                        <option value='http://www.yueyang.gov.cn'> 岳阳市 </option>
                        <option value='http://www.cdcity.gov.cn'> 常德市 </option>
                        <option value='http://www.yiyangcity.gov.cn'> 益阳市 </option>
                        <option value='http://www.yzcity.gov.cn'> 永州市 </option>
                        <option value='http://www.hnloudi.gov.cn'> 娄底市 </option>
                        <option value='http://www.huaihua.gov.cn'> 怀化市 </option>
                        <option value='http://www.xxz.gov.cn'> 湘西自治州 </option>
                        <option value='http://www.zjj.gov.cn'> 张家界 </option>
                    </select></td>
                  </tr>
                  <tr>
                    <td height="24"><select name="menu6"   onchange="window.open(this.options[this.selectedIndex].value)"  class="bd" style="FONT-SIZE: 12px; WIDTH: 190px" >
                        <option selected>:::::省直各部门网站:::::</option>
                        <option value='http://www.hunan.gov.cn/szfbgt/'> 省政府办公厅 </option>
                        <option value='http://www.hnjt.gov.cn'> 省交通厅 </option>
                        <option value='http://www.hnii.gov.cn/'> 省信息产业厅 </option>
                        <option value='http://www.hnwr.gov.cn'> 省水利厅 </option>
                        <option value='http://www.hnagri.gov.cn'> 省农业厅 </option>
                        <option value='http://www.hnforestry.gov.cn'> 省林业厅 </option>
                        <option value='http://www.culture.hn.cn'> 省文化厅 </option>
                        <option value='http://www.happyhome.net.cn'> 省人口和计划生育委员会 </option>
                        <option value='http://sjt.hunan.gov.cn'> 省审计厅 </option>
                        <option value='http://www.hntax.gov.cn/'> 省国家税务局 </option>
                        <option value='http://www.hnds.gov.cn'> 省地方税务局 </option>
                        <option value='http://www.hbj.hunan.gov.cn'> 省环境保护局 </option>
                        <option value='http://www.gbs.cn'> 省广播电视局 </option>
                        <option value='http://www.sports.gov.cn'> 省体育局 </option>
                        <option value='http://www.hntj.gov.cn'> 省统计局 </option>
                        <option value='http://www.hnaic.net.cn'> 省工商行政管理局 </option>
                        <option value='http://www.hnppa.com/'> 省新闻出版局 </option>
                        <option value='http://www.hnsfzb.gov.cn'> 省法制办公室 </option>
                        <option value='http://zjsw.hunan.gov.cn/'> 省宗教事务局 </option>
                        <option value='http://hnjyj.hunan.gov.cn/'> 省监狱管理局 </option>
                        <option value='http://www.nzw.hunan.gov.cn'> 省农办 </option>
                        <option value='http://rfb.hunan.gov.cn/index.asp'> 人民防空办公室 </option>
                        <option value='http://www.hnfp.gov.cn/'> 省扶贫办 </option>
                        <option value='http://www.hnipo.gov.cn/'> 省知识产权局 </option>
                        <option value='http://www.hnjx.gov.cn/'> 省经济协作办公室 </option>
                        <option value='http://www.hunancoal.gov.cn/'> 省煤炭工业局 </option>
                        <option value='http://hn.chinapost.gov.cn'> 湖南省邮政管理局 </option>
                        <option value='http://www.hnczt.gov.cn'> 省财政厅 </option>
                    </select></td>
                  </tr>
                  <tr>
                    <td height="24"><select name="menu1"   onchange="window.open(this.options[this.selectedIndex].value)"  class="bd" style="FONT-SIZE: 12px; WIDTH: 190px" >
                        <option selected>:::::县（市、区）政府网站:::::</option>
                        <option value='http://www.czbeihu.gov.cn'> 北湖区 </option>
                        <option value='http://www.hnsx.gov.cn'> 苏仙区 </option>
                        <option value='http://www.zixing.gov.cn'> 资兴市 </option>
                        <option value='http://www.gyzf.gov.cn/'> 桂阳县 </option>
                        <option value='http://www.yzxtj.gov.cn'> 宜章县 </option>
                        <option value='http://www.yxx.gov.cn'> 永兴县 </option>
                        <option value='http://www.jiahe.gov.cn/'> 嘉禾县 </option>
                        <option value='http://www.linwu.gov.cn/'> 临武县 </option>
                        <option value='http://www.rc.gov.cn/'> 汝城县 </option>
                        <option value='http://www.guidong.gov.cn/'> 桂东县 </option>
                        <option value='http://www.anrenzf.gov.cn/'> 安仁县 </option>
                    </select></td>
                  </tr>
                </table></TD></TR>
              </FORM></TABLE></TD></TR></TABLE></TD>
    <TD width=3 bgColor=#f6f9ec></TD>
    <TD width=1 bgColor=#a6a6a6></TD></TR></TABLE>
<TABLE width=1007 height="86" border=0 align=center cellPadding=0 cellSpacing=0>
  
  <TR>
    <TD ><iframe  align="middle" src="foot.html" width="100%" height="86" scrolling="No" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" ></iframe></TD>
    </TR></TABLE>
</body></form>
</BODY></HEAD></HTML>
<!--输出模版后缀-->



