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
.STYLE6 {color: #0000FF}

-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>CMS ͼ�����</title>
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
<a id="reload" href="add_gallery.jsp" style="display:none">reload...</a>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<form action="" method="post" enctype="multipart/form-data"  name="fm_site"  onsubmit="return check_form()">
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
              <td height="77" colspan="4" valign="top" background="../images/toolbar_common_func_gallery.jpg"><table width="96%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="28">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ͼƬ����</td>
                </tr>
                <tr>
                  <td height="48" valign="bottom" style="padding-bottom:0px"><div align="right"><span class="STYLE6">ͼƬ��Ĭ�ϴ�С�ϴ���ͼ��</span><img src="../images/tan.gif" width="11" height="11"></div></td>
                </tr>
              </table></td>
              </tr>
            <tr >
              <td width="1%">&nbsp;</td>
              <td width="3%" height="20"><img src="../images/ico_point.gif" width="25" height="25"></td>
              <td height="20" colspan="2">&nbsp;<span class="cms_title_blue">ͼƬ����</span></td>
              </tr>
            
            
            <!--��Դ�ڱ����վ���и�վ��-->
            
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td width="26%">&nbsp;</td>
              <td width="70%" height="27"><div align="left">��ǰͼ��:         
                <input  name="parentsiteid3" type="text" class="cms_text" id="parentsiteid3" value="��ҳ�����ز�" size="30"  readonly />
                <span class="red_star">*</span></div></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td align="center">&nbsp;</td>
              <td height="27" align="center"><div align="left"></div>
                <label>
                <div align="left">
                  ѡ��ͼƬ:
              <input name="file" type="file" class="cms_file" size="30">
                <span class="red_star">*</span></div>
                </label>                
                <div align="left"></div></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td align="center">&nbsp;</td>
              <td height="27" align="center"><div align="left">ͼƬ����:
                <input   name="parentsiteid2" type="text" class="cms_text" id="parentsiteid2" value="" size="30" />
                  <span class="red_star">*</span></div></td>
            </tr>
            
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td height="22">&nbsp;</td>
            </tr>
            
            <tr>
              <td height="22" colspan="4"><div align="center">
                <input name="btn_close" type="submit" class="cms_button"  value="���" />
                <input name="btn_close2"  type="button" class="cms_button"  onclick="javascript:window.close();" value="�ر�" />
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

</body>
</html>