<%--
生日提醒
王淑滨
 --%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.directory.dao.DirectoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.ListShowUtilBean"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.*"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.impl.*"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JGRID</title>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/testcss.css" />

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<!--模块特殊，不能去掉，去掉字母样式会不显示  -->
<script type="text/javascript"src="../../resources/util/multiSelect.js"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript">
var i = 0;
var userids = new Array();//当前列表的用户id的数组
$(function() {
	//文档添加回车按钮事件
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	

	//初始化grid表格
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId'
		+'=com.chinacreator.xtbg.core.directory.list.BirthdayList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		autowidth: true,
		//最重要的数组之一，用于设定各列的参数
		colModel: [ 
		{	label:'序号',
			name: 'xuhao',
			index: 'xuhao',
			hidden : true,
			formatter:function(cellvalue, options, rowObject){
				i++;
				return i ;
			}
		},
		{
			label:'名录id',
			name: 'directoryid',
			index: 'directoryid',
			hidden: true
		},
		{
			label:'姓名',
			name: 'directoryname',
			index: 'directoryname',
			width: 180,
			sortable:false,
			editable: true
		},
		{
			label:'部门',
			name: 'org_id',
			index: 'org_id',
			width: 180,
			hidden : true
		},
		{
			label:'部门',
			name: 'orgname',
			index: 'orgname',
			width: 150,
			sortable:false,
			search: true
		},
		{
			label:'生日日期',
			name: 'directoryyear',
			index: 'directoryyear',
			width: 180,
			sortable:false,
			editable: true
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
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);				
				userids.push(model.directoryid);
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		
		//caption: "名录管理",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toUserParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top",
		          "<input type='button' class='but_excelout_01' title='导出excel表格' onMouseOver=javascript:$(this).attr('class','but_excelout_02'); onMouseOut=javascript:$(this).attr('class','but_excelout_01');  value='' onclick='exportFile()' style='margin-left:5px;'/>"
		          ],
		multiselect: false,
		onSelectRow: function(id) {
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh: false
	});	
});
	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	userids.length = 0;//清空该变量
	var start_time = $("#start_time").val();
	var end_time = $("#end_time").val();
    var str = "{'directoryyear1':'" + start_time + "','directoryyear2':'" + end_time + "'}";
    		
	return descape(escape(str));
}

/*
	 函数:  userSearch
	 说明:  查询用户信息
	 参数:   无
	 返回值: 用户列表
	 */
var userSearch = function() {
	i = 0;
	var sdata = { //构建查询需要的参数 
		paramJson: toUserParamJosn()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search: true // 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [{
		page: 1
	}]); //重新载入Grid表格，以使上述设置生效 
}



/**
 * 导出
 */
function exportFile(){
    var url = "ajaxexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='userids' value='"+userids.join()+"' /> ");
    html.push("<input type='hidden' name='parmjson' value='"+toUserParamJosn()+"' /> ");
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
}




</script>
</head>
<body>	    		
<form id="form1" name="form1" method="post" action="">  
<table width="100%" id="queryTable">
    <tr>
        <td>
            <!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
                <tr>
                    <td>
                        <!-- 固定查询 -->
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
                            <tr>
								<th class="input_cx_title_th">查找区间：</th>
								<td  class="cx_title_td">
									<input id="start_time" name="start_time" type="text" class="date_120"onFocus="var input_endtime=$dp.$('end_time');WdatePicker({onpicked:function(){end_time.focus();},dateFmt:'MM-dd '})"   /> 
									<span class="date_120_span">至</span>
									 <input id="end_time" name="end_time" type="text"  class="date_120" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'start_time\')}',dateFmt:'MM-dd '})" />
								</td>
                                <td width="385"  colspan="2"  >
                                <input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
                            </tr>
                        </table>
                        <!-- 固定查询 end-->
                    </td>
                    </tr>
            </table>
            
        <!-- 查询列表区[开始]-->
        <div class="cGridArea">
            <table id="gridTable"></table>
            <div id="gridPager"></div>
        </div>
        <iframe name="hiddenFrame" width=0 height=0></iframe>
    </td>
    </tr>
    </table>
    </form>
</body>
</html>