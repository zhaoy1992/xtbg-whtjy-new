
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.holiday.*"%>
<%@ page import="java.util.*,com.frameworkset.util.StringUtil,com.chinacreator.holiday.*"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
            accesscontroler.checkAccess(request, response);
            String syear = StringUtil.replaceNull(request.getParameter("year"));
            String smonth = StringUtil.replaceNull(request
                    .getParameter("month"));
            Date thisd = new Date();
            int year = 0;
            int month = 0;

            if (syear.equals(""))
                year = thisd.getYear() + 1900;
            else
                year = Integer.parseInt(syear);
            if (smonth.equals(""))
                month = thisd.getMonth() + 1;
            else
                month = Integer.parseInt(smonth);
           
%>
<title></title>

<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>


<script language="JavaScript" >


    function cmdOK_onclick()
    {
        document.dateform.submit();
    }
    
   function setholiday()
   {
    	document.setform.action.value=1;
    	document.setform.submit();
   }
   
    function mholiday(){
		document.setform.action.value=2;
		document.setform.submit();
   }
   
   function yearHoliday(){
       document.setform.action.value=3;
	   document.setform.submit();
   }
   function dailyDetail(work_id){
	  var url="dailyDetail.jsp?work_id="+work_id;
	  var status=window.showModalDialog(url,"作息时间设置","dialogHeight:300px;dialogWidth:570px");
	  if(status){
	     document.location="setholiday.jsp?menu_path=module%3A%3Amenu%3A%2F%2Fsysmenu%24root%2Feppmanager%24module%2Fholidaymanager%24item&menu_type=10";
	  }
   }
   function addDetail(){
	  var url="dailyDetail.jsp";
	 // var status=window.open(url,"作息时间设置","top=250,left=200,height=300px,width=570px");
	  var status=window.showModalDialog(url,"作息时间设置","dialogHeight:300px;dialogWidth:570px");
	  if(status){
	     document.location="setholiday.jsp?menu_path=module%3A%3Amenu%3A%2F%2Fsysmenu%24root%2Feppmanager%24module%2Fholidaymanager%24item&menu_type=10";
	  }
   }
   function delDaily(dealType) {
    var isSelect = false;
    var outMsg;
	    
    for (var i=0;i<DailyForm.elements.length;i++) {
		var e = DailyForm.elements[i];
		if (e.name == 'checkBoxOne'){
			if (e.checked){
	       		isSelect=true;
	       		break;
		    }
		}
    }
    if (isSelect){    		
        	if (confirm("确认删除吗？")){
        		var inputObjects = document.getElementsByName("checkBoxOne");
				var arrayValues = new Array;
				for(var i = 0;i < inputObjects.length;i ++){
					if(false != inputObjects[i].checked)
						arrayValues[arrayValues.length] = inputObjects[i].value;
				}        	
				var idsStr=arrayValues.join("','");
				document.location="setholiday.jsp?menu_path=module%3A%3Amenu%3A%2F%2Fsysmenu%24root%2Feppmanager%24module%2Fholidaymanager%24item&menu_type=10&idsStr="+idsStr;	
			
		} 
    }else{
    	alert("至少要选择一条记录！");
    	return false;
    }
	return false;
}

function modifyRecord(dealType) {
	var count=0;   
	var work_id='';
    for (var i=0;i<DailyForm.elements.length;i++) {
		var e = DailyForm.elements[i];	
		if (e.name == 'checkBoxOne'){
			if (e.checked){
			    work_id=e.value;
	       		count++;
		    }
		}
    }
    if (count==1){
		dailyDetail(work_id); 
    }else{
    	alert("请选择你要修改的一条(仅一条)记录！");
    	return false;
    }
	return false;
}
</script>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin">
<link rel="stylesheet" type="text/css" href="../../<%=session.getAttribute("current_cssname")%>">
<TABLE width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE" class="thin">
	<tr align="center" height="20px" class="labeltable_middle_td">
		<td colspan="4">
			工作日列表（打勾为假日）
		</td>
	</tr>
	<form name="dateform" action="setholiday.jsp">
		<input type="hidden" name="action">
	<tr>

		<td align="center" colspan="4">
			<select NAME=year>
				<%int iyear = 2004;
            for (int i = 0; i < 10; i++)
            {
                if (year == iyear)
                {

                    %>
				<option value="<%=year%>" selected>
					<%=year%>
				</option>
				<%} else
                {

                    %>
				<option value="<%=iyear%>">
					<%=iyear%>
				</option>
				<%}
                iyear = iyear + 1;
            }

            %>
			</select>
			年

			<select NAME=month>
				<%int imonth = 1;
            for (int i = 0; i < 12; i++)
            {
                if (month == imonth)
                {

                    %>
				<option value="<%=month%>" selected>
					<%=month%>
				</option>
				<%} else
                {

                    %>
				<option value="<%=imonth%>">
					<%=imonth%>
				</option>
				<%}
                imonth = imonth + 1;
            }

            %>
			</select>
			月
			<input class="input" type="Button" name="cmdOK" value="确定" onClick="cmdOK_onclick()">			
		</td>

	</tr>	
	</form>
	</table>
	<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
	<tr align="center" height="20px" class="labeltable_middle_td">
	    <td class="headercolor" align="left">星期日</td>
	    <td class="headercolor" align="left">星期一</td>
	    <td class="headercolor" align="left">星期二</td>
	    <td class="headercolor" align="left">星期三</td>
	    <td class="headercolor" align="left">星期四</td>
	    <td class="headercolor" align="left">星期五</td>
	    <td class="headercolor" align="left">星期六</td>
	</tr>
	<tr align="center" height="20px" class="labeltable_middle_td">
	<form name="setform" action="holidayadd.jsp">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="action">
		<%
		    String[] m = new String[10];
            Date dCalDate = null;
            int length = new Date(year, month, 0).getDate();            
            String ischecked = null;
            //补开头少的星期
            Date startDate = new Date(year - 1900, month - 1, 1);
            int lack_weekday = startDate.getDay();
            //补结尾的td
            int lack_td = 0 ;
            for (int i = 1; i <= length + lack_weekday; i++)
            {
                if(i <= lack_weekday){
                    out.print("<td></td>");
                    continue;
                }
                dCalDate = new Date(year - 1900, month - 1, i-lack_weekday);
                
                //取出指定年月得周末；用于默认设定
                int nn = 0;
                //add by ge.tao
                String month_str = "";
                if(month<10) month_str = "0" + month;
                else month_str = "" + month;
                String day_str = "";
                if(dCalDate.getDate()<10) day_str = "0" + dCalDate.getDate();
                else day_str = "" + dCalDate.getDate();
                //end
                String holiday = year + "-" + month_str + "-" + day_str;
                HolidayDao hm = new HolidayDao();
                ischecked = hm.findByDay(holiday);
        %>
			<td align="left">
				<input type="checkbox" id="chkTaskId" name="chkTaskId" value="<%=holiday%>" <%=ischecked%>>
				&nbsp;
				<%=holiday%>
				
				
			</td>

		<%
		    	if ((i != 0) && (i%7 == 0) ){
		%>
			    </tr>
			    <tr align="center" height="20px" class="labeltable_middle_td">
			
	    <%
	        	} 	 
	        	if(i==length + lack_weekday){//一个月最后一天
	        	    lack_td = 7 - dCalDate.getDay();
	        	} 
	        	      
	    }   
	        for(int i=1;i<lack_td;i++){
	            out.print("<td></td>");
	        }
	    %>
	</tr>
	<tr>
		<td align="center" colspan="7">
			<input class="input" type="Button" name="cxsd" value="保存自定义设置" onClick="setholiday()">
			<!-- input class="input" type="Button" name="mrsd" value="保存本月默认设定（周六周日）" onClick="mholiday()"> -->			
			<input class="input" type="Button" name="cmdOK" value="保存本年默认设定(周六周日)" onClick="yearHoliday()">
		</td>
	</tr>
	</form>
</table>

		<div id="contentborder" align="center">
			<form name="DailyForm" action="" method="post">
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=10>
							<b>作息时间管理</b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.holiday.DailyList" keyName="DailyList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="6" scope="request" data="DailyList" isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
							</td>

							<td height='20' class="headercolor">
								日期范围
							</td>
							<td height='20' class="headercolor">
								上午班时间段
							</td>
							<td height='20' class="headercolor">
								下午班时间段
							</td>
							<td height='20' class="headercolor">
								备注说明
							</td>
							<td height='20' class="headercolor">
								最后修改时间
							</td>
						</tr>

						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有记录
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" >
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="checkbox" name="checkBoxOne" onClick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="work_id" defaultValue=""/>'>
									</P>
								</td>

								<td align=center height='20' width="170" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="begin_date" defaultValue="" />
								</td>
								<td align=center height='20' width="100" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="am_begin_time" defaultValue="" />
								</td>
								<td align=center height='20' width="100" align=left class="tablecells" style="word-wrap:break-word;" onMouseOver="">
									<pg:cell colName="pm_begin_time" defaultValue="" maxlength="30" replace="..." />
								</td>
								<td  height='20' width="230" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="remark" defaultValue="" maxlength="25" replace="..."/>
								</td>
								<td align=center height='20' width="120" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="last_modify_time" defaultValue="" />
								</td>
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
								<%
								if (accesscontroler.isAdmin()) {
								%>
								<input  name="Submit" type="button" class="input" value="新增" onClick="addDetail()" >
								<input name="Submit" type="button" class="input" value="修改" onClick="javascript:modifyRecord(0); return false;">
								<input type="button" value="删除" class="input" onClick="javascript:delDaily(0); return false;">
								<%
								}
								%>
							</td>
						</tr>
					</pg:pager>

				</table>
			</form>
		</div>
</body>
