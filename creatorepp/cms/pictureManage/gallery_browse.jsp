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
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  
   
	<!--��Դ�ڱ����վ���и�վ��-->
    <tr >
      <td height="22" style="padding-top:3px"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="2" bgcolor="D7D7D7"></td>
        </tr>
        <tr>
          <td bgcolor="D7D7D7"><div align="center">
            <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
              
              <!--��Դ�ڱ����վ���и�վ��-->
              
                <tr >
                  <td height="394" valign="top"><table width="100%" border="0">
                      <tr>
                        <td height="26" colspan="4"><table width="100%" border="0">
                            <tr>
                              <td width="17"><img src="../images/pic_lib.gif" width="17" height="14"></td>
                              <td>��ҳ�����ز� (���๲��ͼƬ<span class="red_star">4</span>��/��<span class="red_star">1</span>ҳ)&nbsp; <span class="STYLE6">�鿴��ʽ:
                                  <label>
                                <select name="select" class="cms_select">
                                  <option value="��ʽ��ͼ">��ʽ��ͼ</option>
                                  <option value="�б�鿴">�б�鿴</option>
                                </select>
                                </label>
                              </span>| <a style="cursor:hand" onClick="openWin('add_gallery.jsp',600,290)"><u>���ͼƬ</u></a></td>
                            </tr>
                          </table></td>
                        </tr>
                      <tr>
                        <td><div align="center">
                          <table width="120" border="0" class="mhwz_table">
                              <tr>
                                <td><table width="120" border="0">
                                  <tr>
                                    <td><div align="center"><img src="../Pub/Gallery/pic1.jpg" width="56" height="56"></div></td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;
                                      <div align="center"><span class="STYLE6">(1)</span>�ز�1</div></td>
                                  </tr>
                                  <tr>
                                    <td><div align="center">�ߴ�:<span class="red_star">56*56</span> <span class="STYLE6">16</span>KB</div></td>
                                  </tr>
                                  
                                </table></td>
                              </tr>
                                                  </table>
                        </div></td>
                        <td><div align="center">
                          <table width="120" border="0" class="mhwz_table">
                              <tr>
                                <td><table width="120" border="0">
                                    <tr>
                                      <td><div align="center"><img   style="cursor:hand" title="�����鿴ȫͼ..." onclick="openWin('zoom_preview.jsp',400,400)" src="../Pub/Gallery/pic2.jpg" width="56" height="56"></div></td>
                                    </tr>
                                    <tr>
                                      <td>&nbsp;
                                          <div align="center"><span class="STYLE6">(2)</span>�ز�2</div></td>
                                    </tr>
                                    <tr>
                                      <td>&nbsp;
                                        �ߴ�:<span class="red_star">56*56</span> <span class="STYLE6">16</span>KB</td>
                                    </tr>
                                </table></td>
                              </tr>
                                                  </table>
                        </div></td>
                        <td><div align="center">
                          <table width="120" border="0" class="mhwz_table">
                              <tr>
                                <td><table width="120" border="0">
                                    <tr>
                                      <td><div align="center"><img src="../Pub/Gallery/pic3.jpg" width="56" height="56"></div></td>
                                    </tr>
                                    <tr>
                                      <td>&nbsp;
                                          <div align="center"><span class="STYLE6">(3)</span>�ز�3</div></td>
                                    </tr>
                                    <tr>
                                      <td><div align="center">�ߴ�:<span class="red_star">56*56</span> <span class="STYLE6">16</span>KB</div></td>
                                    </tr>
                                </table></td>
                              </tr>
                                                  </table>
                        </div></td>
                        <td><div align="center">
                          <table width="120" border="0" class="mhwz_table">
                              <tr>
                                <td><table width="120" border="0">
                                    <tr>
                                      <td><div align="center"><img src="../Pub/Gallery/pic4.jpg" width="56" height="56"></div></td>
                                    </tr>
                                    <tr>
                                      <td>&nbsp;
                                          <div align="center"><span class="STYLE6">(4)</span>�ز�4</div></td>
                                    </tr>
                                    <tr>
                                      <td><div align="center">�ߴ�:<span class="red_star">56*56</span> <span class="STYLE6">16</span>KB</div></td>
                                    </tr>
                                </table></td>
                              </tr>
                                                  </table>
                        </div></td>
                        </tr>
                      <tr>
                        <td><div align="center">
                          <table width="120" border="0" class="mhwz_table">
                              <tr>
                                <td><table width="120" border="0">
                                    <tr>
                                      <td><div align="center"><img src="../Pub/Gallery/pic5.jpg" width="56" height="56"></div></td>
                                    </tr>
                                    <tr>
                                      <td>&nbsp;
                                          <div align="center"><span class="STYLE6">(5)</span>�ز�5</div></td>
                                    </tr>
                                    <tr>
                                      <td><div align="center">�ߴ�:<span class="red_star">56*56</span> <span class="STYLE6">16</span>KB</div></td>
                                    </tr>
                                </table></td>
                              </tr>
                                                  </table>
                        </div></td>
                        <td><div align="center">
                          <table width="120" border="0" class="mhwz_table">
                              <tr>
                                <td><table width="120" border="0">
                                    <tr>
                                      <td><div align="center"><img src="../Pub/Gallery/pic6.jpg" width="56" height="56"></div></td>
                                    </tr>
                                    <tr>
                                      <td>&nbsp;
                                          <div align="center"><span class="STYLE6">(6)</span>�ز�6</div></td>
                                    </tr>
                                    <tr>
                                      <td><div align="center">�ߴ�:<span class="red_star">56*56</span> <span class="STYLE6">16</span>KB</div></td>
                                    </tr>
                                </table></td>
                              </tr>
                                                  </table>
                        </div></td>
                        <td><div align="center"></div></td>
                        <td><div align="center"></div></td>
                        </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table></td>
                  </tr>
              
              
              <!--��Դ�ڱ����վ���и�վ��-->
              
              <tr>
                <td height="19" background="../images/bottom_gray.jpg"><div align="center">&nbsp;<a href="gallery_browse.jsp" target="_self">��ҳ</a> | ��ҳ | ��ҳ | βҳ Go
                  <label>
                  <select name="select2">
                    <option value="1">1</option>
                    <option value="2">2</option>
                  </select>
                  </label> 
                  ҳ
</div></td>
                </tr>
            </table>
          </div></td>
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