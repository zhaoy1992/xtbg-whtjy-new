<%@page import="com.chinacreator.xtbg.core.holiday.service.impl.HolidayServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.holiday.service.HolidayService"%>
<%@page import="com.chinacreator.xtbg.core.holiday.entity.Holiday"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page language="java" pageEncoding="utf-8" %>
<%@page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<!DOCTYPE HTML PUBLIC "-//w3c//dtd html 4.0 transitional//en">
<%
		AccessControl accesscontroler = AccessControl.getInstance();
        accesscontroler.checkAccess(request, response);
        String year = StringUtil.deNull(request.getParameter("year"));
        String month = StringUtil.deNull(request.getParameter("month"));
        month = month.trim().length()==1?"0"+month:month;
        String action = StringUtil.deNull(request.getParameter("action"));        
        StringUtil.main(null);
        LogManager logManager = SecurityDatabase.getLogManager(); 
        String operContent = "";        
        String operSource = accesscontroler.getMachinedID();
        String openModle = "节假日管理";
        String description = "";
        String userName = accesscontroler.getUserAccount();
        boolean isInit = false;    
        HolidayService hmng = new HolidayServiceImpl();
        if(action.equals("1")){
            String days[] = request.getParameterValues("chkTaskId");
            Holiday hol = new Holiday();
            hol.setYholiday(year);
            hol.setMholiday(month);
            hmng.delete(hol);
            String day = "";
            for(int i=0;days!=null && i<days.length;i++){
               hol.setYholiday(year);
               hol.setMholiday(month);
               hol.setHoliday(days[i]);
               if(!"".equals(day)){
               		day += "," + days[i];
               }else{
               		day = days[i];
               }
               hmng.insert(hol);
            }
            operContent = "用户【"+userName+"】将日期【"+day+"】设置为节假日";
        }else if(action.equals("2")){
            Holiday hol = new Holiday();
            hol.setYholiday(year);
            hol.setMholiday(month);
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
                    hol.setYholiday(year);
                    hol.setMholiday(month);
                    hol.setHoliday(days[nd]);
                    hmng.insert(hol);
                    nd++;
                }
            } 
            operContent = "用户【"+userName+"】保存"+year+"年" + month +"月 这个月默认设定(周六，周日)  设置为节假日";
        }else{//初始化本年的: 把本年周六 周日保存到节假日表
            //year 保存本年到 初始化年的标记表
            isInit = hmng.hasInitYear(year);
            if(isInit){//改年份已经初始化了
                //do nothing 
            }else{
                //把日期保存到节假日表
                //把初始化年份保存到表
            	hmng.insertYearHoliday(year);
            
            operContent = "用户【"+userName+"】保存"+year+"年  该年默认设定(周六，周日)  设置为节假日";}
        }
        if(!isInit){
        	logManager.log(userName,operContent,openModle,operSource,description);   
        }
  %>
<title></title>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<script language="JavaScript">
if(<%=isInit%>){
	alert("已经保存本年默认设置(周六周日)！！！");
}else{
	alert("保存成功！！！");
}
    window.location="setholiday.jsp?year=<%=year%>&month=<%=month%>";
</script>
