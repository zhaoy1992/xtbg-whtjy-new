<%@ page contentType="text/html; charset=GBK" language="java"%>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", -1);
	//prevents caching at the proxy server
	response.setDateHeader("max-age", 0); 
%>
<html>
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>
<style type="text/css">
<!--
.STYLE5 {color: #666666}
.STYLE7 {color: #999999}

-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>CMS Ƶ������</title>
</head>
<script language="javascript">
//վ�㴰���������У��
function check_form(){
	
	if(fm_site.sitename.value==""){
		alert("������վ����������!");
		fm_site.sitename.focus();
		return false
	}
    if(fm_site.sitedesc.value==""){
		alert("������վ������!");
		fm_site.sitedesc.focus();
		return false
	}
   if(fm_site.sitepath.value==""){
		alert("������վ����·��!");
		fm_site.sitepath.focus();
		return false
	}
	
	 // if(fm_site.hometemplateid.value==""){
	//	alert("��ѡ��վ����ҳģ��!");
	//	fm_site.hometemplateid.focus();
	//	return false
	 //}
	return true
}

</script>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<base target="_self">
<body  bottommargin="0"  background="../images/grayline_bg.jpg" onkeydown="if(event.keyCode==116){reload.click()}" rightmargin="0" leftmargin="0" topmargin="0">
<a id="reload" href="channel_doc_naming.jsp" style="display:none">reload...</a>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<form  name="fm_site" method="post" action="site_createdo.jsp"  onsubmit="return check_form()">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  
   
	<!--��Դ�ڱ����վ���и�վ��-->
    <tr >
      <td height="22" style="padding-top:3px"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="2" bgcolor="D7D7D7"></td>
        </tr>
        <tr >
          <td bgcolor="D7D7D7"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
            
            <!--��Դ�ڱ����վ���и�վ��-->
            
            <tr >
              <td height="77" colspan="4" valign="top" background="../images/toolbar_common_func_channel.jpg"><table width="96%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="32">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �ĵ���������</td>
                </tr>
                <tr>
                  <td height="48" valign="bottom" style="padding-bottom:0px"><div align="right">&nbsp; </div></td>
                </tr>
              </table></td>
              </tr>
            <tr >
              <td>&nbsp;</td>
              <td height="20"><img src="../images/ico_point.gif" width="25" height="25"></td>
              <td height="20" class="cms_title_blue">�ĵ��������·����������  &nbsp;&nbsp;  &nbsp;  &nbsp;&nbsp;  &nbsp;  &nbsp;&nbsp;  &nbsp;  &nbsp;&nbsp;  &nbsp;  &nbsp;  &nbsp;   &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td height="8" colspan="4">&nbsp;</td>
            </tr>
            
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="27"><label>
                <input name="method" type="radio" value="1" checked>
              </label>
              ����������Ŀ¼</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="27"><label>
                <input type="radio" name="method" value="2">
              </label> 
                ����֣�ÿ��һ��Ŀ¼ ��:/2006</td>
              <td>&nbsp;</td>
            </tr>
            <!--��Դ�ڱ����վ���и�վ��-->
            <tr>
              <td width="1%">&nbsp;</td>
              <td width="4%">&nbsp;</td>
              <td width="91%" height="27"><label>
                <input type="radio" name="method" value="3">
              �����·֣�ÿ��һ��Ŀ¼ ��:/2006/11
</label></td>
              <td width="4%">&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="27"><label>
                <input type="radio" name="method" value="4">
�������շ֣�ÿ��һ��Ŀ¼ ��:/2006/11/1 </label></td>
              <td>&nbsp;</td>
            </tr>
            
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="27"><label>
                <input type="radio" name="method" value="5">
���շ֣�ÿ��һ��Ŀ¼ ��:/2006-11-1 </label></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="27"><label>
                <input type="radio" name="method" value="6">
�����߷֣�ÿ������һ��Ŀ¼ ��:/author </label></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr  style="display:none">
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">�ļ���׺��:<span class="STYLE5">
                <input name="sitename22" type="text" class="cms_text" id="sitename22" value=".html" size="22" />
              </span></td>
              <td>&nbsp;</td>
            </tr>
            <tr  style="display:none">
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">��������:<span class="STYLE5">
               &nbsp;
               <label>
               <select name="select" class="cms_select">
                 <option value="{docid}">Ĭ�����ĵ��������</option>
				 <option value="{byuser}">�û������ݲɼ�ʱ�ֹ�����</option>
               </select>
               </label>
              </span></td>
              <td>&nbsp;</td>
            </tr>
            
            
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22"><span class="STYLE7">(ҳ�����շ�������:{docid}.html)</span></td>
              <td>&nbsp;</td>
            </tr>
            
            <tr>
              <td height="8" colspan="4" class="cms_title_bar"></td>
              </tr>
            

            <tr>
              <td height="22" colspan="4"><div align="center">
                <input name="btn_ok" type="submit" class="cms_button"  value="ȷ��" />
                <input name="btn_close" type="button" class="cms_button"  onclick="javascript:window.close();" value="�ر�" />
              </div></td>
              </tr>
            <tr>
              <td height="22" colspan="4">&nbsp;</td>
            </tr>
            <tr>
              <td height="11" colspan="4" background="../images/bottom_gray.jpg">&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td height="3" bgcolor="D7D7D7"></td>
        </tr>
      </table></td>
    </tr>
    
    
  <!--��Դ�ڱ����վ���и�վ��-->
</table>   
</form>


</body>
</html>