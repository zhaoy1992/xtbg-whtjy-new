<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.cms.searchmanager.*"%>
<%
	String searchType = (String)session.getAttribute("searchType");
	CMSSearchManager sm = new CMSSearchManager();
	String searchTypeDes = sm.getSearchButtonValue(searchType);
%>
<html>
<head>
<title>��������--��������</title>
<link rel="stylesheet" href="inc/mycss.css" type="text/css">
</head>
<body>
<table width="800" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td><iframe src='../siteResource/site1/_template/detail_top.html' width="100%" height="168" scrolling=no marginwidth=0 marginheight=0 frameborder=0 vspace=0 hspace=0>
�����ҳͷ</iframe>
	</td>
  </tr>
  <tr>
    <td height="4" bgcolor="#0073B3"></td>
  </tr>
  <tr>
    <td><form action="search_process.jsp" method="post" name="searchForm" id="searchForm">
      <p>&nbsp;</p>
      <table width="50%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center" valign="middle">�ؼ��֣�
            <input type="text" name="queryString" size="38" maxlength="50" />          </td>
          <td width="11%" align="center" valign="middle"><input name="button" type="button" onclick="searchForm.submit()" value="<%=searchTypeDes%>"  style="width:60; height:25;cursor:hand" />          </td>
          <td width="19%" align="center" valign="middle">&nbsp;</td>
          </tr>
      </table>
    </form></td>
  </tr>
   <tr><td background="images/line.gif" height="1"></td>
  <tr>
    <td style="padding:20 0"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" style="border:6px solid #E1E1E1">
      <tr>
        <td style="padding:20"><table width="100%" border="0" cellspacing="0" cellpadding="10" align="center" style="border:1px solid #e1e1e1">
          <tr><td style="font-size:14px; font-weight:bold"><img src="images/dot_red.gif" width="7" height="7" hspace="6" align="absmiddle"><font color="#DF0218">����</font></td>
		</tr>
        <tr><td background="images/line.gif" height="1"></td>
          <tr>
            <td style="padding:10 20"><p><b>a.	һ������</b>
              </p>
              <p>���Զ���Ӣ�Ľ��м�����������ʿ���ͨ���߼�&quot;��&quot;��&quot;��&quot;,&quot;+&quot;(����)��&quot;-&quot;(��)��ϵ������ϼ�����ȱʡ��Ϊ�����ϵ��</p>
              <p> �磺�ڽ������룺&quot;�Ʋ��� ����&quot;,��������Զ�תΪ&quot; �Ʋ��� and ����&quot;
                �û������Լ��������Զ�����߼���ϵ���������                </p>
              <p>�磺�ڽ������룺&quot; �Ʋ��� and ����&quot;����������&quot; �Ʋ���&quot;��&quot;����&quot;��ҳ�档                </p>
              <p>���룺&quot;�ƴ� or ����&quot; ����������&quot; ��������&quot; �Ʋ���&quot;��&quot;����&quot;��ҳ�档</p>
              <p> ���룺(�ƴ� OR ����) AND ����У������������&quot;�ƴ�&quot;��&quot;����У��&quot;��&quot;����&quot;��&quot;����У��&quot;��ҳ�档                </p>
              <p>ע�⣺������õ�������Ӣ�ĵ����š�&quot;and&quot;��&quot;or&quot;���������Сд�� </p>
              <p>&nbsp;</p>
              <p><b>b.	�߼�����</b></p>
              <p> ѡ��ؼ������ӵ��߼�������,���ѡ&quot;or&quot;���򵥴ʼ���&quot;or&quot;���ӡ�          </p>
              <p>ͨ��ѡ��ÿҳ��ʾ��������û������Զ���ҳ��ÿҳ��ʾ�Ľ��������
                ͨ��ѡ������վ�㣬�û������Զ��������ķ�Χ��</p>
              <p>�磺�����ϴ�ѧվ������&quot;�Ʋ���&quot;����Ҫ��&quot;����վ��&quot;��ѡ��&quot;���ϴ�ѧ&quot;.
                ͨ��ѡ����ҳ����ʱ�䣬�û�����ѡ����ָ��ʱ��η�����ҳ�档 </p></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><iframe src='../siteResource/site1/_template/index_foot.html' width="100%" height="100" scrolling=no marginwidth=0 marginheight=0 frameborder=0 vspace=0 hspace=0>
�����ҳβ</iframe></td>
  </tr>
</table>
</body>     
</html> 




