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

<style type="text/css">
<!--
.STYLE4 {color: #799BFF}

-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>CMS �½�վ��</title>
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

 //ftp���Ӽ��
  function ftplink(ftpip,ftpport,ftpuser,ftppasswd){
        var ret=false;
		
		if(fm_site.ftpip.value==""){
	     alert("����û����ftp��ַ��!");
		 fm_site.ftpip.focus();
		ret=false;
	    }
		if(fm_site.ftpport.value==""){
	     alert("����û����ftp�˿���!");
		 fm_site.ftpport.focus();
		ret=false;
	    }
		if(fm_site.ftpuser.value==""){
	     alert("����û����ftp�û���!");
		 fm_site.ftpuser.focus();
		 ret=false;
	    }
		if(fm_site.ftppasswd.value==""){
	     alert("����û����ftp������!");
		 fm_site.ftppasswd.focus();
		 ret=false;
	    }
		
		if(fm_site.ftpip.value!=null&&fm_site.ftpport.value!=null&&fm_site.ftpuser.value!=null&&fm_site.ftppasswd.value!=null){
		   window.open("site_ftplink.jsp?ftpip="+ftpip+"&ftpport="+ftpport+"&ftpuser="+ftpuser+"&ftppasswd="+ftppasswd);  
         }
  
  }
</script>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<base target="_self">
<body  bottommargin="0"  background="../images/grayline_bg.jpg" onkeydown="if(event.keyCode==116){reload.click()}" rightmargin="0" leftmargin="0" topmargin="0">
<a id="reload" href="site_edit1.jsp" style="display:none">reload...</a>
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
              <td height="77" colspan="5" valign="top" background="../images/toolbar_common_func_site.jpg"><table width="96%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="28">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �༭վ��</td>
                </tr>
                <tr>
                  <td height="48" valign="bottom" style="padding-bottom:0px"><div align="right"><img src="../images/createsite2.jpg" width="223" height="19" border="0" usemap="#Map"></div></td>
                </tr>
              </table></td>
              </tr>
            <tr >
              <td>&nbsp;</td>
              <td height="20"><img src="../images/ico_point.gif" width="25" height="25"></td>
              <td height="20" colspan="3">&nbsp;<span class="cms_title_blue">�ļ�������</span></td>
              </tr>
            <tr>
              <td height="8" colspan="5">&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22" bgcolor="#E7E9F8">��ҳ��:
                 &nbsp;&nbsp;</td>
              <td>&nbsp;</td>
              <td>�ļ���
                <input  readonly name="parentsiteid" type="text" value="default" class="cms_text" id="parentsiteid" />
��չ��:
<input  readonly name="parentsiteid2" type="text" value="htm" class="cms_text" id="parentsiteid2" /></td>
            </tr>
            <!--��Դ�ڱ����վ���и�վ��-->
            <tr>
              <td width="1%">&nbsp;</td>
              <td width="4%">&nbsp;</td>
              <td width="10%" height="22">&nbsp;</td>
              <td width="3%">&nbsp;</td>
              <td width="82%">&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22" bgcolor="#E7E9F8">����ҳ��:&nbsp;</td>
              <td>&nbsp;</td>
              <td>�ļ���
                <input  readonly name="parentsiteid3" type="text" value="default" class="cms_text" id="parentsiteid3" />
��չ��:
<input  readonly name="parentsiteid22" type="text" value="htm" class="cms_text" id="parentsiteid22" /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22" bgcolor="#E7E9F8">ϸ��ҳ��:&nbsp;</td>
              <td>&nbsp;</td>
              <td>�ļ���
                <input  readonly name="parentsiteid4" type="text" value="default" class="cms_text" id="parentsiteid4" />
��չ��:
<input  readonly name="parentsiteid23" type="text" value="htm" class="cms_text" id="parentsiteid23" /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22" nowrap>&nbsp;</td>
              <td nowrap>&nbsp;</td>
              <td nowrap>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
              <td nowrap>&nbsp;</td>
              <td nowrap>&nbsp;</td>
            </tr>
            
            <tr>
              <td class="cms_title_bar">&nbsp;</td>
              <td height="20" class="cms_title_bar">&nbsp;</td>
              <td height="20" class="cms_title_blue">&nbsp;</td>
              <td class="cms_title_blue">&nbsp;</td>
              <td class="cms_title_blue">&nbsp;</td>
            </tr>
            <tr>
              <td></td>
              <td height="9"></td>
              <td height="9"></td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td height="8" colspan="5">&nbsp;</td>
              </tr>
            <tr>
              <td height="22" colspan="5"><div align="center">
                <input name="btn_ok" type="submit" class="cms_button"  value="����" />
                <input name="btn_close" type="button" class="cms_button"  onclick="javascript:window.close();" value="�ر�" />
              </div></td>
              </tr>
            <tr>
              <td height="11" colspan="5" background="../images/bottom_gray.jpg">&nbsp;</td>
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

<map name="Map"><area shape="rect" coords="1,4,80,25" href="site_edit.jsp" >
<area shape="rect" coords="80,-2,81,3" href="#"><area shape="rect" coords="87,3,153,23" href="site_edit1.jsp">
<area shape="rect" coords="160,3,224,32" href="site_edit2.jsp" >
</map></body>
</html>