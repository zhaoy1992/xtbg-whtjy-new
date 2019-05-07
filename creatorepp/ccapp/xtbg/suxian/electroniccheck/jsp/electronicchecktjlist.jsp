<%--
描述：电子考勤统计列表
作者：邱炼
版本：1.0
日期：2014-06-03
--%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String userId = accesscontroler.getUserID();
  	//获得当前登录用户所属单位信息
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    String unit_id = usercachebean.getUnit_id();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>电子考勤统计列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<style type="text/css">
.mybtn{ 
	background-color:transparent; /* 背景色透明 */ 
	border:0px; /*border:0px solid #005aa7;边框取消 */ 
	cursor:pointer; 
	color:red;
} 
</style>
<script type="text/javascript">
var userId = "<%=userId%>";

var userids = new Array();//当前列表的用户id的数组
var start_time = "";
var end_time = "";

$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
        	Search();
        }
    });
    $("#gridTable").jqGrid({
    url: '<%= path %>' + '/commonListServlet?classNameId=electInfoTjList',  
    //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
    datatype: "json",
    //这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
    mtype: "POST",
    //定义使用哪种方法发起请求，GET或者POST
    height: "100%",//270
    //Grid的高度，可以接受数字、%值、auto，默认值为150
    autowidth: true,
    colModel: [ //最重要的数组之一，用于设定各列的参数
         { 
            label : '部门ID',
            name: 'orgid',
            index: 'orgid',
            hidden: true
         },
        {
             label : '部门名称 ',
            name: 'orgname',
            index: 'orgname',
            width: 150,
            editable: true
        },
        {
        	 label : '人员id',
             name: 'userid',
             index: 'userid',
             hidden: true
        },
        {
            label : '人员',
            name: 'username',
            index: 'username',
            width: 100,
            search: true
        }, {
        	label : '迟到',
            name: 'cdcount',
            index: 'cdcount',
            width: 100,
            search: false,
            hidden: true
        },
        {
        	label : '早退',
            name: 'ztcount',
            index: 'ztcount',
            width: 100,
            search: false,
            hidden: true
        },
        {
        	label : '旷工',
            name: 'kgcount',
            index: 'kgcount',
            width: 100,
            search: false,
            hidden: true
        },
        {
        	label : '迟到并早退',
            name: 'cdztcount',
            index: 'cdztcount',
            width: 100,
            search: false,
            hidden: true
        },
        {
        	label : '外勤',
            name: 'wqcount',
            index: 'wqcount',
            width: 80,
            search: false,
            hidden: true
        },
        {
        	label : '请假',
            name: 'qjcount',
            index: 'qjcount',
            width: 80,
            search: false,
            hidden: true
        },
        {
        	label : '事假',
            name: 'sjcount',
            index: 'sjcount',
            width: 80,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value7') value='"+cellvalue+"' >";
            	}
			}
        },
        {
        	label : '年休假',
            name: 'nxjcount',
            index: 'nxjcount',
            width: 90,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value1') value='"+cellvalue+"' >";
            	}
			}
        },
        {
        	label : '学习培训假',
            name: 'xxpxjcount',
            index: 'xxpxjcount',
            width: 100,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value10') value='"+cellvalue+"' >";
            	}
			}
        },
        {
        	label : '公差假',
            name: 'gcjcount',
            index: 'gcjcount',
            width: 100,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value8') value='"+cellvalue+"' >";
            	}
			}
        },
        {
        	label : '病（伤）假',
            name: 'bsjcount',
            index: 'bsjcount',
            width: 100,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value6') value='"+cellvalue+"' >";
            	}
			}
        },
        {
        	label : '产假',
            name: 'cjcount',
            index: 'cjcount',
            width: 80,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value4') value='"+cellvalue+"' >";
            	}
			}
        },
        {
        	label : '工伤假',
            name: 'gsjcount',
            index: 'gsjcount',
            width: 100,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value3') value='"+cellvalue+"' >";
            	}
			}
        },
        {
        	label : '婚假',
            name: 'hjcount',
            index: 'hjcount',
            width: 80,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value2') value='"+cellvalue+"' >";
            	}
			}
        },
        {
        	label : '计划生育假',
            name: 'jhsyjcount',
            index: 'jhsyjcount',
            width: 100,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value5') value='"+cellvalue+"' >";
            	}
			}
        },
        {
        	label : '丧假',
            name: 'sajcount',
            index: 'sajcount',
            width: 80,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value9') value='"+cellvalue+"' >";
            	}
			}
        },{
            label : '陪产假',
            name: 'pcjcount',
            index: 'pcjcount',
            width: 80,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value11') value='"+cellvalue+"' >";
            	}
			}
        },{
            label : '调休假',
            name: 'breakoff',
            index: 'breakoff',
            width: 80,
            search: false,
            formatter:function(cellvalue, options, rowObject){
            	if(cellvalue == '0'){
            		return cellvalue;
            	}else{
					return "<input type=button class='mybtn' id='b1' onclick=show('"+rowObject.userid+"','value12') value='"+cellvalue+"' >";
            	}
			}
        },
        {
        	label : '正常',
            name: 'zccount',
            index: 'zccount',
            width: 100,
            search: false,
            hidden: true
        }
    ],
    sortname: 't3.org_sn, t1.user_id',
        
    //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
    sortorder: 'asc',
    viewrecords: true,
    
    //设置是否在Pager Bar显示所有记录的总数。
    rowNum: 10,
    gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
		var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
		for (var i = 0; i < ids.length; i++) {
			var cl = ids[i];
			var model = jQuery("#gridTable").jqGrid('getRowData', cl);
		}
	},
    jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
        repeatitems: false
    },
    pagerintoolbar:true,//上面的分页条
    pagerinBottombar:true,//下面的分页条
    search : toParamJosn(),
    caption: "",    
    prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
        rows: "rows",
        //表示请求行数的参数名称  
        sort: "sidx",
        //表示用于排序的列名的参数名称  
        order: "sord",
        //表示采用的排序方式的参数名称 
        search : "search"
    },
    toolbar: [true,"top","<input class='but_y_01' id='exportButton' type='button' onclick='exportFile()' value='导出'/>"],
    multiselect: false,
    onCellSelect:function(id,iCol){
        if(iCol != 0 )
        {
        }
    }
}).navGrid('#gridPager', {
    edit: false,
    add: false,
    del: false,
    refresh: false,
    search: false
});
    
});
/*
函数:  toParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toParamJosn = function(){
	 userids.length = 0;//清空该变量
	 start_time = $("#start_time").val();
	 end_time = $("#end_time").val();
// 	 if(start_time==""){
// 		 start_time = getCurrentMonthFirst().Format('yyyy-MM-dd');//当月第一天
// 	 }
// 	 if(end_time==""){
// 		 end_time = getCurrentMonthLast().Format('yyyy-MM-dd');//当月最后一天
// 	 }
    var str = "{'username':'" + $("#username").val()    
            + "','start_time':'" + start_time
            + "','end_time':'" + end_time
            + "','orgid':'" + $("#orgid").val() 
             +"','state':'" + $("#state").val() 
            + "','unit_id':'<%=unit_id%>'}";
    return descape(escape(str));
}
/**
 * 选取机构
 */
 function chooseOrg (){
	  var s = new jQuery.z_tree_leftRigth();
	  s.treeID='mianDept';
	  s.isShowSeacher="aa";
	  s.treeName="选取部门";
	  s.headerName="选取部门";
	  s.titelText = "选取部门";
	  s.rightHeaderText="已添加机构和人员";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.dept) || null ==orgObj.dept )
		  	{
			   jQuery('#orgid').val('');
			   jQuery('#orgname').val('');
			 }else{
				jQuery('#orgid').val(orgObj.dept.id);
				jQuery('#orgname').val(orgObj.dept.name);
			 }
	  }
	  s.treeList=
			  [{
				  leftHeaderText:'按部门选择',
				  item_id :'org_id',
				  isType:'dept', 
				  valueKey:'dept',
				  selectedIds:jQuery('#orgid').val(),
				  type:"ADEPT"
			}];
	  s.init();
}
/*
函数:  StringCheck
说明:  做查询时通配符处理问题
参数:   obj 文本框上获得的值
返回值: 返回转换后的值
*/
var StringCheck = function(obj){
    return obj.replaceAll('%','---').replaceAll("'","’").replaceAll(":","：");
}
/*
函数:  briefsSearch
说明:  查询信息
参数:   无
返回值: 列表
*/
var Search = function() {
    var sdata = { //构建查询需要的参数 
        paramJson : toParamJosn()
    }; //获得当前postData选项的值  
    var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
    $.extend(postData, sdata);
    $("#gridTable").jqGrid("setGridParam", {
        search : true
    // 将jqGrid的search选项设为true  
    }).trigger("reloadGrid", [ {
        page : 1
    } ]); //重新载入Grid表格，以使上述设置生效 
     }

    /*
     函数:  clearSearch
     说明:  重置
     参数:   无
     返回值: 无
     */
    var clearSearch = function() {
         resetSingleSearchDialog();
            var sdata = {
                paramJson: toTasksParamJosn()
            };
            var postData = $("#gridTable").jqGrid("getGridParam", "postData");
            $.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
            $("#gridTable").jqGrid("setGridParam", {
                search: true // 将jqGrid的search选项设为false  
            }).trigger("reloadGrid", [{
                page: 1
            }]);
    }

    /*
     函数:  resetSingleSearchDialog
     说明:  清空值查询值
     参数:   无
     返回值: 无
     */
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
    $(":text", "#queryTable").val("");
    $(":hidden", "#queryTable").val("");
    $("select").each(function(){
        $(this).find("option:first").attr("selected","selected");
    });
}
    
    
/**
 * 导出
 */
function exportFile(){
	var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='userids' value='"+userids.join()+"' /> ");
    html.push("<input type='hidden' name='start_time' value='"+start_time+"' /> ");
    html.push("<input type='hidden' name='end_time' value='"+end_time+"' /> ");
    html.push("<input type='hidden' name='parmjson' value='"+toParamJosn()+"' /> ");
    html.push("<input type='hidden' name='excelname' value='考勤统计' /> ");//导出的主题
    html.push("<input type='hidden' name='excelImplClass' value='electTJDaoExcelImpl' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
    html.push("<input type='hidden' name='excelTemplateFilePath' value='leavecelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
}

/**
 * 获取当前月的第一天
 */
function getCurrentMonthFirst(){
	 var date=new Date();
	 date.setDate(1);
	 return date;
}
/**
 * 获取当前月的最后一天
 */
function getCurrentMonthLast(){
	 var date=new Date();
	 var currentMonth=date.getMonth();
	 var nextMonth=++currentMonth;
	 var nextMonthFirstDay=new Date(date.getFullYear(),nextMonth,1);
	 var oneDay=1000*60*60*24;
	 return new Date(nextMonthFirstDay-oneDay);
} 

//对Date的扩展，将 Date 转化为指定格式的String 
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt) 
{ //author: meizz 
	var o = { 
	 "M+" : this.getMonth()+1,                 //月份 
	 "d+" : this.getDate(),                    //日 
	 "h+" : this.getHours(),                   //小时 
	 "m+" : this.getMinutes(),                 //分 
	 "s+" : this.getSeconds(),                 //秒 
	 "q+" : Math.floor((this.getMonth()+3)/3), //季度 
	 "S"  : this.getMilliseconds()             //毫秒 
	}; 
	if(/(y+)/.test(fmt)) 
	 fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	for(var k in o) 
	 if(new RegExp("("+ k +")").test(fmt)) 
	fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
	return fmt; 
}

//打开详情记录
var show = function(id,type_value) {
	var t_start_time = $("#start_time").val();
	var t_end_time = $("#end_time").val();
	window.location.href="detailslist.jsp?userid="+id+"&type_value="+type_value+"&start_time="+t_start_time+"&end_time="+t_end_time;
}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="">  
<input type="hidden" name="testid" id="testid"> 
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
                                <th width="90" class="input_cx_title_th" >人员：</th>
                                <td width="200"  class="cx_title_td">
                                <input  type="text" class="input_cx_title_283" id="username" name="username"/>
                                </td>
                                <td width="385"  colspan="2"  >
                                <input name="Input2" value="搜索" type="button" onclick="Search()" class="but_y_01"/>
                                <span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span></td>
                            </tr>
                        </table>
                        <!-- 固定查询 end-->
                    </td>
                    </tr>
                    
                 <tr>
                    <td>
                    <!-- 隐藏查询 -->
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none">
                            <tr>
                            <th class="input_cx_title_th">部门：</th>
                            <td  class="cx_title_td">
                                <input  type="text" class="input_cx_title_283" id="orgname" name="orgname"  onclick="chooseOrg();"/>
                                 <input name="orgid"  id="orgid"  type="hidden" />
                            </td>
							<th class="input_cx_title_th">统计区间：</th>
							<td  class="cx_title_td">
							<input id="start_time" name="start_time" type="text" class="date_120"　
							onFocus="var input_endtime=$dp.$('end_time');WdatePicker({onpicked:function(){end_time.focus();},dateFmt:'yyyy-MM-dd '})"   /> 
							<span class="date_120_span">至</span>
							 <input id="end_time" name="end_time" type="text"  class="date_120" 
							 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'start_time\')}',dateFmt:'yyyy-MM-dd '})" />
							</td>
                            </tr>
                            <tr>
                            <th class="input_cx_title_th">请假类别：</th>
                            <td  class="cx_title_td">
                                 <select id='state' name='state' >
					                <option value="" >--请选择--</option>
					                <option value='年休假'>年休假</option>
					                <option value='婚假'>婚假</option>
					                <option value='工伤假'>工伤假</option>
					                <option value='产假'>产假</option>
					                <option value='计划生育假'>计划生育假</option>
					                <option value='病(伤)假'>病(伤)假</option>
					                <option value='事假'>事假</option>
					                <option value='公差假'>公差假</option>
					                <option value='丧假'>丧假</option>
					                <option value=' 学习培训假'> 学习培训假</option>
					                <option value='陪产假'>陪产假</option>
							    </select>
                            </td>
                            </tr>
                        </table>
                        <!-- 隐藏查询 end-->
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