<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.sitemanager.*" %>
<%@ page import="com.chinacreator.cms.util.*" %>
  <%AccessControl control = AccessControl.getInstance();
    //ҳ�汣��
    control.checkAccess(request,response);//

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
    
    //����ftp����  
  try{
	String sip   = request.getParameter("ftpip");   
	String sport = request.getParameter("ftpport"); 
	int sporta=0;
	sporta=Integer.parseInt(sport);
	String suser = request.getParameter("ftpuser");   
	String spwd  = request.getParameter("ftppasswd");  
//	out.print(sip+";"+sport+";"+suser+";"+spwd);  

   
	FtpUpfile myFtp=new FtpUpfile(sip,sporta,suser,spwd);
     if (myFtp.testftp()) {%>
      <script>
      alert("��ϲ: \n       \n ָ����FTP�������������ӳɹ�!!");
        window.close();
      </script>
     <%
     
	 }else{ %>
	  <script>
      alert("��Ǹ: \n       \nָ����FTP��������������ʧ��,\n����ftp����!!");
      window.close();
      </script>
	 <%
     	 }
	 }
    catch(Exception ex){
    %>
      <script>
      alert("��Ǹ: \n       \nָ����FTP��������������ʧ��,\n����ftp����!!");
        window.close();
      </script>
	 <%
   } 
 
%>


