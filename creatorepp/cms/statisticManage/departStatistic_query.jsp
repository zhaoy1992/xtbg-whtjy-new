<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.*"%>
<%@page import=" java.util.Calendar,java.util.Date"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	
	
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
		//��վ��ͨʱ��
		String start_open = "2007-9-1";
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
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<title>����ͳ�Ʋ�ѯ</title>
<script src="../inc/js/func.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
<script language="JavaScript" src="../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
<script type="text/javascript" src="../../public/datetime/calender.js" language="javascript"></script>
<script type="text/javascript" src="../../public/datetime/calender_date.js" language="javascript"></script>
<script language="javascript">
	function query(){	
		//��ѯ
		if(form1.startDate.value>form1.endDate.value)
		{
			alert("��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡");
			return;
		}
		form1.action="departStatistic_list.jsp?startDate="+form1.startDate.value+"&endDate="+form1.endDate.value+"&maxPageItems="+form1.maxPageItems.value+"&orgid="+form1.org.value;
		form1.target="forList";
		form1.submit();	
	}
	function changeDate()
	{	//����ʱ���
	    //ȫ��
	    if(form1.dateType.value==0)
		{
		    form1.startDate.value="<%=start_open%>";
			form1.endDate.value="<%=riqi%>";
			return;
		}
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
		form1.action="departStatistic_print.jsp?startDate="+form1.startDate.value+"&endDate="+form1.endDate.value+"&maxPageItems="+form1.maxPageItems.value+"&orgid="+form1.org.value;
		form1.target="_blank";
		form1.submit();
	}
	
	function showOrg(obj,name,value){
        
        var x=offsetLeft(obj)
        var y=offsetTop(obj)*1-50;
        window.showModalDialog("orgList.jsp?inputName="+name+"&inputValue="+value,window,'dialogheight:500px;dialogwidth:180px;dialogLeft:'+x+';dialogTop:'+y+'status:no;help:no');
        return;
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
						<STRONG><FONT size="3" >����ͳ��</FONT></STRONG>
					</td>
  </tr>
  <tr>
    <td width="5" valign="top"><img src="../images/querybox_left.gif" width="5" height="62"></td>
    <td  style="background:url(../images/querybox_bg.gif) repeat-x top">
	<table width="100%" border="0" cellpadding="3" cellspacing="0" style="margin-top:5px"   class="query_table">
		<tr>
			<td  height='30' align="left" nowrap="nowrap">
				���ͣ�
				<select name="dateType" class="cms_select" style="width:120" onChange="changeDate()">	
					<option value="1">����</option>
					<option value="2">����</option>
					<option value="3">����</option>
					<option value="4">����</option>
				</select>			          
			</td>
			<td>
			����
			<select name="org">
				<option value="">��ѡ����</option>
				<pg:pager  scope="request" statement="select org_id,org_name from td_sm_organization  order by org_sn" dbname="bspf" isList="true">
					<pg:list>
					<option value="<pg:cell colName="org_id"/>"><pg:cell colName="org_name"/></option>
					</pg:list>
				</pg:pager>
			</select>
			</td>
			<td  height='30' align="left" nowrap="nowrap">
				ÿҳ��ʾ������
				<input name="maxPageItems" type="text" size="2" value="10">	          
			</td>
			<td  height='30' align="left" nowrap="nowrap">
				Ƶ����
				<input type="text" name="channel_name"  onClick="showOrg(this,'channel_name','channel_id')" readonly="true">
				<input type="hidden" name="channel_id"/>          
			</td>
		</tr>
		<tr>
			<td  >������Ҫ��ѯ��ʱ��Σ�</td>
        	<td  >
            	 ��ʼʱ�䣺<input type="text" name="startDate" onclick="showdate(document.all('startDate'))" readonly="true" value="<%=start_weekDate%>" validator="stringNull" cnname="��ʼʱ��" maxlength="40">
            </td>
            <td>
            	����ʱ�䣺<input type="text" name="endDate" onclick="showdate(document.all('endDate'))" readonly="true" value="<%=riqi%>" validator="stringNull" cnname="����ʱ��" maxlength="40">
            </td>
            <td align="right">            
				<input name="search" type="button" class="cms_button" value="��ѯ" onClick="query()">&nbsp;&nbsp;
				<input name="print" type="button" class="cms_button" value="��ӡ" onClick="doprint()">
			</td>
        </tr>
	</table>
	</td>
    <td width="6" valign="top"><img src="../images/querybox_right.gif" width="6" height="62"></td>
  </tr>
</table>
</form>
</body>
</html>