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
.STYLE6 {color:#003398; font-size: 12px;}

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
<a id="reload" href="channel_add1.jsp" style="display:none">reload...</a>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<form  name="fm_site" method="post" action="site_createdo.jsp"  onsubmit="return check_form()">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  
   
	<!--��Դ�ڱ����վ���и�վ��-->
    <tr >
      <td height="22" style="padding-top:3px"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="2" bgcolor="D7D7D7"></td>
        </tr>
        <tr>
          <td bgcolor="D7D7D7"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
            
            <!--��Դ�ڱ����վ���и�վ��-->
            
            <tr >
              <td height="77" colspan="4" valign="top" background="../images/toolbar_common_func_channel.jpg"><table width="96%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="32">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �½�Ƶ��</td>
                </tr>
                <tr>
                  <td height="48" valign="bottom" style="padding-bottom:0px"><div align="right"><img src="../images/createchannel2.jpg" width="223" height="19" border="0" usemap="#Map">&nbsp; </div></td>
                </tr>
              </table></td>
              </tr>
            <tr >
              <td>&nbsp;</td>
              <td height="20"><img src="../images/ico_point.gif" width="25" height="25"></td>
              <td height="20">&nbsp;<span class="cms_title_blue">Ƶ���Զ����&nbsp;&nbsp;&nbsp;  &nbsp;  &nbsp;  &nbsp;&nbsp;  &nbsp;  &nbsp;&nbsp;  &nbsp;  &nbsp;&nbsp;  &nbsp;  &nbsp;&nbsp;  &nbsp;  &nbsp;  &nbsp;   &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;  &nbsp;</span></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td height="8" colspan="4">&nbsp;</td>
            </tr>
            
            
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="33">�ĵ��ɼ�ģ��:&nbsp;&nbsp;&nbsp;&nbsp;
                <select name="select2" class="cms_select">
                  <option value="">ϵͳĬ��ģ��</option>
                  <option value="">ģ��1</option>
                  <option value="">ģ��2</option>
                  <option value="">ģ��3</option>
                </select>
                <span class="STYLE5">
                <input name="sitename22" type="text" class="cms_text" id="sitename22" value="cms/docManage/doc_content_input.jsp" size="45" />
                </span></td>
              <td>&nbsp;</td>
            </tr>
            <!--��Դ�ڱ����վ���и�վ��-->
            <tr>
              <td width="1%">&nbsp;</td>
              <td width="4%">&nbsp;</td>
              <td width="91%" height="33">�ĵ��༭ģ��:
                &nbsp;&nbsp;&nbsp;<span class="STYLE5">
                <input name="sitename2" type="text" class="cms_text" id="sitename2" value="cms/docManage/doc_edit.jsp" size="45" />
                </span></td>
              <td width="4%">&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="33">�ĵ��б�ģ��:
               &nbsp;&nbsp;&nbsp;
               <select name="select" class="cms_select">
                 <option value="">ϵͳĬ��ģ��</option>
                 <option value="">ģ��1</option>
                 <option value="">ģ��2</option>
                 <option value="">ģ��3</option>
               </select>
               <span class="STYLE5">
               <input name="sitename23" type="text" class="cms_text" id="sitename23" value="cms/docManage/doc_list.jsp" size="45" />
               </span></td>
              <td>&nbsp;</td>
            </tr>
            
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="33">�ĵ��鿴ģ��:
                &nbsp;&nbsp;&nbsp;
                <select name="select3" class="cms_select">
                  <option value="">ϵͳĬ��ģ��</option>
                  <option value="">ģ��1</option>
                  <option value="">ģ��2</option>
                  <option value="">ģ��3</option>
                </select>
                <span class="STYLE5">
                <input name="sitename24" type="text" class="cms_text" id="sitename24" value="cms/docManage/doc_detail.jsp" size="45" />
                </span></td>
              <td>&nbsp;</td>
            </tr>
            
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22" nowrap>&nbsp;</td>
              <td nowrap>&nbsp;</td>
            </tr>
            
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td height="8" colspan="4" class="cms_title_bar"></td>
              </tr>
            
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
               <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
               </tr> 
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            
            <tr>
              <td height="22" colspan="4"><div align="center">
                <input name="btn_ok" type="submit" class="cms_button"  value="����" />
                <input name="btn_close" type="button" class="cms_button"  onclick="javascript:window.close();" value="�ر�" />
              </div></td>
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


<map name="Map"><area shape="rect" coords="4,3,77,18" href="channel_add.jsp">
<area shape="rect" coords="86,3,153,20" href="channel_add1.jsp">
</map></body>
</html>