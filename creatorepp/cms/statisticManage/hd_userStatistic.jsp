<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="java.util.*"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	//���ܵ���ʼʱ��
	String start_weekDate;
	java.text.SimpleDateFormat   df=new   java.text.SimpleDateFormat("yyyy-MM-dd");   
    Calendar   calendar=Calendar.getInstance();   
    Calendar   cpcalendar=(Calendar)calendar.clone(); 
        
    Date currentDate = new Date(); 
    /**��ǰʱ��*/ 
    String riqi = df.format(currentDate); 
    //�õ�����һ��ʱ��
    cpcalendar.set(Calendar.DAY_OF_WEEK,   Calendar.MONDAY); 
    start_weekDate = df.format(new Date(cpcalendar.getTimeInMillis()));
%>
<html>
	<frameset rows="120,*" border=0>
	<frame frameborder=0  noResize marginwidth="0" scrolling="auto"  name="forQuery" src="hd_userStatistic_query.jsp"></frame>	
	<frame frameborder=0  noResize  marginwidth="0" scrolling="auto"  name="forList" src="hd_userStatistic_list.jsp?startDate=2007-09-01&endDate=<%=riqi%>"></frame>
	</frameset>
</html>