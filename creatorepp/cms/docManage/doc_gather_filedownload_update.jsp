<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.templatemanager.*
,com.chinacreator.cms.container.Template,com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.security.AccessControl,java.util.List"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	String docid = request.getParameter("docid");
	String channelname = request.getParameter("channelName");
	String siteid = request.getParameter("siteid");
	String channelId = request.getParameter("channelId");
	
	DocumentManager dmi = new DocumentManagerImpl();
	Document document = dmi.getDoc(docid);
	String status = String.valueOf(document.getStatus());
	SiteManager siteManager = new SiteManagerImpl();
	String sitename = siteManager.getSiteName(siteid);
	String tid = String.valueOf(document.getDetailtemplate_id());
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>
<style type="text/css">
<!--
.STYLE7 {color:#003398; font-size: 12px;}
#Layer1 {
	position:absolute;
	left:0px;
	top:0px;
	width:113px;
	height:127px;
	z-index:1;
}
.STYLE9 {color: #FF6600}

-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>CMS �ĵ�����</title>
</head>
<script language="javascript">
	//վ�㴰���������У��
	function saveform(){
	if(!confirm('��ȷ��Ҫ�޸��ĵ���')){
	return;
	}
		if(myform.title.value==""){
			alert("�������ĵ�����!");
			myform.title.focus();
			return false;
		}
		if(myform.subtitle.value==""){
			alert("��������ʾ����!");
			myform.subtitle.focus();
			return false;
		}else{
			myform.method="post";
			myform.action="update_document.jsp";
			myform.submit();
		}
	}
	//����
	function back() {
		window.close();
	}
	//������ڵ�һ��text
	function init(){
		myform.title.focus();
	}
	
</script>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<base target="_self">
<body  bottommargin="0"  background="../images/grayline_bg.jpg" onkeydown="if(event.keyCode==116){reload.click()}" rightmargin="0" leftmargin="0" topmargin="0" onload="init();">
<a id="reload" href="doc_gather_filedownload.jsp" style="display:none">reload...</a>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<form target="updatefiledownload" action="update_document.jsp" method="post"  name="myform">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<input type="hidden" name="content">
    <input name="doctype" value="2" type=hidden>
    <input name="docid" value="<%=docid%>" type=hidden>
   	<input name="siteid" value="<%=siteid%>" type=hidden>
  	<input name="channelName" value="<%=channelname%>" type=hidden>
  	<input name="channelId" value="<%=channelId%>" type=hidden>
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
              <td height="47" colspan="3" valign="top" background="../images/toolbar_common_func_template.jpg"><table width="96%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="28">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ���ݱ༭ [<%=sitename%> վ��  :  <%=channelname%> Ƶ��]</td>
                </tr>
                <tr>
                  <td valign="middle" style="padding-bottom:0px">&nbsp;</td>
                </tr>
              </table></td>
              </tr>
            
            
            <tr>
              <td height="18" colspan="3"><table width="98%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="4%" height="27"><img src="../images/ico_point.gif" width="25" height="25"></td>
                  <td colspan="2" class="cms_title_blue"><table width="100%" border="0">
                      <tr>
                        <td class="cms_title_blue">�ĵ���Ϣ��д</td>
                        <td><div align="right"><span class="red_star">*</span> Ϊ������<span class="red_star"><img src="../images/tan.gif" width="11" height="11"> </span></div></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td height="23">&nbsp;</td>
                  <td height="23" colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="9%">�ĵ�����:</td>
                      <td width="4%"><div align="center"><img src="../images/doc_downloadfile.gif" width="15" height="16">&nbsp;</div></td>
                      <td width="32%">�ⲿ�ļ�</td>
                      <td width="30%">&nbsp;</td>
                    </tr>
                  </table>
                    <label>&nbsp;</label></td>
                </tr>
                <tr>
                  <td height="23">&nbsp;</td>
                  <td height="23" colspan="2">�ĵ�����:<span class="cms_title_blue">
                    <label>
                    <input name="title" type="text" class="cms_text" size="60" value="<%=document.getTitle()%>">
                    </label>
                  </span><span class="STYLE7">
                  <label><span class="red_star">*</span></label>
                  </span><span class="cms_title_blue">
				  <label></label>
                  </span><span>&nbsp;&nbsp; ������ɫ</span><span >:
                  <input name="titlecolor"  value="<%=document.getTitlecolor()%>"  onClick="window.open('../inc/js/selcolor.htm?','window','height=271, width=411, top=0, left=580, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');"  readonly type="text" class="cms_text" style="color:<%=document.getTitlecolor()%>" size="7" maxlength="50">
				  </span><span class="black"><!--span class="red_star">*</span>&nbsp;Ȩ��:
				  <input name="documentprior" type="text" class="cms_text" value="100" size="3" value="<%=document.getDocumentprior()%>">
				  </span--></td>
                </tr>
                <tr>
                  <td height="23">&nbsp;</td>
                  <td height="23" colspan="2">��ʾ����:
                    <input name="subtitle" type="text" class="cms_text" size="60" value="<%=document.getSubtitle()%>">
					<label><span class="red_star">*</span></label>
					<label>&nbsp;&nbsp; ���ʱ��: <span class="black"><span class="cms_title_blue">
					<input name="docwtime" type="text" class="cms_text" value="2006/12/11 12:55:05" size="20" value="<%=document.getCreateTime()%>">
					</span><span class="STYLE7"><span class="red_star">*</span></span></span></label></td>
                </tr>
                
                <tr>
                  <td height="23">&nbsp;</td>
                  <td height="23" colspan="2"><table width="100%" border="0" cellspacing="0">
                    <tr>
                      <td>����ģ��:<span class="cms_title_blue">
                    <select name="detailtemplate_id" class="cms_select">
                        <%
                          List list=null;
					      TemplateManagerImpl tmi=new TemplateManagerImpl();
					      Template template=new Template();
						  list=tmi.getTemplateInfoList(2);
						  request.setAttribute("tpllist",list);
						%>
						  <pg:list requestKey="tpllist">
						  	  
							  <option value="<pg:cell colName="templateid"/>" <pg:equal colName="templateid" value="<%=tid%>">selected</pg:equal>>
							  <pg:cell colName="name"/>
							  </option>
						  </pg:list>
                    </select>
					&nbsp; </span>Ԥ�� | �༭ </td>
                      </tr>
                  </table></td>
                </tr>
                
                <tr>
                  <td height="23">&nbsp;</td>
                  <td width="73%" height="23">�����ļ�:
                    <label>
                    <input name="docurl" type="text"  class="cms_file" size="50" value="<%=document.getLinkfile()%>">
<!--                    <input name="docurl" type="file"  class="cms_file" size="20">-->
                    </label>
                    <label>&nbsp;<span class="red_star">*</span>&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;</label></td>
                  <td width="23%" height="23"><div align="right">&nbsp;&nbsp; 
                  </div></td>
                </tr>
                <tr>
	               <td height="23">&nbsp;</td>
	               <%if ((accesscontroler.getUserName()!=null)&& accesscontroler.getUserName().equals("ϵͳ����Ա")){%>
					
					 <!--td  height="23">�ĵ�״̬:
						<select name="status" class="cms_select">
	                      <option value="1" <%if(status.equals("1")){out.print("selected");}%>>�¸�</option>
	                      <option value="2" <%if(status.equals("2")){out.print("selected");}%>>����</option>
	                      <option value="3" <%if(status.equals("3")){out.print("selected");}%>>����</option>
	                      <option value="4" <%if(status.equals("4")){out.print("selected");}%>>�ѷ�</option>
	                      <option value="5" <%if(status.equals("5")){out.print("selected");}%>>�ѻ���</option>
	                      <option value="6" <%if(status.equals("6")){out.print("selected");}%>>�ѹ鵵</option>
	                    </select>
	                </td-->
			    	<%}%>
            </tr>
              </table></td>
              </tr>
            
        	
            
            <tr>
              <td  width="766" height="22" colspan="3"  align="center" valign="top">
              	 <INPUT name="button" type="button" class="cms_button"  value="�޸�" onclick="saveform();">
                  <input type="button" value="����" class="cms_button"
								onclick="back()">
                </tr>
            
            <tr>
              <td height="22" colspan="3"><table width="98%" border="0">
                
                <tr>
                  <td width="11%">&nbsp;</td>
                  <td width="89%">&nbsp;</td>
                </tr>
              </table></td>
              </tr>
            
            
            <!--��Դ�ڱ����վ���и�վ��-->
            
            <tr>
              <td height="11" colspan="3" background="../images/bottom_gray.jpg">&nbsp;</td>
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
<div style="display:none">
	<iframe name="updatefiledownload" width="0" height="0"></iframe>
</div>
</body>
</html>