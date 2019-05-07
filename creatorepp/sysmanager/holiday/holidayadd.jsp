<%@ page language="java" pageEncoding="GBK" %>
<%@page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="java.util.*,com.frameworkset.util.StringUtil,com.chinacreator.holiday.*"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<!DOCTYPE HTML PUBLIC "-//w3c//dtd html 4.0 transitional//en">
<%
		AccessControl accesscontroler = AccessControl.getInstance();
        accesscontroler.checkAccess(request, response);
        String year = StringUtil.replaceNull(request.getParameter("year"));
        String month = StringUtil.replaceNull(request.getParameter("month"));
        month = month.trim().length()==1?"0"+month:month;
        String action = StringUtil.replaceNull(request.getParameter("action"));        
        StringUtil.main(null);
        LogManager logManager = SecurityDatabase.getLogManager(); 
        String operContent = "";        
        String operSource = accesscontroler.getMachinedID();
        String openModle = "�ڼ��չ���";
        String description = "";
        String userName = accesscontroler.getUserAccount();
        boolean isInit = false;    
        HolidayDao hmng = new HolidayDao();
        if(action.equals("1")){
            String days[] = request.getParameterValues("chkTaskId");
            Holiday hol = new Holiday();
            hol.setYHoliday(year);
            hol.setMHoliday(month);
            hmng.delete(hol);
            String day = "";
            for(int i=0;days!=null && i<days.length;i++){
               hol.setYHoliday(year);
               hol.setMHoliday(month);
               hol.setHoliday(days[i]);
               if(!"".equals(day)){
               		day += "," + days[i];
               }else{
               		day = days[i];
               }
               hmng.insert(hol);
            }
            operContent = "�û���"+userName+"�������ڡ�"+day+"������Ϊ�ڼ���";
        }else if(action.equals("2")){
            Holiday hol = new Holiday();
            hol.setYHoliday(year);
            hol.setMHoliday(month);
            hmng.delete(hol);
            
            Date dCalDate = null;
            String days[] = new String[12];
            int nd = 0;
            int length = (new Date(Integer.parseInt(year), Integer.parseInt(month), 0)).getDate();
            for(int i = 1; i <= length; i++)
            {
                dCalDate = new Date(Integer.parseInt(year) - 1900, Integer.parseInt(month) - 1, i);
                if(dCalDate.getDay() == 0 || dCalDate.getDay() == 6)
                {
                    month = month.trim().length()==1?"0"+month:month;
                    String day_str = dCalDate.getDate()<10?"0"+dCalDate.getDate():""+dCalDate.getDate();
                    String holiday = year + "-" + month + "-" + day_str;
                    days[nd] = holiday;
                    hol.setYHoliday(year);
                    hol.setMHoliday(month);
                    hol.setHoliday(days[nd]);
                    hmng.insert(hol);
                    nd++;
                }
            } 
            operContent = "�û���"+userName+"������"+year+"��" + month +"�� �����Ĭ���趨(����������)  ����Ϊ�ڼ���";
        }else{//��ʼ�������: �ѱ������� ���ձ��浽�ڼ��ձ�
            //year ���汾�굽 ��ʼ����ı�Ǳ�
            isInit = hmng.hasInitYear(year);
            if(isInit){//������Ѿ���ʼ����
                //do nothing 
            }else{
                //�����ڱ��浽�ڼ��ձ�
                //�ѳ�ʼ����ݱ��浽��
            	hmng.insertYearHoliday(year);
            
            operContent = "�û���"+userName+"������"+year+"��  ����Ĭ���趨(����������)  ����Ϊ�ڼ���";}
        }
        if(!isInit){
        	logManager.log(userName,operContent,openModle,operSource,description);   
        }
  %>
<title></title>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>

<script language="JavaScript">
<%
    if(isInit){
        out.print("alert('����ʧ��, �Ѿ����汾��Ĭ������(��������)������');");
    }else{    
%>    		
        alert("����ɹ�������");    
<%
    }
%>
    window.location="setholiday.jsp?year=<%=year%>&month=<%=month%>";
</script>
