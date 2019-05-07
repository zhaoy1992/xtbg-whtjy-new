<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="cms"%>


<!--输出模版头文件-->

<!--输出模版前缀-->

<!--输出模版正文-->
<HTML><HEAD><title><cms:cell colName="title" defaultValue="" /></title>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="../images/main.css" type=text/css rel=stylesheet>
<script language="javascript">
//字体变化
function doZoom(size){
	document.getElementById('zoom').style.fontSize=size+'px';	
}

//双击滚屏
var currentpos;
var timer; 

function initialize() 
{ 
timer=setInterval("scrollwindow()",70); 
} 
function sc(){ 
clearInterval(timer); 
} 
function scrollwindow() 
{ 
currentpos=document.body.scrollTop; 
window.scroll(0,++currentpos); 
if (currentpos != document.body.scrollTop) 
sc(); 
} 
document.onmousedown=sc;
document.ondblclick=initialize; 
</script>
</HEAD><body topmargin="0" bottommargin="0" style="overflow-x:hidden" leftmargin="0" rightmargin="0"> 
<TABLE width=1007 height="184" border=0 align=center cellPadding=0 cellSpacing=0>
  <TR>
    <TD ><iframe  align="middle" src="../top.htm" width="100%" height="184" scrolling="No" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" ></iframe></TD>
    </TR></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=1007 align=center border=0>
  
  <TR>
    <TD width=1 bgColor=#a6a6a6></TD>
    <TD width=3 bgColor=#f6f9ec></TD>
    <TD width=999 bgColor=#f6f9ec>
      <TABLE height=35 cellSpacing=0 cellPadding=0 width=999 align=center 
      border=0>
        <TR>
          <TD background=../images/sgw.gif>
            <TABLE height=35 cellSpacing=0 cellPadding=0 width="96%" 
            align=center border=0>
              <TR>
                <TD><img src="../zwgk/img/orgico01.gif" width="5" height="7" hspace="6" />
                <cms:position style="color:#000000; text-decoration:none"/></TD>
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
          <TD vAlign=top bgColor=#f6f9ec>
            <TABLE cellSpacing=0 cellPadding=0 width="75%" border=0>
              
              <TR>
                <TD height=2></TD>
              </TR></TABLE>
            <table width="900" border="0" cellpadding="0" cellspacing="0" align="center">
              <tr>
                <td align="center"><div style="width:860px;margin:20px;background:#cccccc url(../images/content_bg.gif) repeat-x top">
                    <div style="border:1px solid #999999;background:#ffffff;margin-top:3px;margin-bottom:3px;margin-right:3px">
                      <table width="94%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="60" align="center" class="titlef" style="font-size:18px; font-weight:bold"><cms:cell colName="title"/></td>
                        </tr>
                        <tr>
                          <td height="30" align="center" bgcolor="#E0E6C6">编稿时间：
                            <cms:cell colName="docwtime" defaultValue="未知" dateformat="yyyy年MM月dd日"/>
                            来源：
                            <cms:cell colName="docsource_name" defaultValue="自定义" />
                            作者：
                            <cms:cell colName="author" defaultValue="不祥"/>
                          字体： <a  class="Link03" href="javascript:doZoom(24)">大</a> <a  class="Link03" href="javascript:doZoom(16)">中</a> <a  class="Link03" href="javascript:doZoom(12)">小</a> (双击滚屏) </td>
                        </tr>
                        <tr>
                          <td id="zoom" style="line-height:150%">&nbsp;&nbsp;&nbsp;&nbsp;
                              <cms:cell colName="content" defaultValue="" />
                          </td>
                        </tr>
                        <tr>
                          <td><div align="center">
                              <cms:cmsindex/>
                          </div></td>
                        </tr>
                        <tr>
                          <td><cms:outline datatype="attach">
                              <li>
                                <cms:attachment />
                              </li>
                          </cms:outline>
                          </td>
                        </tr>
                        <tr>
                          <td align="right"><table width="40%" border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                <td height="47">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                              </tr>
                              <tr>
                                <td width="25%">[<a  class="Link03" href="#" onclick='window.external.AddFavorite(top.location.href,document.title)' >加入收藏</a>]</td>
                                <td width="25%">[<a  class="Link03" href="#" onClick="window.print();">打印本页</a>]</td>
                                <td width="25%">[<a  class="Link03" href="#" onClick="window.close();">关闭窗口</a>]</td>
                              </tr>
                          </table></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td><br />
                              <div style="border-top:1px dotted #999999;margin-bottom:20px"></div>
                            <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td bgcolor="#E0E6C6"><div style="width:150px;font-weight:bold; font-size:14px; color:#006600;margin-left:3px;padding:5px 0 5px 10px">相关内容</div></td>
                                </tr>
                                <tr>
                                  <td><table width="100%" border="0" align="center" cellpadding="4" cellspacing="0">
                                      <cms:outline datatype="related">
                                        <tr>
                                          <td align="center" width="4%"><img src="../images/dot05.gif" width="6" height="7" border="0" /></td>
                                          <td ><cms:link colName="title"/></td>
                                          <td width="20%" align="right">[
                                            <cms:cell colName="docwtime"  dateformat="yyyy-MM-dd"/>
                                            ]</td>
                                        </tr>
                                        <tr>
                                          <td colspan="3" height="1" background="../images/dian01.gif"></td>
                                        </tr>
                                      </cms:outline>
                                      <cms:outline datatype="keywordRelated" count="3">
                                        <tr>
                                          <td align="center" width="4%"><img src="../images/dot05.gif" width="6" height="7" border="0" /></td>
                                          <td ><cms:link  classname="link03"  colName="title"/></td>
                                          <td width="20%" align="right">[
                                            <cms:cell colName="docwtime"  dateformat="yyyy-MM-dd"/>
                                            ]</td>
                                        </tr>
                                        <tr>
                                          <td colspan="3" height="1" background="../images/dian01.gif"></td>
                                        </tr>
                                      </cms:outline>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td>&nbsp;</td>
                                </tr>
                              </table>
                            <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <!--<tr>
            <td height="30" style="font-weight:bold; font-size:14px; color:#0073b3;padding-left:20px"><b>网友评论</b></td>
            <td>&nbsp;</td>
          </tr>-->
                                <!--<tr>
            <td>
			
			<table width="100%" border="0" align="center" cellpadding="4" cellspacing="0">
				<tr>
				<td><iframe frameborder="0" id=headlogin width="100%" scrolling="no" src="/cms/docManage/docCommentsListTag.jsp?docId=<cms:cell colName="document_id"/>" onload="this.height=this.contentWindow.document.body.scrollHeight"></iframe>
				</td>
				</tr>
				<tr>
				<td align="center">
				<link href='/cms/inc/css/cms.css' rel='stylesheet' type='text/css'><div><form method='post' target='operIframe' name='myForm'> <table align='center' style='width:100%;'><tr><td width='12%' align='right'>用户名:</td><td width='16%'><input type='text' name='commenterName' size='16'></td><td width='11%' align='right'>密码:</td><td width='25%'><input type='password' name='psword' size='16'></td><td width='36%'><input type='checkbox' name='userhidebox' checked='checked' onClick='changeBoxVluae()'>匿名发表</td><input type='hidden' name='userhide' checked='checked' value='1'></tr><tr><td colspan='5' height='70' align='left'><textarea style='width:80%; height:130;' name='docComment'></textarea></td></tr><tr><td colspan='4'></td><td colspan='4' align='left'><input type='button' name='button' onClick='sub()'  class = 'cms_button' value='提交留言'></td></tr></table></form></div><script language='javascript'>function sub(){if(myForm.docComment.value==''){alert('留言不能为空');return;}myForm.action='/cms/docManage/addCommentHandleDefault.jsp?docId=<cms:cell colName="document_id"/>';myForm.submit();}function changeBoxVluae(){if(myForm.userhidebox.checked)myForm.userhide.value = '1';else myForm.userhide.value = '0';}</script><div style='display:none'><iframe name='operIframe'></iframe></div>
				</td>
				</tr>
              </table>
              
                </td>
          </tr>-->
                                <tr>
                                  <td>&nbsp;</td>
                                </tr>
                            </table></td>
                        </tr>
                      </table>
                    </div>
                </div>
                    <br />
                </td>
              </tr>
            </table></TD>
        </TR></TABLE>
      <MAP 
      name=MapMap><AREA shape=RECT coords=475,10,543,33 
        href="http://www.wgj.suzhou.gov.cn/Info.asp?ParentID=101"></MAP><MAP 
      name=Map2Map><AREA shape=RECT coords=475,6,538,37 
        href="http://www.wgj.suzhou.gov.cn/Info.asp?ParentID=103"></MAP>
              <MAP 
      name=Map5Map><AREA shape=RECT target=_blank coords=1,1,97,29 
        href="http://www.gov.cn/"><AREA shape=RECT target=_blank 
        coords=101,2,197,27 href="http://www.jiangsu.gov.cn/"><AREA shape=RECT 
        target=_blank coords=2,39,95,65 href="http://www.suzhou.gov.cn/"><AREA 
        shape=RECT coords=100,38,195,64 
        href="http://www.wgj.suzhou.gov.cn/#"><AREA shape=RECT target=_blank 
        coords=2,73,96,100 href="http://www.sz2500.net/"><AREA shape=RECT 
        target=_blank coords=101,76,197,102 href="http://www.sz.js.cn/"></MAP></TD>
    <TD width=3 bgColor=#f6f9ec></TD>
    <TD width=1 bgColor=#a6a6a6></TD></TR></TABLE>
<TABLE width=1007 height="86" border=0 align=center cellPadding=0 cellSpacing=0>
  
  <TR>
    <TD ><iframe  align="middle" src="../foot.html" width="100%" height="86" scrolling="No" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" ></iframe></TD>
    </TR></TABLE>
</BODY></HTML>
<!--输出模版后缀-->



