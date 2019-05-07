<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@page import="com.chinacreator.cms.templatemanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.lang.*"%>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", -1);
	//prevents caching at the proxy server
	response.setDateHeader("max-age", 0); 	
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String userId = control.getUserID();
%>
<html>
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>
<style type="text/css">
<!--
.STYLE5 {color: #0000FF}

-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>CMS ģ�����</title>
</head>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<base target="_self">
<body  bottommargin="0"  background="../images/grayline_bg.jpg" onkeydown="if(event.keyCode==116){reload.click()}" rightmargin="0" leftmargin="0" topmargin="0">
<a id="reload" href="template_import.jsp" style="display:none">reload...</a>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<form action="../siteManage/site_createdo.jsp" method="post" enctype="multipart/form-data"  name="fm_site"  onsubmit="return check_form()">
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
              <td height="77" valign="top" background="../images/toolbar_common_func_template.jpg"><table width="96%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="28">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ģ��ɾ��</td>
                </tr>
                <tr>
                  <td height="48" valign="bottom" style="padding-bottom:0px">o<div align="right"></div></td>
                </tr>
              </table></td>
              </tr>
            
            
            <tr>
              <td height="33"><div align="center"><span class="STYLE5">
              
              <%
              		String tplId = request.getParameter("tplIds");
					int siteId = Integer.parseInt(request.getParameter("siteId"));	
					String[] tplIds = tplId.split(";"); 

					TemplateManager templateM = new TemplateManagerImpl();
					String deletedTempleteId="";
					
					boolean templateisuser=true;
					
					for(int i = 0;i<tplIds.length;i++)
					{
						int templateId = Integer.parseInt(tplIds[i]) ;
						
						//ɾ��֮ǰ�ж�ģ���Ƿ񱻴���
						if(templateM.isExistTemplate(templateId))
						{
						
							try
							{	
								templateM.deleteTemplateFile(
										templateId,
										new Integer(siteId).toString(),
										userId);
											
								templateisuser = templateM.deleteTemplateofSite(
													templateId,
													siteId);
													
								deletedTempleteId += tplIds[i]+ ",";
								
							    if(!templateisuser)
							    {
									break;
								}
							}
							catch(TemplateManagerException ex)
							{		
								   templateisuser=false;
								   break;
							}
						}		
				}
				
				
				if(!templateisuser)	
				{
	%>
					ģ�屻���ã�ɾ��ʧ��!
	<% 
				}
				else if(deletedTempleteId.length()>0)
				{ 
	%>
					ģ��ɾ���ɹ���
			<script language = "javascript">window.returnValue ="ok";</script>
	<% 
				}
				else
				{
	%>
					ģ��ɾ��ʧ�ܡ�
	<%
				}
	%>
              </span></div></td>
              </tr>
            <tr>
              <td height="14">&nbsp;</td>
              </tr>
            
            <!--��Դ�ڱ����վ���и�վ��-->
            
            <tr>
              <td height="22"><div align="center">
                <input name="btn_close" type="button" class="cms_button"  onclick="javascript:window.close();" value="�ر�" />
              </div></td>
              </tr>
            <tr>
              <td height="11" background="../images/bottom_gray.jpg">&nbsp;</td>
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