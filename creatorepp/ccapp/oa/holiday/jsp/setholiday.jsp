<%--
描述：资料基本管理查询列表页面(index内右)
作者：肖杰
版本：1.0
日期：2013-08-21
--%>
<%@page import="com.chinacreator.xtbg.core.holiday.service.impl.HolidayServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.holiday.service.HolidayService"%>
<%@page import="com.chinacreator.xtbg.core.holiday.dao.impl.HolidayDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.holiday.dao.HolidayDao"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.data.entity.DataDataBean"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import="com.chinacreator.xtbg.core.data.service.impl.DataTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.data.service.DataTypeService"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	
	String syear = StringUtil.deNull(request.getParameter("year"));
    String smonth = StringUtil.deNull(request.getParameter("month"));
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
    
    int nowyear=(new Date()).getYear()+1900;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入formvValidatetion -->
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script src="../../resources/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	
	
<%--query table begin--%>
<script type="text/javascript">
$(function() {
	
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.holiday.list.DailyList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['id','日期范围','上午班时间段','下午班时间段 ', '备注说明 ', '最后修改时间 '],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'work_id',
			index: 'work_id',
			width: 50,
			editable: true,
			hidden:true
		},
		{
			name: 'work_date',
			index: 'work_date',
			width: 180,
			editable: true
		},
		{
			name: 'work_am_time',
			index: 'work_am_time',
			width: 180,
			editable: true,
			sortable: false
		},
		{
			name: 'work_pm_time',
			index: 'work_pm_time',
			width: 180,
			editable: true,
			sortable: false
		},
		{
			name: 'remark',
			index: 'remark',
			width: 120,
			editable: true,
			sortable: false
		},

		{
			name: 'last_modify_time',
			index: 'last_modify_time',
			width: 150,
			editable: true,
			sortable: false
		}
		],
		sortname: '',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: '',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "草稿箱",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		multiselect: true,
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add type='button' onclick='addDetail()' value='新增'/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=del type='button' value='删除' onclick='delDaily()'/>"],
		onCellSelect:function(rowid,iCol){
			if(iCol!=0){
				jQuery("#gridTable").setSelection(rowid,false);
				modifyRecord(rowid);
			}
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh:false
	});
});



function toParamJosn(){
	return "";
}

//删除
function delDaily() {
	 var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids += "'" + model.work_id + "'";
		}		 
	if (IsSpace(ids)) {
		alert("请选择要删除记录！");
	} else {
		var okF = function(){	
			$("#work_id").val(ids);
			var fm = document.getElementById("delForm1");
			fm.target = "hiddenFrame";
			fm.submit();
			}
		var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
			cancelName:'取消'
		};
		alert("确定要删除吗？",p);
	}
}

//添加
function addDetail(){
	var url = "<%=path%>/ccapp/oa/holiday/jsp/dailyDetail.jsp?subid=adddaily";
	openAlertWindows('adddaily',url,'添加工作时间',800,350,'25%','25%');
 }
 //修改
function modifyRecord(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	openAlertWindows('updatedaily','<%=path%>/ccapp/oa/holiday/jsp/dailyDetail.jsp?subid=updatedaily&work_id='+model.work_id,'修改工作时间',800,350,'25%','25%');
}
function cmdOK_onclick()
{
	var fm = document.getElementById("dateform");
	fm.submit(); 
}

function setholiday()
{
	document.setform.action.value=1;
	var fm = document.getElementById("setform");
	fm.target = "hiddenFrame";
	fm.submit();
}

function mholiday(){
	/* document.setform.action.value=2;
	document.setform.submit(); */
}

function yearHoliday(){
   document.setform.action.value=3;
   var fm = document.getElementById("setform");
   fm.target = "hiddenFrame";
   fm.submit();
}
</script>
</head>
<body style="overflow-x: auto;">
<div class="content_02_box_title_bg" style="width: 98%;" ><span>节假日设定</span></div>

<TABLE width="98%" cellpadding="0" cellspacing="0"  class="content_02_box_div_table_02" cellspacing="0" cellpadding="0" border="0" >
	<tr align="center" height="20px" class="">
		<td colspan="4" >
			<div class="content_02_box_title_bg" style="width: 100%" ><span >工作日列表（打勾为假日）</span></div>
		</td>
	</tr>
	<form id="dateform" name="dateform" action="setholiday.jsp" >
		<input type="hidden" name="action" />
	<tr>

		<td align="center" colspan="7" class="labeltable_middle_td" >
			<select name="year" id="year" style="" >
				<%int iyear = 2004;
            for (int i = 0; i <= nowyear-2004; i++)
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
			<span style="">&nbsp;年&nbsp;</span>

			<select name="month" id="month" style="float: none;" >
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
			<span style="">&nbsp;月&nbsp;</span>
			<input class="but_y_01" style="float: none;" align="middle" type="Button" name="cmdOK" value="确定" onClick="cmdOK_onclick()">			
		</td>

	</tr>	
	</form>
	</table>
	<table cellspacing="1" cellpadding="0" border="0"  width=98% class="content_02_box_div_table_02">
	<tr align="center" height="20px" >
	    <td class="content_02_box_div_table_th" style="text-align: center;" >星期日</td>
	    <td class="content_02_box_div_table_th" style="text-align: center;" >星期一</td>
	    <td class="content_02_box_div_table_th" style="text-align: center;" >星期二</td>
	    <td class="content_02_box_div_table_th" style="text-align: center;" >星期三</td>
	    <td class="content_02_box_div_table_th" style="text-align: center;" >星期四</td>
	    <td class="content_02_box_div_table_th" style="text-align: center;" >星期五</td>
	    <td class="content_02_box_div_table_th" style="text-align: center;" >星期六</td>
	</tr>
	<form name="setform" id="setform" action="holidayadd.jsp">
	<tr align="center" height="20px" >
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
                    out.print("<td class='content_02_box_div_table_td' style='text-align: center;'></td>");
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
                HolidayService serv=new HolidayServiceImpl();
                ischecked = serv.findByDay(holiday);
        %>
			<td align="left" class='content_02_box_div_table_td' style='text-align: center;'>
				<input type="checkbox" id="chkTaskId" name="chkTaskId" value="<%=holiday%>" <%=ischecked%>>
				&nbsp;
				<%=holiday%>
				
				
			</td>

		<%
		    	if ((i != 0) && (i%7 == 0)&&i!=length + lack_weekday){
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
	            out.print("<td class='content_02_box_div_table_td' style='text-align: center;'></td>");
	        }
	    %>
	</tr>
	<tr style="height: 30px">
		<td align="center" colspan="7" class="labeltable_middle_td" >
			<input style="margin-left: 10px;float: none;" class="but_y_07" type="Button" name="cxsd" value="保存自定义设置" onClick="setholiday()">
			<!-- input class="input" type="Button" name="mrsd" value="保存本月默认设定（周六周日）" onClick="mholiday()"> -->			
			<input class="but_y_07" style="margin-left: 10px;width: 200px;float: none;" type="Button" name="cmdOK" value="保存本年默认设定(周六周日)" onClick="yearHoliday()">
		</td>
	</tr>
	</form>
</table>


<%--query table end
<table width="100%" style="margin-left: 0" class="tabs_search_ctable_box">
	
	<tr>
		<td width="100%" align="center" valign="top">
		<div class="content_02_box_title_bg" style="width: 100%;"><span>工作时间管理</span></div>
		<div style="float:left;width:100%;margin-top: 1px" class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		</td>
	</tr>
</table>
--%>
<form id="delForm1" name="delForm1" method="post" action="dailydo.jsp">
	<input type="hidden" name="work_id" id="work_id" /> 
	<input type="hidden" name="action" value="deldaily" />
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>