<%@ page contentType="text/html; charset=GBK" language="java"%>


<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="java.text.DateFormat,
				java.text.SimpleDateFormat,
				java.util.Calendar,
				java.util.Date"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	com.chinacreator.cms.CMSManager cmsManager  = new com.chinacreator.cms.CMSManager();
 	cmsManager.init(request,session,response,accesscontroler);
 	String currentSiteid = cmsManager.getSiteID();
	
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	//���ܵ���ʼʱ��
		String start_weekDate;
		//���µ���ʼʱ��
		String start_monthDate;
		//��������ʼʱ��
		String start_quarterDate;
		//�������ʼʱ��
		String start_yearDate;
		//��ǰ��ʱ��
		String riqi ;
		
		java.text.SimpleDateFormat   df=new   java.text.SimpleDateFormat("yyyy-MM-dd");   
        Calendar   calendar=Calendar.getInstance();   
        Calendar   cpcalendar=(Calendar)calendar.clone(); 
        
        Date currentDate = new Date(); 
        /**��ǰʱ��*/ 
        riqi = df.format(currentDate); 
             
        //�õ�����,��һ��Ϊ�㣬����Ҫ��1
        int month = currentDate.getMonth()+1;
        
        
        //�õ�����һ��ʱ��
        cpcalendar.set(Calendar.DAY_OF_WEEK,   Calendar.MONDAY); 
        start_weekDate = df.format(new Date(cpcalendar.getTimeInMillis()));
        
        //�õ����µ���ʼʱ��         
        cpcalendar.set(Calendar.DAY_OF_MONTH,   1);
        start_monthDate = df.format(new Date(cpcalendar.getTimeInMillis()));
        
        //�õ���������ʼʱ��
        
        //����������ڵ�һ����
        if(month>=1 && month<=3){
        	cpcalendar.set(Calendar.MONTH,   0);
            start_quarterDate = df.format(new Date(cpcalendar.getTimeInMillis()));
        	//start_quarterDate = year+"-01-01";
        }
        //����������ڵڶ�����
        else if(month>=4 && month<=6){
        	cpcalendar.set(Calendar.MONTH,   3);
            start_quarterDate = df.format(new Date(cpcalendar.getTimeInMillis()));
        }
        //����������ڵ�������
        else if(month>=7 && month<=9){
        	cpcalendar.set(Calendar.MONTH,   6);
            start_quarterDate = df.format(new Date(cpcalendar.getTimeInMillis()));
        }
        //����������ڵ��ļ���
        else {
        	cpcalendar.set(Calendar.MONTH,   9);
            start_quarterDate = df.format(new Date(cpcalendar.getTimeInMillis()));
        }
        
        //�õ��������ʼʱ��
        cpcalendar.set(Calendar.DAY_OF_YEAR,   1);
        start_yearDate = df.format(new Date(cpcalendar.getTimeInMillis()));
       
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../../inc/css/cms.css" rel="stylesheet" type="text/css">
<title>��Դͳ�Ʋ�ѯ</title>
<script src="../../inc/js/func.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
<script language="JavaScript" src="../../../sysmanager/include/pager.js" type="text/javascript"></script>
<script language="JavaScript" src="../../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../public/datetime/calender.js" language="javascript"></script>
<script type="text/javascript" src="../../../public/datetime/calender_date.js" language="javascript"></script>
<script language="javascript">
	function query(){	
		//��ѯ
		if(form1.startDate.value>form1.endDate.value)
		{
			alert("��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡");
			return;
		}
		form1.action="statistic_list.jsp?startDate="+form1.startDate.value+"&endDate="+form1.endDate.value+"&channelId="+form1.channelId.value+"&maxPageItems="+form1.maxPageItems.value;
		form1.target="forList";
		form1.submit();	
	}
	function changeDate()
	{	//����ʱ���
		//����
		
		if(form1.dateType.value==1){
			form1.startDate.value="<%=start_weekDate%>";
			form1.endDate.value="<%=riqi%>";
			return;
		}
		//����
		else if(form1.dateType.value==2){
			form1.startDate.value="<%=start_monthDate%>";
			form1.endDate.value="<%=riqi%>";
			return;
		}
		//����
		else if(form1.dateType.value==3){
			form1.startDate.value="<%=start_quarterDate%>";
			form1.endDate.value="<%=riqi%>";
			return;
		}
		//����
		else if(form1.dateType.value==4){
			form1.startDate.value="<%=start_yearDate%>";
			form1.endDate.value="<%=riqi%>";
			return;
		}
		
	}
	
	function doprint(){
		form1.action="docStatistic_print.jsp?startDate="+form1.startDate.value+"&endDate="+form1.endDate.value+"&channelId="+form1.channelId.value+"&maxPageItems="+form1.maxPageItems.value;
		form1.target="_blank";
		form1.submit();
	}
	
	function selectChnl(){
		var reVlaue = openWin('../../docManage/multi_channel_select_frame.jsp?siteid=<%=currentSiteid%>&type=single',400,500);	
		if(reVlaue != undefined){
			var channelName= reVlaue.split(":")[0];
			var channelId = reVlaue.split(":")[1];
			form1.channelName.value = channelName.substring(0,channelName.length-1);
			form1.channelId.value = channelId.substring(0,channelId.length-1);
		}
	}
	
	function testTime(arg)
	{
		if(arg == "start")
		{
			showdate(document.all('startDate')) ;
		}else if(arg == "end")
		{
			showdate(document.all('endDate')) ;
		}
		
	
		var startTime = form1.startDate.value ;
		
		var endTime = form1.endDate.value ;
		
		if(startTime > endTime)
		{
			alert("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
			
			if(arg == "start")
			{
				form1.startDate.value = "" ;	
			}else if(arg == "end")
			{
				form1.endDate.value = "" ;
			}
		}
	}
	function doprint(){
		form1.action="crawlStatistic_print.jsp?startDate="+form1.startDate.value+"&endDate="+form1.endDate.value+"&maxPageItems="+form1.maxPageItems.value;
		form1.target="_blank";
		form1.submit();
	}
	
</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<body>
<form id="form1" name="form1" method="post">
<table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
     <td colspan="3">
						<STRONG><FONT size="3" >����Դͳ��</FONT></STRONG>
					</td>
  </tr>
  <tr>
    <td width="5" valign="top"><img src="../../images/querybox_left.gif" width="5" height="62"></td>
    <td  style="background:url(../../images/querybox_bg.gif) repeat-x top">
	<table width="100%" border="0" cellpadding="3" cellspacing="0" style="margin-top:5px"   class="query_table">
		
		<tr>
        	<td>&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;�ͣ�
            	  <select name="dateType" class="cms_select" style="width:120" onChange="changeDate()">					
					<option value="1">����</option>
					<option value="2">����</option>
					<option value="3">����</option>
					<option value="4">����</option>
				</select>
            </td>
            <td>
            	����Ƶ����
				<input name="channelName" type="text" size="20" readOnly>
				<input name="chnlSel" type="button" onClick="selectChnl()" value="��">
            </td>
            <td>            
				ÿҳ��ʾ������
				<input name="maxPageItems" type="text" size="2" value="10">
			</td>
        </tr>
		<tr>
        	<td>
            	 ��ʼʱ�䣺<input type="text" name="startDate" readonly="true" value="<%=start_weekDate%>" validator="stringNull" cnname="��ʼʱ��" maxlength="30">
				 <input name="button" type="button" onClick="testTime('start')" value="..."/>
            </td>
            <td>
            	����ʱ�䣺&nbsp;&nbsp;<input type="text" name="endDate"  readonly="true" value="<%=riqi%>" validator="stringNull" cnname="����ʱ��" maxlength="40">
				<input name="button" type="button" onClick="testTime('end')" value="..."/>
            </td>
            <td align="center">            
				<input name="search" type="button" class="cms_button" value="��ѯ" onClick="query()">&nbsp;&nbsp;
				<input name="print" type="reset" class="cms_button" value="��ӡ" onClick="doprint()">
			</td>
        </tr>
	</table>
	</td>
    <td width="6" valign="top"><img src="../images/querybox_right.gif" width="6" height="62"></td>
  </tr>
</table>
<input type="hidden" name="channelId" value="">
</form>
</body>
</html>