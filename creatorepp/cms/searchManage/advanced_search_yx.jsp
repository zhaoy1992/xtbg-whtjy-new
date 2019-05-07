<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.cms.searchmanager.*"%>
<%@ page import="java.util.List"%>
<%@ page autoFlush="true" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	//��ǰվ��
	String siteId = request.getParameter("siteId");   //��ǩ�����Ĳ���
	if(siteId == null || siteId.length() <= 0)
		siteId = (String)session.getAttribute("siteId");
	
	session.removeAttribute("chnlId");
	session.removeAttribute("indexId");
	session.removeAttribute("hitsPerSet");
	session.removeAttribute("fromDays");
	session.removeAttribute("fileFormat");
	session.removeAttribute("keyWord");
	session.removeAttribute("sort");
	session.removeAttribute("field");
	
	CMSSearchManager sm = new CMSSearchManager();
	String searchTypeDes = sm.getSearchButtonValue("");
%>
<html>
<head>
<title>��������--�߼�����</title>
<link rel="stylesheet" href="inc/mycss.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html;charset=gb2312">
<script language="JavaScript" src="../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
<script type="text/javascript" src="../../public/datetime/calender.js" language="javascript"></script>
<script type="text/javascript" src="../../public/datetime/calender_date.js" language="javascript"></script>

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
    <td style="padding:20 0"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="86%">&nbsp;</td>
        <td width="5%"><a href="help.jsp" style="cursor:hand">����</a></td>
        <td width="9%"><a href="../siteResource/site1/_template/index.html">������ҳ</a></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">&nbsp;</td>
      </tr>
    </table>
    <table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" style="border:6px solid #E1E1E1">
      <tr>
        <td style="padding:20">
		 <FORM name="searchForm" method="post" action="search_process.jsp" style="margin:0">
		<table width="100%" border="0" cellspacing="0" cellpadding="10" align="center" style="border:1px solid #e1e1e1">
		<tr><td colspan="2" style="font-size:14px; font-weight:bold"><img src="images/dot_red.gif" width="7" height="7" hspace="6" align="absmiddle"><font color="#DF0218">�߼�����</font></td>
		</tr>
		<tr><td colspan="2" background="images/line.gif" height="1"></td>
		</tr>
          <tr>
            <td align="right"><b>�ؼ��֣�</b></td>
            <td><input type="text" name="queryString" size="45" maxlength="50">
                <input type="hidden" name="flag" value="0">
            </td>
          </tr>
		 <tr><td colspan="2" background="images/line.gif" height="1"></td>
          <tr>
            <td align="right"><strong>�ؼ����߼���</strong></td>
            <td><input type="radio" name="andor" value="and" checked>
              �롡
              <input type="radio" name="andor" value="or">
              �� </td>
          </tr>
		  <tr><td colspan="2" background="images/line.gif" height="1"></td>
          <tr>
            <td align="right"><strong>ÿҳ��ʾ�Ľ������</strong></td>
            <td><select name="hitsPerSet">
                <option value="5">5</option>
                <option value="10" selected>10</option>
                <option value="15">15</option>
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="100">100</option>
                <option value="200">200</option>
              </select>
            </td>
          </tr>
		  <tr><td colspan="2" background="images/line.gif" height="1"></td>
          <tr>
            <td align="right"><strong>����վ�㣺</strong></td>
            <td><select name="indexId" class="cms_select" style="width:120">
                <option value="all_advanced">����վ��</option>
                <%
					List list = null;
					list = sm.getIndexListOfSite(siteId);
					request.setAttribute("list", list);
				%>
                <pg:list requestKey="list">
                  <option value="<pg:cell colName="id"/>        
                  ">
                  <pg:cell colName="indexName" />
                </pg:list>
              </select>
            </td>
          </tr>
		 <tr><td colspan="2" background="images/line.gif" height="1"></td>
          <tr>
            <td align="right"><strong>�ļ���ʽ��</strong></td>
            <td><select name="fileFormat">
                <option value="all">���и�ʽ</option>
                <option value="text/html">��ҳ</option>
                <option value="pdf">pdf�ĵ�</option>
                <option value="word">word�ĵ�</option>
                <option value="excel">excel�ĵ�</option>
                <option value="ppt">powerpoint�ĵ�</option>
                <option value="rtf">rtf�ĵ�</option>
              </select>
            </td>
          </tr>
		  <tr><td colspan="2" background="images/line.gif" height="1"></td>
          <tr>
            <td align="right"><strong>����</strong></td>
            <td><select name="sort">
                <option value="time">ʱ��</option>
                <option value="relevance">��ض�</option>
              </select>
            </td>
          </tr>
		 <tr><td colspan="2" background="images/line.gif" height="1"></td>
          <tr>
            <td align="right"><strong>�����ֶΣ�</strong></td>
            <td><select name="field">
                <option value="all">�����ֶ�</option>
                <option value="content">����</option>
                <option value="title">����</option>
                <option value="description">����</option>
                <option value="keyword">�ؼ���</option>
              </select>
            </td>
          </tr>
		 <tr><td colspan="2" background="images/line.gif" height="1"></td>
          <tr>
            <td align="right"><!--          	��ҳ������ʼʱ�䣺-->
                <!--            <select name="fromDays">-->
                <!--              <option value="~" selected>�κ�ʱ��</option>-->
                <!--              <option value="7">���һ��</option>-->
                <!--              <option value="32">���һ����</option>-->
                <!--              <option value="183">���������</option>-->
                <!--              <option value="366">���һ��</option>-->
                <!--            </select>-->
                <strong>              ��ʼʱ��:</strong></td>
            <td>
              <input type="text" name="dayBegin"  size="18"  class="cms_text" >
              <input name="button1" type="button" onClick="showdate(document.all('dayBegin'))" value="ʱ��" style="cursor:hand">
              &nbsp;&nbsp;
              <strong>����ʱ�䣺</strong>
              <input type="text" name="dayEnd"  size="18"  class="cms_text" >
                  <input name="button2" type="button" onClick="showdate(document.all('dayEnd'))" value="ʱ��" style="cursor:hand">
            </td>
          </tr>
		   <tr><td colspan="2" background="images/line.gif" height="1"></td>
		  <tr><td colspan="2" align="center"><input name="button" type="button" onClick="searchForm.submit()" value="<%=searchTypeDes%>" style="width:60; height:25;cursor:hand" >
		  <input name="button" type="button" onClick="reset()" value="����" style="width:60; height:25;cursor:hand"></td></tr>
        </table>
		</FORM>
		  </td>
      </tr>
    </table>
 
	</td>
  </tr>
  <tr>
    <td><iframe src='../siteResource/site1/_template/index_foot.html' width="100%" height="100" scrolling=no marginwidth=0 marginheight=0 frameborder=0 vspace=0 hspace=0>
�����ҳβ</iframe></td>
  </tr>
</table>
</body>
</html>

